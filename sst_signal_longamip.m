%--------------------------------------------------------------------------------------------
% sst_signal_longamip.m
%
% examines the relationship between swcre and sst in various ways including
% histograms, cumulative distribution functions, and regression analysis
%
% an attempt is made to follow analysis outlined in Fueglistaler, 2019
% initial results (poor correlations) indicate that the relationship between
% tao swcre and sst is not nearly as strong in amip like experiments as it is
% in observations (based on CERES data). 
%
% levi silvers                                                 may 2019
%--------------------------------------------------------------------------------------------

% import the sst and landmask data, they are on different grids
sst=ncread('~/data/amip_long/hadisst_sst.data.nc','sst');
% the sst data starts in 1860
landm=ncread('~/data/am4p0/atmos.static.nc','land_mask');

path_to_longamip='/Users/silvers/data/amip_long/AM4/ens2/';

source_am4_a_olr             =strcat(path_to_longamip,'atmos.187001-201412.olr.nc');
source_am4_a_olr_clr         =strcat(path_to_longamip,'atmos.187001-201412.olr_clr.nc');
source_am4_a_swup_toa_clr    =strcat(path_to_longamip,'atmos.187001-201412.swup_toa_clr.nc');
source_am4_a_swup_toa        =strcat(path_to_longamip,'atmos.187001-201412.swup_toa.nc');

% only present in ens2 data at the moment, still need to download
source_am4_tsurf             =strcat(path_to_longamip,'atmos.187001-201412.t_surf.nc');
tsurf=ncread(source_am4_tsurf,'t_surf');

olr        =ncread(source_am4_a_olr,'olr');
olr_clr    =ncread(source_am4_a_olr_clr,'olr_clr');
swup_clr   =ncread(source_am4_a_swup_toa_clr,'swup_toa_clr');
swup       =ncread(source_am4_a_swup_toa,'swup_toa');


%% define parameters and initialize arrays
endtime=1740; % needs to be an integer of 12
nyears=endtime/12;
monthint=1/12;
nlat=180;
nlon=288;
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

sst_30p                      =zeros(endtime,30);

%----------------------------------------------------------------------------------------
% process the sw data

% cloud Radiative Effect = All sky flux - Clear sky flux
swcre=swup-swup_clr;
% remove seasonal cycle
swup_nocycle=scycle_remove(swup,nlat,nlon,nyears);
swcre_nocycle=scycle_remove(swcre,nlat,nlon,nyears);
% grab tropical points
swcre_tr=swcre(:,60:120,:);
swcre_tr_nocycle=swcre_nocycle(:,60:120,:);

% compute domain mean values
swcre_tr_mn1=mean(swcre_tr,1);
swcre_tr_mn=squeeze(mean(swcre_tr_mn1,2));
swcre_tr_nc_mn1=mean(swcre_tr_nocycle,1);
swcre_tr_nocycle_mn=squeeze(mean(swcre_tr_nc_mn1,2));

% a figure is being generated in this script and I am not sure from whence it commeth 
figure

%swup_nocycle=scycle_remove(swup,nlat,nlon,nyears);

% convert all of the points over land to nans.  
for timin=1:endtime
  test1=squeeze(swup_nocycle(:,:,timin));
  swup_nocycle_noocean(:,:,timin)=nanland(test1);
  test2=squeeze(swcre_nocycle(:,:,timin));
  swcre_nocycle_noland(:,:,timin)=nanland(test2);
end 
swcre_tr_nocycle_noland=swcre_nocycle_noland(:,60:120,:);
swcre_tr_ncnl_mn1=nanmean(swcre_tr_nocycle_noland,1);
swcre_trnocycnoland_mn=squeeze(nanmean(swcre_tr_ncnl_mn1,2));

%----------------------------------------------------------------------------------------
% process the observational sst data

% impose landseamask
% sst_ocean has dimensions of 360x180x1740, dimensions of the land mask are 288x180
stindex=13;
fiindex=1752;
sst_1870to2014=sst(:,:,stindex:fiindex);
for timin=1:endtime
  sst_time1=squeeze(sst_1870to2014(:,:,timin)); % get sst at one time
  sst_ocean(:,:,timin)=nanlandinterp(sst_time1,landm,XN,YN); % impose a landmask of NaNs
end

% grab only tropical points
%sst_tr=sst(:,60:120,1:endtime);
sst_ocean_tr=sst_ocean(:,60:120,1:endtime);

% compute domain mean time series
sst_trnl_1=nanmean(sst_ocean_tr,1);
sst_trnoland_mn=squeeze(nanmean(sst_trnl_1,2));

% remove the seasonal cycle
bolluck=scycle_remove(sst_ocean_tr,61,360,nyears);
bolluck_1=nanmean(bolluck,1);
bolluck_mn=squeeze(nanmean(bolluck_1,2));

sst_noscycle_tr_mn=bolluck_mn;

%----------------------------------------------------------------------------------------
% use a running mean to smooth the data a bit
tendindex=1740;
% swcre no land or s cycle
incoming_ts=swcre_trnocycnoland_mn;
  running_mean;
smooth_swcre_noland_1=output_ts;
tendindex=1732;
incoming_ts=smooth_swcre_noland_1;
  running_mean;
smooth_swcre_noland_2=output_ts;

% swcre no s cycle
tendindex=1740;
incoming_ts=swcre_tr_nocycle_mn;
  running_mean;
smooth_swcre_1=output_ts;
tendindex=1732;
incoming_ts=smooth_swcre_1;
  running_mean;
smooth_swcre_2=output_ts;

% compute a 7 pt running mean to compare with Stephans CERES figure
tendindex=1740;
incoming_ts=swcre_tr_nocycle_mn;
  running_mean_7pt;
smooth_swcre_7pt=output_ts;
incoming_ts=sst_noscycle_tr_mn;
  running_mean_7pt;
smooth_sst_7pt=output_ts;
%corrcoef(smooth_sst_7pt,smooth_swcre_7pt) % -0.35

% swcre 
tendindex=1740;
incoming_ts=swcre_tr_mn;
  running_mean;
smooth_swcre_raw_1=output_ts;
tendindex=1732;
incoming_ts=smooth_swcre_raw_1;
  running_mean;
smooth_swcre_raw_2=output_ts;

% sst no land
tendindex=1740;
incoming_ts=sst_trnoland_mn;
  running_mean;
smooth_sst_1=output_ts;
tendindex=1732;
incoming_ts=smooth_sst_1;
  running_mean;
smooth_sst_2=output_ts;

% sst no land no s cycle
tendindex=1740;
incoming_ts=sst_noscycle_tr_mn;
  running_mean;
smooth_sst_noscycle_1=output_ts;
tendindex=1732;
incoming_ts=smooth_sst_noscycle_1;
  running_mean;
smooth_sst_nanland_noscycle_2=output_ts;

%incoming_ts=smooth_swcre_raw_1;
%  running_mean;
%smooth_swcre_raw_2=output_ts;

%incoming_ts=smooth_swcre_noland_1;
%  running_mean;
%smooth_swcre_noland_2=output_ts;

%incoming_ts=smooth_sst_noscycle_1;
%  running_mean;
%smooth_sst_noscycle_2=output_ts;

%incoming_ts=smooth_sst_1;
%  running_mean;
%smooth_sst_2=output_ts;

%incoming_ts=smooth_swcre_1;
%  running_mean;
%smooth_swcre_2=output_ts;

%---------------------------------------------
% compute the linear regression:

% how do I compute the multiple linear regression?  probably with 'fitlm' 
%       mdl = fitlm(X,y)  where y is the response to the data matrix X
% how do I select the warmest 30% of the SSTs?
% why do my correlations (0.39) look much lower than those in Fueglistaler Fig 1a? (0.61) 
swcrevssst=polyfit(smooth_sst_2,smooth_swcre_2,1)
corrcoef(smooth_sst_2,smooth_swcre_2)
sstnanlandnosc_swcrenosc=corrcoef(smooth_sst_nanland_noscycle_2,smooth_swcre_2)
%corrcoef(smooth_sst_noscycle_2,smooth_swcre_raw_2)

% does smoothing have much of an impact on the correlation?
unsmoothed_corcof=corrcoef(sst_noscycle_tr_mn,swcre_tr_nocycle_mn)

%---------------------------------------------
% i believe this is computing the empirical cummulative distribution function; 
% which appears to sort the data as well.  

for tim=1:endtime
  sst_ocean_tr_cdf=histogram(sst_ocean_tr(:,:,tim),binnum,'Normalization','cdf');
  for i=1:binnum
    sst_oc_tr_edges(tim,i)=sst_ocean_tr_cdf.BinEdges(i);
    sst_oc_tr(tim,i)=sst_ocean_tr_cdf.Values(i);
  end
  sst_30p(tim,:)=sst_ocean_tr_cdf.BinEdges(72:101);
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

sst_30p_mn=mean(sst_30p,2);
sst_mean=mean(sst_oc_tr_edges,2);

%sst_pound_diff=sst_30p_mn-sst_mean;

% sst no land no s cycle
tendindex=1740;
incoming_ts=sst_30p_mn;
  running_mean;
sm_sst_30_1=output_ts;
tendindex=1732;
incoming_ts=sm_sst_30_1;
  running_mean;
sm_sst_30p=output_ts;

tendindex=1740;
incoming_ts=sst_mean;
  running_mean;
sm_sst_mean_1=output_ts;
tendindex=1732;
incoming_ts=sm_sst_mean_1;
  running_mean;
sm_sst_mean=output_ts;

%tendindex=1740;
%incoming_ts=sst_pound_diff;
%  running_mean;
%sm_sst_pound_diff_1=output_ts;
%tendindex=1732;
%incoming_ts=sm_sst_pound_diff_1;
%  running_mean;
%sm_sst_pound=output_ts;

sst_pound=sm_sst_30p-sm_sst_mean;

%---------------------------------------------
% do a bit more smoothing and make some plots.

yblu_b=0.0:1./binnum:1.0-1./binnum;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,sst_oc_tr_deseas');
set(h,'EdgeColor','none');
colorbar

smooth=zeros(1740,92);
smoothlong=zeros(1732,92);

tendindex=100;
for t=1:1740;
  incoming_ts=sst_oc_tr_deseas(t,:);
  running_mean;
  smooth(t,:)=output_ts(:);
end

binnm=binnum-8;
%yblu_b=0.0:1./binnm:1.0-1./binnm;
%figure
%colormap(jet)
%[C,h]=contourf(years,yblu_b,smooth');
%set(h,'EdgeColor','none');
%colorbar

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
