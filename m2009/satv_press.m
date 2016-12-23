function [es]=satv_press(temperature)
% output saturation vapor pressure in Pa
% incoming temperature shoudl be in Kelvin
%
% to do: allow for computation with arrays
%
% levi silvers                  dec 2016
const1=610.8;
const2=17.27;
const3=35.85;
t_zeroc=273.15;

es=const1*exp(const2.*(temperature-t_zeroc)/(temperature-const3));

