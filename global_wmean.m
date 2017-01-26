function out_var=global_wmean(fieldin,vlon,vlat)
%------------------------------------------------------------
% levi silvers                                 oct 2016
%------------------------------------------------------------
%clear longit latit latitweight glblatweight nlongit
%clear glbsumweight wgt_var out_var

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

out_var=glblatweight;

%sumone=sum(glblatweight);
%size(sumone)
%sumtwo=sum(sumone);
%size(sumtwo)
%sumtwo
%
%glbsumweight
%
%in_var=fieldin;
%%wgt_var       = in_var(:,:).*glblatweight;
%wgt_var       = in_var.*glblatweight;
%%out_var = sum(wgt_var(:))/glbsumweight
%out_var = nansum(wgt_var(:))/glbsumweight;
