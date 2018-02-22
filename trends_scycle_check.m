% for am4
nlat=180;
nlon=288;
nyears=30;

conts=[-5,-4,-3,-2,-1,1,2,3,4,5];
caxisin=([-5 5]);

% lcloud_ensmn is the raw data with seasonal cycle
vartotrend=lcloud_ensmn;
reg_trend
lcloud_trend=regtrend_var_oo;

% plot trend before seasonal cycle is removed
cont_map_modis(lcloud_trend,vlat,vlon,conts,caxisin)
colorbar
title('lcloud ensmn')

% blah should be lcloud_ensmn with seasonal cycle removed
blah=scycle_remove(lcloud_ensmn,nlat,nlon,nyears);

vartotrend=blah;
reg_trend
lcloud_deseason_trend=regtrend_var_oo;

% plot trend after seasonal cycle is removed
cont_map_modis(lcloud_deseason_trend,vlat,vlon,conts,caxisin)
colorbar
title('lcloud ensmn without seasonal cycle')
