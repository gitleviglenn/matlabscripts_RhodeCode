function out_prof=global_wmean3d(fieldin,nlev,vlon,vlat)
%------------------------------------------------------------

% incoming field fieldin should be a 3d field
% this script depends on global_wmean.m

% global_wmean.m is written to account for NaN's

% levi silvers                                 oct 2016
%------------------------------------------------------------

longit=vlon;
latit=vlat;
index=nlev;

out_prof=zeros(1,nlev);

%% compute the weights
%latitweight=cos(pi/180*latit);
%glblatweight=cos(pi/180*latit);
%nlongit=length(longit);
%for index=1:nlongit-1;
%  glblatweight=horzcat(glblatweight,latitweight);
%end
%glbsumweight=sum(glblatweight(:));
%
%in_var=fieldin;
%wgt_var       = in_var(:,:).*glblatweight;
%out_var = sum(wgt_var(:))/glbsumweight


%fieldin2d=squeeze(fieldin(index,:,:));

for index=1:nlev;
  fieldin2d=squeeze(fieldin(index,:,:));
  out_prof(index)=global_wmean(fieldin2d,longit,latit);
end
