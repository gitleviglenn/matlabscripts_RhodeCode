%------------------------------------------------------------------------------
% reproduce plot 2c from Zhou et al. 2016
% i don' think that regression trends have been used there
%
% before this is called, temp_ts, eis_ts, and lcloud_ts need to exist.
%
% zum beispiel: 
% temp_ts =v.tsurf_am4ts;
% eis_ts  =eis_am4ts;
% vlon    =v.lon_am4ts;
% vlat    =v.lat_am4ts;
% lcloud_ts=v.lcloud_am4ts;
%------------------------------------------------------------------------------

%tindex=1620;
tindex=size(temp_ts,1);
tindex=tindex-12
nyears=tindex/12

lcloud_gmn_ts=zeros(tindex,1);
lcloud_trmn_ts=zeros(tindex,1);

eis_gmn_ts=zeros(tindex,1);
eis_trmn_ts=zeros(tindex,1);

tsurf_gmn_ts=zeros(tindex,1);
tsurf_trmn_ts=zeros(tindex,1);

% compute the global mean cosine weighted time series
for ti=1:tindex;
  % eis 
  fullfield=squeeze(eis_ts(ti,:,:));
  global_wmean_script;
  eis_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(eis_ts(ti,:,:));
  global_wmean_script;
  eis_trmn_ts(ti)=wgt_mean;

  % tsurf
  fullfield=squeeze(temp_ts(ti,:,:));
  global_wmean_script;
  tsurf_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(temp_ts(ti,:,:));
  global_wmean_script;
  tsurf_trmn_ts(ti)=wgt_mean;

  % lcloud 
  fullfield=squeeze(lcloud_ts(ti,:,:));
  global_wmean_script;
  lcloud_gmn_ts(ti)=wgt_mean;

  fullfield=squeeze(lcloud_ts(ti,:,:));
  global_wmean_script;
  lcloud_trmn_ts(ti)=wgt_mean;
end

% compute yearly means
% lcloud
clear monthsbyyears
monthsbyyears=reshape(lcloud_gmn_ts,[12 nyears]);
lcloud_yearlymean=mean(monthsbyyears,1);
lcloud_gtmn_ts=mean(lcloud_yearlymean,2);
lcloud_gyrmn_anom_ts=lcloud_yearlymean-lcloud_gtmn_ts;

clear monthsbyyears
monthsbyyears=reshape(lcloud_trmn_ts,[12 nyears]);
lcloud_tr_yearlymean=mean(monthsbyyears,1);
lcloud_tr_ts=mean(lcloud_tr_yearlymean,2);
lcloud_tryrmn_anom_ts=lcloud_tr_yearlymean-lcloud_tr_ts;

% eis
clear monthsbyyears
monthsbyyears=reshape(eis_gmn_ts,[12 nyears]);
eis_yearlymean=mean(monthsbyyears,1);
eis_gtmn_ts=mean(eis_yearlymean,2);
eis_gyrmn_anom_ts=eis_yearlymean-eis_gtmn_ts;

clear monthsbyyears
monthsbyyears=reshape(eis_trmn_ts,[12 nyears]);
eis_tr_yearlymean=mean(monthsbyyears,1);
eis_trtmn_ts=mean(eis_tr_yearlymean,2);
eis_tryrmn_anom_ts=eis_tr_yearlymean-eis_trtmn_ts;

% tsurf
clear monthsbyyears
monthsbyyears=reshape(tsurf_gmn_ts,[12 nyears]);
tsurf_yearlymean=mean(monthsbyyears,1);
tsurf_gtmn_ts=mean(tsurf_yearlymean,2);
tsurf_gyrmn_anom_ts=tsurf_yearlymean-tsurf_gtmn_ts;

clear monthsbyyears
monthsbyyears_tr=reshape(tsurf_trmn_ts,[12 nyears]);
tsurf_tr_yearlymean=mean(monthsbyyears_tr,1);
tsurf_trtmn_ts=mean(tsurf_tr_yearlymean,2);
tsurf_tryrmn_anom_ts=tsurf_tr_yearlymean-tsurf_trtmn_ts;

%% compute the running mean
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

incoming_ts=tsurf_gyrmn_anom_ts;
running_mean
tsurf_gyrmn_anom_ts=output_ts;

incoming_ts=tsurf_tryrmn_anom_ts;
running_mean
tsurf_tryrmn_anom_ts=output_ts;

%
jackhearts=3.7.*eis_tryrmn_anom_ts-0.9.*tsurf_tryrmn_anom_ts;
%jackhearts=3.7.*eis_tryrmn_anom_ts-0.25.*tsurf_tryrmn_anom_ts;
jackhearts_glob=3.7.*eis_gyrmn_anom_ts-0.9.*tsurf_gyrmn_anom_ts;
%
figure
plot(lcloud_tryrmn_anom_ts,'b')
hold on
plot(eis_tryrmn_anom_ts,'k')
plot(tsurf_tryrmn_anom_ts,'r')
plot(jackhearts,'g','LineWidth',2)
% we could also use tsurf_yearlymean and eis_yearlymean (eis_tr_yearlymean)
plot(lcloud_tryrmn_anom_ts,'b')
hold on
plot(eis_tryrmn_anom_ts,'k')
plot(tsurf_tryrmn_anom_ts,'r')
plot(jackhearts,'g','LineWidth',2)
title('base time series')


figure
plot(jackhearts,'g','LineWidth',2)
hold on
plot(3.7.*eis_tryrmn_anom_ts,'k')
plot(-0.9.*tsurf_tryrmn_anom_ts,'r')
plot(lcloud_tryrmn_anom_ts,'b','LineWidth',2)
title('product time series')
