%function out_var=global_wmean(fieldin,vlon,vlat)
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
% levi silvers                                 dec 2016
%------------------------------------------------------------

longit=vlon;
%nlongit=size(longit,1);
latit=vlat;
%nlatit=size(latit,1);
% compute the weights
latitweight=cos(double(pi)/180*latit);
glblatweight=cos(double(pi)/180*latit);
%latitweight=1.*latit;
%glblatweight=1.*latit;
nlongit=length(longit);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,latitweight);
end
%glbsumweight=sum(glblatweight(:));
%
glbsumweight=nansum(glblatweight(:));
%glbsumweight=nlongit*nlatit;

%
%siff=size(fullfield)
%sigl=size(glblatweight)
wgt_var       = fullfield.*glblatweight;

%out_var = sum(wgt_var(:))/glbsumweight
wgt_mean = nansum(wgt_var(:))/glbsumweight;



