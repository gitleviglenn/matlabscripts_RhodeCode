%---------------------------------------------------------------------------------------
% see Wood and Bretherton 2006
% 
% this script computes the LTS and EIS using equation 4 and 5
% it is assumed that the necessary variables have already been loaded
% e.g. v.tsurf --> use something like openncfile_new.m
%
% this is called by driver_test.m and eis_lts_ts.m
%
% do I want to make this into a function that outputs LTS and EIS?
% if so it could work nicely to have the input from the function be the 
% source for the experimental data and the output being the LTS and EIS.
%
% with these as output it would be simple to plot LTS and EIS either 
% directly, or to compute differences between LTS and EIS and then use
% cont_wcolorbar_eis to plot the differences.  
%
% CAUTION!  the number of levels is different between AM2.1 and the later models
% this matters! 
%
% variables used in computations below:
% level
% tsurf or tref
% temp
% rh
% hght
%
% levi silvers                                 march 2017
%---------------------------------------------------------------------------------------
%
Lv=2.500*10^6; % J/kg
g=9.81; %m/s2
cp=1000.; % J/(kg K) cp for dry air
Ra=287.; % J/(kg K) gas constant for dry air
Rv=461.; % J/(kg K) gas constant for water vapor
T0=280.; % K surface temperature
p0=100000.; % Pa
rh0=0.8;
kappa=Ra/cp;

%vlevel=squeeze(vlevel(:));

%vlevel=100.*vlevel;
%nlev=size(vlevel,1);

theta_f     = zeros(nlev,nlat,nlon); % potential temp
temp3       = zeros(nlat,nlon);
lts_f       = zeros(nlat,nlon);
%rh_sfc      = zeros(nlat,nlon);
theta_temp1 = zeros(nlat,nlon);

%theta_temp1=squeeze(v.tref_am4ts(timenow,:,:)).*((p0/v.level(1))^kappa);
%theta_temp1=squeeze(v.tsurf_am4ts(timenow,:,:)).*((p0/v.level(1))^kappa);
theta_temp1=squeeze(temp_ll_ts(timenow,:,:)).*((p0/vlevel(1))^kappa);
theta_f(1,:,:)=theta_temp1(:,:);
for lev=2:nlev;
  p_lev=vlevel(lev);
  temptemp=squeeze(temp3d(timenow,lev,:,:));
  temp3=temptemp;
  temp3(temptemp<240)=240.;
  theta_temp=temp3.*((p0/p_lev)^kappa);
  theta_f(lev,:,:)=theta_temp;
end

%theta0_f=v.tsurf.*(1.0)^kappa;
%lts_f=theta_f(5,:,:)-theta_f(1,:,:);
%lts = theta_700 - theta_sfc

%level700=4; % AM3 and AM4, level700=4 for AM2
% for AM3, and AM4 this corresponds to theta_f(5,:,:-theta_f(1,:,:));
lts_f=theta_f(level700,:,:)-theta_f(1,:,:);
% when computing eis, lts for AM2: 
%lts_f=theta_f(4,:,:)-theta_f(1,:,:);
lts_f=squeeze(lts_f);

% compute gamma_m_850 (level 3 for AM2,AM3, and AM4)
%t_850=(v.temp(1,:,:)+v.temp(5,:,:))/2.;
t_850=temp3d(timenow,3,:,:);
%v.temp=squeeze(temp3d(timenow,:,:,:));
t_850(t_850<0)=50.;
es_850=610.8*exp(17.27.*(t_850-273.15)./(t_850-35.85)); % [Pa] sat vapor press on 850 hPa level
pp=es_850.*0;
pp=pp+85000.;
qs_850=0.622.*es_850./(pp-es_850); % [kg/kg] sat mixing ratio on 850 hPa level
gamma_m_850=(g/cp)*(1-(1+Lv*qs_850./(Ra*t_850))./(1+Lv*Lv*qs_850./(cp*Rv*t_850.*t_850)));
%
% compute an approximate lifting condensation level (lcl)
% i thnk that Espy's lcl formula is intended for RH>50% and temp>0 C.  
%rh_sfc=squeeze(v.rh(1,:,:))./100.;
%rh_sfc=rh_ll(timenow,:,:)./100.;
%rh_sfc(isnan(rh_sfc))=rh0;
% using only surface values
%lcl=(20.+(v.tsurf-273.15)/5.).*(1.-rh_sfc)*100.;
temp_llev=squeeze(temp3d(timenow,1,:,:));
%rh_llev=v.rh(:,:)./100;
rh_llev=squeeze(rh_ll(timenow,:,:)./100);
%temp_llev(temp_llev<0)=NaN;
%rh_llev(rh_llev<0)=NaN;
temp_llev(temp_llev<200)=200;
rh_llev(rh_llev<0.05)=0.05;
lcl=(20.+(temp_llev-273.15)/5.).*(1.-rh_llev)*100.;
%
%estinvs=lts_f-gamma_m_850.*(squeeze(v.hght(5,:,:))-lcl);
% hght(5,:,:) = corresponds to the height at the 700hPa level
estinvs=squeeze(lts_f)-squeeze(gamma_m_850).*(squeeze(hght(timenow,:,:))-lcl);
%
