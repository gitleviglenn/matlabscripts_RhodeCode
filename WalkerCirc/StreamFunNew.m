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

source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c96L33_am4p0_10x4000_nh_1km_wlkr_4K/19790301.atmos_month_psivars.nc');
% dimensions for the 1km run are: xdim,ydim,zdim, no time dimension
w_gen=ncread(source_psi,'w');
u_gen=ncread(source_psi,'ucomp');
sphum_gen=ncread(source_psi,'sphum');
temp_gen=ncread(source_psi,'temp');
pfull_gen=ncread(source_psi,'pfull');
pfull_gen=100.*pfull_gen;

% this generalization will not work if the incoming data has not already been time averaged...
temp_gen_ztmn=squeeze(mean(temp_gen,2));
sphum_gen_ztmn=squeeze(mean(sphum_gen,2));
u_gen_ztmn=squeeze(mean(u_gen,2));
w_gen_ztmn=squeeze(mean(w_gen,2));

pfull_25km=100.*pfull_25km; % convert to Pa
pfull_2km=100.*pfull_2km; % convert to Pa

r_dry=287.; % J/kg K
epsilon=0.622;
grav=9.8; % m/s2

dx=25000.; % m
dx_crm=2000.;

% general parameters
dx_gen=1000.; % grid cell size in meters
x_ngp_gen=4000; % width of domain in grid points

clear rho_gen
Tv_gen=temp_gen_ztmn.*(1+sphum_gen_ztmn./epsilon)./(1+sphum_gen_ztmn);
for j=33:-1:1
    for i=1:x_ngp_gen
        rho_gen(i,j)=pfull_gen(j)/(r_dry*Tv_gen(i,j));
    end
end

psi_gen=zeros(x_ngp_gen,33);

u_bc(1)=(1/grav)*u_gen_ztmn(1,1)*(pfull_gen(2)-pfull_gen(1));

for j=33:-1:2
    psi_gen(1,j)=psi_gen(x_ngp_gen,j)-dx_gen.*rho_gen(1,j)*w_gen_ztmn(1,j);
    for i=2:x_ngp_gen
        % compute the boundary condition u_bc_p
      u_bc=zeros(33,1);
      for jj=33:-1:j 
         u_bc(jj)=(1/grav)*u_gen_ztmn(i,jj)*(pfull_gen(jj)-pfull_gen(jj-1));
      end
      u_bc_p=sum(u_bc);
        %psi_crm_3(i+1,j)=psi_crm_3(i-1,j)-2*dx_crm.*rho_2km(i,j)*w_2km_ztmn(i,j);
        psi_gen(i,j)=dx_gen*rho_gen(i,j)*w_gen_ztmn(i,j)...
            +u_bc_p;
    end
end



%% % 
figure
subplot(1,3,3)
stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
[C,h]=contourf(1:xgcm_ngp,pfull_25km,psi_3',stream_cons);
v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('GCM mass streamfunction')
set(gca,'Ydir','reverse')

subplot(1,3,2)
[C,h]=contourf(1:xcrm_ngp,pfull_2km,psi_crm_3',stream_cons);
clabel(C,h,v);
title('2km CRM mass streamfunction')
set(gca,'Ydir','reverse')

subplot(1,3,1)
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
clabel(C,h,v);
title('1km CRM mass streamfunction')
set(gca,'Ydir','reverse')


tit_str=strcat('Streamfunction: ',tit_st);
suptitle(tit_str)

figure
stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('mass streamfunction')
set(gca,'Ydir','reverse')

