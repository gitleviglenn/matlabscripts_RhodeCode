%% compute a landmask to apply to the output fields
%landm='/Users/silvers/data/c96L32_landmask_atmos.static.nc'
%land=ncread(landm,'land_mask');
%onlyocean=zeros(size(land));
%onlyocean(land>=0.5)=NaN;
%onlyocean(land<0.5)=1.;

% to get teh v_ctl structure loaded, run open_sstpatt.m

%figure;
%scatter(eis_ctl_p3(:),lts_ctl_p3(:))
%new_lcloud=v_ctl.lcloud.*onlyocean;
%new_lts=lts_ctl_p1.*onlyocean;
%new_eis=eis_ctl_p1.*onlyocean;

%figure;
%scatter(new_lts(:),new_lcloud(:))

% define the window of interest
% the five windows below are those defined in Klein and Hartmann 1993;
% latitude runs from 0 at the SP to 180 at NP
% i think that 0 long is at Greenwich...
conv=288.0/360.;
% peruvian window
long1=conv*270.;
long2=conv*280.; % max of 288
lat1=70;
lat2=80;
% namibian window;
long1=conv*0;
long2=conv*10;
lat1=70;
lat2=80;
%Californian window;
long1=conv*230;
long1=conv*220;
lat1=110;
lat2=120;
%Australian window;
long1=conv*95;
long2=conv*105;
lat1=55;
lat2=65;
%Canarian window;
long1=conv*325;
long2=conv*335;
lat1=105;
lat2=115;
%
%wind_lcloud=new_lcloud(long1:long2,lat1:lat2);
%wind_lts=new_lts(long1:long2,lat1:lat2);
%wind_eis=new_eis(long1:long2,lat1:lat2);
clear wind_lcloud; 
clear wind_lts;
clear wind_eis;
%wind_lcloud=v.lcloud(:,long1:long2,lat1:lat2);

latdim=lat2-lat1+1;
londim=long2-long1+1;

wind_lcloud=lcloud_am4_mn(:,lat1:lat2,long1:long2);

wind_lts=lts_ens_am4_mn(:,lat1:lat2,long1:long2);

wind_eis=eis_ens_am4_mn(:,lat1:lat2,long1:long2);
eis_wmn_am4_re=reshape(wind_eis,[12,135,latdim,londim]);
eis_wymn_am4=squeeze(mean(eis_wmn_am4_re,1));

%figure;
%scatter(wind_lts(:),wind_lcloud(:))
figure
scatter(wind_eis(:),wind_lcloud(:))
%
%
