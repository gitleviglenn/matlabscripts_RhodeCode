function out_var=global_wmean(fieldin,vlon,vlat)
%------------------------------------------------------------
% levi silvers                                 oct 2016
%------------------------------------------------------------


longit=vlon;
latit=vlat;
% compute the weights
latitweight=cos(pi/180*latit);
glblatweight=cos(pi/180*latit);
nlongit=length(longit);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,latitweight);
end
%glbsumweight=sum(glblatweight(:));
glbsumweight=nansum(glblatweight(:));

in_var=fieldin;
wgt_var       = in_var(:,:).*glblatweight;
%out_var = sum(wgt_var(:))/glbsumweight
out_var = nansum(wgt_var(:))/glbsumweight;
