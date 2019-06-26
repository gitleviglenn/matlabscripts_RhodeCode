%------------------------------------------------------------------------
%
% calls lcc_mlr.m to use multiple linear regression in the decomposition
% of the influence of SST, and EIS on LCC for AM2, AM3, and AM4
%
% what does this need to have run before it is called?  
% it does not work after ensmn_ncout.m
%
% levi silvers                                        may 2017
%------------------------------------------------------------------------

%incoming_temp_ts=temp_sfc_am2_mn(:,30:60,:);
%incoming_eis_ts=eis_ens_am2_mn(:,30:60,:);
%incoming_lcc_ts=lcloud_am2_mn(:,30:60,:);

% 45 is equator
latso=30; % am2 and am3 extend from 0:90, 30:60 is from -30S to +30N
latno=60;
%latso=15; % 15 to 75 corresponds to 60S to 60N
%latno=75

% global extent
%latso=1;
%latno=90;


%am2
second_ts=temp_sfc_am2_mn(:,latso:latno,:);
first_ts=eis_ens_am2_mn(:,latso:latno,:);
primary_ts=lcloud_am2_mn(:,latso:latno,:);
%second_ts=temp_sfc_am2_mn(:,30:60,:);
%first_ts=eis_ens_am2_mn(:,30:60,:);
%primary_ts=lcloud_am2_mn(:,30:60,:);

ensnum=1;

%incoming_temp_ts=temp_sfc_array(:,30:60,:,ensnum);
%incoming_eis_ts=eis_array(:,30:60,:,ensnum);
%incoming_lcc_ts=lcloud_array(:,30:60,:,ensnum);

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
lcc_am2_smooth=output_ts;

figure
plot(primary_del_ymn,'k')
hold on
zhou_ts=3.7.*first_del_ymn-0.9.*second_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;
sst_scaled2=cc(2).*second_del_ymn;
zhou_am2=corrcoef(primary_del_ymn,zhou_ts);
new_am2=corrcoef(primary_del_ymn,new_ts);
plot(new_ts,'r')
title('lcc anomaly for AM2')

ccoefs=zeros(3,2);
llccoefs=zeros(3,2);
ccoefs(1,1)=zhou_am2(2);
ccoefs(1,2)=new_am2(2);
llccoefs(1,1)=cc(1);
llccoefs(1,2)=cc(2);

incoming_ts=new_ts;
running_mean;
new_ts_am2_smooth=output_ts;

%am3
second_ts=temp_sfc_am3_mn(:,latso:latno,:);
first_ts=eis_ens_am3_mn(:,latso:latno,:);
primary_ts=lcloud_am3_mn(:,latso:latno,:);
%second_ts=temp_sfc_am3_mn(:,30:60,:);
%first_ts=eis_ens_am3_mn(:,30:60,:);
%primary_ts=lcloud_am3_mn(:,30:60,:);

%incoming_temp_ts=temp_sfc_am3_mn(:,30:60,:);
%incoming_eis_ts=eis_ens_am3_mn(:,30:60,:);
%incoming_lcc_ts=lcloud_am3_mn(:,30:60,:);
%
%%incoming_temp_ts=temp_sfc_array_am3(:,30:60,:,ensnum);
%%incoming_eis_ts=eis_array_am3(:,30:60,:,ensnum);
%%incoming_lcc_ts=lcloud_array_am3(:,30:60,:,ensnum);

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
lcc_am3_smooth=output_ts;

figure
plot(primary_del_ymn,'k')
hold on
zhou_ts=3.7.*first_del_ymn-0.9.*second_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;
sst_scaled3=cc(2).*second_del_ymn;
plot(new_ts,'r')
zhou_am3=corrcoef(primary_del_ymn,zhou_ts);
new_am3=corrcoef(primary_del_ymn,new_ts);
title('lcc anomaly for AM3')

ccoefs(2,1)=zhou_am3(2);
ccoefs(2,2)=new_am3(2);
llccoefs(2,1)=cc(1);
llccoefs(2,2)=cc(2);

incoming_ts=new_ts;
running_mean;
new_ts_am3_smooth=output_ts;


%am4

latso_am4=2*latso;
latno_am4=2*latno;
%second_ts=temp_sfc_am4_mn(:,60:120,:);
%first_ts=eis_ens_am4_mn(:,60:120,:);
%primary_ts=lcloud_am4_mn(:,60:120,:);
second_ts=temp_sfc_am4_mn(:,latso_am4:latno_am4,:);
first_ts=eis_ens_am4_mn(:,latso_am4:latno_am4,:);
primary_ts=lcloud_am4_mn(:,latso_am4:latno_am4,:);

%second_ts=temp_sfc_array_am4(:,60:120,:,ensnum);
%first_ts=eis_array_am4(:,60:120,:,ensnum);
%primary_ts=lcloud_array_am4(:,60:120,:,ensnum);

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
lcc_am4_smooth=output_ts;

figure
plot(primary_del_ymn,'k')
hold on
zhou_ts=3.7.*first_del_ymn-0.9.*second_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;
sst_scaled4=cc(2).*second_del_ymn;
eis_scaled4=cc(1).*first_del_ymn;
plot(new_ts,'r')
zhou_am4=corrcoef(primary_del_ymn,zhou_ts);
new_am4=corrcoef(primary_del_ymn,new_ts);
title('lcc anomaly for AM4')

ccoefs(3,1)=zhou_am4(2);
ccoefs(3,2)=new_am4(2);
llccoefs(3,1)=cc(1);
llccoefs(3,2)=cc(2);

incoming_ts=new_ts;
running_mean;
new_ts_am4_smooth=output_ts;

incoming_ts=sst_scaled2;
running_mean;
new_sst2_scaled=output_ts;

incoming_ts=sst_scaled3;
running_mean;
new_sst3_scaled=output_ts;

incoming_ts=sst_scaled4;
running_mean;
new_sst4_scaled=output_ts;

incoming_ts=eis_scaled4;
running_mean;
new_eis_scaled=output_ts;

% multi-model figure
figure

timearr=1875:2000;
plot(timearr,lcc_am2_smooth,'b','LineWidth',2)
hold on
plot(timearr,new_ts_am2_smooth,'b')
plot(timearr,lcc_am3_smooth,'r','LineWidth',2)
plot(timearr,new_ts_am3_smooth,'r')
plot(timearr,lcc_am4_smooth,'k','LineWidth',2)
plot(timearr,new_ts_am4_smooth,'k')
plot(timearr,new_sst2_scaled,'--b')
plot(timearr,new_sst3_scaled,'--r')
plot(timearr,new_sst4_scaled,'--k')
plot(timearr,new_eis_scaled,'k')
title('LCC anomaly and Approximate LCC anomaly')

%%-------------------------------------------------------------
%% can we similarly decompose high cloud changes?  
%%-------------------------------------------------------------
%
%%am3
%second_ts=temp_sfc_am3_mn(:,30:60,:);
%first_ts=omega500_am3_mn(:,30:60,:);
%primary_ts=hcloud_am3_mn(:,30:60,:);
%
%clear var_array;
%clear cc;
%lcc_mlr
%
%incoming_ts=primary_del_ymn;
%running_mean;
%hcc_am3_smooth=output_ts;
%
%figure
%plot(primary_del_ymn,'k')
%hold on
%zhou_ts=3.7.*first_del_ymn-0.9.*second_del_ymn;
%plot(zhou_ts,'g')
%new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;
%plot(new_ts,'r')
%%zhou_am3=corrcoef(primary_del_ymn,zhou_ts)
%%new_am3=corrcoef(primary_del_ymn,new_ts)
%title('hcc change for AM3')
%
%incoming_ts=new_ts;
%running_mean;
%new_ts_am3_smooth=output_ts;
%
%figure
%plot(hcc_am3_smooth)
%hold on
%plot(new_ts_am3_smooth)
