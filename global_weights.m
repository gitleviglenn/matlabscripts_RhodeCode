
longit=vlon;
latit=vlat;
% compute the weights
latitweight=cos(double(pi)/180*latit);
glblatweight=cos(double(pi)/180*latit);
nlongit=length(longit);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,latitweight);
end

%glblatweight_am4=glblatweight;
glblatweight_gen=glblatweight;

dims_of_glbweights=size(glblatweight_gen)
