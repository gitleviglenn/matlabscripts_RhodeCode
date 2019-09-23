function [msts,sten,ststp] = stasta_3d(temp,hur,nxg,psfc,press,zfull)
%--------------------------------------------------------------
% compute the dry and moist static energy 
%
% also computes the moist static energy
%
% levi silvers                                    June 2019
%--------------------------------------------------------------

% dry static energy: sts=cp*T+gz
phys_constants

% nxg is the number of gridpoints in the x direction

sten  =zeros(nxg,33); % dry static energy
msts =zeros(nxg,33); % moist static energy
ststp=zeros(nxg,33); % static stability par

% compute the static stability
for i=1:nxg
for j=1:33
    sten(i,j)=cp*temp(i,j)+grav*zfull(j);
    msts(i,j)=cp*temp(i,j)+grav*zfull(j)+hur(i,j)*latheat;
    %sts(j)=cp%*temp(plot_lat,j)%+grav*zfull(j);
end
end
%% compute the static stability parameter [K/Pa]
for i=1:nxg
  for j=2:33-1
    ststp(i,j)=(1/cp).*(sten(i,j+1)-sten(i,j-1))/(press(j+1)-press(j-1));
  end
  ststp(i,1)=sten(i,2);
  ststp(i,33)=(1/cp).*(sten(i,33)-sten(i,32))/(psfc(i)-press(32));
end
