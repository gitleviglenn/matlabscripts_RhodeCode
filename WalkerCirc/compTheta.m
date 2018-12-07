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
gamma       = zeros(nlat,nlev);

gamma_d = gamma_d+grav/cp;

sten        = zeros(nlat,nlev);

% first compute theta at the surface
tsurf_zmn=squeeze(mean(tsfc_mn,2));
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
temp_eq_tzmn=squeeze(mean(temp_eq_tmn,2));
temp_eq_ztmn=squeeze(mean(temp_eq_tmn,2));
for lev=1:nlev;
   p_lev=100.0*pfull_gen(lev);
   temptemp=squeeze(temp_eq_tmn(:,:,lev));
   temp3=temptemp;
%   temp3(temptemp<240)=240.;
   theta_temp=temp3.*((p0/p_lev)^kappa);
   theta_f(:,:,lev)=theta_temp;
end
theta_znm=squeeze(mean(theta_f,2));

plot_lat=80;
for lev=2:nlev-1
    gamma(plot_lat,lev)=(temp_eq_tzmn(plot_lat,lev+1)-temp_eq_tzmn(plot_lat,lev-1))/(pfull_gen(lev+1)-pfull_gen(lev-1));
end
gamma(plot_lat,1)=gamma(plot_lat,2);
gamma(plot_lat,nlev)=(tsfc_mn(plot_lat,4)-temp_eq_tzmn(plot_lat,nlev-1))/(psurf(plot_lat,4)-pfull_gen(nlev-1));

%function deriv = Dp(P, dp, plot_lat)
%P(plot_lat,1)=P(plot_lat,2);
%for plev=2:nlev-1
%    deriv(plot_lat,plev)=(temp_eq_tzmn(plot_lat,plev+1)-temp_eq_tmn(plot_lat,plev-1))/(pfull_gen(plev+1)-pfull_gen(plev-1));
%end
%
%end % function Dp

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
zzfull=squeeze(zfull_25km_zmn(500,:,1));
sten_mn=mean(sten,1);
figure
plot(sten_mn(10:33),zzfull(10:33));
title('dry static energy')

% plot the lapse rate
figure
plot(gamma(80,10:33),zzfull(10:33))
title('lapse rate')

% compute an approximate lower tropospheric stability
lts=theta_znm(:,21)-theta_sfc(:);
