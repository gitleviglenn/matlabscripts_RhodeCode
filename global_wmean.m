function global_wmean(fieldin,vlon,vlat)


longit=vlon;
latit=vlat;
% compute the weights
latitweight=cos(pi/180*latit);
glblatweight=cos(pi/180*latit);
nlongit=length(longit);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,latitweight);
end
glbsumweight=sum(glblatweight(:));

in_var=fieldin;
wgt_var       = in_var(:,:).*glblatweight;
out_var = sum(wgt_var(:))/glbsumweight
