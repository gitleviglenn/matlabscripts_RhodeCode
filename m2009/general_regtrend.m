%----------------------------------------------------------------------------------
% levi silvers					jan 2017
%----------------------------------------------------------------------------------

tindex=size(temp_ts,1);
nyears=tindex/12;

tref_gmn_ts=zeros(tindex,1);
tref_trmn_ts=zeros(tindex,1);
tref_windmn_ts=zeros(tindex,1);

genvar_gmn_ts=zeros(tindex,1);
genvar_trmn_ts=zeros(tindex,1);
genvar_windmn_ts=zeros(tindex,1);

% compute global means
% what should I do about land?  If I use the only_ocean mask then the zero's 
% over land will pervert the global mean.  NaNs?  Perhaps just leave the values
% as are over land, but block them out in the final figures?  
%lat1=36;
%lat2=55;

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

  fullfield=squeeze(genvar_ts(ti,:,:));
  global_wmean_script;
  genvar_gmn_ts(ti)=wgt_mean;

  tropfield=squeeze(genvar_ts(ti,lat1:lat2,:));
  tropzmn=mean(tropfield,1);
  tropmn=mean(tropzmn,2);
  genvar_trmn_ts(ti)=tropmn;

  %windfield=squeeze(genvar_ts(ti,wlat1:wlat2,wlon1:wlon2));
  %windzmn=mean(windfield,1);
  %windmn=mean(windzmn,2);
  %genvar_windmn_ts(ti)=windmn;
end

% compute yearly means
clear monthsbyyears
clear monthsbyyears_tr
%clear monthsbyyears_wind

monthsbyyears=reshape(tref_gmn_ts,[12 nyears]);
tref_yearlymean=mean(monthsbyyears,1);
monthsbyyears_tr=reshape(tref_trmn_ts,[12 nyears]);
tref_tr_yearlymean=mean(monthsbyyears_tr,1);
%monthsbyyears_wind=reshape(tref_windmn_ts,[12 nyears]);
%tref_wind_yearlymean=mean(monthsbyyears_wind,1);

monthsbyyears=reshape(genvar_gmn_ts,[12 nyears]);
genvar_yearlymean=mean(monthsbyyears,1);
monthsbyyears_tr=reshape(genvar_trmn_ts,[12 nyears]);
genvar_tr_yearlymean=mean(monthsbyyears_tr,1);
%monthsbyyears_wind=reshape(genvar_windmn_ts,[12 nyears]);
%genvar_wind_yearlymean=mean(monthsbyyears_wind,1);

% reference
mn_init_tref=mean(tref_yearlymean(nyears-30:nyears));
mn_init_genvar=mean(genvar_yearlymean(nyears-30:nyears));
%
mn_init_tref_tr=mean(tref_tr_yearlymean(nyears-30:nyears));
mn_init_genvar_tr=mean(genvar_tr_yearlymean(nyears-30:nyears));
%
%mn_init_tref_wind=mean(tref_wind_yearlymean(nyears-30:nyears));
%mn_init_genvar_wind=mean(genvar_wind_yearlymean(nyears-30:nyears));

% compute anomalies
delTrf=tref_yearlymean-mn_init_tref;
delgenvar=genvar_yearlymean-mn_init_genvar;
%
delTrf_tr=tref_tr_yearlymean-mn_init_tref_tr;
delgenvar_tr=genvar_tr_yearlymean-mn_init_genvar_tr;
%
%delTrf_wind=tref_wind_yearlymean-mn_init_tref_wind;
%delgenvar_wind=genvar_wind_yearlymean-mn_init_genvar_wind;

window_yr=30;
st=1;
tend=nyears-window_yr-1;
genvar_30y=zeros(tend,1);
tr_genvar_30y=zeros(tend,1);
%wind_genvar_30y=zeros(tend,1);
for ti=1:tend;
    endt=st+window_yr;
    %
    delTrf30yr=delTrf(st:endt);
    delTrf_tr_30yr=delTrf_tr(st:endt);
%    delTrf_wind_30yr=delTrf_wind(st:endt);
    %
    delgenvar30yr=delgenvar(st:endt);
    delgenvar_tr_30yr=delgenvar_tr(st:endt);
%    delgenvar_wind_30yr=delgenvar_wind(st:endt);
    %
    regval=polyfit(delTrf30yr,delgenvar30yr,1);
    tr_regval=polyfit(delTrf_tr_30yr,delgenvar_tr_30yr,1);
%    wind_regval=polyfit(delTrf_wind_30yr,delgenvar_wind_30yr,1);
    %
    genvar_30y(ti)=regval(1);
    tr_genvar_30y(ti)=tr_regval(1);
%    wind_genvar_30y(ti)=wind_regval(1);
    %
    st=st+1;
end


% reproduce plot 2c from Zhou et al. 2016
% i don' think that regression trends have been used there

% these time series have already had the mean from a 30 year period subtracted...
% delEIS
% delEIS_tr

% we could also use tref_yearlymean and eis_yearlymean (eis_tr_yearlymean)

lcloud_gyrmn_am4ts=genvar_yearlymean;
lcloud_tryrmn_am4ts=genvar_tr_yearlymean;
tmn_am4ts=mean(genvar_yearlymean,2);
lcloud_tryrmn_anom_am4ts=lcloud_tryrmn_am4ts-tmn_am4ts;
tmn_tr_am4ts=mean(genvar_tr_yearlymean,2);
lcloud_tryrmn_anom_am4ts=lcloud_tryrmn_am4ts-tmn_tr_am4ts;
lcloud_gyrmn_anom_am4ts=lcloud_gyrmn_am4ts-tmn_am4ts;
figure
plot(lcloud_gyrmn_anom_am4ts,'k')

eis_gtmn_tsam4=mean(eis_yearlymean,2);
eis_gyrmn_anom_tsam4=eis_yearlymean-eis_gtmn_tsam4;
eis_trtmn_tsam4=mean(eis_tr_yearlymean,2);
eis_tryrmn_anom_tsam4=eis_tr_yearlymean-eis_trtmn_tsam4;

% tref
tref_gtmn_tsam4=mean(tref_yearlymean,2);
tref_gyrmn_anom_tsam4=tref_yearlymean-tref_gtmn_tsam4;
tref_trtmn_tsam4=mean(tref_tr_yearlymean,2);
tref_tryrmn_anom_tsam4=tref_tr_yearlymean-tref_trtmn_tsam4;
