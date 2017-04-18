%---------------------------------------------------------
% alpha_09.m
%
% computes the global climate feedback parameter using 
% linear regression on a moving 30 year window.  the time
% series used in the computation have been averaged over 
% the entire globe for each year of data.
%
% the TOA radiative imbalance is also computed for particular
% geographic windows as set in regional_alpha.m
%
%---------------------------------------------------------
% what vars need to be loaded for this to run? 
% wlat1,wlat2,wlon2,wlon1 
%
%v.tref_ts
%v.olr_toa_ts
%v.swdn_toa_ts
%v.swup_toa_ts
%
%
% calls:
%   global_wmean_script
%
% called by: 
%   regional_alpha
%
% levi silvers                                jan 2017
% 
% updated:                                    apr 2017
%---------------------------------------------------------
%
% if these variables haven't already been set by a calling 
% script then use below:
%temp_ll_ts=v.tref_ts;
%olr_ts=v.olr_toa_ts;
%swdn_ts=v.swdn_toa_ts;
%swup_ts=v.swup_toa_ts;

% compute the weighted global mean values of the 2m temperature
% careful with the size of v.tref_full... it may not be full!
tindex=size(temp_ll_ts,1);
nyears=tindex/12;

tref_gmn_ts     =zeros(tindex,1);
tref_wind_ts    =zeros(tindex,1);
olr_gmn_ts      =zeros(tindex,1);
olr_wind_ts      =zeros(tindex,1);
swdn_gmn_ts     =zeros(tindex,1);
swdn_wind_ts     =zeros(tindex,1);
swup_gmn_ts     =zeros(tindex,1);
swup_wind_ts     =zeros(tindex,1);
swup_clr_gmn_ts =zeros(tindex,1);
swup_clr_wind_ts =zeros(tindex,1);
olr_clr_gmn_ts  =zeros(tindex,1);
olr_clr_wind_ts  =zeros(tindex,1);

%temp_ll_ts=temp_ts;

%latla=40;
%lonla=70;
% related to initializing the glblatweight array
fullfield=squeeze(temp_ll_ts(1,:,:));
global_wmean_script;
test_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

latlen=size(test_wgt_wind,1);
lonlen=size(test_wgt_wind,2);

temp_glblatweight=zeros(latlen,lonlen);
temp_glblatweight=glblatweight(wlat1:wlat2,wlon1:wlon2);
reg_area_sum=sum(temp_glblatweight(:)); % # of grid points in window

for ti=1:tindex;
 
  fullfield=squeeze(temp_ll_ts(ti,:,:));
  global_wmean_script;
  tref_gmn_ts(ti)=wgt_mean;
  tref_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(olr_ts(ti,:,:));
  global_wmean_script;
  olr_gmn_ts(ti)=wgt_mean;
  olr_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);
  
  fullfield=squeeze(olr_clr_ts(ti,:,:));
  global_wmean_script;
  olr_clr_gmn_ts(ti)=wgt_mean;
  olr_clr_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(swdn_ts(ti,:,:));
  global_wmean_script;
  swdn_gmn_ts(ti)=wgt_mean;
  swdn_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

  fullfield=squeeze(swup_clr_ts(ti,:,:));
  global_wmean_script;
  swup_clr_gmn_ts(ti)=wgt_mean;
  swup_clr_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);
  
  fullfield=squeeze(swup_ts(ti,:,:));
  global_wmean_script;
  swup_gmn_ts(ti)=wgt_mean;
  swup_wgt_wind=wgt_var(wlat1:wlat2,wlon1:wlon2);

%  % compute time series for a specific geographic window
%  latlen=size(tref_wgt_wind,1);
%  lonlen=size(tref_wgt_wind,2);
%  temp_glblatweight=zeros(latlen,lonlen);
%  temp_glblatweight=glblatweight(wlat1:wlat2,wlon1:wlon2);
%  reg_area_sum=sum(temp_glblatweight(:));

  tref_wind_ts(ti)=nansum(tref_wgt_wind(:))/reg_area_sum;
  olr_wind_ts(ti)=nansum(olr_wgt_wind(:))/reg_area_sum; 
  olr_clr_wind_ts(ti)=nansum(olr_clr_wgt_wind(:))/reg_area_sum; 
  swdn_wind_ts(ti)=nansum(swdn_wgt_wind(:))/reg_area_sum; 
  swup_wind_ts(ti)=nansum(swup_wgt_wind(:))/reg_area_sum; 
  swup_clr_wind_ts(ti)=nansum(swup_clr_wgt_wind(:))/reg_area_sum; 
end

size(tref_wgt_wind)

% compute a time series of the toa feedback parameter
% should be comparable to ts shown in Gregory and Andrews 2016

%instantaneous, running mean, or regression analysis?
% begin by computing the yearly mean values...
clear monthsbyyears
monthsbyyears=reshape(tref_gmn_ts,[12 nyears]);
tref_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(olr_gmn_ts,[12 nyears]);
olr_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(olr_clr_gmn_ts,[12 nyears]);
olr_clr_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swdn_gmn_ts,[12 nyears]);
swdn_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swup_gmn_ts,[12 nyears]);
swup_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swup_clr_gmn_ts,[12 nyears]);
swup_clr_yearlymean=mean(monthsbyyears,1);

% yearly mean values for selected window
monthsbyyears=reshape(tref_wind_ts,[12 nyears]);
tref_wind_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(olr_wind_ts,[12 nyears]);
olr_wind_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(olr_clr_wind_ts,[12 nyears]);
olr_clr_wind_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swdn_wind_ts,[12 nyears]);
swdn_wind_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swup_wind_ts,[12 nyears]);
swup_wind_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swup_clr_wind_ts,[12 nyears]);
swup_clr_wind_yearlymean=mean(monthsbyyears,1);

%% delR=incoming-outgoing=v.swdn_toa-v.olr_toa-v.swup_toa;

toa_R=swdn_yearlymean-swup_yearlymean-olr_yearlymean;
toa_R_wind=swdn_wind_yearlymean-swup_wind_yearlymean-olr_wind_yearlymean;
%toa_R_lw=-olr_yearlymean;
%toa_R_sw=swdn_yearlymean-swup_yearlymean;
toa_clr_R=swdn_yearlymean-swup_clr_yearlymean-olr_clr_yearlymean;
toa_clr_R_wind=swdn_wind_yearlymean-swup_clr_wind_yearlymean-olr_clr_wind_yearlymean;
toa_cre_R=toa_clr_R-toa_R;
toa_cre_R_wind=toa_clr_R_wind-toa_R_wind;

% in Gregory and Andrews 2016, the time series are expressed as 
% differences from the AMIP period 1979-2008 but I don't think
% it should matter for the regression plots, only the axis of 
% the scatter plot.  right?

%mn30yr_tref=mean(tref_yearlymean(1:20));
%mn30yr_R=mean(toa_R(1:20));
%mn30yr_clr_R=mean(toa_clr_R(1:20));
%mn30yr_cre_R=mean(toa_cre_R(1:20));

mn30yr_tref=mean(tref_yearlymean(nyears-30:nyears));
mn30yr_wind_tref=mean(tref_wind_yearlymean(nyears-30:nyears));
mn30yr_R=mean(toa_R(nyears-30:nyears));
mn30yr_R_wind=mean(toa_R_wind(nyears-30:nyears));

mn30yr_clr_R=mean(toa_clr_R(nyears-30:nyears));
mn30yr_cre_R=mean(toa_cre_R(nyears-30:nyears));
%mn30yr_R_lw=mean(toa_R_lw(nyears-36:nyears));
%mn30yr_R_sw=mean(toa_R_sw(nyears-36:nyears));

delTs=tref_yearlymean-mn30yr_tref;
%delTs_wind=tref_wind_yearlymean-mn30yr_wind_tref;
delTs_wind=tref_wind_yearlymean-mn30yr_tref;
delR=toa_R-mn30yr_R;
%delR_wind=toa_R_wind-mn30yr_R_wind;
delR_wind=toa_R_wind-mn30yr_R;
%delR_lw=toa_R_lw-mn30yr_R_lw;
%delR_sw=toa_R_sw-mn30yr_R_sw;
delR_clr=toa_clr_R-mn30yr_clr_R;
delR_cre=toa_cre_R-mn30yr_cre_R;

window_yr=30;
st=1;
%tend=nyears-window_yr-1;
tend=nyears-window_yr;
alpha_30y=zeros(tend,1);
alpha_30y_wind=zeros(tend,1);
%alpha_lw_30y=zeros(tend,1);
%alpha_sw_30y=zeros(tend,1);
alpha_cre_30y=zeros(tend,1);
alpha_clr_30y=zeros(tend,1);
%delT_run=zeros(tend,1);

% compute the linear regressino over 30 yr windows
% slope can also be computed using endpoints of 30 yr window.
% end point computation of slope is given by regval_ep compared 
% to regval
denlimit=0.1;
for ti=1:tend;
    endt            =st+window_yr;
    %endt            =ti+window_yr; % to follow david P's method
    delTs30yr       =delTs(st:endt);
    delR30yr        =delR(st:endt);
    delR_cre_30yr   =delR_cre(st:endt);
    delR_clr_30yr   =delR_clr(st:endt);

    regval       =polyfit(delTs30yr,delR30yr,1);
    denom=delTs(endt)-delTs(st);
    denom(abs(denom)<denlimit)=denlimit;
    %regval=(delR(endt)-delR(st))/(delTs(endt)-delTs(st));
    regval_ep=(delR(endt)-delR(st))/denom;
    %regval(abs(regval)<denlimit)=denlimit;

    regval_cre   =polyfit(delTs30yr,delR_cre_30yr,1);
    regval_cre_ep=(delR_cre(endt)-delR_cre(st))/denom;
    %regval_cre(abs(regval_cre)<denlimit)=denlimit;
    regval_clr   =polyfit(delTs30yr,delR_clr_30yr,1);
    regval_clr_ep=(delR_clr(endt)-delR_clr(st))/denom;
    %regval_clr(abs(regval_clr)<denlimit)=denlimit;

    alpha_30y(ti)       =regval(1);
    alpha_cre_30y(ti)   =regval_cre(1);
    alpha_clr_30y(ti)   =regval_clr(1);

%    delR_lw_30yr=delR_lw(st:endt);
%    delR_sw_30yr=delR_sw(st:endt);
%    regval_lw=polyfit(delTs30yr,delR_lw_30yr,1);
%    regval_sw=polyfit(delTs30yr,delR_sw_30yr,1);
%    alpha_lw_30y(ti)=regval_lw(1);
%    alpha_sw_30y(ti)=regval_sw(1);

% if computing over a window:
    delTs30yr_wind  =delTs_wind(st:endt);
    delR30yr_wind   =delR_wind(st:endt);
    regval_wind     =polyfit(delTs30yr_wind,delR30yr_wind,1);
    regval_wind_ep=(delR_wind(endt)-delR_wind(st))/denom;
    alpha_30y_wind(ti)  =regval_wind(1);

    st=st+1;
end
%for ti=1:tend;
%  delT_per=delTs_am4(ti:ti+30);
%  delT_run(ti)=mean(delT_per);
%end
figure
plot(alpha_30y,'k')
hold on
plot(alpha_cre_30y,'b')
plot(alpha_clr_30y,'r')
hold off
title('cre and clr')
whycorr=corrcoef(alpha_30y,alpha_cre_30y);

%figure
%plot(alpha_lw_30y,'r')
%hold on
%plot(alpha_sw_30y,'b')
%plot(alpha_30y,'k')
%title('lw and sw')
%hold off
