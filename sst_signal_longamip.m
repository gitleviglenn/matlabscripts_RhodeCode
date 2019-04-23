
% import the sst and landmask data, they are on different grids
sst=ncread('~/data/amip_long/hadisst_sst.data.nc','sst');
% the sst data starts in 1860
landm=ncread('~/data/am4p0/atmos.static.nc','land_mask');

path_to_longamip='/Users/silvers/data/amip_long/AM4/';

source_am4_a_olr             =strcat(path_to_longamip,'atmos.187001-201412.olr.nc');
source_am4_a_olr_clr         =strcat(path_to_longamip,'atmos.187001-201412.olr_clr.nc');
source_am4_a_swup_toa_clr    =strcat(path_to_longamip,'atmos.187001-201412.swup_toa_clr.nc');
source_am4_a_swup_toa        =strcat(path_to_longamip,'atmos.187001-201412.swup_toa.nc');

olr        =ncread(source_am4_a_olr,'olr');
olr_clr    =ncread(source_am4_a_olr_clr,'olr_clr');
swup_clr   =ncread(source_am4_a_swup_toa_clr,'swup_toa_clr');
swup       =ncread(source_am4_a_swup_toa,'swup_toa');


%% define parameters and initialize arrays
endtime=1740; % needs to be an integer of 12
nyears=endtime/12;
monthint=1/12;
years=1860.0833:monthint:1860+nyears;
years_n=1860.75:monthint:1860+nyears; % time series to use for the smoothed data.
month=repmat(1:12,1,nyears);
binnum=100;
[XN,YN]=meshgrid(0.2:0.8:288,1:180);

% define arrays
sst_ocean                    =zeros(360,180,endtime);
sst_oc_tr                    =zeros(endtime,binnum);
sst_oc_tr_deseas             =zeros(endtime,binnum);
sst_1870to2014               =zeros(360,180,endtime);

% compute the sw cloud radiative effect
swcre=swup-swup_clr;
swup_nocycle=scycle_remove(swup,nlat,nlon,nyears);
swcre_nocycle=scycle_remove(swcre,nlat,nlon,nyears);
swcre_tr=swcre(:,60:120,:);
swcre_tr_nocycle=swcre_nocycle(:,60:120,:);

swcre_tr_mn1=mean(swcre_tr,1);
swcre_tr_mn=squeeze(mean(swcre_tr_mn1,2));
swcre_tr_nc_mn1=mean(swcre_tr_nocycle,1);
swcre_tr_nocycle_mn=squeeze(mean(swcre_tr_nc_mn1,2));

% a figure is being generated in this script and I am not sure from whence it commeth 
figure

swup_nocycle=scycle_remove(swup,nlat,nlon,nyears);

for timin=1:endtime
  test1=squeeze(swup_nocycle(:,:,timin));
  swup_nocycle_noocean(:,:,timin)=nanland(test1);
  test2=squeeze(swcre_nocycle(:,:,timin));
  swcre_nocycle_noland(:,:,timin)=nanland(test2);
end 
swcre_tr_nocycle_noland=swcre_nocycle_noland(:,60:120,:);
swcre_tr_ncnl_mn1=nanmean(swcre_tr_nocycle_noland,1);
swcre_trnocycnoland_mn=squeeze(nanmean(swcre_tr_ncnl_mn1,2));


% impose landseamask
% sst_ocean has dimensions of 360x180x1740, dimensions of the land mask are 288x180
sst_1870to2014=sst(:,:,13:1752);
for timin=1:endtime
  sst_time1=squeeze(sst_1870to2014(:,:,timin)); % get sst at one time
  sst_ocean(:,:,timin)=nanlandinterp(sst_time1,landm,XN,YN); % impose a landmask of NaNs
end


% grab only tropical points
sst_tr=sst(:,60:120,1:endtime);
sst_ocean_tr=sst_ocean(:,60:120,1:endtime);

sst_trnl_1=nanmean(sst_ocean_tr,1);
sst_trnoland_mn=squeeze(nanmean(sst_trnl_1,2));

tendindex=1740;
incoming_ts=swcre_trnocycnoland_mn;
  running_mean;
smooth_swcre_noland_1=output_ts;

incoming_ts=sst_trnoland_mn;
  running_mean;
smooth_sst_1=output_ts;

incoming_ts=swcre_tr_nocycle_mn;
  running_mean;
smooth_swcre_1=output_ts;

tendindex=1732;
incoming_ts=smooth_swcre_noland_1;
  running_mean;
smooth_swcre_noland_2=output_ts;

incoming_ts=smooth_sst_1;
  running_mean;
smooth_sst_2=output_ts;

incoming_ts=smooth_swcre_1;
  running_mean;
smooth_swcre_2=output_ts;

% compute the linear regression:
% how do I compute the multiple linear regression? 
% how do I select the warmest 30% of the SSTs?
% why do my correlations (0.39) look much lower than those in Fueglistaler Fig 1a? (0.61) 
swcrevssst=polyfit(smooth_sst_2,smooth_swcre_2,1)

% i believe this is computing the empirical cummulative distribution function; 
%which appears to sort the data as well.  
for tim=1:endtime
  sst_ocean_tr_cdf=histogram(sst_ocean_tr(:,:,tim),binnum,'Normalization','cdf');
  for i=1:binnum
%    sst_oc_tr(tim,i-1)=sst_ocean_tr_cdf.BinEdges(i);
    sst_oc_tr(tim,i)=sst_ocean_tr_cdf.Values(i);
  end
end

% deseasonalize
for i=1:binnum-1;
  for k=1:12;
%    oc_monmean(k)=mean(sst_oc_tr(month==k,i));
    oc_monmean(k,i)=mean(sst_oc_tr(month==k,i));
  end
  for k=1:12;
    sst_oc_tr_deseas(month==k,i)=sst_oc_tr(month==k,i)-oc_monmean(k,i);
  end
end

yblu_b=0.0:1./binnum:1.0-1./binnum;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,sst_oc_tr_deseas');
set(h,'EdgeColor','none');
colorbar
title('new crap')

%smooth=zeros(1776,92);
%smoothlong=zeros(1768,92);
smooth=zeros(1740,92);
smoothlong=zeros(1732,92);

% smooth data
tendindex=100;
for t=1:1740;
  incoming_ts=sst_oc_tr_deseas(t,:);
  running_mean;
  smooth(t,:)=output_ts(:);
end

binnm=binnum-8;
yblu_b=0.0:1./binnm:1.0-1./binnm;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,smooth');
set(h,'EdgeColor','none');
colorbar
title('new crap')

tendindex=1740;
for t=1:binnm;
  incoming_ts=sst_oc_tr_deseas(:,t);
  running_mean;
  smoothlong(:,t)=output_ts(:);
end

yblu_b=0.0:1./binnm:1.0-1./binnm;
figure
colormap(jet)
[C,h]=contourf(years_n,yblu_b,smoothlong');
set(h,'EdgeColor','none');
colorbar
title('new crap')
