%-------------------------------------------------------------------------------------------
% make_aqua_ozone.m
%
% This script opens a file with CFMIP3 specified climatology ozone and 
% modifies it a bit to make it usable by the AM4 model as input
%
% The initial file has 12 monthly time steps, corresponding to 1 year.
% This needs to be extended to 11 years.  
%
% input: /Users/silvers/data/apeozone_cam3_5_54.nc
%
% final product: aquaplanet_ozone_cfmip3.nc
%
% levi silvers                                                                  june 2018
%-------------------------------------------------------------------------------------------

% this is the ozone file supplied by cfmip3, see Webb et al. 2017 for details
fin_cfmip_o3='/Users/silvers/data/apeozone_cam3_5_54.nc'

% this is the time average ozone file that was previously used in
% aquaplanet experiments...  
% it looks like the pfull variable from the prviously used ozone file
% is identical to the lev variable in the cfmip provided file...
fin_o3_short='/Users/silvers/data/ape_ncks.nc'

o3_climo=ncread(fin_cfmip_o3,'OZONE');
o3_tmn=ncread(fin_o3_short,'ozone');
pfull=ncread(fin_o3_short,'pfull');
phalf=ncread(fin_o3_short,'phalf');
% 
lat = ncread(fin_cfmip_o3,'lat');
lon = ncread(fin_cfmip_o3,'lon');
% lat_bnds = ncread(fin_amip_full_sst,'lat_bnds');
% lon_bnds = ncread(fin_amip_full_sst,'lon_bnds');
% 
% %sst_amip = cat(3,sst_climo,sst_co2);
 nlon=128;
 nlat=64;
%
% time is an imaginary reference to days, a difference of
% 30 in 'time' is about a month.
time(1)=0;
%time(2)=16;
for itime=2:241
  time(itime)=time(itime-1)+30;
end

% introduce a scale factor.  I think that the incoming file apeozone_cam3_5_54.nc
% is the mixing ratio of ozone, or the mole fraction.  It is not well documented but
% I think this because the units in the file are 'Fraction' and the magnitude of 
% the values are suspiciuos.  So to convert to a mass fraction of kg/kg we need
% to multiply the mixing ratio of ozone by the molecular weight of ozone and divide
% by the molecular weight of dry air

M_o3=48e-3% kg/mole of ozone
M_a =28.96e-3% kg/mole of dry air

scale=M_o3/M_a% kg of ozone per kg of dry air

 for itime=1:1:240
     aqua_o3(:,:,:,itime)=scale*o3_climo(:,:,:,1);
 end

 aqua_o3_a=squeeze(mean(aqua_o3,1));
 aqua_o3_b=squeeze(mean(aqua_o3_a,1));
% 
% output file name
o3f = 'ape_ozone_cfmip3_scaled.nc';
system(['rm -f ',o3f]);
% 
% 
nccreate(o3f,'ozone','Dimensions',{'lon' size(aqua_o3,1) 'lat' ...
                     size(aqua_o3,2) 'pfull' size(aqua_o3,3) 'time' Inf},'Datatype','single');

nccreate(o3f,'lon','Dimensions',{'lon' size(aqua_o3,1)});
nccreate(o3f,'time','Dimensions',{'time' size(aqua_o3,4)});
nccreate(o3f,'lat','Dimensions',{'lat' size(aqua_o3,2)});
nccreate(o3f,'pfull','Dimensions',{'pfull' size(aqua_o3,3)});
nccreate(o3f,'phalf','Dimensions',{'phalf' 60});
%nccreate(o3f,'lat_bnds','Dimensions',{'bnds' 2 'lat' size(aqua_o3,2)});
%nccreate(o3f,'lon_bnds','Dimensions',{'bnds' 2 'lon' size(aqua_o3,1)});

ncwrite(o3f,'lon',lon);
ncwrite(o3f,'lat',lat);
ncwrite(o3f,'pfull',pfull);
ncwrite(o3f,'phalf',phalf);
ncwrite(o3f,'time',time);
ncwrite(o3f,'ozone',aqua_o3);

%ncwrite(o3f,'lat_bnds',lat_bnds);
%ncwrite(o3f,'lon_bnds',lon_bnds);
% 
ncwriteatt(o3f,'time','standard_name','time');
ncwriteatt(o3f,'time','long_name','time');
%ncwriteatt(o3f,'time','bounds','time_bnds');

ncwriteatt(o3f,'time','units','days since 1979-01-01 00:00:00');
ncwriteatt(o3f,'time','axis','T');
ncwriteatt(o3f,'time','calendar','noleap');

ncwriteatt(o3f,'ozone','cell_methods','time:mean (interval: 1 months)');
ncwriteatt(o3f,'ozone','standard_name','ozone');
ncwriteatt(o3f,'ozone','long_name','ozone mass mixing ratio');
ncwriteatt(o3f,'ozone','units','kg/kg');

ncwriteatt(o3f,'lat','standard_name','latitude');
ncwriteatt(o3f,'lat','long_name','Latitude');
ncwriteatt(o3f,'lat','axis','Y');
ncwriteatt(o3f,'lat','units','degrees_north');

ncwriteatt(o3f,'lon','standard_name','longitude');
ncwriteatt(o3f,'lon','long_name','Longitude');
ncwriteatt(o3f,'lat','axis','X');
ncwriteatt(o3f,'lon','units','degrees_east');

ncwriteatt(o3f,'pfull','standard_name','pfull');
ncwriteatt(o3f,'pfull','long_name','layer-mean pressure');
ncwriteatt(o3f,'pfull','units','hPa');
ncwriteatt(o3f,'pfull','positive','down');
ncwriteatt(o3f,'pfull','cartesian_axis','Z');

ncwriteatt(o3f,'phalf','long_name','half pressure level');
ncwriteatt(o3f,'phalf','units','hPa');
ncwriteatt(o3f,'phalf','positive','down');
ncwriteatt(o3f,'phalf','cartesian_axis','Z');

ncdisp('ape_ozone_cfmip3_scaled.nc')
