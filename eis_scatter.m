% compute a landmask to apply to the output fields
%landm='/Users/silvers/data/c96L32_landmask_atmos.static.nc'
%land=ncread(landm,'land_mask');
%onlyocean=zeros(size(land));
%onlyocean(land>=0.5)=NaN;
%onlyocean(land<0.5)=1.;

% to get teh v_ctl structure loaded, run open_sstpatt.m

%figure;
%scatter(eis_ctl_p3(:),lts_ctl_p3(:))
new_lcloud=v_ctl.lcloud.*onlyocean;
new_lts=lts_ctl_p1.*onlyocean;
new_eis=eis_ctl_p1.*onlyocean;

%figure;
%scatter(new_lts(:),new_lcloud(:))


long1=1;
long2=288;
lat1=34;
lat2=35;
wind_lcloud=new_lcloud(long1:long2,lat1:lat2);
wind_lts=new_lts(long1:long2,lat1:lat2);
wind_eis=new_eis(long1:long2,lat1:lat2);
%figure;
%scatter(wind_lts(:),wind_lcloud(:))
figure
scatter(wind_eis(:),wind_lcloud(:))
%
%
