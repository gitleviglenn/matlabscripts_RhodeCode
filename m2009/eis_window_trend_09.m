%----------------------------------------------------------------------------------
% levi silvers					jan 2017
%----------------------------------------------------------------------------------

tindex=size(temp_ts,1);
nyears=tindex/12;

tref_gmn_ts=zeros(tindex,1);
eis_gmn_ts=zeros(tindex,1);
tref_trmn_ts=zeros(tindex,1);
eis_trmn_ts=zeros(tindex,1);
tref_windmn_ts=zeros(tindex,1);
eis_windmn_ts=zeros(tindex,1);

% compute global means
% what should I do about land?  If I use the only_ocean mask then the zero's 
% over land will pervert the global mean.  NaNs?  Perhaps just leave the values
% as are over land, but block them out in the final figures?  
%lat1=36;
%lat2=55;

for ti=1:tindex;
%  fullfield=squeeze(temp_ts(ti,:,:));
%  global_wmean_script;
%  tref_gmn_ts(ti)=wgt_mean;
%
%  tropfield=squeeze(temp_ts(ti,lat1:lat2,:));
%  tropzmn=mean(tropfield,1);
%  tropmn=mean(tropzmn,2);
%  tref_trmn_ts(ti)=tropmn;

  windfield=squeeze(temp_ts(ti,wlat1:wlat2,wlon1:wlon2));
  windzmn=mean(windfield,1);
  windmn=mean(windzmn,2);
  tref_windmn_ts(ti)=windmn;

%  fullfield=squeeze(eis_ts(ti,:,:));
%  global_wmean_script;
%  eis_gmn_ts(ti)=wgt_mean;
%
%  tropfield=squeeze(eis_ts(ti,lat1:lat2,:));
%  tropzmn=mean(tropfield,1);
%  tropmn=mean(tropzmn,2);
%  eis_trmn_ts(ti)=tropmn;

  windfield=squeeze(eis_ts(ti,wlat1:wlat2,wlon1:wlon2));
  windzmn=mean(windfield,1);
  windmn=mean(windzmn,2);
  eis_windmn_ts(ti)=windmn;
end

% compute yearly means
%clear monthsbyyears
%clear monthsbyyears_tr
clear monthsbyyears_wind

%monthsbyyears=reshape(tref_gmn_ts,[12 nyears]);
%tref_yearlymean=mean(monthsbyyears,1);
%monthsbyyears_tr=reshape(tref_trmn_ts,[12 nyears]);
%tref_tr_yearlymean=mean(monthsbyyears_tr,1);
monthsbyyears_wind=reshape(tref_windmn_ts,[12 nyears]);
tref_wind_yearlymean=mean(monthsbyyears_wind,1);

%monthsbyyears=reshape(eis_gmn_ts,[12 nyears]);
%eis_yearlymean=mean(monthsbyyears,1);
%monthsbyyears_tr=reshape(eis_trmn_ts,[12 nyears]);
%eis_tr_yearlymean=mean(monthsbyyears_tr,1);
monthsbyyears_wind=reshape(eis_windmn_ts,[12 nyears]);
eis_wind_yearlymean=mean(monthsbyyears_wind,1);

% reference
%mn_init_tref=mean(tref_yearlymean(nyears-30:nyears));
%mn_init_eis=mean(eis_yearlymean(nyears-30:nyears));
%%
%mn_init_tref_tr=mean(tref_tr_yearlymean(nyears-30:nyears));
%mn_init_eis_tr=mean(eis_tr_yearlymean(nyears-30:nyears));
%
mn_init_tref_wind=mean(tref_wind_yearlymean(nyears-30:nyears));
mn_init_eis_wind=mean(eis_wind_yearlymean(nyears-30:nyears));

% compute anomalies
%delTrf=tref_yearlymean-mn_init_tref;
%delEIS=eis_yearlymean-mn_init_eis;
%%
%delTrf_tr=tref_tr_yearlymean-mn_init_tref_tr;
%delEIS_tr=eis_tr_yearlymean-mn_init_eis_tr;
%
delTrf_wind=tref_wind_yearlymean-mn_init_tref_wind;
delEIS_wind=eis_wind_yearlymean-mn_init_eis_wind;

window_yr=30;
st=1;
tend=nyears-window_yr-1;
eis_30y=zeros(tend,1);
tr_eis_30y=zeros(tend,1);
wind_eis_30y=zeros(tend,1);
for ti=1:tend;
    endt=st+window_yr;
    %
    %delTrf30yr=delTrf(st:endt);
    %delTrf_tr_30yr=delTrf_tr(st:endt);
    delTrf_wind_30yr=delTrf_wind(st:endt);
    %
    %delEIS30yr=delEIS(st:endt);
    %delEIS_tr_30yr=delEIS_tr(st:endt);
    delEIS_wind_30yr=delEIS_wind(st:endt);
    %
    %regval=polyfit(delTrf30yr,delEIS30yr,1);
    %tr_regval=polyfit(delTrf_tr_30yr,delEIS_tr_30yr,1);
    wind_regval=polyfit(delTrf_wind_30yr,delEIS_wind_30yr,1);
    %
    %eis_30y(ti)=regval(1);
    %tr_eis_30y(ti)=tr_regval(1);
    wind_eis_30y(ti)=wind_regval(1);
    %
    st=st+1;
end

