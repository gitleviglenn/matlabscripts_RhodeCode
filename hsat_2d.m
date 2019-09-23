function [hstar] = hsat_2d(temp,nxg,qsat,zfull)
%--------------------------------------------------------------
% computes the saturated moist static energy
%
% levi silvers          
%--------------------------------------------------------------

hstar=zeros(nxg,33);

% dry static energy: sts=cp*T+gz
phys_constants

% compute the static stability
for i=1:nxg
for j=1:33
    hstar(i,j)=cp*temp(i,j)+grav*zfull(j)+latheat*qsat(j);
end
end

