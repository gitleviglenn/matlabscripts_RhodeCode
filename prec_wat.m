function [var] = prec_wat(nxg,rho_air,psfc,sph,press)

phys_constants

var=zeros(nxg,33);

% lev 1 is TOA
% lev 33 is lowest atmospheric model level.  not surface

for i=1:nxg
  for j=1:33-1
    delp=press(j+1)-press(j); % this should be positive
    var(i,j)=(1/(grav)).*sph(i,j+1)*delp;
  end
  var(i,33)=(1/(grav*997.)).*sph(i,33)*(psfc-press(33));
end
