function var = satvappres(temp)

% approximate computation for the saturation vapor pressure
% originally taken from notes by David Randall

phys_constants

%temp=temp-273.15; % convert to celcius

for j=1:33
  var(j) = 6.11*exp((latheat/Rv)*(1./273-1./temp(j)));
end


var=100.*var; % convert to Pa

% qstar(T,p) --> is the saturation mixing ratio

% the definition of qstar is rho_vstar (saturation vapor density) divided by
% the rho_d (density of dry air)

% e = vapor pressure

% q = rho_v/rho_d = epsilon e / p_d = 0.622 e/p_d; throughout the troposphere: 
% q approx = 0.622 e/p

% qstar(T,p) approx = epsilon estar(T)/p
