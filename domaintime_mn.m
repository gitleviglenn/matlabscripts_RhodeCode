%
% computes the domain and time mean of var
%
% assumes var has dimensions of 
% var(time, grid_yt, grid_xt)
%
% levi silvers
%
function var_dmn=domaintime_mn(var)
  var_mn_a=squeeze(mean(var,1));
  size(var_mn_a);
  var_mn_b=squeeze(mean(var_mn_a,1));
  size(var_mn_b);
  %var_mn_c=squeeze(mean(var_mn_b(1,4:12)));
  %var_mn_c=squeeze(mean(var_mn_b(1,2)));
  var_mn_c=squeeze(mean(var_mn_b,2));
  %var_mn_c=squeeze(var_mn_b(:,4)); % use this line if a particular time period is wanted
  size(var_mn_c);
  var_dmn=var_mn_c;
end
