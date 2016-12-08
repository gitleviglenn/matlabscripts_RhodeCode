source='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_20yr/atmos.0002-0021.07.nc';
file=netcdf(source,'nowrite');
v.lat=file{'lat'}(:);
v.lon=file{'lon'}(:);
v.level=file{'level'}(:); % level 5 corresponds to p=700 hPa
v.level=100*v.level
v.temp=file{'temp'}(:,:,:,:); 
v.tsurf=file{'t_surf'}(:,:,:); 
v.hght=file{'hght'}(:,:,:,:); 
