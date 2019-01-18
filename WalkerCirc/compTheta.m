%------------------------------------------------------------------
% compute the potential temperature using temperature and pressure
% compute the static stability
%
% goal: compute and plot the change of temp with height.  do I want 
% do plot dT/dz, dtheta/dz, dT/dp, or dtheta/dp?
%
% the intention is to make this general enough to use with 1km, 2km, 
% 25km, or 100km grid-spacing experiments
%
% why are we using p0=1000 instead of the actual surface pressure?
%------------------------------------------------------------------

clear gamma_d;

theta_f     = zeros(nlat,nlon,nlev);
temp3       = zeros(nlat,nlon);
lts_f       = zeros(nlat,nlon);
rh_sfc      = zeros(nlat,nlon);
theta_temp = zeros(nlat,nlon);
%staticst    = zeros(nlat,nlev);
gamma_d     = zeros(1,nlev);
gamma_m     = zeros(3,nlev);
%gamma      = zeros(nlat,nlev);
gamma       = zeros(3,nlev);
stastapar   = zeros(3,nlev);
es       = zeros(1,nlev);
qs       = zeros(1,nlev);

gamma_d = gamma_d+grav/cp;

sten        = zeros(nlat,nlev);

% first compute theta at the surface
tsurf_zmn=squeeze(mean(tsfc_mn,2));
tsurf_crm1_zmn=squeeze(mean(tsurf_crm1,2));
tsurf_crm1_ztmn=squeeze(mean(tsurf_crm1_zmn,2));
tsurf_crm2_zmn=squeeze(mean(tsurf_crm,2));
tsurf_crm2_ztmn=squeeze(mean(tsurf_crm2_zmn,2));
% compute theta at the surface
theta_sfc=tsurf_zmn.*(p0./psurf_zmn).^kappa;

% assume that tsfc and psurf are the same for all models and experiments
% generalize these variables:
% temp_25km*


% now compute theta throughout the atmospheric depth
theta_temp=tsfc_mn.*((p0/pfull_gen(33))^kappa);
theta_f(:,:,33)=theta_temp(:,:);
temp_gen=ncread(source_gcm_month,'temp');
temp_equil=temp_gen(:,:,:,1:4);
temp_eq_tmn=squeeze(mean(temp_equil,4));
temp_eq_ztmn=squeeze(mean(temp_eq_tmn,2));

for lev=1:nlev; % compute the 3d potential temperature field
   p_lev=100.0*pfull_gen(lev);
   temptemp=squeeze(temp_eq_tmn(:,:,lev));
   temp3=temptemp;
%   temp3(temptemp<240)=240.;
   theta_temp=temp3.*((p0/p_lev)^kappa);
   theta_f(:,:,lev)=theta_temp;
end
theta_znm=squeeze(mean(theta_f,2));

% compute the virtual temperature and density
Tv_25km=temp_25km_ztmn.*(1+q_25km_ztmn./epsilon)./(1+q_25km_ztmn);
Tv_2km=temp_crm_ztmn.*(1+q_2km_ztmn./epsilon)./(1+q_2km_ztmn);
Tv_1km=temp_crm1_ztmn.*(1+q_1km_ztmn./epsilon)./(1+q_1km_ztmn);

clear rho_25km;
clear rho_2km;
clear rho_1km;

rho_25km=rho_2d_gen(temp_25km_ztmn,q_25km_ztmn,pfull_25km,160);
rho_2km=rho_2d_gen(temp_crm_ztmn,q_2km_ztmn,pfull_2km,2000);
rho_1km=rho_2d_gen(temp_crm1_ztmn,q_1km_ztmn,pfull_1km,2000);

% lev 1 is the at the top of the domain, lev 33 is the lowest atmospheric level
% gamma = -g*rho*delT/delp
plot_lat=80;
%plot_lat=1;
gamma(1,:)=lapser(temp_eq_ztmn,rho_25km,plot_lat,tsfc,psurf_zmn,pfull_gen);
%gamma(1,:)=lapser(temp_eq_ztmn_midmn,rho_25km_midmn,plot_lat,tsfc,psurf_zmn,pfull_gen);
temp_eq_prof=temp_eq_ztmn(plot_lat,:);
es(:)=satvappres(temp_eq_prof);
qs(:)=qstar(es,pfull_gen);
gamma_m(1,:)=moistadiabat(temp_eq_prof,qs);

plot_lat=1000;
%plot_lat=1;
gamma(2,:)=lapser(temp_crm_ztmn,rho_2km,plot_lat,tsurf_crm2_ztmn,psurf_2km_zmn,pfull_gen);
temp_crm_prof=temp_crm_ztmn(plot_lat,:);
es(:)=satvappres(temp_crm_prof);
qs(:)=qstar(es,pfull_gen);
gamma_m(2,:)=moistadiabat(temp_eq_prof,qs);

plot_lat=2000;
%plot_lat=1;
gamma(3,:)=lapser(temp_crm1_ztmn,rho_1km,plot_lat,tsurf_crm1_ztmn,psurf_1km_zmn,pfull_gen);
temp_crm1_prof=temp_crm1_ztmn(plot_lat,:);
es(:)=satvappres(temp_crm1_prof);
qs(:)=qstar(es,pfull_gen);
gamma_m(3,:)=moistadiabat(temp_eq_prof,qs);

% compute the average over the middle quarter of the domain: 
temp_eq_ztmn_mid=mean(temp_eq_ztmn(60:100,:));
temp_crm_ztmn_mid=mean(temp_crm_ztmn(750:1250,:));
temp_crm1_ztmn_mid=mean(temp_crm1_ztmn(1500:2500,:));

top_2plot=18;
zzfull=squeeze(zfull_2km_zmn(500,:,1));

temp_crm_zmn=squeeze(mean(temp_2km,2));
temp_crm_zmn=temp_crm_zmn(:,:,3:6);
temp_crm_ztmn=squeeze(mean(temp_crm_zmn,3));
temp_crm_ztzmn=squeeze(mean(temp_crm_ztmn,1));

% compute the lcl lifting condensation level (m)
lcl_gcm=lcl_romps(pfull_25km(33),temp_eq_ztmn(80,33),0.01*hur_25km_ztmn(80,33),false,false)
lcl_crm2=lcl_romps(pfull_2km(33),temp_crm_ztmn(1000,33),0.01*hur_2km_ztmn(1000,33),false,false)
lcl_crm1=lcl_romps(pfull_2km(33),temp_crm1_ztmn(2000,33),0.01*hur_1km_ztmn(2000,33),false,false)

% s=cp*T+g*z  % dry static energy
% the output is only a function of height
plot_lat=80;
zfull_prof=squeeze(zfull_25km_ztmn(plot_lat,:));
stastapar(1,:)=stastap(temp_eq_ztmn,plot_lat,psurf_zmn,pfull_gen,zfull_prof);
plot_lat=1000;
%zfull_prof=squeeze(zfull_2km_ztmn(plot_lat,:));
stastapar(2,:)=stastap(temp_crm_ztmn,plot_lat,psurf_2km_zmn,pfull_gen,zfull_prof);
plot_lat=2000;
%zfull_prof=squeeze(zfull_1km_ztmn(plot_lat,:));
stastapar(3,:)=stastap(temp_crm1_ztmn,plot_lat,psurf_1km_zmn,pfull_gen,zfull_prof);

%compute the static stability throughout the domain
staticst_25km             = zeros(160,nlev);
staticst_par_25km         = zeros(160,nlev);
vvel_d_25km               = zeros(160,nlev);
div_d_25km                = zeros(160,nlev);
staticst_25km=stasta_3d(temp_eq_ztmn,160,psurf_zmn,pfull_gen,zfull_prof);
staticst_par_25km=stastap_3d(staticst_25km,160,psurf_zmn,pfull_gen);

staticst_2km              = zeros(2000,nlev);
staticst_par_2km          = zeros(2000,nlev);
vvel_d_2km                = zeros(2000,nlev);
staticst_2km=stasta_3d(temp_crm_ztmn,2000,psurf_2km_zmn,pfull_gen,zfull_prof);
staticst_par_2km=stastap_3d(staticst_2km,2000,psurf_2km_zmn,pfull_gen);

staticst_1km              = zeros(4000,nlev);
staticst_par_1km          = zeros(4000,nlev);
vvel_d_1km                = zeros(4000,nlev);
staticst_1km=stasta_3d(temp_crm1_ztmn,4000,psurf_1km_zmn,pfull_gen,zfull_prof);
staticst_par_1km=stastap_3d(staticst_1km,4000,psurf_1km_zmn,pfull_gen);

% compute the diabatic vertical velocity
vvel_d_25km=rad_heating_25./staticst_par_25km;
vvel_d_2km=rad_heating_2./staticst_par_2km;
vvel_d_1km=rad_heating_1./staticst_par_1km;

% compute the diabatic divergence
div_d_25km=diabdiv(vvel_d_25km,160,psurf_zmn,pfull_gen);
div_d_2km=diabdiv(vvel_d_2km,2000,psurf_2km_zmn,pfull_gen);
div_d_1km=diabdiv(vvel_d_1km,4000,psurf_1km_zmn,pfull_gen);

% compute an approximate lower tropospheric stability
lts=theta_znm(:,21)-theta_sfc(:);

fr_line=zeros(1,33)+273.15;

% Figures -----------------------------------------
%figure
%plot(sten_mn(10:33),zzfull(10:33));
%title('dry static energy')

figure
subplot(2,3,1)
% the 0.01 factor converts to 100hPa/day
vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,0.01.*vvel_d_25km',vvel_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
v=vvel_cons;
clabel(C,h,v);
ylim([20000 100000])
title('GCM: diabatic vertical velocity')
set(gca,'Ydir','reverse')
%colorbar

subplot(2,3,4)
%vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
div_cons=[-.3,-.25,-.2,-0.15,-0.1,-0.05,-0.01,0.0,0.01,0.05,0.1,0.15,0.2,0.25,0.3];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,div_d_25km',div_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
v=div_cons;
clabel(C,h,v);
ylim([20000 100000])
title('GCM: diabatic divergence')
set(gca,'Ydir','reverse')
%colorbar

subplot(2,3,2)
vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,0.01.*vvel_d_2km',vvel_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
v=vvel_cons;
clabel(C,h,v);
ylim([20000 100000])
title('CRM 2km: diabatic vertical velocity')
set(gca,'Ydir','reverse')
%colorbar

subplot(2,3,5)
div_cons=[-.3,-.25,-.2,-0.15,-0.1,-0.05,-0.01,0.0,0.01,0.05,0.1,0.15,0.2,0.25,0.3];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,div_d_2km',div_cons);
v=div_cons;
clabel(C,h,v);
ylim([20000 100000])
title('CRM 2km: diabatic divergence')
set(gca,'Ydir','reverse')
%colorbar

subplot(2,3,3)
vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
[C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,0.01.*vvel_d_1km',vvel_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
v=vvel_cons;
clabel(C,h,v);
ylim([20000 100000])
title('CRM 1km: diabatic vertical velocity')
set(gca,'Ydir','reverse')
%colorbar

subplot(2,3,6)
div_cons=[-.3,-.25,-.2,-0.15,-0.1,-0.05,-0.01,0.0,0.01,0.05,0.1,0.15,0.2,0.25,0.3];
[C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,div_d_1km',div_cons);
v=div_cons;
clabel(C,h,v);
ylim([20000 100000])
title('CRM 1km: diabatic divergence')
set(gca,'Ydir','reverse')
%colorbar


figure
plot(temp_crm_ztmn(1000,top_2plot:33),zzfull(top_2plot:33),'k')
hold on
plot(temp_crm_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'k','LineWidth',2)
plot(temp_crm_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--k')
plot(temp_crm1_ztmn(2000,top_2plot:33),zzfull(top_2plot:33),'g')
plot(temp_crm1_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'g','LineWidth',2)
plot(temp_crm1_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--g')
plot(temp_eq_ztmn(80,top_2plot:33),zzfull(top_2plot:33),'c')
plot(temp_eq_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'c','LineWidth',2)
plot(temp_eq_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--c')
title('Temperature')

figure
plot(temp_crm_ztmn(1000,top_2plot:33),pfull_gen(top_2plot:33),'k')
hold on
plot(temp_crm_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'k','LineWidth',2)
plot(temp_crm_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--k')
plot(temp_crm1_ztmn(2000,top_2plot:33),pfull_gen(top_2plot:33),'g')
plot(temp_crm1_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'g','LineWidth',2)
plot(temp_crm1_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--g')
plot(temp_eq_ztmn(80,top_2plot:33),pfull_gen(top_2plot:33),'c')
plot(temp_eq_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'c','LineWidth',2)
plot(temp_eq_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--c')
plot(fr_line(top_2plot:33),pfull_gen(top_2plot:33))
title('Temperature')
set(gca,'Ydir','reverse')

% plot the lapse rate

% define color1
color1=[0,0.4470,0.7410];
colyel=[0.9290,0.6940,0.1250];
colblu=[0.3010,0.7450,0.9330];
colgrn=[0.4660,0.6740,0.1880];

figure
%plot(-1000.*gamma(80,10:33),zzfull(10:33))
plot(-1000.*gamma(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
plot(-1000.*gamma(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(-1000.*gamma(3,10:33),zzfull(10:33),'-o','Color',colgrn)
plot(1000.*gamma_m(1,10:33),zzfull(10:33),'-o','Color',colyel)
plot(1000.*gamma_m(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(1000.*gamma_m(3,10:33),zzfull(10:33),'-o','Color',colgrn)
xlim([0 10])
title('Lapse Rate (K/km)')


figure % convert from K/Pa to K/100hPa to compare with Mapes
plot(10000*stastapar(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
plot(10000*stastapar(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(10000*stastapar(3,10:33),zzfull(10:33),'-o','Color',colgrn)
xlim([-10 0])
ylim([0 15000])
title('Static Stability Par (K/100hPa)')



