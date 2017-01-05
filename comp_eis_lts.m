%
% see Wood and Bretherton 2006
% 
% this script computes the LTS and EIS using equation 4 and 5
% it is assumed that the necessary variables have already been loaded
% e.g. v.tsurf
%
% do I want to make this into a function that outputs LTS and EIS?
% if so it could work nicely to have the input from the function be the 
% source for the experimental data and the output being the LTS and EIS.
%
% with these as output it would be simple to plot LTS and EIS either 
% directly, or to compute differences between LTS and EIS and then use
% cont_wcolorbar_eis to plot the differences.  
%
% levi silvers                                 dec 2016
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

theta_f=zeros(288,180,23);
temp3=zeros(288,180);
lts_f=zeros(288,180);
rh_sfc=zeros(288,180);
  %theta_temp1=v.tsurf(:,:).*((p0/v.level(1))^kappa);
  theta_temp1=v.tref(:,:).*((p0/v.level(1))^kappa);
  %theta_f(1,:,:)=theta_temp1;
  theta_f(:,:,1)=theta_temp1;
for lev=2:23;
  p_lev=v.level(lev);
  %temptemp=squeeze(v.temp(lev,:,:));
  temptemp=squeeze(v.temp(:,:,lev));
  temp3=temptemp;
  temp3(temptemp<240)=240.;
  theta_temp=temp3.*((p0/p_lev)^kappa);
  %theta_f(lev,:,:)=theta_temp;
  theta_f(:,:,lev)=theta_temp;
end

%theta0_f=v.tsurf.*(1.0)^kappa;
%lts_f=theta_f(5,:,:)-theta_f(1,:,:);
lts_f=theta_f(:,:,5)-theta_f(:,:,1);

% compute gamma_m_850
%t_850=(v.temp(1,:,:)+v.temp(5,:,:))/2.;
t_850=v.temp(:,:,3); % temperature on 850 hPa level
t_850(t_850<0)=150.;
%es_850=6.11*exp((Lv/Rv)*((1./273.15)-(1./t_850))); % sat vapor press on 850 hPa level
es_850=610.8*exp(17.27.*(t_850-273.15)./(t_850-35.85)); % [Pa] sat vapor press on 850 hPa level
pp=es_850.*0;
pp=pp+85000.;
qs_850=0.622.*es_850./(pp-es_850); % sat mixing ratio on 850 hPa level
gamma_m_850=(g/cp)*(1-(1+Lv*qs_850./(Ra*t_850))./(1+Lv*Lv*qs_850./(cp*Rv*t_850.*t_850)));
%
% compute an approximate lifting condensation level (lcl)
rh_sfc=v.rh(:,:,1)./100.;
rh_sfc(isnan(rh_sfc))=rh0;
%lcl=(20.+(temp-273.15)/5.)*(1.-rh0)*100.;
% using only surface values
%lcl=(20.+(T0-273.15)/5.)*(1.-rh0)*100.;
%lcl=(20.+(v.tsurf-273.15)/5.)*(1.-rh0)*100.;
%lcl=(20.+(v.tsurf-273.15)/5.).*(1.-rh_sfc)*100.;
% see Lawrence 2005, BAMS, equation 24
% the lcl can presumably also be computed with a method from
% Georgakakos and Bras (1984), as used in Myers and Norris, 2013
lcl=(20.+(v.tref-273.15)/5.).*(1.-rh_sfc)*100.;

%
estinvs=lts_f-gamma_m_850.*(squeeze(v.hght(:,:,5))-lcl);
%
% plot the LTS and EIS
%
titin='Lower Tropispheric Stability';
cont_wcolorbar_eis(lts_f',titin)
%titin='estimated inversion strength';
%cont_wcolorbar_eis(estinvs',titin)
figure;
conts=[-6,-4,-2,0,2,4,6,8,10,12,14];
fig1=contourf(squeeze(estinvs)',conts);
caxis([-6 14]);
cmap_orang=[
82,211,255;
138,255,255;
197,255,255;
255,255,138;
255,211,82;
255,153,27;
226,96,0;
168,41,0;
111,0,0;
56,0,0];
%0,0,0];
cmap=cmap_orang/256;
colormap(cmap(1:10,:))
h=colorbar('SouthOutside');
title('Estimated Inversion Strength')

%
%%
% commands to generate differences after teh ctl,p2K,4xCO2, and 1pctCO2 fields are computed
%
%eis_p2Kmctl=eis_p2K-eis_ctl;
%lts_p2Kmctl=lts_p2K-lts_ctl;
%
%eis_4xCO2mctl=eis_4xCO2-eis_ctl;
%lts_4xCO2mctl=lts_4xCO2-lts_ctl;
%
%lts_1pctCO2mctl=lts_1pctCO2-lts_ctl;
%eis_1pctCO2mctl=eis_1pctCO2-eis_ctl;
%
%
