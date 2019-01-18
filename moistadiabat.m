function var=moistadiabat(temp,qstar)

phys_constants

for j=1:33
    num(j) = (1+(latheat.*qstar(j))./(r_dry.*temp(j)));
    den(j) = (1+(qstar(j)*latheat^2)./(cp*Rv.*temp(j).^2));
    var(j) = (grav/cp)*num(j)/den(j);
end

num

den



