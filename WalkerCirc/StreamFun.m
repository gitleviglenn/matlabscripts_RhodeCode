%----------------------------------------------------------------------
% StreamFun.m
%
% computes mass streamfunction (psi_3, psi_crm_3) for 25km and 2km data
%
% psi depends on: w,u,sphum,temp, and pfull
%
% psi is computed as: psi(rho,w,u)=dx*rho(i,j)*w_ztmn(i,j)+u_bc_p;
% 
% The density rho is computed with the virtual temperature Tv
% rho(i,j)=pfull(j)/(r_dry*Tv(i,j));
% Tv=temp_ztmn.*(1+sphum_ztmn./epsilon)./(1+sphum_ztmn);
% where sphum referes to the specific humidity
%
% The boundary condition in u is: 
%      u_bc_p=sum(u_bc); --> sum over vertical levels where u_bc is:
%      u_bc(jj)=(1/grav)*u_ztmn(i,jj)*(pfull(jj)-pfull(jj-1));
%
% levi silvers                                               june 2018
%----------------------------------------------------------------------
%path_base='/Users/silvers/data/WalkerCell/'

% source_25km=strcat(path_25km,'.atmos_daily.nc');
% source_2km=strcat(path_2km,'.atmos_daily.nc');
% 
% source_25km_month=strcat(path_25km,'.atmos_month.nc');
% source_2km_month=strcat(path_2km,'.atmos_month.nc');
% 
% source_25km_8xday=strcat(path_25km,'.atmos_8xdaily.nc');
% source_2km_8xday=strcat(path_2km,'.atmos_8xdaily.nc');

w_25km=ncread(source_25km,'w');
u_25km=ncread(source_25km_month,'ucomp');
sphum_25km=ncread(source_25km_month,'sphum');
v_25km=ncread(source_25km_month,'vcomp');
temp_25km=ncread(source_25km_month,'temp');
zfull_25km=ncread(source_25km_month,'z_full');
pfull_25km=ncread(source_25km_month,'pfull');
w_2km=ncread(source_2km,'w');
u_2km=ncread(source_2km_month,'ucomp');
sphum_2km=ncread(source_2km_month,'sphum');
temp_2km=ncread(source_2km_month,'temp');
pfull_2km=ncread(source_2km_month,'pfull');

pfull_25km=100.*pfull_25km; % convert to Pa
pfull_2km=100.*pfull_2km; % convert to Pa

% % domain related parameters:
% %x80=0:25:2000;
% xgcm=0:25:4000; % size of gcm domain in km
% xgcm_ngp=160; % gcm number of grid points in x
% %x1000=0:2:2000;
% xcrm=0:2:4000; % size of crm domain in km
% %xcrm=0:2:2000;
% xcrm_ngp=2000; % crm number of grid points in x

%----------------------------------------------------------------


r_dry=287.; % J/kg K
epsilon=0.622;
grav=9.8; % m/s2

dx=25000.; % m
dx_crm=2000.;
dz=zeros(33);

% compute the time and zonal mean of temp
temp_25km_zmn=squeeze(mean(temp_25km,2));
temp_25km_zmn_eq=temp_25km_zmn(:,:,an_t1:an_t2);
temp_25km_ztmn=squeeze(mean(temp_25km_zmn_eq,3));
temp_25km_ztzmn=squeeze(mean(temp_25km_ztmn,1));

temp_crm_zmn=squeeze(mean(temp_2km,2));
temp_crm_zmn=temp_crm_zmn(:,:,4:6);
temp_crm_ztmn=squeeze(mean(temp_crm_zmn,3));
temp_crm_ztzmn=squeeze(mean(temp_crm_ztmn,1));

u_25km_zmn=squeeze(mean(u_25km,2));
u_25km_zmn_eq=u_25km_zmn(:,:,an_t1:an_t2);
%w_25km_zmn=squeeze(w_25km(:,4,:,:));
u_25km_ztmn=squeeze(mean(u_25km_zmn_eq,3));

u_2km_zmn=squeeze(mean(u_2km,2));
u_2km_zmn=u_2km_zmn(:,:,4:6);
u_2km_ztmn=squeeze(mean(u_2km_zmn,3));

% compute the time and zonal mean of w
w_25km_zmn=squeeze(mean(w_25km,2));
w_25km_zmn_eq=w_25km_zmn(:,:,an_t1_d:an_t2_d);
%w_25km_zmn=squeeze(w_25km(:,4,:,:));
w_25km_ztmn=squeeze(mean(w_25km_zmn_eq,3));

w_2km_zmn=squeeze(mean(w_2km,2));
w_2km_zmn=w_2km_zmn(:,:,t_mid:t_end);
w_2km_ztmn=squeeze(mean(w_2km_zmn,3));

sphum_25km_zmn=squeeze(mean(sphum_25km,2));
sphum_25km_zmn_eq=sphum_25km_zmn(:,:,an_t1:an_t2);
%sphum_25km_zmn=squeeze(sphum_25km(:,4,:,:));
sphum_25km_ztmn=squeeze(mean(sphum_25km_zmn_eq,3));

sphum_2km_zmn=squeeze(mean(sphum_2km,2));
sphum_2km_zmn=sphum_2km_zmn(:,:,4:6);
sphum_2km_ztmn=squeeze(mean(sphum_2km_zmn,3));

% compute virtual temperature for use in the density computation
% rho = p*Rd*Tv
%clear Tv_25km

Tv_25km=temp_25km_ztmn.*(1+sphum_25km_ztmn./epsilon)./(1+sphum_25km_ztmn);
Tv_2km=temp_crm_ztmn.*(1+sphum_2km_ztmn./epsilon)./(1+sphum_2km_ztmn);

clear rho_25km;
clear rho_2km;

for j=33:-1:1
    for i=1:160
        rho_25km(i,j)=pfull_25km(j)/(r_dry*Tv_25km(i,j));
        %rho_25km(i,j)=pfull_25km(j)./(r_dry*temp_25km_ztmn(i,j));
    end
end
for j=33:-1:1
    for i=1:2000
        rho_2km(i,j)=pfull_2km(j)/(r_dry*Tv_2km(i,j));
    end
end

psi_3=zeros(160,33);
psi_crm_3=zeros(2000,33);

% boundary condition depending on u wind
u_bc=zeros(33,1);
u_bc(1)=(1/grav)*u_25km_ztmn(1,1)*(pfull_25km(2)-pfull_25km(1));

for j=33:-1:2
   psi_3(1,j)=psi_3(160,j)+dx*rho_25km(1,j)*w_25km_ztmn(1,j);
   for i=2:160
      % compute the boundary condition u_bc_p
      u_bc=zeros(33,1);
      for jj=33:-1:j 
         u_bc(jj)=(1/grav)*u_25km_ztmn(i,jj)*(pfull_25km(jj)-pfull_25km(jj-1));
      end
      u_bc_p=sum(u_bc);
      psi_3(i,j)=dx*rho_25km(i,j)*w_25km_ztmn(i,j)...
          +u_bc_p;
   end
end
    
u_bc(1)=(1/grav)*u_2km_ztmn(1,1)*(pfull_25km(2)-pfull_25km(1));


for j=33:-1:2
    psi_crm_3(1,j)=psi_crm_3(2000,j)-dx_crm.*rho_2km(1,j)*w_2km_ztmn(1,j);
    for i=2:2000
        % compute the boundary condition u_bc_p
      u_bc=zeros(33,1);
      for jj=33:-1:j 
         u_bc(jj)=(1/grav)*u_2km_ztmn(i,jj)*(pfull_2km(jj)-pfull_2km(jj-1));
      end
      u_bc_p=sum(u_bc);
        %psi_crm_3(i+1,j)=psi_crm_3(i-1,j)-2*dx_crm.*rho_2km(i,j)*w_2km_ztmn(i,j);
        psi_crm_3(i,j)=dx_crm.*rho_2km(i,j)*w_2km_ztmn(i,j)...
            +u_bc_p;
    end
end


% % 
figure
subplot(1,2,2)
stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
[C,h]=contourf(1:xgcm_ngp,pfull_25km,psi_3',stream_cons);
v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('GCM mass streamfunction')
set(gca,'Ydir','reverse')

subplot(1,2,1)
[C,h]=contourf(1:xcrm_ngp,pfull_2km,psi_crm_3',stream_cons);
clabel(C,h,v);
title('CRM mass streamfunction')
set(gca,'Ydir','reverse')

tit_str=strcat('Streamfunction: ',tit_st);
suptitle(tit_str)
