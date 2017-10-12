%
glbsumweight=nansum(glblatweight_gen(:));
%
wgt_var = fullfield.*glblatweight_gen;

wgt_mean = nansum(wgt_var(:))/glbsumweight;
