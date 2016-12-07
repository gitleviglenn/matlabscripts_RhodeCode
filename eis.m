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
theta=temp(p/p0)^kappa

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

% compute an approximate lifting condensation level (lcl)
lcl=(20.+(temp-273.15)/5.)*(1.-rh0)*100.;

%
%%gamma_m=zeros(size(temp,2),size(press,2));
%frac=zeros(size(temp,2),size(press,2));
%
%num=1;
%den=1;
%%frac=num./den;
%frac=10;
%
%gamma_m=g/cp.*(1-frac)
