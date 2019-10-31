% plot the time evolution of the domain mean precipitation field.  
%
% a running mean is applied multiple times to the data to smooth it a bit.
%
% levi silvers                                   april 2018

colyel=[0.9290,0.6940,0.1250];  % used for 25km runs
colblu=[0.3010,0.7450,0.9330];  % 2 km runs
colgrn=[0.4660,0.6740,0.1880];  % 1 km runs

path_new='/Users/silvers/data/WalkerCell/testing_20181203';

%%path_2km_1=strcat(path,'am4p0_50x2000_4K/','19790101');
%path_2km_1=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790101');
%path_2km_2=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790201');
%path_2km_3=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790301');
%path_2km_4=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790401');
%path_2km_5=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790501');
%path_2km_6=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790601');
%source_2km_1=strcat(path_2km_1,'.atmos_daily.nc');
%source_2km_2=strcat(path_2km_2,'.atmos_daily.nc');
%source_2km_3=strcat(path_2km_3,'.atmos_daily.nc');
%source_2km_4=strcat(path_2km_4,'.atmos_daily.nc');
%source_2km_5=strcat(path_2km_5,'.atmos_daily.nc');
%source_2km_6=strcat(path_2km_6,'.atmos_daily.nc');
%
%precip_2km=ncread(source_2km_1,'precip');
%precip_2km_b=ncread(source_2km_2,'precip');
%precip_2km_c=ncread(source_2km_3,'precip');
%precip_2km_d=ncread(source_2km_4,'precip');
%precip_2km_e=ncread(source_2km_5,'precip');
%precip_2km_f=ncread(source_2km_6,'precip');
%
%precip_2km_a_znm=mean(precip_2km,2);
%precip_2km_b_znm=mean(precip_2km_b,2);
%precip_2km_c_znm=mean(precip_2km_c,2);
%precip_2km_d_znm=mean(precip_2km_d,2);
%precip_2km_e_znm=mean(precip_2km_e,2);
%precip_2km_f_znm=mean(precip_2km_f,2);
%
%p_2km_a_znm=scale.*(squeeze(precip_2km_a_znm));
%p_2km_b_znm=scale.*(squeeze(precip_2km_b_znm));
%p_2km_c_znm=scale.*(squeeze(precip_2km_c_znm));
%p_2km_d_znm=scale.*(squeeze(precip_2km_d_znm));
%p_2km_e_znm=scale.*(squeeze(precip_2km_e_znm));
%p_2km_f_znm=scale.*(squeeze(precip_2km_f_znm));
%
%precip_mn_dly_2km_m1=squeeze(mean(p_2km_a_znm,1));
%precip_mn_dly_2km_m2=squeeze(mean(p_2km_b_znm,1));
%precip_mn_dly_2km_m3=squeeze(mean(p_2km_c_znm,1));
%precip_mn_dly_2km_m4=squeeze(mean(p_2km_d_znm,1));
%precip_mn_dly_2km_m5=squeeze(mean(p_2km_e_znm,1));
%precip_mn_dly_2km_m6=squeeze(mean(p_2km_f_znm,1));
%
%boohiss=cat(2,precip_mn_dly_2km_m1,precip_mn_dly_2km_m2,precip_mn_dly_2km_m3,...
%            precip_mn_dly_2km_m4,precip_mn_dly_2km_m5,precip_mn_dly_2km_m6);
%tendindex=180;
%incoming_ts=boohiss;
%running_mean;
%boohiss_sm=output_ts;
%
%tendindex=172;
%incoming_ts=boohiss_sm;
%running_mean;
%precip_2km_smts_b=output_ts;
%
%tendindex=164;
%incoming_ts=precip_2km_smts_b;
%running_mean;
%precip_2km_smts=output_ts;

% read in newer data from the 1km and 2km simululations
%path_new='/Users/silvers/data/WalkerCell/testing_20181203'
path_2km_ctl=strcat(path_new,'/c50x2000L33_am4p0_2km_wlkr_4K/','1979.6mn.atmos_daily_selvars.nc');
prec_2km_ctl_full=ncread(path_2km_ctl,'precip');
prec_2km_ctl_a=squeeze(mean(prec_2km_ctl_full,1));
prec_2km_ctl=squeeze(mean(prec_2km_ctl_a,1));

path_new='/Users/silvers/data/WalkerCell/testing_20181203'
path_2km_lwoff=strcat(path_new,'/c50x2000L33_am4p0_2km_wlkr_4K_lwoff/','1979.6mn.atmos_daily_selvars.nc');
prec_2km_lwoff_full=ncread(path_2km_lwoff,'precip');
prec_2km_lwoff_a=squeeze(mean(prec_2km_lwoff_full,1));
prec_2km_lwoff=squeeze(mean(prec_2km_lwoff_a,1));

path_new='/Users/silvers/data/WalkerCell/testing_20181203'
path_1km_ctl=strcat(path_new,'/c10x4000L33_am4p0_1km_wlkr_4K/','1979.6mn.atmos_daily_selvars.nc');
prec_1km_ctl_full=ncread(path_1km_ctl,'precip');
prec_1km_ctl_a=squeeze(mean(prec_1km_ctl_full,1));
prec_1km_ctl=squeeze(mean(prec_1km_ctl_a,1));

path_new='/Users/silvers/data/WalkerCell/testing_20181203'
path_1km_lwoff=strcat(path_new,'/c10x4000L33_am4p0_1km_wlkr_4K_lwoff/','1979.6mn.atmos_daily_selvars.nc');
prec_1km_lwoff_full=ncread(path_1km_lwoff,'precip');
prec_1km_lwoff_a=squeeze(mean(prec_1km_lwoff_full,1));
prec_1km_lwoff=squeeze(mean(prec_1km_lwoff_a,1));

prec_2km_ctl_sm   =apply_2_runmns(prec_2km_ctl);
prec_2km_lwoff_sm =apply_2_runmns(prec_2km_lwoff);
prec_1km_ctl_sm   =apply_2_runmns(prec_1km_ctl);
prec_1km_lwoff_sm =apply_2_runmns(prec_1km_lwoff);

figure
plot(scale*prec_2km_ctl_sm,'k')
hold on
plot(scale*prec_2km_lwoff_sm,'-.k')
plot(scale*prec_1km_ctl_sm,'r')
plot(scale*prec_1km_lwoff_sm,'-.r')

%precip_mean_daily_25km=squeeze(mean(p_25km_znm,1));
precip_mean_dy_25km=squeeze(mean(precip_25km_daily,1));
precip_mean_daily_25km=squeeze(mean(precip_mean_dy_25km,1));

% define paths for gcm like

% 25km large domain
source_gcm_l_dly           =strcat(path_new,'/c8x640L33_am4p0_25km_wlkr_ent0p9/1979th1983_daily.nc');
source_gcm_l_mly           =strcat(path_new,'/c8x640L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_gcm_l_dly_lwoff     =strcat(path_new,'/c8x640L33_am4p0_25km_wlkr_ent0p9_lwoff/1979th1983_daily.nc');
source_gcm_l_mly_lwoff     =strcat(path_new,'/c8x640L33_am4p0_25km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

% 25km small domain
source_gcm_dly             =strcat(path_new,'/c8x160L33_am4p0_25km_wlkr_ent0p9/1979th1983_daily.nc');
source_gcm_mly             =strcat(path_new,'/c8x160L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_gcm_mly_lwoff       =strcat(path_new,'/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

% 100km large domain
source_100km_l_dly         =strcat(path_new,'/c8x160L33_am4p0_100km_wlkr_ent0p9/1979th1983_daily.nc');
source_100km_l_mly         =strcat(path_new,'/c8x160L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_100km_l_dly_lwoff   =strcat(path_new,'/c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff/1979th1983_daily.nc');
source_100km_l_mly_lwoff   =strcat(path_new,'/c8x160L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

% 100km small domain
source_100km_s_dly         =strcat(path_new,'/c8x40L33_am4p0_100km_wlkr_ent0p9/1979th1983_daily.nc');
source_100km_s_dly_lwoff   =strcat(path_new,'/c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff/1979th1983_daily.nc');
source_100km_s_mly         =strcat(path_new,'/c8x40L33_am4p0_100km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc');
source_100km_s_mly_lwoff   =strcat(path_new,'/c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff/1980th1983.atmos_month_tmn.nc');

source_25km_dly       =source_gcm_l_dly;
source_25km_dly_lwoff =source_gcm_l_dly_lwoff;
source_25km_mly       =source_gcm_mly;
source_25km_mly_lwoff =source_gcm_mly_lwoff;

source_100km_dly       =source_gcm_l_dly;
source_100km_dly_lwoff =source_gcm_l_dly_lwoff;
source_100km_mly       =source_gcm_l_mly;
source_100km_mly_lwoff =source_gcm_l_mly_lwoff;

do_lw=2;
if (do_lw > 1)
  tit_25='lwcre on for 25km '
  tit_100='lwcre on for 100km '
  [cv_25km,ls_25km,f_ls_25km]=precip_largesc_vs_conv(source_gcm_mly,1,4);
  [cv_25km_l,ls_25km_l,f_ls_25km_l]=precip_largesc_vs_conv(source_gcm_l_mly,1,4);
  [cv_100km,ls_100km,f_ls_100km]=precip_largesc_vs_conv(source_100km_s_mly,1,4);
  [cv_100km_l,ls_100km_l,f_ls_100km_l]=precip_largesc_vs_conv(source_100km_l_mly,1,4);
else % do lwcre off
  tit_25='lwcre off for 25km '
  tit_100='lwcre off for 100km '
  [cv_25km,ls_25km,f_ls_25km]=precip_largesc_vs_conv(source_gcm_mly_lwoff,1,4);
  [cv_25km_l,ls_25km_l,f_ls_25km_l]=precip_largesc_vs_conv(source_gcm_l_mly_lwoff,1,4);
  [cv_100km,ls_100km,f_ls_100km]=precip_largesc_vs_conv(source_100km_s_mly_lwoff,1,4);
  [cv_100km_l,ls_100km_l,f_ls_100km_l]=precip_largesc_vs_conv(source_100km_l_mly_lwoff,1,4);
end 

%----------------
figure
thickness=2;

subplot(2,2,1)
plot(cv_25km_l,'k','LineWidth',thickness);
xlim([0 640])
ylim([0 25])
hold on
plot(ls_25km_l,'b','LineWidth',thickness);
  [cv_25km_l_lwo,ls_25km_l_lwo,f_ls_25km_l_lwoff]=precip_largesc_vs_conv(source_gcm_l_mly_lwoff,1,4);
plot(ls_25km_l_lwo,'b','LineWidth',1);
plot(cv_25km_l_lwo,'k','LineWidth',1);
title('large domain: 25km')

subplot(2,2,2)
plot(cv_25km,'k','LineWidth',thickness);
xlim([0 160])
ylim([0 25])
hold on
plot(ls_25km,'b','LineWidth',thickness);
  [cv_25km_lwo,ls_25km_lwo,f_ls_25km_lwo]=precip_largesc_vs_conv(source_gcm_mly_lwoff,1,4);
plot(ls_25km_lwo,'b','LineWidth',1);
plot(cv_25km_lwo,'k','LineWidth',1);
title('small domain: 25km')
%title('conv (black) and ls (blue)')

subplot(2,2,3)
plot(cv_100km_l,'k','LineWidth',thickness);
xlim([0 160])
hold on
plot(ls_100km_l,'b','LineWidth',thickness);
  [cv_100km_l_lwo,ls_100km_l_lwo,f_ls_100km_l_lwoff]=precip_largesc_vs_conv(source_100km_l_mly_lwoff,1,4);
plot(ls_100km_l_lwo,'b','LineWidth',1);
plot(cv_100km_l_lwo,'k','LineWidth',1);
%title('conv (black) and ls (blue)')
title('large domain: 100km')

subplot(2,2,4)
plot(cv_100km,'k','LineWidth',thickness);
xlim([0 40])
ylim([0 25])
hold on
plot(ls_100km,'b','LineWidth',thickness);
  [cv_100km_lwo,ls_100km_lwo,f_ls_100km_lwoff]=precip_largesc_vs_conv(source_100km_s_mly_lwoff,1,4);
plot(ls_100km_lwo,'b','LineWidth',1);
plot(cv_100km_lwo,'k','LineWidth',1);
title('small domain: 100km')
%title('conv (black) and ls (blue)')
suptitle('Large-Scale vs Convective Precipitation')
%----------------

figure
subplot(2,2,1)
plot(f_ls_25km)
xlim([0 160])
ylim([0.1 0.9])
title('small: fraction of large scale precip')
subplot(2,2,2)
plot(cv_25km,'k');
xlim([0 160])
hold on
plot(ls_25km,'b');
title('conv (black) and ls (blue)')
subplot(2,2,3)
plot(f_ls_25km_l)
xlim([0 640])
ylim([0.1 0.9])
title('large: fraction of large scale precip')
subplot(2,2,4)
plot(cv_25km_l,'k');
xlim([0 640])
hold on
plot(ls_25km_l,'b');
title('conv (black) and ls (blue)')
suptitle(tit_25)

figure
subplot(2,2,1)
plot(f_ls_100km)
xlim([0 40])
ylim([0.1 0.9])
title('small: fraction of large scale precip')
subplot(2,2,2)
plot(cv_100km,'k');
xlim([0 40])
hold on
plot(ls_100km,'b');
title('conv (black) and ls (blue)')
subplot(2,2,3)
plot(f_ls_100km_l)
xlim([0 160])
ylim([0.1 0.9])
title('large: fraction of large scale precip')
subplot(2,2,4)
plot(cv_100km_l,'k');
xlim([0 160])
hold on
plot(ls_100km_l,'b');
title('conv (black) and ls (blue)')
suptitle(tit_100)

%stop

% compute the fraction of precip that is large-scale and convective
%% why in the world does this crappy loop not work?
%daily=0;
%grid='gcm_';
%p_cv=strcat('p_cv_','grid','ztmn');
%p_ls=strcat('p_ls_','grid','ztmn');
%f_ls=strcat('f_ls_','grid');
%if daily
%  freq='dly';
%  t1=365;
%  t2=1826;
%  source=strcat('source_',grid,freq);
%  [p_cv,p_ls,f_ls]=precip_largesc_vs_conv(source,t1,t2);
%else 
%  freq='mly';
%  t1=1
%  t2=4
%  tsource=strcat('source_',grid,freq);
%  source=tsource;
%  [p_cv,p_ls,f_ls]=precip_largesc_vs_conv(source,t1,t2);
%end



%[p_cv_100km_dly_l_ztmn,p_ls_100km_dly_l_ztmn,f_100_l_ls_dly]=precip_largesc_vs_conv(source_100_gcm_daily_l,1,20);
%[p_cv_100km_dly_l_lwoff_ztmn,p_ls_100km_dly_l_lwoff_ztmn,f_100_l_lwoff_ls_dly]=precip_largesc_vs_conv(source_100km_l_month_lwoff,365,1826);

%[p_cv_100km_dly_s_ztmn,p_ls_100km_dly_s_ztmn,f_100_s_ls_dly]=precip_largesc_vs_conv(source_100_gcm_daily_s,365,1826);

%[p_cv_100km_mly_l_ztmn,p_ls_100km_mly_l_ztmn,f_100_l_ls_mly]=precip_largesc_vs_conv(source_100km_month,1,4);

%precip_mean_daily_25km_sm=apply_2_runmns(precip_mean_daily_25km);

% smooth precip with a running mean
tendindex=365;
incoming_ts=precip_mean_daily_25km;
running_mean;

figure
subplot(1,3,1)
plot(output_ts)
title('first application of running mean')
hold on
%plot(boohiss_sm);

incoming_ts=output_ts;
tendindex=357;
running_mean;
precip_dmn_smooth=output_ts;

subplot(1,3,2)
plot(precip_dmn_smooth)
title('second application of running mean')
hold on
%plot(precip_2km_smts_b)


incoming_ts=precip_dmn_smooth;
tendindex=349;
running_mean;
precip_dmn_smooth_3=output_ts;

subplot(1,3,3)
plot(precip_dmn_smooth_3)
title('third application of running mean')
hold on
%plot(precip_2km_smts)


% compute and plot the fraction of precip that is large-scale, as well as
% the large-scale and convective precipitation


tit_st='What is your title string?';

%figure
%subplot(1,2,1)
%plot(f_ls_mly)
%xlim([0 160])
%ylim([0.1 0.9])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_25km_mly_ztmn,'k');
%xlim([0 160])
%hold on
%plot(p_ls_25km_mly_ztmn,'b');
%title('conv (black) and ls (blue)')
%%tit_pr=strcat('Precip LS: ',tit_st);
%suptitle('lwcre on monthly for 25km small dom')
%
%figure
%subplot(1,2,1)
%plot(f_l_ls_dly)
%xlim([0 640])
%ylim([0.1 0.9])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_25km_dly_l_ztmn,'k');
%xlim([0 640])
%hold on
%plot(p_ls_25km_dly_l_ztmn,'b');
%title('conv (black) and ls (blue)')
%%tit_pr=strcat('Precip LS: ',tit_st);
%suptitle('lwcre on monthly for 25km large dom')
%
%figure
%subplot(1,2,1)
%plot(f_ls_dly)
%xlim([0 160])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_25km_dly_ztmn,'k');
%xlim([0 160])
%hold on
%plot(p_ls_25km_dly_ztmn,'b');
%title('conv (black) and ls (blue)')
%%tit_pr=strcat('Precip LS: ',tit_st);
%suptitle('lwcre on daily for 25km')
%
%
%figure
%subplot(1,2,1)
%plot(f_ls_mly_lwoff)
%xlim([0 160])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_25km_mly_lwoff_ztmn,'k');
%hold on
%plot(p_ls_25km_mly_lwoff_ztmn,'b');
%xlim([0 160])
%title('conv (black) and ls (blue)')
%tit_pr=strcat('Precip LS: ',tit_st);
%suptitle('lwoff monthly for 25km')
%
%figure
%subplot(1,2,1)
%plot(f_100_l_ls_mly)
%xlim([0 160])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_100km_mly_l_ztmn,'k');
%hold on
%plot(p_ls_100km_mly_l_ztmn,'b');
%xlim([0 160])
%title('conv (black) and ls (blue)')
%suptitle('100km monthly large domain')
%
%figure
%subplot(1,2,1)
%plot(f_100_l_lwoff_ls_dly)
%xlim([0 160])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_100km_dly_l_lwoff_ztmn,'k');
%hold on
%plot(p_ls_100km_dly_l_lwoff_ztmn,'b');
%xlim([0 160])
%title('conv (black) and ls (blue)')
%suptitle('100km monthly large domain: lwoff')
%
%
%figure
%subplot(1,2,1)
%plot(f_100_s_ls_dly)
%xlim([0 40])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_100km_dly_s_ztmn,'k');
%xlim([0 40])
%hold on
%plot(p_ls_100km_dly_s_ztmn,'b');
%title('conv (black) and ls (blue)')
%suptitle('100km daily small domain')
%
%figure
%subplot(1,2,1)
%plot(f_100_l_ls_dly)
%xlim([0 160])
%title('fraction of large scale precip')
%subplot(1,2,2)
%plot(p_cv_100km_dly_l_ztmn,'k');
%xlim([0 160])
%hold on
%plot(p_ls_100km_dly_l_ztmn,'b');
%title('conv (black) and ls (blue)')
%suptitle('100km daily large domain')



% code to plot 5 years of daily mean precip

path_exp_noconv_lwoff='/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff';
path_exp_ctl='/c8x160L33_am4p0_25km_wlkr_ent0p9';
path_exp_noconv='/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv';
path_exp_lwoff='/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff';

path_fname='/1979th1983_daily.nc';

path_ctl=strcat(path_new,path_exp_ctl,path_fname);
path_lwoff=strcat(path_new,path_exp_lwoff,path_fname);
path_noconv=strcat(path_new,path_exp_noconv,path_fname);
path_noconv_lwoff=strcat(path_new,path_exp_noconv_lwoff,path_fname);

precip_25km_ctl_raw          =ncread(path_ctl,'precip');
precip_25km_lwoff_raw        =ncread(path_lwoff,'precip');
precip_25km_noconv_lwoff_raw =ncread(path_noconv_lwoff,'precip');
precip_25km_noconv_raw       =ncread(path_noconv,'precip');

%source_100km_sm_lwoff_daily  =strcat(path_100km_small_dly_lwoff,'/1979th1983_daily.nc');
%source_100km_sm_daily  =strcat(path_100km_small_dly,'/1979th1983_daily.nc');

precip_100km_sm_raw          =ncread(source_100km_sm_daily,'precip');
precip_100km_sm_lwoff_raw    =ncread(source_100km_sm_lwoff_daily,'precip');

precip_100km_sm_ztmn         =read_1var_ztmn(source_100km_sm_daily,'precip');
precip_100km_sm_lwoff_ztmn   =read_1var_ztmn(source_100km_sm_lwoff_daily,'precip');

%% compute the domain mean shear...
%u_ctl_ztmn             = read_1var_ztmn(path_ctl,'ucomp');
%u_ctl_dmn              = squeeze(mean(u_ctl_ztmn,1));
%u_lwoff_ztmn           = read_1var_ztmn(path_lwoff,'ucomp');
%u_lwoff_dmn            = squeeze(mean(u_lwoff_ztmn,1));
%u_noconv_lwoff_ztmn    = read_1var_ztmn(path_noconv_lwoff,'ucomp');
%u_noconv_lwoff_dmn     = squeeze(mean(u_noconv_lwoff_ztmn,1));
%u_noconv_ztmn          = read_1var_ztmn(path_noconv,'ucomp');
%u_noconv_dmn           = squeeze(mean(u_noconv_ztmn,1));

% ctl
precip_25km_ctl_znm=mean(precip_25km_ctl_raw,2);
p_25km_ctl_znm=scale.*(squeeze(precip_25km_ctl_znm));
precip_daily_ctl=squeeze(mean(p_25km_ctl_znm,1));

precip_daily_100km=scale.*(squeeze(mean(precip_100km_sm_ztmn,1)));

% lwoff 
precip_znm=mean(precip_25km_lwoff_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_lwoff=squeeze(mean(p_znm,1));

precip_daily_100km_lwoff=scale.*(squeeze(mean(precip_100km_sm_lwoff_ztmn,1)));

% noconv_lwoff 
precip_znm=mean(precip_25km_noconv_lwoff_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_noconv_lwoff=squeeze(mean(p_znm,1));

% noconv
precip_znm=mean(precip_25km_noconv_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_noconv=squeeze(mean(p_znm,1));

tendindex=1826;
incoming_ts=precip_daily_ctl;
running_mean;
pre_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_25km_ctl=output_ts;

tendindex=1826;
incoming_ts=precip_daily_lwoff;
running_mean;
pre_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_25km_lwoff=output_ts;

tendindex=1826;
incoming_ts=precip_daily_noconv;
running_mean;
pre_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_25km_noconv=output_ts;

tendindex=1826;
incoming_ts=precip_daily_noconv_lwoff;
running_mean;
pre_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_25km_noconv_lwoff=output_ts;

tendindex=1826;
incoming_ts=precip_daily_ctl;
running_mean;
precip_ctl_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_ctl_rm2=output_ts;

tendindex=1826;
incoming_ts=precip_daily_100km;
running_mean;
pre_100_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_100km_ctl_rm2=output_ts;

tendindex=1826;
incoming_ts=precip_daily_100km_lwoff;
running_mean;
pre_100_rm1=output_ts;
tendindex=1818;
incoming_ts=output_ts;
running_mean
precip_100km_lwoff_rm2=output_ts;

figure
plot(scale*prec_2km_ctl_sm,'Color',colblu,'LineWidth',2)
hold on
plot(scale*prec_2km_lwoff_sm,'Color',colblu,'LineWidth',1)
plot(scale*prec_1km_ctl_sm,'Color',colgrn,'LineWidth',2)
plot(scale*prec_1km_lwoff_sm,'Color',colgrn,'LineWidth',1)
%plot(precip_ctl_rm2(1:344),'Color',colyel,'LineWidth',2)
plot(precip_ctl_rm2(1:1200),'Color',colyel,'LineWidth',2)
%plot(precip_25km_noconv(1:164),'--','Color',colyel,'LineWidth',2)
plot(precip_25km_lwoff(1:344),'Color',colyel,'LineWidth',1)
%plot(precip_100km_ctl_rm2(1:344),'r','LineWidth',2);
plot(precip_100km_ctl_rm2(1:1200),'r','LineWidth',2);
plot(precip_100km_lwoff_rm2,'r','LineWidth',1);
%ytitle('mm/day')
%xtitle('days')
xlabel('days')
xlim([0 1200])
ylabel('mm/day')
title('Domain Mean Precipitation')
mn_100km_ctl=mean(precip_100km_ctl_rm2)
mn_100km_ctl_6m=mean(precip_100km_ctl_rm2(1:164))
mn_100km_lwoff=mean(precip_100km_lwoff_rm2)
mn_100km_lwoff_6m=mean(precip_100km_lwoff_rm2(1:164))
mn_25km_ctl=mean(precip_ctl_rm2)
mn_25km_ctl_6m=mean(precip_ctl_rm2(1:164))
mn_25km_noconv=mean(precip_25km_noconv)
mn_25km_noconv_6m=mean(precip_25km_noconv(1:164))
mn_25km_lwoff=mean(precip_25km_lwoff)
mn_25km_lwoff_6m=mean(precip_25km_lwoff(1:164))
mn_2km_ctl=scale*mean(prec_2km_ctl_sm)
mn_2km_lwoff_sm=scale*mean(prec_2km_lwoff_sm)
mn_1km_ctl_sm=scale*mean(prec_1km_ctl_sm)
mn_1km_lwoff_sm=scale*mean(prec_1km_lwoff_sm)

figure
plot(precip_ctl_rm2,'Color',colyel,'LineWidth',2);
hold on
plot(precip_25km_lwoff,'Color',colyel,'LineWidth',1)
plot(precip_100km_ctl_rm2,'r','LineWidth',2);
plot(precip_100km_lwoff_rm2,'r','LineWidth',1);
%plot(precip_25km_noconv,'--','Color',colyel,'LineWidth',1)
%plot(precip_25km_noconv_lwoff,'-.','Color',colyel,'LineWidth',1)
%plot(precip_25km_lwoff,'b','LineWidth',1)
set(gca,'YLim',[2.5,5])
set(gca,'XLim',[0,1820])
pctl=mean(precip_ctl_rm2(200:1810))
plwoff=mean(precip_25km_lwoff(200:1810))
pnoconv=mean(precip_25km_noconv(200:1810))
pnoconvlwoff=mean(precip_25km_noconv_lwoff(200:1810))
title('5 years of domain mean precip 25km')

figure
plot(precip_ctl_rm2,'Color',colyel,'LineWidth',2);
hold on
plot(precip_25km_lwoff,'Color',colyel,'LineWidth',1)
plot(precip_25km_noconv,'--','Color',colyel,'LineWidth',1)
plot(precip_25km_noconv_lwoff,'-.','Color',colyel,'LineWidth',1)
%plot(precip_25km_lwoff,'b','LineWidth',1)
set(gca,'YLim',[2.5,5])
set(gca,'XLim',[0,180])
mean(precip_ctl_rm2(200:1810))
mean(precip_25km_lwoff(200:1810))
mean(precip_25km_noconv(200:1810))
mean(precip_25km_noconv_lwoff(200:1810))
title('first 180 days of domain mean precip 25km')

tendindex=1810;
incoming_ts=precip_ctl_rm2;
running_mean
precip_ctl_rm3=output_ts;

tendindex=1810;
incoming_ts=precip_25km_lwoff;
running_mean
precip_25km_lwoff_rm3=output_ts;

%tendindex=1810;
%incoming_ts=precip_25km_noconv;
%running_mean
%precip_25km_lwoff_rm3=output_ts;



figure
plot(scale*prec_2km_ctl_sm,'Color',colblu,'LineWidth',2)
hold on
plot(scale*prec_2km_lwoff_sm,'Color',colblu,'LineWidth',1)
plot(scale*prec_1km_ctl_sm,'Color',colgrn,'LineWidth',2)
plot(scale*prec_1km_lwoff_sm,'Color',colgrn,'LineWidth',1)
plot(precip_ctl_rm2(1:164),'Color',colyel,'LineWidth',2)
plot(precip_25km_noconv(1:164),'--','Color',colyel,'LineWidth',2)
plot(precip_25km_lwoff(1:164),'Color',colyel,'LineWidth',1)
%ytitle('mm/day')
%xtitle('days')
xlabel('days')
xlim([0 160])
ylabel('mm/day')
title('Domain Mean Precipitation')
mn_25km_ctl=mean(precip_ctl_rm2)
mn_25km_ctl_6m=mean(precip_ctl_rm2(1:164))
mn_25km_noconv=mean(precip_25km_noconv)
mn_25km_noconv_6m=mean(precip_25km_noconv(1:164))
mn_25km_lwoff=mean(precip_25km_lwoff)
mn_25km_lwoff_6m=mean(precip_25km_lwoff(1:164))
mn_2km_ctl=scale*mean(prec_2km_ctl_sm)
mn_2km_lwoff_sm=scale*mean(prec_2km_lwoff_sm)
mn_1km_ctl_sm=scale*mean(prec_1km_ctl_sm)
mn_1km_lwoff_sm=scale*mean(prec_1km_lwoff_sm)










