%----------------------------------------------------------------------------------
% levi silvers					jan 2017
%----------------------------------------------------------------------------------

tindex=1620;
%tindex=size(temp_ts,1);
nyears=tindex/12;

tref_gmn_ts=zeros(tindex,1);
tref_trmn_ts=zeros(tindex,1);
tref_windmn_ts=zeros(tindex,1);

eis_gmn_ts=zeros(tindex,1);
eis_trmn_ts=zeros(tindex,1);
eis_windmn_ts=zeros(tindex,1);

lcloud_gmn_ts=zeros(tindex,1);
lcloud_trmn_ts=zeros(tindex,1);
lcloud_windmn_ts=zeros(tindex,1);

% compute global means
% what should I do about land?  If I use the only_ocean mask then the zero's 
% over land will pervert the global mean.  NaNs?  Perhaps just leave the values
% as are over land, but block them out in the final figures?  
%lat1=36;
%lat2=55;

clear fullfield;
clear delTrf;
clear delEIS;

for ti=1:tindex;
  fullfield=squeeze(temp_ts(ti,:,:));
  global_wmean_script;
  tref_gmn_ts(ti)=wgt_mean;

  tropfield=squeeze(temp_ts(ti,lat1:lat2,:));
  tropzmn=mean(tropfield,1);
  tropmn=mean(tropzmn,2);
  tref_trmn_ts(ti)=tropmn;

  %windfield=squeeze(temp_ts(ti,wlat1:wlat2,wlon1:wlon2));
  %windzmn=mean(windfield,1);
  %windmn=mean(windzmn,2);
  %tref_windmn_ts(ti)=windmn;

  fullfield=squeeze(eis_ts(ti,:,:));
  global_wmean_script;
  eis_gmn_ts(ti)=wgt_mean;

  tropfield=squeeze(eis_ts(ti,lat1:lat2,:));
  tropzmn=mean(tropfield,1);
  tropmn=mean(tropzmn,2);
  eis_trmn_ts(ti)=tropmn;

  %windfield=squeeze(eis_ts(ti,wlat1:wlat2,wlon1:wlon2));
  %windzmn=mean(windfield,1);
  %windmn=mean(windzmn,2);
  %eis_windmn_ts(ti)=windmn;

 % lcloud
   fullfield=squeeze(lcloud_ts(ti,:,:));
   global_wmean_script;
   lcloud_gmn_ts(ti)=wgt_mean;

   tropfield=squeeze(lcloud_ts(ti,lat1:lat2,:));
   tropzmn=mean(tropfield,1);
   tropmn=mean(tropzmn,2);
   lcloud_trmn_ts(ti)=tropmn;
end

% compute yearly means
clear monthsbyyears
clear monthsbyyears_tr
%clear monthsbyyears_wind

%tref
monthsbyyears=reshape(tref_gmn_ts,[12 nyears]);
tref_yearlymean=mean(monthsbyyears,1);
tref_gtmn_ts=mean(tref_yearlymean,2);
tref_gyrmn_anom_ts=tref_yearlymean-tref_gtmn_ts;

monthsbyyears_tr=reshape(tref_trmn_ts,[12 nyears]);
tref_tr_yearlymean=mean(monthsbyyears_tr,1);
tref_trtmn_ts=mean(tref_tr_yearlymean,2);
tref_tryrmn_anom_ts=tref_tr_yearlymean-tref_trtmn_ts;

%monthsbyyears_wind=reshape(tref_windmn_ts,[12 nyears]);
%tref_wind_yearlymean=mean(monthsbyyears_wind,1);

%eis
monthsbyyears=reshape(eis_gmn_ts,[12 nyears]);
eis_yearlymean=mean(monthsbyyears,1);
eis_gtmn_ts=mean(eis_yearlymean,2);
eis_gyrmn_anom_ts=eis_yearlymean-eis_gtmn_ts;

monthsbyyears_tr=reshape(eis_trmn_ts,[12 nyears]);
eis_tr_yearlymean=mean(monthsbyyears_tr,1);
eis_trtmn_ts=mean(eis_tr_yearlymean,2);
eis_tryrmn_anom_ts=eis_tr_yearlymean-eis_trtmn_ts;

%monthsbyyears_wind=reshape(eis_windmn_ts,[12 nyears]);
%eis_wind_yearlymean=mean(monthsbyyears_wind,1);

%lcloud
monthsbyyears=reshape(lcloud_gmn_ts,[12 nyears]);
lcloud_yearlymean=mean(monthsbyyears,1);
lcloud_gtmn_ts=mean(lcloud_yearlymean,2);
lcloud_gyrmn_anom_ts=lcloud_yearlymean-lcloud_gtmn_ts;

monthsbyyears_tr=reshape(lcloud_trmn_ts,[12 nyears]);
lcloud_tr_yearlymean=mean(monthsbyyears_tr,1);
lcloud_tr_ts=mean(lcloud_tr_yearlymean,2);
lcloud_tryrmn_anom_ts=lcloud_tr_yearlymean-lcloud_tr_ts;

% compute the running mean for anomaly time series
tendindex=nyears-4; % why minus 4?
incoming_ts=lcloud_gyrmn_anom_ts;
running_mean
lcloud_gyrmn_anom_ts=output_ts;

incoming_ts=lcloud_tryrmn_anom_ts;
running_mean
lcloud_tryrmn_anom_ts=output_ts;

incoming_ts=eis_gyrmn_anom_ts;
running_mean
eis_gyrmn_anom_ts=output_ts;

incoming_ts=eis_tryrmn_anom_ts;
running_mean
eis_tryrmn_anom_ts=output_ts;

incoming_ts=tref_gyrmn_anom_ts;
running_mean
tref_gyrmn_anom_ts=output_ts;

incoming_ts=tref_tryrmn_anom_ts;
running_mean
tref_tryrmn_anom_ts=output_ts;

% figures for anomalies
jackhearts=3.7.*eis_tryrmn_anom_ts-0.9.*tref_tryrmn_anom_ts;
figure
plot(jackhearts,'g','LineWidth',2)
hold on
plot(3.7.*eis_tryrmn_anom_ts,'k')
plot(-0.9.*tref_tryrmn_anom_ts,'r')
plot(lcloud_tryrmn_anom_ts,'b','LineWidth',2)
title('tr product time series')
corrcoef(lcloud_tryrmn_anom_ts,jackhearts)

% figures for anomalies
jackhearts_g=3.7.*eis_gyrmn_anom_ts-0.9.*tref_gyrmn_anom_ts;
figure
plot(jackhearts_g,'g','LineWidth',2)
hold on
plot(3.7.*eis_gyrmn_anom_ts,'k')
plot(-0.9.*tref_gyrmn_anom_ts,'r')
plot(lcloud_gyrmn_anom_ts,'b','LineWidth',2)
title('gl product time series')
corrcoef(lcloud_gyrmn_anom_ts,jackhearts_g)

%------------------------------------------------------------------
% reference
mn_init_tref=mean(tref_yearlymean(nyears-30:nyears));
mn_init_eis=mean(eis_yearlymean(nyears-30:nyears));
mn_init_lcloud=mean(lcloud_yearlymean(nyears-30:nyears));
%
mn_init_tref_tr=mean(tref_tr_yearlymean(nyears-30:nyears));
mn_init_eis_tr=mean(eis_tr_yearlymean(nyears-30:nyears));
mn_init_lcoud_tr=mean(lcloud_tr_yearlymean(nyears-30:nyears));
%
%mn_init_tref_wind=mean(tref_wind_yearlymean(nyears-30:nyears));
%mn_init_eis_wind=mean(eis_wind_yearlymean(nyears-30:nyears));

% compute anomalies
delTrf=tref_yearlymean-mn_init_tref;
delEIS=eis_yearlymean-mn_init_eis;
dellcloud=lcloud_yearlymean-mn_init_lcloud;
%
delTrf_tr=tref_tr_yearlymean-mn_init_tref_tr;
delEIS_tr=eis_tr_yearlymean-mn_init_eis_tr;
%
%delTrf_wind=tref_wind_yearlymean-mn_init_tref_wind;
%delEIS_wind=eis_wind_yearlymean-mn_init_eis_wind;

window_yr=30;
st=1;
tend=nyears-window_yr-1;
eis_30y=zeros(tend,1);
tr_eis_30y=zeros(tend,1);
%wind_eis_30y=zeros(tend,1);
for ti=1:tend;
    endt=st+window_yr;
    %
    delTrf30yr=delTrf(st:endt);
    delTrf_tr_30yr=delTrf_tr(st:endt);
%    delTrf_wind_30yr=delTrf_wind(st:endt);
    %
    delEIS30yr=delEIS(st:endt);
    delEIS_tr_30yr=delEIS_tr(st:endt);
%    delEIS_wind_30yr=delEIS_wind(st:endt);
    %
    regval=polyfit(delTrf30yr,delEIS30yr,1);
    tr_regval=polyfit(delTrf_tr_30yr,delEIS_tr_30yr,1);
%    wind_regval=polyfit(delTrf_wind_30yr,delEIS_wind_30yr,1);
    %
    eis_30y(ti)=regval(1);
    tr_eis_30y(ti)=tr_regval(1);
%    wind_eis_30y(ti)=wind_regval(1);
    %
    st=st+1;
end

