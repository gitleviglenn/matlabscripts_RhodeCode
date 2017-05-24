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

%am2
second_ts=temp_sfc_am2_mn(:,30:60,:);
first_ts=eis_ens_am2_mn(:,30:60,:);
primary_ts=lcloud_am2_mn(:,30:60,:);

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
plot(new_ts,'r')
title('lcc change for AM2')

incoming_ts=new_ts;
running_mean;
new_ts_am2_smooth=output_ts;

%am3
second_ts=temp_sfc_am3_mn(:,30:60,:);
first_ts=eis_ens_am3_mn(:,30:60,:);
primary_ts=lcloud_am3_mn(:,30:60,:);

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
plot(new_ts,'r')
title('lcc change for AM3')

incoming_ts=new_ts;
running_mean;
new_ts_am3_smooth=output_ts;


%am4
second_ts=temp_sfc_am4_mn(:,60:120,:);
first_ts=eis_ens_am4_mn(:,60:120,:);
primary_ts=lcloud_am4_mn(:,60:120,:);

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
plot(new_ts,'r')
zhou_am4=corrcoef(primary_del_ymn,zhou_ts)
new_am4=corrcoef(primary_del_ymn,new_ts)
title('lcc change for AM4')

incoming_ts=new_ts;
running_mean;
new_ts_am4_smooth=output_ts;

% multi-model figure
figure

timearr=1876:2001;
plot(timearr,lcc_am2_smooth,'b','LineWidth',2)
hold on
plot(timearr,new_ts_am2_smooth,'b')
plot(timearr,lcc_am3_smooth,'r','LineWidth',2)
plot(timearr,new_ts_am3_smooth,'r')
plot(timearr,lcc_am4_smooth,'k','LineWidth',2)
plot(timearr,new_ts_am4_smooth,'k')
title('LCC change and Approximate LCC change')

%-------------------------------------------------------------
% can we similarly decompose high cloud changes?  
%-------------------------------------------------------------

%am3
second_ts=temp_sfc_am3_mn(:,30:60,:);
first_ts=omega500_am3_mn(:,30:60,:);
primary_ts=hcloud_am3_mn(:,30:60,:);

clear var_array;
clear cc;
lcc_mlr

incoming_ts=primary_del_ymn;
running_mean;
hcc_am3_smooth=output_ts;

figure
plot(primary_del_ymn,'k')
hold on
zhou_ts=3.7.*first_del_ymn-0.9.*second_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*first_del_ymn+cc(2).*second_del_ymn;
plot(new_ts,'r')
%zhou_am3=corrcoef(primary_del_ymn,zhou_ts)
%new_am3=corrcoef(primary_del_ymn,new_ts)
title('hcc change for AM3')

incoming_ts=new_ts;
running_mean;
new_ts_am3_smooth=output_ts;

figure
plot(hcc_am3_smooth)
hold on
plot(new_ts_am3_smooth)
