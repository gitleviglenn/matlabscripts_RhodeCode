function var = lapser(temp,rho,plot_lat,tsfc,psfc,press)
% compute the lapse rate

phys_constants

for j=2:33-1
    var(j)=(-grav*rho(plot_lat,j)).*(temp(plot_lat,j+1)-temp(plot_lat,j-1))/(press(j+1)-press(j-1));
end
var(1)=var(2);
var(33)=(tsfc(plot_lat)-temp(plot_lat,33-1))/(psfc(plot_lat)-press(33-1));

