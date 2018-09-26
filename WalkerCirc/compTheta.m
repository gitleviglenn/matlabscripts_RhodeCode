% compute the potential temperature using temperature and pressure

% define constants and initial arrays
Lv=2.500*10^6; % J/kg
g=9.81; %m/s2
cp=1000.; % J/(kg K) cp for dry air
Ra=287.; % J/(kg K) gas constant for dry air
Rv=461.; % J/(kg K) gas constant for water vapor
T0=280.; % K surface temperature
p0=100000.; % Pa
rh0=0.8;
kappa=Ra/cp;

nlev=33;
nlat=160;
nlon=8;

theta_f     = zeros(nlat,nlon,nlev);
temp3       = zeros(nlat,nlon);
lts_f       = zeros(nlat,nlon);
rh_sfc      = zeros(nlat,nlon);
theta_temp = zeros(nlat,nlon);

sten        = zeros(nlat,nlev);

% first compute theta at the surface
tsurf_zmn=squeeze(mean(tsfc_mn,2));
% compute theta at the surface
theta_sfc=tsurf_zmn.*(p0./psurf_zmn).^kappa;

% now compute theta throughout the atmospheric depth
theta_temp=tsfc_mn.*((p0/pfull_25km(33))^kappa);
theta_f(:,:,33)=theta_temp(:,:);
temp_25km_last11=temp_25km(:,:,:,2:12);
temp_25km_tmn=squeeze(mean(temp_25km_last11,4));
for lev=1:nlev;
   p_lev=100.0*pfull_25km(lev);
   temptemp=squeeze(temp_25km_tmn(:,:,lev));
   temp3=temptemp;
%   temp3(temptemp<240)=240.;
   theta_temp=temp3.*((p0/p_lev)^kappa);
   theta_f(:,:,lev)=theta_temp;
end

theta_znm=squeeze(mean(theta_f,2));
temp_znm=squeeze(mean(temp_25km_tmn,2));

% s=cp*T+g*z
blah=flipdim(temp_znm,2);
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

% compute an approximate lower tropospheric stability
lts=theta_znm(:,21)-theta_sfc(:);
