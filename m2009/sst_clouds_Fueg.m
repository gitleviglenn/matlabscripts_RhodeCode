%
% taken from driver_ensembles.m 
% load data from one of hte am4 longamip amipPIforcing experiments that was 
% used in Silvers et al. 2018
%
% initial goal is to reproduce figure 1 from Fueglistaler 2019
%
% my analysis in Silvers et al. 2018 used yearly means Stephan used montly means
%
% the sst analysis in sst_signal_longamip.m was complicated because the sst
% was not on the same kind of grid as the model output so an interpolation 
% had to be done.  the output from the am4 model is on a 180x288 grid, 
% comared to the sst which is on a 180x360 grid.
%
% levi silvers                           april 2019
%----------------------------------------------------------------------------------
% ensemble 4 
pathbase='/net2/Levi.Silvers/data/amip_long/';
path='c96L33_am4p0_longamip_1850rad_ens4/ts_all/';
years2='atmos.187001-201412'; 

%%modtitle='AM4p0';
%
%%% for AM4
%%timest=13;
timest=1;
%%%timeend=1632;
timeend=1620;
%%timeend=1608;
%%
level700=5; % for AM3, and AM4
%
[XN,YN]=meshgrid(0.2:0.8:288,1:180);
swcre_ocean=zeros(360,180,endtime)
%
readvars
global_weights
%
% define the tropical window
wlat1=60;
wlat2=120;
wlon1=1;
wlon2=288;

tindex=size(temp_ll_ts,1);
nyears=tindex/12;

% create global mean time series
for ti=1:tindex;
 
  fullfield=squeeze(temp_ll_ts(ti,:,:));
  global_wmean_quick;
  tref_gmn_ts(ti)=wgt_mean;
  tref_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(lcloud_ts(ti,:,:));
  global_wmean_quick;
  lcloud_gmn_ts(ti)=wgt_mean;
  lcloud_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(olr_ts(ti,:,:));
  global_wmean_quick;
  olr_gmn_ts(ti)=wgt_mean;
  olr_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);
  
  fullfield=squeeze(olr_clr_ts(ti,:,:));
  global_wmean_quick;
  olr_clr_gmn_ts(ti)=wgt_mean;
  olr_clr_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(swdn_ts(ti,:,:));
  global_wmean_quick;
  swdn_gmn_ts(ti)=wgt_mean;
  swdn_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(swup_clr_ts(ti,:,:));
  global_wmean_quick;
  swup_clr_gmn_ts(ti)=wgt_mean;
  swup_clr_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);
  
  fullfield=squeeze(swup_ts(ti,:,:));
  global_wmean_quick;
  swup_gmn_ts(ti)=wgt_mean;
  swup_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

%% how should window values be normalized?
%  tref_wind_ts(ti)=nansum(tref_wgt_wind(:))/reg_area_sum;
%  lcloud_wind_ts(ti)=nansum(lcloud_wgt_wind(:))/reg_area_sum;
%  olr_wind_ts(ti)=nansum(olr_wgt_wind(:))/reg_area_sum; 
%  olr_clr_wind_ts(ti)=nansum(olr_clr_wgt_wind(:))/reg_area_sum; 
%  swdn_wind_ts(ti)=nansum(swdn_wgt_wind(:))/reg_area_sum; 
%  swup_wind_ts(ti)=nansum(swup_wgt_wind(:))/reg_area_sum; 
%  swup_clr_wind_ts(ti)=nansum(swup_clr_wgt_wind(:))/reg_area_sum; 

  tref_wind_ts(ti)=nansum(tref_wgt_wind(:))/glbsumweight;
  lcloud_wind_ts(ti)=nansum(lcloud_wgt_wind(:))/glbsumweight;
  olr_wind_ts(ti)=nansum(olr_wgt_wind(:))/glbsumweight; 
  olr_clr_wind_ts(ti)=nansum(olr_clr_wgt_wind(:))/glbsumweight; 
  swdn_wind_ts(ti)=nansum(swdn_wgt_wind(:))/glbsumweight; 
  swup_wind_ts(ti)=nansum(swup_wgt_wind(:))/glbsumweight; 
  swup_clr_wind_ts(ti)=nansum(swup_clr_wgt_wind(:))/glbsumweight; 
end

% new
% global fields
swcre_glb=swup_ts-swup_clr_ts;
swcre_g_nocycle=scycle_remove(swcre_glb,nlat,nlon,nyears);

% grab points in the tropics
swcre_t_nocycle=swcre_g_nocycle(:,60:120,:);
swcre_t=swcre_glb(:,60:120,:);

% impose landseamask
for timin=1:timeend
  swcre_time1=squeeze(swcre_glb(timin,:,:)); % get sst at one time
  swcre_ocean(:,:,timin)=nanlandinterp(swcre_time1,landm,XN,YN);
end


% compute domain means to create a time series
swcre_trmn_nocycle_a=mean(swcre_t_nocycle,2);
swcre_trmn_nocycle_b=mean(swcre_trmn_nocycle_a,3);

swcre_trmn_a=mean(swcre_t,2);
swcre_trmn_b=mean(swcre_trmn_a,3);

% smooth the data with a 9 point running mean
index=1620;
incoming_ts=swcre_trmn_nocycle_b;
running_mean
swcre_trmn_nocyc_smooth=output_ts;
index=1611;
incoming_ts=swcre_trmn_nocyc_smooth;
running_mean
swcre_trmn_nocyc_smooth_b=output_ts;





swdn_mmean     = swdn_gmn_ts;
swup_mmean     = swup_gmn_ts;
swup_clr_mmean = swup_clr_gmn_ts;
olr_mmean      = olr_gmn_ts;
olr_clr_mmean  = olr_clr_gmn_ts;

% these lines are from alpha_09.m
% change the yearly mean to monthlymean time series..
toa_R=swdn_mmean-swup_mmean-olr_mmean;

toa_clr_R=swdn_mmean-swup_clr_mmean-olr_clr_mmean;

toa_cre_R=toa_clr_R-toa_R;
toa_lwcre=-olr_clr_mmean+olr_mmean; % lw clr sky - lw all sky
toa_swcre=-swup_clr_mmean+swup_mmean; % sw clr sky - lw all sky

stop


alpha_09
ensnum=14
alpha_window_driver
%
alpha_array_am4(:,4)=alpha_30y;
alpha_cre_array_am4(:,4)=alpha_cre_30y;
alpha_lwcre_array_am4(:,4)=alpha_lwcre_30y;
alpha_swcre_array_am4(:,4)=alpha_swcre_30y;
alpha_clr_array_am4(:,4)=alpha_clr_30y;
alpha_lcc_array_am4(:,4)=alpha_lcc_30y;
glbmn_lcc_am4(:,4)      =del_lcc;
%
eis_lts_ts
%
%% save output to appropriate local vars:
eis_gmn_array_am4(:,4)      =eis_gmn_ts; %=zeros(1620,6);
lts_gmn_array_am4(:,4)      =lts_gmn_ts; %=zeros(1620,6);
eis_array_am4(:,:,:,4)      =eis_ts;
lts_array_am4(:,:,:,4)      =lts_ts;
omega500_ens                =squeeze(omega_ts(:,level500,:,:));
omega500_array_am4(:,:,:,4) =omega500_ens;
temp700_ens                 =squeeze(temp3d(:,level700,:,:));
temp700_array_am4(:,:,:,4)  =temp700_ens;
%temp_sfc_ens=temp_sfc_ts; % it looks like there is something wrong 
% with temp_sfc_ens from the 5th ensemble member...
temp_sfc_array_am4(:,:,:,4) =temp_sfc_ts;
lcloud_array_am4(:,:,:,4)   =lcloud_ts;
hcloud_array_am4(:,:,:,4)   =hcloud_ts;
toa_sw_cre_array_am4(:,:,:,4)=swup_clr_ts-swup_ts;
%
