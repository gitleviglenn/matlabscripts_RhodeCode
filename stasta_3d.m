function var = stasta_3d(temp,nxg,psfc,press,zfull)
% compute the static stability parameter, as shown in Mapes
% 2001, figure 1b.  

% dry static energy: sts=cp*T+gz
phys_constants

% nxg is the number of gridpoints in the x direction

var=zeros(nxg,33);

% compute the static stability
for i=1:nxg
for j=1:33
    var(i,j)=cp*temp(i,j)+grav*zfull(j);
    %sts(j)=cp%*temp(plot_lat,j)%+grav*zfull(j);
end
end
%% compute the static stability parameter [K/Pa]
%for j=2:33-1
%    var(j)=(1/cp).*(sts(j+1)-sts(j-1))/(press(j+1)-press(j-1));
%end
%var(1)=var(2);
%var(33)=(1/cp).*(sts(33)-sts(32))/(psfc(plot_lat)-press(32));
