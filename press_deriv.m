function var = press_deriv(fieldin,psfc,press)
% compute the pressure derivative of fieldin
%
% fieldin   variable which will be differentiated
% psfc      surface pressure at a single point
% press     vertical array of pressure
%
% levi silvers            april 2019
%
%---------------------------------------------
var=zeros(1,33);
for j=2:33-1
  var(j)=(fieldin(j+1)-fieldin(j-1))/(press(j+1)-press(j-1));
end
var(1)=var(2);
var(33)=(fieldin(33)-fieldin(32))/(psfc-press(32));
