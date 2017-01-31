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
temp_ts=v.tref_am3ts;
olr_ts=v.olr_toa_am3ts;
swdn_ts=v.swdn_toa_am3ts;
swup_ts=v.swup_toa_am3ts;

% compute the weighted global mean values of the 2m temperature
% careful with the size of v.tref_full... it may not be full!
tindex=size(temp_ts,1);
nyears=tindex/12;
%tref_gmn_ts=zeros(tindex,1);
%olr_gmn_ts=zeros(tindex,1);
%swdn_gmn_ts=zeros(tindex,1);
%swup_gmn_ts=zeros(tindex,1);
%swup_clr_gmn_ts=zeros(tindex,1);
olr_clr_gmn_ts=zeros(tindex,1);

tref_ts=zeros(nyears,1);
olr_ts=zeros(nyears,1);
swdn_ts=zeros(nyears,1);
swup_ts=zeros(nyears,1);
toa_R_ts=zeros(nyears,1);

alpha_global=zeros(tend,90,144);

nlatlat=90;
nlonlon=144;
stlon=1;
endlon=144;
%%instantaneous, running mean, or regression analysis?
%% begin by computing the yearly mean values...
clear monthsbyyears
monthsbyyears=reshape(v.tref_am3ts,[12 nyears nlatlat nlonlon]);
tref_yearlymean=squeeze(mean(monthsbyyears,1));
monthsbyyears=reshape(v.olr_toa_am3ts,[12 nyears nlatlat nlonlon]);
olr_yearlymean=squeeze(mean(monthsbyyears,1));
monthsbyyears=reshape(v.swdn_toa_am3ts,[12 nyears nlatlat nlonlon]);
swdn_yearlymean=squeeze(mean(monthsbyyears,1));
monthsbyyears=reshape(v.swup_toa_am3ts,[12 nyears nlatlat nlonlon]);
swup_yearlymean=squeeze(mean(monthsbyyears,1));
%

%% in Gregory and Andrews 2016, the time series are expressed as 
%% differences from the AMIP period 1979-2008 but I don't think
%% it should matter for the regression plots, only the axis of 
%% the scatter plot.  right?

%figure
for latlat=1:nlatlat;
	latlat
  for lonlon=stlon:endlon;
    for ti=1:nyears;
      tref_ts(ti)=tref_yearlymean(ti,latlat,lonlon);
      olr_ts(ti)=olr_yearlymean(ti,latlat,lonlon);
      swdn_ts(ti)=swdn_yearlymean(ti,latlat,lonlon);
      swup_ts(ti)=swup_yearlymean(ti,latlat,lonlon);
      toa_R_ts(ti)=swdn_ts(ti)-swup_ts(ti)-olr_ts(ti);
    end
%%% delR=incoming-outgoing=v.swdn_toa-v.olr_toa-v.swup_toa;
%toa_R=swdn_yearlymean-swup_yearlymean-olr_yearlymean;
%toa_R_ts=swdn_ts-swup_ts-olr_ts;
%
    mn_init_tref=mean(tref_ts(nyears-30:nyears));
    mn_init_R=mean(toa_R_ts(nyears-30:nyears));
    %
    delTs=tref_ts-mn_init_tref;
    delR=toa_R_ts-mn_init_R;
    %
    %window_yr=30;
    window_yr=30;
    st=1;
    tend=nyears-window_yr-1;
    alpha_30y=zeros(tend,1);
    for ti=1:tend;
       endt=st+window_yr;
       delTs30yr=delTs(st:endt);
       delR30yr=delR(st:endt);
       regval=polyfit(delTs30yr,delR30yr,1);
       alpha_30y(ti)=regval(1);
       st=st+1;
       alpha_global(ti,latlat,lonlon)=alpha_30y(ti);
    end
  %    alpha_global(nyears,latlat,lonlon)=alpha_30y(ti);
  end
    %%figure
    %plot(squeeze(alpha_global(:,latlat,lonlon)))
    %hold on
end
%hold off
%figure
%plot(alpha_30y,'k')
%hold on
%plot(alpha_cre_30y,'b')
%plot(alpha_clr_30y,'r')
%hold off
%title('cre and clr')
%whycorr=corrcoef(alpha_30y,alpha_cre_30y);

