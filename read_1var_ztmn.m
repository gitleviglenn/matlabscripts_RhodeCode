%--------------------------------------------------------------------------------------
% matlab function to open a netcdf file, read and save a variable, average over time
% and over the 'y' dimension.
%
% this can be very confusing.  for the data i am using at the time, the netcdf file 
% shows the variable dimensions for 'varnam' in 'filnam' to be: 
% varname(time, height, ydim, xdim)
% however, when using ncread() in matlab the dimensions of var turn out to be
% var(xdim, ydim, height, time)
%
% written originally with Matlab 2015a
%
% levi silvers                                                       june 2018
%--------------------------------------------------------------------------------------

function var = read_1var_ztmn(filnam,varnam)
  var = ncread(filnam,varnam);
  var = squeeze(mean(var(:,:,:,:),4)); % average over time
  var = squeeze(mean(var,2)); % average meridionally
end
