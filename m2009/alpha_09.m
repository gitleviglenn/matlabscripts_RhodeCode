%---------------------------------------------------------
% what vars need to be loaded for this to run? 
%v.tref_ts
%v.olr_toa_ts
%v.swdn_toa_ts
%v.swup_toa_ts
%
%
% calls:
% global_wmean_script
%
% levi silvers                                jan 2017
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
tref_gmn_ts=zeros(tindex,1);
olr_gmn_ts=zeros(tindex,1);
swdn_gmn_ts=zeros(tindex,1);
swup_gmn_ts=zeros(tindex,1);
swup_clr_gmn_ts=zeros(tindex,1);
olr_clr_gmn_ts=zeros(tindex,1);

latla=40;
lonla=70;
for ti=1:tindex;
 
  fullfield=squeeze(temp_ll_ts(ti,:,:));
  global_wmean_script;
  tref_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(olr_ts(ti,:,:));
  global_wmean_script;
  olr_gmn_ts(ti)=wgt_mean;
  
  fullfield=squeeze(olr_clr_ts(ti,:,:));
  global_wmean_script;
  olr_clr_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(swdn_ts(ti,:,:));
  global_wmean_script;
  swdn_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(swup_clr_ts(ti,:,:));
  global_wmean_script;
  swup_clr_gmn_ts(ti)=wgt_mean;
  
  fullfield=squeeze(swup_ts(ti,:,:));
  global_wmean_script;
  swup_gmn_ts(ti)=wgt_mean;
end

%for ti=1:tindex;
%  tref_gmn_ts(ti)=squeeze(temp_ll_ts(ti,latla,lonla));
%  olr_gmn_ts(ti)=squeeze(olr_ts(ti,latla,lonla));
%  olr_clr_gmn_ts(ti)=squeeze(olr_clr_ts(ti,latla,lonla));
%  swdn_gmn_ts(ti)=squeeze(swdn_ts(ti,latla,lonla));
%  swup_clr_gmn_ts(ti)=squeeze(swup_clr_ts(ti,latla,lonla));
%  swup_gmn_ts(ti)=squeeze(swup_ts(ti,latla,lonla));
%end

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
monthsbyyears=reshape(swdn_gmn_ts,[12 nyears]);
swdn_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swup_gmn_ts,[12 nyears]);
swup_yearlymean=mean(monthsbyyears,1);
monthsbyyears=reshape(swup_clr_gmn_ts,[12 nyears]);
swup_clr_yearlymean=mean(monthsbyyears,1);

%% delR=incoming-outgoing=v.swdn_toa-v.olr_toa-v.swup_toa;

toa_R=swdn_yearlymean-swup_yearlymean-olr_yearlymean;
%toa_R_lw=-olr_yearlymean;
%toa_R_sw=swdn_yearlymean-swup_yearlymean;
toa_clr_R=swdn_yearlymean-swup_clr_yearlymean-olr_clr_yearlymean;
toa_cre_R=toa_clr_R-toa_R;

% in Gregory and Andrews 2016, the time series are expressed as 
% differences from the AMIP period 1979-2008 but I don't think
% it should matter for the regression plots, only the axis of 
% the scatter plot.  right?

%mn_init_tref=mean(tref_yearlymean(1:20));
%mn_init_R=mean(toa_R(1:20));
%mn_init_clr_R=mean(toa_clr_R(1:20));
%mn_init_cre_R=mean(toa_cre_R(1:20));

mn_init_tref=mean(tref_yearlymean(nyears-30:nyears));
mn_init_R=mean(toa_R(nyears-30:nyears));
mn_init_clr_R=mean(toa_clr_R(nyears-30:nyears));
mn_init_cre_R=mean(toa_cre_R(nyears-30:nyears));
%mn_init_R_lw=mean(toa_R_lw(nyears-36:nyears));
%mn_init_R_sw=mean(toa_R_sw(nyears-36:nyears));

delTs=tref_yearlymean-mn_init_tref;
delR=toa_R-mn_init_R;
%delR_lw=toa_R_lw-mn_init_R_lw;
%delR_sw=toa_R_sw-mn_init_R_sw;
delR_clr=toa_clr_R-mn_init_clr_R;
delR_cre=toa_cre_R-mn_init_cre_R;

window_yr=30;
st=1;
tend=nyears-window_yr-1;
alpha_30y=zeros(tend,1);
%alpha_lw_30y=zeros(tend,1);
%alpha_sw_30y=zeros(tend,1);
alpha_cre_30y=zeros(tend,1);
alpha_clr_30y=zeros(tend,1);
delT_run=zeros(tend,1);
for ti=1:tend;
    endt=st+window_yr;
    delTs30yr=delTs(st:endt);
    delR30yr=delR(st:endt);
 %   delR_lw_30yr=delR_lw(st:endt);
 %   delR_sw_30yr=delR_sw(st:endt);
    delR_cre_30yr=delR_cre(st:endt);
    delR_clr_30yr=delR_clr(st:endt);
    regval=polyfit(delTs30yr,delR30yr,1);
    regval_cre=polyfit(delTs30yr,delR_cre_30yr,1);
    regval_clr=polyfit(delTs30yr,delR_clr_30yr,1);
%    regval_lw=polyfit(delTs30yr,delR_lw_30yr,1);
%    regval_sw=polyfit(delTs30yr,delR_sw_30yr,1);
    alpha_30y(ti)=regval(1);
%    alpha_lw_30y(ti)=regval_lw(1);
%    alpha_sw_30y(ti)=regval_sw(1);
    alpha_cre_30y(ti)=regval_cre(1);
    alpha_clr_30y(ti)=regval_clr(1);
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
