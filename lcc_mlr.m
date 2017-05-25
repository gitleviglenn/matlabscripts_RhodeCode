%
%-------------------------------------------------------------------------------
% use multiple linear regression to estimate the dependence of changes in low cloud cover (lcc) on change of the estimated inversion strength (eis) and the change in sst.  
%
% primary_ts = alpha*first_ts + betta*second_ts + residual?  
%
% time series are obtained from 
% driver_ensembles, using readvars and eis_lts_ts.
%
% i think that we should be using the anomalous time series for the linear regresion.  
% the anomalous time series is computed here.
%
% do i need to first remove the seasonal cycle?  ming 
% says this should be the same as using the yearly mean values.  
%
% levi silvers                                            may 2017
%-------------------------------------------------------------------------------

% grab the tropics
% sst here could mean sst, tref, or low level temp
% i am a sloppy man.

sst_tr=second_ts;%(:,60:120,:);
eis_tr=first_ts;%(:,60:120,:);
lcc_tr=primary_ts;%(:,60:120,:);

% average over the tropics
sst_tr_mn_a=mean(sst_tr,3);
sst_tr_mn=mean(sst_tr_mn_a,2);
eis_tr_mn_a=mean(eis_tr,3);
eis_tr_mn=mean(eis_tr_mn_a,2);
lcc_tr_mn_a=mean(lcc_tr,3);
lcc_tr_mn=mean(lcc_tr_mn_a,2);

% average over time
sst_tmn=mean(sst_tr_mn,1);
eis_tmn=mean(eis_tr_mn,1);
lcc_tmn=mean(lcc_tr_mn,1);

% compute anomalies
eis_del=eis_tr_mn-eis_tmn;
sst_del=sst_tr_mn-sst_tmn;
lcc_del=lcc_tr_mn-lcc_tmn;

tindex=size(first_ts,1);
nyears=tindex/12;
clear monthsbyyears
monthsbyyears=reshape(eis_del,[12 nyears]);
first_del_ymn=mean(monthsbyyears,1);
monthsbyyears=reshape(sst_del,[12 nyears]);
second_del_ymn=mean(monthsbyyears,1);
monthsbyyears=reshape(lcc_del,[12 nyears]);
primary_del_ymn=mean(monthsbyyears,1);

%monthsbyyears=reshape(eis_tr_mn,[12 nyears]);
%eis_tr_ymn=mean(monthsbyyears,1);
%eis_tmn_b=mean(eis_tr_ymn,2);
%eis_del_ymn_b=eis_tr_ymn-eis_tmn_b;

% do i need to first remove the seasonal cycle?  ming 
% says this should be the same as using the yearly mean values.  
%
%var_array2=[eis_del sst_del];
%cc=mvregress(var_array2,lcc_del);

var_array=[first_del_ymn' second_del_ymn'];
cc=mvregress(var_array,primary_del_ymn')




