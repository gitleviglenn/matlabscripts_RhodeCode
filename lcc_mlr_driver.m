%------------------------------------------------------------------------
%
% calls lcc_mlr.m to use multiple linear regression in the decomposition
% of the influence of SST, and EIS on LCC for AM2, AM3, and AM4
%
% levi silvers                                        may 2017
%------------------------------------------------------------------------

incoming_temp_ts=temp_sfc_am2_mn(:,30:60,:);
incoming_eis_ts=eis_ens_am2_mn(:,30:60,:);
incoming_lcc_ts=lcloud_am2_mn(:,30:60,:);

ensnum=1;

%incoming_temp_ts=temp_sfc_array(:,30:60,:,ensnum);
%incoming_eis_ts=eis_array(:,30:60,:,ensnum);
%incoming_lcc_ts=lcloud_array(:,30:60,:,ensnum);

clear var_array;
clear cc;
lcc_mlr

figure
plot(lcc_del_ymn,'k')
hold on
zhou_ts=3.7.*eis_del_ymn-0.9.*sst_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*eis_del_ymn+cc(2).*sst_del_ymn;
plot(new_ts,'r')
%zhou_am2=corrcoef(lcc_del_ymn,zhou_ts)
%new_am2=corrcoef(lcc_del_ymn,new_ts)
title('lcc change for AM2')

incoming_temp_ts=temp_sfc_am3_mn(:,30:60,:);
incoming_eis_ts=eis_ens_am3_mn(:,30:60,:);
incoming_lcc_ts=lcloud_am3_mn(:,30:60,:);
%incoming_temp_ts=temp_sfc_array_am3(:,30:60,:,ensnum);
%incoming_eis_ts=eis_array_am3(:,30:60,:,ensnum);
%incoming_lcc_ts=lcloud_array_am3(:,30:60,:,ensnum);

clear var_array;
clear cc;
lcc_mlr

figure
plot(lcc_del_ymn,'k')
hold on
zhou_ts=3.7.*eis_del_ymn-0.9.*sst_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*eis_del_ymn+cc(2).*sst_del_ymn;
plot(new_ts,'r')
%zhou_am3=corrcoef(lcc_del_ymn,zhou_ts)
%new_am3=corrcoef(lcc_del_ymn,new_ts)
title('lcc change for AM3')

incoming_temp_ts=temp_sfc_array_am4(:,60:120,:,ensnum);
incoming_eis_ts=eis_array_am4(:,60:120,:,ensnum);
incoming_lcc_ts=lcloud_array_am4(:,60:120,:,ensnum);

clear var_array;
clear cc;
lcc_mlr


figure
plot(lcc_del_ymn,'k')
hold on
zhou_ts=3.7.*eis_del_ymn-0.9.*sst_del_ymn;
plot(zhou_ts,'g')
new_ts=cc(1).*eis_del_ymn+cc(2).*sst_del_ymn;
plot(new_ts,'r')
zhou_am4=corrcoef(lcc_del_ymn,zhou_ts)
new_am4=corrcoef(lcc_del_ymn,new_ts)
title('lcc change for AM4')




