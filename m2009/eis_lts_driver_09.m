%------------------------------------------------------------------------------------
% this script uses amip data to compute eis and lts
%
% used with: 
% m2009/openncfile_new.m
% m2009/comp_eis_lts_09.m
% m2009/reg_trend.m
%
% levi silvers                                                 jan 2017
%------------------------------------------------------------------------------------
%
%cont_wcolorbar_eisdiff(diff_term','EIS - LTS');

boo='have you saved changes you numskull?'

%% open netcdf files and load data
%%
%%modtitle='c96L32 am4g12r04: ';
%% this should only need to be called the first time after the experiment
%% paths are changed...
%
% use the 20 lines below when running first time with new input...
%openncfile_new.m
%
%
% compute a mask to eliminate values over continents
onlyocean=make_onlyocean; 


%% compute the weighted global mean values of the 2m temperature
% careful with the size of v.tref_full... it may not be full!
%tindex=size(v.tref_full,1);
%tref_gmn_ts=zeros(tindex,1);
%for ti=1:tindex;
%  fullfield=squeeze(v.tref_full(ti,:,:));
%  global_wmean_script;
%  tref_gmn_ts(ti)=wgt_mean;
%end

% compute a time series of the toa feedback parameter
% should be comparable to ts shown in Gregory and Andrews 2016
%alpha_ts=zeros(tindex,1);
%for ti=1:tindex;
%  alpha_ts(ti)=delR/delT_surf;
%end
% this can be done with:
%alpha_3mod_driver.m  or 
%alpha_09.m

%%
%% if it is desired to only call comp_eis_lts_09 once..
%%comp_eis_lts_09
%%
%%lts_amip=lts_f;
%%eis_amip=estinvs;
%%diff_term=eis_amip-lts_amip;

% default plotting contours
contsin=[-5,-4,-3,-2,-1,0,1,2,3,4,5]; 
caxisin=[-5 5];   

% reg_trend computes the regression over a period that is
% ts_length long.  the starting and ending points should be
% specified
% endtime and ts_length are defined in openncfile_new
%stime=endtime-ts_length+1;
%rstime=stime;
%rendtime=endtime;

%% use these if the full arrays are not being read in openncfile_new
rstime=1;
rendtime=360;

% LCC
%rstime=stime;
%rendtime=endtime;
vartotrend=v.lcloud;
reg_trend
lcloud_trend=regtrend_var_oo;
titin=strcat(modtitle,': low cloud trend')
title(titin);
lcloud_znm=nanmean(lcloud_trend,2);
figure;
plot(lcloud_znm',v.lat)
% HCC
%rstime=stime;
%rendtime=endtime;
vartotrend=v.hcloud;
reg_trend
hcloud_trend=regtrend_var_oo;
titin=strcat(modtitle,': high cloud trend')
title(titin);
hcloud_znm=nanmean(hcloud_trend,2);

% lw_clr 
vartotrend=v.olr_toa_clr;
reg_trend
lw_clr_trend=regtrend_var_oo;
% lw_cre 
lw_crecre=v.olr_toa_clr-v.olr_toa;
vartotrend=lw_crecre;
reg_trend
lw_cre_trend=regtrend_var_oo;

% sw_clr 
vartotrend=v.swup_toa_clr;
reg_trend
sw_clr_trend=regtrend_var_oo;
% sw_cre 
%rstime=stime;
%rendtime=endtime;
sw_crecre=v.swup_toa_clr-v.swup_toa;
vartotrend=sw_crecre;
reg_trend
sw_cre_trend=regtrend_var_oo;
titin=strcat(modtitle,': short wave cloud radiative effect trend')
title(titin);
sw_cre_znm=nanmean(sw_cre_trend,2);
figure;
plot(sw_cre_znm',v.lat)
%
% compute the net fluxes
cre_trend=sw_cre_trend+lw_cre_trend;
toa_clr_trend=sw_clr_trend+lw_clr_trend;
toa_trend=toa_clr_trend-cre_trend;

% write out fields to be saved in a nc file nad plotted in ncl
%modtitle='am4test';
%
% the fields to be written to ncfilename are: 
%toa_trend
%cre_trend
%sw_cre_trend
%sw_clr_trend
%lw_cre_trend
%lw_cre_trend

ncfilename=strcat(modtitle,'_trends_early.nc')
file_out=ncfilename;
amip_trends_ncout

%lw_cre_trend;
%sw_cre_trend;
%lw_clr_trend;
%sw_clr_trend;

% temp_700
%rstime=stime;
%rendtime=endtime;
% grab the temperature on 700 hPa surface
% Qu et al. 2015 or 16 estimate del EIS as
% del EIS = del T_700 - 1.2*del T_s
contsin=[-1,-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8,1.0]; 
caxisin=[-1.1 1.1];   
temp_700=squeeze(v.temp_full(:,5,:,:));
vartotrend=temp_700;
reg_trend
temp700_trend=regtrend_var_oo;
titin=strcat(modtitle,': temp on 700 hPa surface trend')
title(titin);

% grab the 500 hPa vertical velocity
%rstime=stime;
%rendtime=endtime;
contsin=[-0.025,-0.02,-0.015,-0.01,-0.005,0,0.005,0.01,0.015,0.02,0.025];
caxis=[-0.025 0.025];
omega_500=squeeze(v.omega(:,7,:,:));
vartotrend=omega_500;
reg_trend
omega500_trend=regtrend_var_oo;
titin=strcat(modtitle,': omega on 500 hPa surface trend')
title(titin);
omega500_trend_znm=nanmean(omega500_trend,2);
%
% t_surf 
%rstime=stime;
%rendtime=endtime;
contsin=[-1.5,-1,-0.75,-0.5,-0.25,0,0.25,0.5,0.75,1,1.5]; 
caxisin=[-1.75 1.75];   
vartotrend=v.tref_full;
reg_trend
tsurf_trend=regtrend_var_oo;
titin=strcat(modtitle,': surface temp trend')
title(titin);
tsurf_trend_znm=nanmean(tsurf_trend,2);
% eis
%rstime=1;
%rendtime=ts_length;
contsin=[-2.5,-2.0,-1.5,-1,-0.5,0,0.5,1,1.5,2.0,2.5]; 
caxisin=[-2.5 2.5];   
vartotrend=eis_ts;
reg_trend
eis_trend=regtrend_var_oo;
titin=strcat(modtitle,': estimated inversion strength trend')
title(titin);
eis_trend_znm=nanmean(eis_trend,2);
figure;
plot(eis_trend_znm',v.lat)

%% compute the mean sw_cre over the entire time period
%sw_crecre_mn=mean(sw_crecre,1);
%sw_crecre_mn=squeeze(sw_crecre_mn);
%sw_cre_gmn=sw_crecre_mn.*onlyocean;
%
%contsin=[-10,-20,-30,-40,-50,-60,-70,-80,-90,-100,-110];
%caxisin=[0 -110];
%cont_map_modis(sw_crecre_mn,v.lat,v.lon,contsin,caxisin)
%titin=strcat(modtitle,'average sw cre');
%title(titin)
%colorbar

% zonal mean plot of selected quantities
%figure
%plot(sw_cre_znm',v.lat,'k',3.*eis_trend_znm',v.lat,500.*omega500_trend_znm',v.lat,'r',lcloud_znm',v.lat,'g')

%% code to check how similar the surface temperature actually is between the models
%% first run openncfile_3mods.m to get all three runs loaded
%boohiss_am2p1000=squeeze(v.tsurf_am2ts(1000,:,:));
%boohiss_am3p1000=squeeze(v.tsurf_am3ts(1000,:,:));
%boohiss_am3p1000=squeeze(v.tsurf_am3ts(1000,:,:));
%
%vlat=v.lat_am2;
%vlon=v.lon_am2;
%vlat4=v.lat_am4;
%vlon4=v.lon_am4;
%
%contsin=[269,272,275,278,282,285,288,291,294,297,300];
%caxisin=[266 303];
%
%cont_map_modis(boohiss_am2p1000,vlat,vlon,contsin,caxisin)
%title('am2 time1000')
%cont_map_modis(boohiss_am3p1000,vlat,vlon,contsin,caxisin)
%title('am3 time1000')
%cont_map_modis(boohiss_am4p1000,vlat4,vlon4,contsin,caxisin)
%title('am4 time1000')




