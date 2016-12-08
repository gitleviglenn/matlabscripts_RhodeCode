%
% see Wood and Bretherton 2006
% 
% this script computes the EIS using equation 4 and 5
%
% levi silvers                                 dec 2016
%
Lv=2.500*10^6 % J/kg
g=9.81 %m/s2
cp=1000. % J/(kg K) cp for dry air
Ra=287. % J/(kg K) gas constant for dry air
Rv=461. % J/(kg K) gas constant for water vapor
T0=280. % K surface temperature
p0=100000. % Pa
rh0=0.8
kappa=Ra/cp;

% moist-adiabatic potential temperature gradient gamma_m
temp=273.15:1:373.15;
press=100:5:1000;

% compute the Lower Tropospheric Stability (LTS)
% (theta_700-theta_0)
p_z=700;
theta0=temp.*(1.0)^kappa;
theta=temp.*(p_z/p0)^kappa;
lts=theta0-theta;

% lts 
% there are difficulties in computing theta where land is present because 
%
theta_f=zeros(23,180,288);
temp3=zeros(180,288);
  theta_temp1=v.tsurf(:,:).*((p0/v.level(1))^kappa);
  theta_f(1,:,:)=theta_temp1;
for lev=2:23;
  p_lev=v.level(lev);
  temptemp=squeeze(v.temp(lev,:,:));
  temp3=temptemp;
  temp3(temptemp<150)=150.;
  %theta_temp=temptemp.*((p0/p_lev)^kappa);
  theta_temp=temp3.*((p0/p_lev)^kappa);
  theta_f(lev,:,:)=theta_temp;
end

%theta0_f=v.tsurf.*(1.0)^kappa;
lts_f=zeros(180,288);
lts_f=theta_f(5,:,:)-theta_f(1,:,:);

% compute the saturation mixing ratio qs=0.622*es/(p-es)
es=6.11*exp((Lv/Rv)*((1./273.15)-(1./temp)));
%qs=0.622.*es/.(p-es);
for i=1:181;
  for j=1:61;
    es_temp=6.11*exp((Lv/Rv)*((1./273.15)-(1./temp(j))));
    qs(j,i)=0.622*es_temp/(press(i)-es_temp);
  end
end

gamma_m=zeros(size(temp,2),size(press,2));
for i=1:181;
  for j=1:61;
    gamma_m(j,i)=(g/cp)*(1-(1+Lv*qs(j,i)/(Ra*temp(j)))/(1+Lv*Lv*qs(j,i)/(cp*Rv*temp(j)*temp(j))));
  end
end

% compute gamma_m_850
%t_850=(v.temp(1,:,:)+v.temp(5,:,:))/2.;
t_850=v.temp(3,:,:);
t_850(t_850<0)=150.;
es_temp_850=6.11*exp((Lv/Rv)*((1./273.15)-(1./t_850)));
qs_850=0.622*es_temp/(85000.-es_temp);
gamma_m_850=(g/cp)*(1-(1+Lv*qs_850/(Ra*t_850))/(1+Lv*Lv*qs_850/(cp*Rv*t_850*t_850)));
% compute an approximate lifting condensation level (lcl)
%lcl=(20.+(temp-273.15)/5.)*(1.-rh0)*100.;
% using only surface values
lcl=(20.+(T0-273.15)/5.)*(1.-rh0)*100.;

% and now for the estimated inversion strength: estinvs
% eis=lts - gamma_m(850)*(z(700)-LCL);
% what value should be used for the height of the 700 mb pressure surface?  
%
estinvs=lts_f-gamma_m_850*(squeeze(hght(5,:,:))-lcl);
%
%
%%gamma_m=zeros(size(temp,2),size(press,2));
