function [onlyocean]=make_onlyocean
% grap the land from one of Ming's files, or one of mine.

% am4 land mask
%landhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc','nowrite');
% am2 and am3 land mask
landhandle=netcdf('/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/atmos.static.nc','nowrite');

land=landhandle{'land_mask'}(:,:);

% mask out the land
% the land mask is originally has ocean set to zero and land rangning from .gt. zero to 1
onlyocean=zeros(size(land));
%onlyocean(land>=0.1)=-999.;
%onlyocean(onlyocean==0)=1.;
%onlyocean(onlyocean==-999.)=0.;
onlyocean(land<=0.05)=-9999.;
onlyocean(land>=0.05)=0.0;
onlyocean(onlyocean<0.0)=1.0;
