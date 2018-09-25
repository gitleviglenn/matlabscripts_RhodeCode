% plot the time evolution of the domain mean precipitation field.  
%
% a running mean is applied multiple times to the data to smooth it a bit.
%
% levi silvers                                   april 2018

%path_2km_1=strcat(path,'am4p0_50x2000_4K/','19790101');
path_2km_1=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790101');
path_2km_2=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790201');
path_2km_3=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790301');
path_2km_4=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790401');
path_2km_5=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790501');
path_2km_6=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790601');
source_2km_1=strcat(path_2km_1,'.atmos_daily.nc');
source_2km_2=strcat(path_2km_2,'.atmos_daily.nc');
source_2km_3=strcat(path_2km_3,'.atmos_daily.nc');
source_2km_4=strcat(path_2km_4,'.atmos_daily.nc');
source_2km_5=strcat(path_2km_5,'.atmos_daily.nc');
source_2km_6=strcat(path_2km_6,'.atmos_daily.nc');

precip_2km=ncread(source_2km_1,'precip');
precip_2km_b=ncread(source_2km_2,'precip');
precip_2km_c=ncread(source_2km_3,'precip');
precip_2km_d=ncread(source_2km_4,'precip');
precip_2km_e=ncread(source_2km_5,'precip');
precip_2km_f=ncread(source_2km_6,'precip');

precip_2km_a_znm=mean(precip_2km,2);
precip_2km_b_znm=mean(precip_2km_b,2);
precip_2km_c_znm=mean(precip_2km_c,2);
precip_2km_d_znm=mean(precip_2km_d,2);
precip_2km_e_znm=mean(precip_2km_e,2);
precip_2km_f_znm=mean(precip_2km_f,2);

p_2km_a_znm=scale.*(squeeze(precip_2km_a_znm));
p_2km_b_znm=scale.*(squeeze(precip_2km_b_znm));
p_2km_c_znm=scale.*(squeeze(precip_2km_c_znm));
p_2km_d_znm=scale.*(squeeze(precip_2km_d_znm));
p_2km_e_znm=scale.*(squeeze(precip_2km_e_znm));
p_2km_f_znm=scale.*(squeeze(precip_2km_f_znm));

precip_mn_dly_2km_m1=squeeze(mean(p_2km_a_znm,1));
precip_mn_dly_2km_m2=squeeze(mean(p_2km_b_znm,1));
precip_mn_dly_2km_m3=squeeze(mean(p_2km_c_znm,1));
precip_mn_dly_2km_m4=squeeze(mean(p_2km_d_znm,1));
precip_mn_dly_2km_m5=squeeze(mean(p_2km_e_znm,1));
precip_mn_dly_2km_m6=squeeze(mean(p_2km_f_znm,1));

boohiss=cat(2,precip_mn_dly_2km_m1,precip_mn_dly_2km_m2,precip_mn_dly_2km_m3,...
            precip_mn_dly_2km_m4,precip_mn_dly_2km_m5,precip_mn_dly_2km_m6);
tendindex=180;
incoming_ts=boohiss;
running_mean;
boohiss_sm=output_ts;

tendindex=172;
incoming_ts=boohiss_sm;
running_mean;
precip_2km_smts_b=output_ts;

tendindex=164;
incoming_ts=precip_2km_smts_b;
running_mean;
precip_2km_smts=output_ts;


precip_mean_daily_25km=squeeze(mean(p_25km_znm,1));

% smooth precip with a running mean
tendindex=365;
incoming_ts=precip_mean_daily_25km;
running_mean;

figure
subplot(1,3,1)
plot(output_ts)
title('first application of running mean')
hold on
plot(boohiss_sm);

incoming_ts=output_ts;
tendindex=357;
running_mean;
precip_dmn_smooth=output_ts;

subplot(1,3,2)
plot(precip_dmn_smooth)
title('second application of running mean')
hold on
plot(precip_2km_smts_b)


incoming_ts=precip_dmn_smooth;
tendindex=349;
running_mean;
precip_dmn_smooth_3=output_ts;

subplot(1,3,3)
plot(precip_dmn_smooth_3)
title('third application of running mean')
hold on
plot(precip_2km_smts)


% compute and plot the fraction of precip that is large-scale, as well as
% the large-scale and convective precipitation

precip_25km_last10m=precip_25km(:,:,an_t1:an_t2);
precip_25km_tmn=squeeze(mean(precip_25km_last10m,3));
precip_25km_ztmn=squeeze(mean(precip_25km_tmn,2));
p_cv_25km_last10m=p_cv_25km(:,:,an_t1:an_t2);
p_cv_25km_tmn=squeeze(mean(p_cv_25km_last10m,3));
p_cv_25km_ztmn=squeeze(mean(p_cv_25km_tmn,2));
p_ls_25km_last10m=p_ls_25km(:,:,an_t1:an_t2);
p_ls_25km_tmn=squeeze(mean(p_ls_25km_last10m,3));
p_ls_25km_ztmn=squeeze(mean(p_ls_25km_tmn,2));

p_cv_25km_ztmn=scale1*p_cv_25km_ztmn;
p_ls_25km_ztmn=scale1*p_ls_25km_ztmn;

f_ls=p_ls_25km_ztmn./(p_ls_25km_ztmn+p_cv_25km_ztmn);
f_test=p_ls_25km_ztmn./(precip_25km_ztmn);

figure
subplot(1,2,1)
plot(f_ls)
title('fraction of precip which is LS')
subplot(1,2,2)
plot(p_cv_25km_ztmn,'k');
hold on
plot(p_ls_25km_ztmn,'b');
title('conv (black) and ls (blue)')
tit_pr=strcat('Precip LS: ',tit_st);
suptitle(tit_pr)