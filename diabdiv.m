function var = diabdiv(dvvel,nxg,psfc,press)
% compute the diabatic divergence as approximated by Mapes 2001
% this is just the pressure derivative of the the diabatic vertical
% velocity, or Q/sigma

% units?

% dvvel is the diabatic vertical velocity
dvvel=-dvvel;

%phys_constants

var=zeros(nxg,33);

for i=1:nxg
    for j=2:33-1
        var(i,j)=(dvvel(i,j+1)-dvvel(i,j-1))/(press(j+1)-press(j-1));
    end
    var(i,1)=var(i,2);
    var(i,33)=(dvvel(i,33)-dvvel(i,32))/(psfc(i)-press(32));
end
