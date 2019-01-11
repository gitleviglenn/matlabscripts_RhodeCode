function var = rho_2d_gen(temp,shum,press,xdim)
% assumes that incoming fields are zonal time mean fields
% except for press which should only have the vertical dimension

phys_constants

Tv_gen=temp.*(1+shum./epsilon)./(1+shum);

for j=33:-1:1
  for i=1:xdim
    var(i,j)=press(j)/(r_dry*Tv_gen(i,j)); % compute 2d density
  end
end
