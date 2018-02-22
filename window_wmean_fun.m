function [glb_wgt_mean,glb_wgt_mean_wind,wgt_mean_wind_area,wind_relarea]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2)
%------------------------------------------------------------
% computes the latitude weighted global mean value of 
% the 'fullfield' variable
%
% for some reason I am having problems getting the functional
% for of this to work which would have 'out_var' as the 
% output of the function.  it could be an issue with the way 
% that functions work in the 2009 version of matlab or it 
% could be some other pathological behavior of matlab.
%
% levi silvers                                 june 2017
%------------------------------------------------------------

longit=vlon;
%nlongit=size(longit,1);
latit=vlat;
%nlatit=size(latit,1);
% compute the weights
latitweight=cos(double(pi)/180*latit);
glblatweight=cos(double(pi)/180*latit);
nlongit=length(longit);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,latitweight);
end
glblatweight_wind=glblatweight(wlat1:wlat2,wlon1:wlon2);
%glbsumweight=sum(glblatweight(:));
glbsumweight=nansum(glblatweight(:));
glbsumweight_wind=nansum(glblatweight_wind(:));

%
window_fieldin=fieldin(wlat1:wlat2,wlon1:wlon2);

wgt_var       = fieldin.*glblatweight;
%siwindin=size(window_fieldin)
%swglbweightwind=size(glblatweight_wind)
wgt_var_wind  = window_fieldin.*glblatweight_wind;

% output.....
% total global weighted mean
glb_wgt_mean      = nansum(wgt_var(:))/glbsumweight;

% contribution to the total global weighted mean from the given window...
% fractional value
glb_wgt_mean_wind = nansum(wgt_var_wind(:))/glbsumweight;

% weighted mean over given window
% window mean
wgt_mean_wind_area = nansum(wgt_var_wind(:))/glbsumweight_wind;

% size of window relative to global total
wind_relarea = glbsumweight_wind/glbsumweight;





