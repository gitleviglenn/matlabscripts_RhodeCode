path_base='/Users/silvers/data/WalkerCell/'
%tit_st=' cos sq ';
tit_st=' gaussian ';
%path_25km=path;

%path=strcat(path_base,'gauss_d/');
%path=strcat(path_base,'gauss_dd/');

% original paths
%path_25km=strcat(path,'c96L33_8x80_nh.19790101');
%path_2km=strcat(path,'c96L33_100x1000_nh_crm.19790101');

%path_25km=strcat(path,'am4p0_8x160_4K/','19790101');
%path_2km=strcat(path,'am4p0_50x2000_4K/','19790301');

source_25km=strcat(path_25km,'.atmos_daily.nc');
source_2km=strcat(path_2km,'.atmos_daily.nc');

source_25km_month=strcat(path_25km,'.atmos_month.nc');
source_2km_month=strcat(path_2km,'.atmos_month.nc');

source_25km_8xday=strcat(path_25km,'.atmos_8xdaily.nc');
source_2km_8xday=strcat(path_2km,'.atmos_8xdaily.nc');

w_25km=ncread(source_25km,'w');
u_25km=ncread(source_25km_month,'ucomp');
sphum_25km=ncread(source_25km_month,'sphum');
v_25km=ncread(source_25km_month,'vcomp');
temp_25km=ncread(source_25km_month,'temp');
zfull_25km=ncread(source_25km_month,'z_full');
pfull_25km=ncread(source_25km_month,'pfull');
pfull_25km=100.*pfull_25km; % convert to Pa
w_2km=ncread(source_2km,'w');
u_2km=ncread(source_2km_month,'ucomp');
sphum_2km=ncread(source_2km_month,'sphum');
temp_2km=ncread(source_2km_month,'temp');
pfull_2km=ncread(source_2km_month,'pfull');
pfull_2km=100.*pfull_2km; % convert to Pa

% domain related parameters:
%blah=1:1000;
%blah=1:500;
%x80=0:25:2000;
xgcm=0:25:4000; % size of gcm domain in km
xgcm_ngp=160; % gcm number of grid points in x
%x1000=0:2:2000;
xcrm=0:2:4000; % size of crm domain in km
%xcrm=0:2:2000;
xcrm_ngp=2000; % crm number of grid points in x

%----------------------------------------------------------------


r_dry=287.; % J/kg K

dx=25000.; % km
dx_crm=2000.;
%dz=pfull_25km;
dz=zeros(33);

for i=33:-1:2
dz(i)=(pfull_25km(i)-pfull_25km(i-1));
dz_crm(i)=(pfull_2km(i)-pfull_2km(i-1));
end

% compute the time and zonal mean of temp
temp_25km_zmn=squeeze(mean(temp_25km,2));
temp_25km_ztmn=squeeze(mean(temp_25km_zmn,3));
temp_25km_ztzmn=squeeze(mean(temp_25km_ztmn,1));
temp_crm_zmn=squeeze(mean(temp_2km,2));
temp_crm_ztmn=squeeze(mean(temp_crm_zmn,3));
temp_crm_ztzmn=squeeze(mean(temp_crm_ztmn,1));

% compute the time and zonal mean of w
w_25km_zmn=squeeze(mean(w_25km,2));
%w_25km_zmn=squeeze(w_25km(:,4,:,:));
w_25km_ztmn=squeeze(mean(w_25km_zmn,3));
sphum_25km_zmn=squeeze(sphum_25km(:,4,:,:));
sphum_25km_ztmn=squeeze(mean(sphum_25km_zmn,3));

w_2km_zmn=squeeze(mean(w_2km,2));
%w_2km_zmn=squeeze(w_2km(:,35,:,:));
w_2km_ztmn=squeeze(mean(w_2km_zmn,3));

sphum_2km_zmn=squeeze(mean(sphum_2km,2));
%sphum_2km_zmn=squeeze(sphum_2km(:,4,:,:));
sphum_2km_ztmn=squeeze(mean(sphum_2km_zmn,3));
% compute the time and zonal mean of u
u_25km_zmn=squeeze(mean(u_25km,2));
u_25km_ztmn=squeeze(mean(u_25km_zmn,3));
u_2km_zmn=squeeze(mean(u_2km,2));
u_2km_ztmn=squeeze(mean(u_2km_zmn,3));

% compute virtual temperature for use in the density computation
% rho = p*Rd*Tv
clear Tv_25km
epsilon=0.622;
%Tv=temp_25km_ztmn.*(1+sphum_25km_ztmn(i,j)./epsilon)./(1+sphum_25km_ztmn(i,j));
Tv_25km=temp_25km_ztmn.*(1+sphum_25km_ztmn./epsilon)./(1+sphum_25km_ztmn);
Tv_2km=temp_crm_ztmn.*(1+sphum_2km_ztmn./epsilon)./(1+sphum_2km_ztmn);

for i=33:-1:2
rho(i)=pfull_25km(i)./(r_dry*temp_25km_ztzmn(i));
rho_crm(i)=pfull_2km(i)./(r_dry*temp_crm_ztzmn(i));
end

for i=33:-1:2
    for j=1:160
rho_25km(j,i)=pfull_25km(i)./(r_dry.*Tv_25km(j,i));
    end
end
for i=33:-1:2
    for j=1:2000
rho_2km(j,i)=pfull_2km(i)./(r_dry.*Tv_2km(j,i));
    end
end

%psi=zeros(160,33);
%psi_new=zeros(160,33);
psi_3=zeros(160,33);
psi_4=zeros(160,33);
psi_crm_3=zeros(2000,33);
psi_crm_4=zeros(2000,33);
%error=zeros(160,33);

% % first guess for psi
% for i=1:160
%     for j=33:-1:1
%         %psi(i,j)=2*dz(j)*rho(j)*u_25km_tzmn(i,j)-2*dx*rho(j)*w_25km_tzmn(i,j);
%         psi(i,j)=0.2*dz(j)*u_25km_tzmn(i,j)-2*dx*rho(j)*w_25km_tzmn(i,j);
%     end 
% end
% 
% psi_fg=psi;
% psi_new=psi;
% 
%     % boundary conditions for psi
%     % zero at toa and surface
%     psi(:,33)=0.0;
%     psi(:,1)=0.0;
% 
%     % doubly periodic in x and y
%     psi(1,:)=psi(160,:);
%     
% %psi=zeros(160,33);
% 
% % now compute the an approximation of the actual psi function:
% relax=0.1;

% for itt=1:3
%     for i=3:158
%         for j=32:-1:2
%             %psi_new(i,j+1)=psi(i,j+1).*(1-relax)+relax.*(2*dz(j)*rho(j)*u_25km_tzmn(i,j)-2*dx*rho(j-1)*w_25km_tzmn(i-1,j-1)+psi(i-2,j-1));
%             psi_new(i,j+1)=psi(i,j+1).*(1-relax)+relax.*(0.2*dz(j)*u_25km_tzmn(i,j)-2*dx*rho(j-1)*w_25km_tzmn(i-1,j-1)+psi(i-2,j-1));
%             error(i,j)=psi_new(i,j)-psi(i,j);
%         end
%     end
%     % boundary conditions for psi
%     % zero at toa and surface
%     psi_new(:,33)=0.0;
%     psi_new(:,1)=0.0;
%     psi_new(:,32)=0.0;
%     psi_new(:,2)=0.0;
% 
%     % doubly periodic in x and y
%     psi_new(1,:)=psi_new(160,:);
%     %psi_new(2,:)=psi_new(159,:);
%     
%     maxerror=max(max(error));
%     minerror=min(min(error));
%     psi=psi_new;
% end

psi_3(1,:)=psi_3(160,:);
psi_3(:,33)=0.0;
psi_3(:,1)=0.0;

% psi_4(1,:)=psi_4(160,:);
% psi_4(:,33)=0.0;
% psi_4(:,1)=0.0;

for j=32:-1:2
for i=2:159
        %for j=32:-1:2
%psi_3(i+1,j)=psi_3(i-1,j)-2*dx.*rho(j)*w_25km_ztmn(i,j);
psi_3(i+1,j)=psi_3(i-1,j)-2*dx.*rho_25km(i,j)*w_25km_ztmn(i,j);
%psi_4(i+1,j)=psi_4(i-1,j)+2*dz(j).*rho(j)*u_25km_ztmn(i,j);
        end
end

psi_crm_3(1,:)=psi_crm_3(2000,:);
psi_crm_3(:,33)=0.0;
psi_crm_3(:,1)=0.0;

% psi_crm_4(1,:)=psi_crm_4(2000,:);
% psi_crm_4(:,33)=0.0;
% psi_crm_4(:,1)=0.0;

for j=32:-1:2
    for i=2:1999
        %psi_crm_3(i+1,j)=psi_crm_3(i-1,j)-2*dx_crm.*rho_crm(j)*w_2km_ztmn(i,j);
        psi_crm_3(i+1,j)=psi_crm_3(i-1,j)-2*dx_crm.*rho_2km(i,j)*w_2km_ztmn(i,j);
        %psi_crm_4(i+1,j)=psi_crm_4(i-1,j)+2*dz_crm(j).*rho_crm(j)*u_2km_ztmn(i,j);
    end
end

% psi_crm_3(1,:)=psi_crm_3(2000,:);
% psi_crm_3(:,33)=0.0;
% psi_crm_3(:,1)=0.0;
% 
% psi_crm_4(1,:)=psi_crm_4(2000,:);
% psi_crm_4(:,33)=0.0;
% psi_crm_4(:,1)=0.0;



% figure
% contourf(psi_fg')
% title('first guess streamfunction')
% set(gca,'Ydir','reverse')
% colorbar

% figure
% contourf(1:xgcm_ngp,pfull_2km,psi')
% title('attempt at streamfunction')
% set(gca,'Ydir','reverse')
% colorbar

% figure
% 
% clt_contours=[1,3,5,10,15,20,25,30];
% subplot(1,2,1)
% %caxis=([1 25]);
% [C,h]=contourf(1:xcrm_ngp,pfull_2km,clt_2km_znm_end_tmn',clt_contours,'EdgeColor','None');
% v=[5,10,20,30,50,70];
% clabel(C,h,v);
% tit_a=strcat('cloud fraction 2km',tit_st)
% title(tit_a)
% set(gca,'Ydir','reverse')
% colorbar

figure
subplot(1,2,2)
stream_cons=[-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.];
[C,h]=contourf(1:xgcm_ngp,pfull_25km,psi_3',stream_cons);
v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('GCM mass streamfunction')
set(gca,'Ydir','reverse')
%colorbar

%figure
subplot(1,2,1)
%stream_cons=[-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,psi_crm_3',stream_cons);
%v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('CRM mass streamfunction')
set(gca,'Ydir','reverse')
%colorbar

% figure
% contourf(1:xgcm_ngp,pfull_25km,psi_4')
% title('attempt at streamfunction with u')
% set(gca,'Ydir','reverse')
% colorbar

