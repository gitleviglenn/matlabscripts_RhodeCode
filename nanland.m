function nanland(fieldin)

% preferably fieldin should be a time averaged field 
% of dimension fieldin(time,lat,lon) with time=1

landm='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc'
fland=netcdf(landm,'nowrite');
v.landm=fland{'land_mask'}(:,:);
latit=-89.5:1:89.5;
v.lat=latit';
normfac=1.87; % surface temperature difference [Kelvin]
%normfac
%1.87 for AM4OM2F
%2.09 for add icesst (hadley ice and sst +1%CO2 Pattern)
%1.67 for add sst (hadley sst +1%CO2 Pattern)
%2.29 for p2k (hadley sst and ice plus 2K for sst)

fieldin2d=squeeze(fieldin)/normfac;

% create a mask with land points = 0 and ocean points = 1
onlyocean=zeros(size(v.landm));
onlyocean(v.landm~=0)=-999.; % shift land points to -999
onlyocean(onlyocean==0)=1.; % shift ocean points to 1.0
onlyocean(onlyocean==-999.)=0.; % shift land points to 0.0

just_ocean=onlyocean.*fieldin2d; % apply land=0.0 mask to global array...
just_ocean(just_ocean==0.)=NaN; % shift land points to NaNs
just_ocean_znm=nanmean(just_ocean,2); % the indexing seems strange here...
% it will be useful, and confirming to plot the zonal mean array over oceans, and the zonal mean array for the entire globe.
contourf(just_ocean)
full_arr_znm=mean(fieldin2d,2);
%figure;plot(v.lat,full_arr_znm,v.lat,just_ocean_znm)
figmatrix=[full_arr_znm,just_ocean_znm];
%call the function that plots the figures
createfigure(v.lat,figmatrix)

