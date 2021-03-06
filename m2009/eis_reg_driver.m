%------------------------------------------------------------------------------------
%
% the global EIS ts needs to have been computed for this to work...
%
% initially run openncfile_3mods.m
% the model to be used must be specified in both global_eis_09 and eis_lts_driver_09.
%
% use  global_eis_09.m --> computes eis and lts globally at one time
%      eis_lts_driver_09.m  --> computes eis and lts time series
%      eis_trend_09.m --> computes the global and yearly mean of eis, then regression
%      eis_reg_driver.m --> calls eis_trend_09.m after specifying what input 
%                           eis_trend_09 will use
%
% levi silvers                                                       jan 2017
%------------------------------------------------------------------------------------
%
% conversion factors for lat/lon
conv_am4=288.0/360.;
conv_lat_am2=90.0/180.;
conv_lon_am2=144.0/360.;

pathbase='/net2/Levi.Silvers/data/amip_long/';

% AM4
modelver='AM4';
path='/c96L32_am4g10r8_longamip_1860rad/';
years2='atmos.187101-201512';
piece=strcat(pathbase,path,years2);

timest=1;
timeend=1608;

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_tref_ts    = strcat(piece,'.t_ref.nc')
fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');

temp_sfc_ts   = fin_tsurf{'t_surf'}(timest:timeend,:,:);  
temp_ref_ts   = fin_tref{'t_ref'}(timest:timeend,:,:);  
vlat          = fin_tsurf{'lat'}(:);
vlon          = fin_tsurf{'lon'}(:);

temp_ts = temp_ref_ts;
%eis_ts  =eis_am4ts;
eis_ts  =eis_ens_am4_mn;
lcloud_ts=lcloud_am4_mn;

%vlon    =v.lon_am4ts;
%vlat    =v.lat_am4ts;
%clear temp_ts;
%%temp_ts=zeros(1620,length(vlat),length(vlon));
%%temp_ts =v.tref_am4ts(1:1620,:,:);
%temp_ts=v.tref_am4ts;

% tropical lats
lat1=71;
lat2=110;

eis_trend_09

%save output for figure of lcc estimates
est_lcc_am4=jackhearts_g;
est_lcc_tr_am4=jackhearts;
lcc_am4=lcloud_gyrmn_anom_ts;
lcc_tr_am4=lcloud_tryrmn_anom_ts;

eis_gyrmn_tsam4=eis_30y; % K/K regression of eis and tref anomalies
eis_tryrmn_tsam4=tr_eis_30y;
delTrf_am4ts=delTrf;
delEIS_am4ts=delEIS;
delEIS_tr_am4ts=delEIS_tr;

%% california window
%wlon1=conv_am4*220;
%wlon2=conv_am4*230;
%wlat1=110;
%wlat2=120;
%
%eis_window_trend_09
%eis_calwind_tsam4=wind_eis_30y;
%
%% peruvian window -------------------------------------
%wlon1=conv_am4*270;
%wlon2=conv_am4*280; 
%wlat1=70;
%wlat2=80;
%
%eis_window_trend_09
%eis_perwind_tsam4=wind_eis_30y;
%
%% namibian window -------------------------------------
%wlon1=conv_am4*1;
%wlon2=conv_am4*10; 
%wlat1=70;
%wlat2=80;
%
%eis_window_trend_09
%eis_namwind_tsam4=wind_eis_30y;
%
%% australian window -------------------------------------
%wlon1=conv_am4*95;
%wlon2=conv_am4*105; 
%wlat1=55;
%wlat2=65;
%
%eis_window_trend_09
%eis_auswind_tsam4=wind_eis_30y;
%
%% canarian window -------------------------------------
%wlon1=conv_am4*325;
%wlon2=conv_am4*335; 
%wlat1=105;
%wlat2=115;
%
%eis_window_trend_09
%eis_canwind_tsam4=wind_eis_30y;


% AM3-------------------------------------

modelver='AM3';
path='/AM3/c48L48_am3p9_1860_ext/';
years2='atmos.187001-200512';
piece=strcat(pathbase,path,years2);

timest=13;
timeend=1620;

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_tref_ts    = strcat(piece,'.t_ref.nc')
fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');

temp_sfc_ts   = fin_tsurf{'t_surf'}(timest:timeend,:,:);  
temp_ref_ts   = fin_tref{'t_ref'}(timest:timeend,:,:);  
vlat          = fin_tsurf{'lat'}(:);
vlon          = fin_tsurf{'lon'}(:);

temp_ts = temp_ref_ts;
%eis_ts  =eis_am4ts;

%temp_ts=v.tref_am3ts;
eis_ts=eis_ens_am3_mn;
lcloud_ts=lcloud_am3_mn;
%vlon   =v.lon_am3ts;
%vlat   =v.lat_am3ts;

% tropical window
lat1=36;
lat2=55;

clear delTrf;
clear delEIS;
eis_trend_09

%save output for figure of lcc estimates
est_lcc_am3=jackhearts_g;
est_lcc_tr_am3=jackhearts;
lcc_am3=lcloud_gyrmn_anom_ts;
lcc_tr_am3=lcloud_tryrmn_anom_ts;

eis_gyrmn_tsam3=eis_30y; % polyfit(delTrf,delEIS)
eis_tryrmn_tsam3=tr_eis_30y; % del indicates anomaly fields
delTrf_am3ts=delTrf;
delEIS_am3ts=delEIS;
delEIS_tr_am3ts=delEIS_tr;

% AM2
modelver='AM2';
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A1/';
years2='atmos.187001-200412';
piece=strcat(pathbase,path,years2);

timest=13;
timeend=1620;

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_tref_ts    = strcat(piece,'.t_ref.nc')
fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');

temp_sfc_ts   = fin_tsurf{'t_surf'}(timest:timeend,:,:);  
temp_ref_ts   = fin_tref{'t_ref'}(timest:timeend,:,:);  
vlat          = fin_tsurf{'lat'}(:);
vlon          = fin_tsurf{'lon'}(:);

temp_ts = temp_ref_ts;

%temp_ts=v.tref_am3ts;
eis_ts=eis_ens_am2_mn;
lcloud_ts=lcloud_am2_mn;

clear delTrf;
clear delEIS;
eis_trend_09

%save output for figure of lcc estimates
est_lcc_am2=jackhearts_g;
est_lcc_tr_am2=jackhearts;
lcc_am2=lcloud_gyrmn_anom_ts;
lcc_tr_am2=lcloud_tryrmn_anom_ts;

eis_gyrmn_tsam2=eis_30y;
eis_tryrmn_tsam2=tr_eis_30y;
%eis_windyrmn_tsam2=wind_eis_30y;
delTrf_am2ts=delTrf;
delEIS_am2ts=delEIS;
delEIS_tr_am2ts=delEIS_tr;

%plot anomalies of the trend around the mean for each time series
eis_tsam4=eis_gyrmn_tsam4-mean(eis_gyrmn_tsam4,1);
eis_tr_tsam4=eis_tryrmn_tsam4-mean(eis_tryrmn_tsam4,1);
eis_tsam3=eis_gyrmn_tsam3-mean(eis_gyrmn_tsam3,1);
eis_tr_tsam3=eis_tryrmn_tsam3-mean(eis_tryrmn_tsam3,1);
eis_tsam2=eis_gyrmn_tsam2-mean(eis_gyrmn_tsam2,1);
eis_tr_tsam2=eis_tryrmn_tsam2-mean(eis_tryrmn_tsam2,1);

%plot anomalies around the mean for each time series
eis_tsam4_anom=delEIS_am4ts-mean(delEIS_am4ts,2);
eis_tr_tsam4_anom=delEIS_tr_am4ts-mean(delEIS_tr_am4ts,2);
eis_tsam3_anom=delEIS_am3ts-mean(delEIS_am3ts,2);
eis_tr_tsam3_anom=delEIS_tr_am3ts-mean(delEIS_tr_am3ts,2);
eis_tsam2_anom=delEIS_am2ts-mean(delEIS_am2ts,2);
eis_tr_tsam2_anom=delEIS_tr_am2ts-mean(delEIS_tr_am2ts,2);

figure
timearr=1875:1:2000;
plot(timearr,est_lcc_am4,'k','LineStyle','--')
hold on
plot(timearr,lcc_am4,'k')
plot(timearr,est_lcc_am3,'r','LineStyle','--')
hold on
plot(timearr,lcc_am3,'r')
plot(timearr,est_lcc_am2,'b','LineStyle','--')
hold on
plot(timearr,lcc_am2,'b')
title('global hogwash')

figure
timearr=1875:1:2000;
plot(timearr,est_lcc_tr_am4,'k','LineStyle','--')
hold on
plot(timearr,lcc_tr_am4,'k')
plot(timearr,est_lcc_tr_am3,'r','LineStyle','--')
hold on
plot(timearr,lcc_tr_am3,'r')
plot(timearr,est_lcc_tr_am2,'b','LineStyle','--')
hold on
plot(timearr,lcc_tr_am2,'b')
title('global hogwash')

%% figure
%timearr=1885:2000;
%figure
%plot(timearr(2:115),eis_tsam4(1:114),'k','LineWidth',1)
%hold on
%plot(timearr(2:115),eis_tr_tsam4(1:114),'k','LineWidth',3)
%%plot(timearr,eis_gyrmn_tsam4,'k','LineWidth',2)
%%mn_arr=zeros(length(alpha_tsam4),1);
%%mn_arr=mn_arr+mean(alpha_tsam4,1);
%%plot(timearr,mn_arr,'k')
%plot(timearr(1:105),eis_tsam3(1:105),'r','LineWidth',1)
%plot(timearr(1:105),eis_tr_tsam3(1:105),'r','LineWidth',3)
%%plot(timearr(1:tend),eis_gyrmn_tsam3(2:tend+1),'r','LineWidth',2)
%plot(timearr(1:104),eis_tsam2(1:104),'b','LineWidth',1)
%plot(timearr(1:104),eis_tr_tsam2(1:104),'b','LineWidth',3)
%%plot(timearr(1:tend-1),eis_gyrmn_tsam2(2:tend),'b','LineWidth',2)
%title('glb mn EIS trend 30yr wind')
%
%% anomaly figure
%tendindex=144;
%incoming_ts=eis_tsam4_anom;
%running_mean;
%eis_tsam4_anom=output_ts;
%incoming_ts=eis_tr_tsam4_anom;
%running_mean;
%eis_tr_tsam4_anom=output_ts;
%tendindex=135;
%incoming_ts=eis_tsam3_anom;
%running_mean;
%eis_tsam3_anom=output_ts;
%incoming_ts=eis_tr_tsam3_anom;
%running_mean;
%eis_tr_tsam3_anom=output_ts;
%tendindex=134;
%incoming_ts=eis_tsam2_anom;
%running_mean;
%eis_tsam2_anom=output_ts;
%incoming_ts=eis_tr_tsam2_anom;
%running_mean;
%eis_tr_tsam2_anom=output_ts;
%
%%timearr=1885:2000;
%timearr=1870:2015;
%figure
%plot(timearr(6:141),eis_tsam4_anom(1:136),'k','LineWidth',1)
%hold on
%plot(timearr(6:141),eis_tr_tsam4_anom(1:136),'k','LineWidth',3)
%%plot(timearr,eis_gyrmn_tsam4,'k','LineWidth',2)
%%mn_arr=zeros(length(alpha_tsam4),1);
%%mn_arr=mn_arr+mean(alpha_tsam4,1);
%%plot(timearr,mn_arr,'k')
%plot(timearr(5:131),eis_tsam3_anom(1:127),'r','LineWidth',1)
%plot(timearr(5:131),eis_tr_tsam3_anom(1:127),'r','LineWidth',3)
%%plot(timearr(1:tend),eis_gyrmn_tsam3(2:tend+1),'r','LineWidth',2)
%plot(timearr(5:130),eis_tsam2_anom(1:126),'b','LineWidth',1)
%plot(timearr(5:130),eis_tr_tsam2_anom(1:126),'b','LineWidth',3)
