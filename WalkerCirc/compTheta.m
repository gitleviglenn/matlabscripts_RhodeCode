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
gamma_d     = zeros(nlev);
gamma_m     = zeros(nlev);
%gamma       = zeros(nlat,nlev);
gamma       = zeros(3,nlev);

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

% lev 1 is the at the top of the domain, lev 33 is the lowest atmospheric level
% gamma = -g*rho*delT/delp
plot_lat=80;

%for lev=2:nlev-1
%    gamma(plot_lat,lev)=(-grav*rho_25km(plot_lat,lev)).*(temp_eq_ztmn(plot_lat,lev+1)-temp_eq_ztmn(plot_lat,lev-1))/(pfull_gen(lev+1)-pfull_gen(lev-1));
%end
%gamma(plot_lat,1)=gamma(plot_lat,2);
%gamma(plot_lat,nlev)=(tsfc_mn(plot_lat,4)-temp_eq_ztmn(plot_lat,nlev-1))/(psurf(plot_lat,4)-pfull_gen(nlev-1));

gamma(1,:)=lapser(temp_eq_ztmn,rho_25km,plot_lat,tsfc_mn,psurf,pfull_gen);
plot_lat=1000;
gamma(2,:)=lapser(temp_crm_ztmn,rho_2km,plot_lat,tsurf_crm2_ztmn,psurf,pfull_gen);
%plot_lat=2000;
%gamma(3,:)=lapser(temp_eq_ztmn,rho_25km,plot_lat,tsfc_mn,psurf,pfull_gen);

% compute the average over the middle quarter of the domain: 
temp_eq_ztmn_mid=mean(temp_eq_ztmn(60:100,:));
temp_crm_ztmn_mid=mean(temp_crm_ztmn(750:1250,:));
temp_crm1_ztmn_mid=mean(temp_crm1_ztmn(1500:2500,:));

top_2plot=18;
zzfull=squeeze(zfull_25km_zmn(500,:,1));

temp_crm_zmn=squeeze(mean(temp_2km,2));
temp_crm_zmn=temp_crm_zmn(:,:,3:6);
temp_crm_ztmn=squeeze(mean(temp_crm_zmn,3));
temp_crm_ztzmn=squeeze(mean(temp_crm_ztmn,1));

% s=cp*T+g*z  % dry static energy
blah=flipdim(temp_eq_ztmn,2);
for xi=1:160;
  for lev=1:nlev;
    %sten(xi,lev)=cp*temp_znm(xi,lev)+g*zfull_25km_zmn(1000,lev,1);
    sten(xi,lev)=cp*blah(xi,lev)+g*zfull_25km_zmn(1000,lev,1);
  end
end
%zzfull=squeeze(zfull_25km_zmn(500,:,1));
sten_mn=mean(sten,1);

% compute an approximate lower tropospheric stability
lts=theta_znm(:,21)-theta_sfc(:);

% Figures -----------------------------------------
figure
plot(sten_mn(10:33),zzfull(10:33));
title('dry static energy')

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
figure
%plot(-1000.*gamma(80,10:33),zzfull(10:33))
plot(-1000.*gamma(2,10:33),zzfull(10:33))
xlim([0 10])
title('Lapse Rate (K/km)')

