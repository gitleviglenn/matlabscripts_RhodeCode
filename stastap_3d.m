function var = stastap_3d(statst,nxg,psfc,press)
% compute the static stability parameter, as shown in Mapes
% 2001, figure 1b.  

% dry static energy: sts=cp*T+gz
phys_constants

var=zeros(nxg,33);

%sts=zeros(1,33);

% compute the static stability parameter [K/Pa]
for i=1:nxg
    for j=2:33-1
        var(i,j)=(1/cp).*(statst(i,j+1)-statst(i,j-1))/(press(j+1)-press(j-1));
    end
    var(i,1)=var(i,2);
    var(i,33)=(1/cp).*(statst(i,33)-statst(i,32))/(psfc(i)-press(32));
end
%var(:,1)=var(2);
%var(33)=(1/cp).*(sts(33)-sts(32))/(psfc(plot_lat)-press(32));
