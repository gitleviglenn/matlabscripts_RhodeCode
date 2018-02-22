%------------------------------------------------------------------------
%
% calls lcc_mlr.m to use multiple linear regression in the decomposition
% of the influence of SST, and EIS on LCC for AM2, AM3, and AM4
%
% what does this need to have run before it is called?  
% it does not work after ensmn_ncout.m
%
%% below is the beginning of work to run this script using a netcdf file
%% we need to open data files and read the appropriate vars
%pathn='/net2/Levi.Silvers/data/amip_long/pp_files/';
%
%filen='am3_ensmn_tref_early_crediff.nc';
%
%totn=strcat(pathn,filen)
%fin_am3_ensmn=netcdf(totn,'nowrite');
%
%sw_cre=fin_am3_ensmn{'toa_sw_cre_out'};
%lcloud=fin_am3_ensmn{'lcloud'};
%hcloud=fin_am3_ensmn{'hcloud'};
%omega=fin_am3_ensmn{'omega500'};
%estinvs=fin_am3_ensmn{'eis'};
%ll_temp=fin_am3_ensmn{'temp_sfc'};
%%lw_cre_out
%%lts_out

% levi silvers                                        may 2017
%------------------------------------------------------------------------

%
%%% am2

lats=30;
latn=60;

second_ts=eis_ens_am2_mn(:,lats:latn,:);
first_ts=omega500_am2_mn(:,lats:latn,:);
first_ts=864.*first_ts;
primary_ts=sw_cre_am2_mn(:,lats:latn,:);

nmonths=size(first_ts,1);
tendindex=nmonths/12;

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
prim_am2_smooth=output_ts;

new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;

% test approximation by computing the correlation
corrcoef(new_ts,primary_del_ymn)

incoming_ts=new_ts;
running_mean;
new_ts_am2_smooth=output_ts;

%% am3

second_ts=eis_ens_am3_mn(:,lats:latn,:);
first_ts=omega500_am3_mn(:,lats:latn,:);
first_ts=864.*first_ts;
primary_ts=sw_cre_am3_mn(:,lats:latn,:);

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
prim_am3_smooth=output_ts;

new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;

% test approximation by computing the correlation
corrcoef(new_ts,primary_del_ymn)

incoming_ts=new_ts;
running_mean;
new_ts_am3_smooth=output_ts;


% omega and estinvs should probably be reschaled so that the 
% time series which are being used in mlr have the same units
%second_ts=estinvs(:,30:60,:);
%first_ts=omega(:,30:60,:);
%primary_ts=sw_cre(:,30:60,:);

%% this appears to work very well
%second_ts=lcloud(:,lats:latn,:);
%first_ts=hcloud(:,lats:latn,:);
%primary_ts=sw_cre(:,lats:latn,:);


%% am4
lats=60;
latn=120;

second_ts=eis_ens_am4_mn(:,lats:latn,:);
first_ts=omega500_am4_mn(:,lats:latn,:);
first_ts=864.*first_ts;
primary_ts=sw_cre_am4_mn(:,lats:latn,:);
%second_ts=eis_ens_am4_mn(:,lats:latn,:);

%second_ts=temp_sfc_am4_mn(:,lats:latn,:);
%first_ts=eis_ens_am4_mn(:,lats:latn,:);
%primary_ts=lcloud_am4_mn(:,lats:latn,:);

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
prim_am4_smooth=output_ts;

new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;

% test approximation by computing the correlation
corrcoef(new_ts,primary_del_ymn)

incoming_ts=new_ts;
running_mean;
new_ts_am4_smooth=output_ts;

%figure
%plot(primary_del_ymn,'k')
%hold on
%%plot(zhou_ts,'g')
%plot(new_ts,'r')
%title('how well do they match?')


%%% am4
%
%figure
%plot(primary_del_ymn,'k')
%hold on
%zhou_ts=3.7.*first_del_ymn-0.9.*second_del_ymn;
%plot(zhou_ts,'g')
%new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;
%plot(new_ts,'r')
%zhou_am4=corrcoef(primary_del_ymn,zhou_ts)
%new_am4=corrcoef(primary_del_ymn,new_ts)
%title('lcc change for AM4')
%
%incoming_ts=new_ts;
%running_mean;
%new_ts_am4_smooth=output_ts;

%% multi-model figure
figure
%
timearr=1875:2001;
plot(timearr,prim_am2_smooth,'b','LineWidth',2)
hold on
plot(timearr,new_ts_am2_smooth,'b')
plot(timearr,prim_am3_smooth,'r','LineWidth',2)
plot(timearr,new_ts_am3_smooth,'r')
plot(timearr,prim_am4_smooth,'k','LineWidth',2)
plot(timearr,new_ts_am4_smooth,'k')
title('SWCRE and Approximate SWCRE')
%
