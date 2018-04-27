% compute the potential temperature using temperature and pressure

tsurf_fulltime=ncread(source_25km,'t_surf');
tsfc=tsurf_fulltime(:,:,32:365);
tsfc_mn=mean(tsfc,3);

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

theta_temp=tsfc_mn.*((p0/pfull_25km(33))^kappa);
theta_f(:,:,33)=theta_temp(:,:);
temp_25km_last11=temp_25km(:,:,:,2:12);
temp_25km_tmn=squeeze(mean(temp_25km_last11,4));
for lev=1:nlev;
   p_lev=pfull_25km(lev);
   temptemp=squeeze(temp_25km_tmn(:,:,lev));
   temp3=temptemp;
%   temp3(temptemp<240)=240.;
   theta_temp=temp3.*((p0/p_lev)^kappa);
   theta_f(:,:,lev)=theta_temp;
end

theta_znm=squeeze(mean(theta_f,2));
temp_znm=squeeze(mean(temp_25km_tmn,2));
