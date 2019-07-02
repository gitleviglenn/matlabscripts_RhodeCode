% plot the time evolution of the domain mean precipitation field.  
%
% a running mean is applied multiple times to the data to smooth it a bit.
%
% levi silvers                                   april 2018

colyel=[0.9290,0.6940,0.1250];  % used for 25km runs
colblu=[0.3010,0.7450,0.9330];  % 2 km runs
colgrn=[0.4660,0.6740,0.1880];  % 1 km runs

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

% read in newer data from the 1km and 2km simululations
path_new='/Users/silvers/data/WalkerCell/testing_20181203'
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

%p_cv_25km=ncread(source_gcm_daily,'prec_conv'); %kg(h2o)/m2/2
%p_ls_25km=ncread(source_gcm_daily,'prec_ls');

% for daily output.  monthly is with 'source_gcm_month'
p_cv_100km=ncread(source_100_gcm_daily_l,'prec_conv'); %kg(h2o)/m2/2
p_ls_100km=ncread(source_100_gcm_daily_l,'prec_ls');
p_cv_100km_s=ncread(source_100_gcm_daily_s,'prec_conv'); %kg(h2o)/m2/2
p_ls_100km_s=ncread(source_100_gcm_daily_s,'prec_ls');


% compute the fraction of precip that is large-scale and convective
%[p_cv_gcm,p_ls_gcm,frac_gcm]=precip_largesc_vs_conv(source_gcm_month,1,4);

[p_cv_25km_ztmn,p_ls_25km_ztmn,f_ls]=precip_largesc_vs_conv(source_gcm_month,1,4);
[p_cv_100km_ztmn,p_ls_100km_ztmn,f_100_ls]=precip_largesc_vs_conv(source_100km_month,1,4);
[p_cv_100km_l_ztmn,p_ls_100km_l_ztmn,f_100_l_ls]=precip_largesc_vs_conv(source_100_gcm_daily_l,365,1826);
[p_cv_100km_s_ztmn,p_ls_100km_s_ztmn,f_100_s_ls]=precip_largesc_vs_conv(source_100_gcm_daily_s,365,1826);



precip_mean_daily_25km_sm=apply_2_runmns(precip_mean_daily_25km);


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

% write a function which uses ls and cv precip time series, an_t1 and an_t2
% and outputs the variables: f_ls, p_cv_ztmn, p_ls_ztmn

% evaluate precip for 25km run 

%precip_25km_last10m=precip_25km(:,:,an_t1:an_t2);
%precip_25km_tmn=squeeze(mean(precip_25km_last10m,3));
%precip_25km_ztmn=squeeze(mean(precip_25km_tmn,2));
%
%p_cv_25km_last10m=p_cv_25km(:,:,an_t1:an_t2);
%p_cv_25km_tmn=squeeze(mean(p_cv_25km_last10m,3));
%p_cv_25km_ztmn=squeeze(mean(p_cv_25km_tmn,2));
%p_ls_25km_last10m=p_ls_25km(:,:,an_t1:an_t2);
%p_ls_25km_tmn=squeeze(mean(p_ls_25km_last10m,3));
%p_ls_25km_ztmn=squeeze(mean(p_ls_25km_tmn,2));
%
%p_cv_25km_ztmn=scale1*p_cv_25km_ztmn;
%p_ls_25km_ztmn=scale1*p_ls_25km_ztmn;

%% evaluate precip for 100km run on the large domain
%p_cv_100km_last10m=p_cv_100km(:,:,an_t1:an_t2);
%p_cv_100km_tmn=squeeze(mean(p_cv_100km_last10m,3));
%p_cv_100km_ztmn=squeeze(mean(p_cv_100km_tmn,2));
%p_ls_100km_last10m=p_ls_100km(:,:,an_t1:an_t2);
%p_ls_100km_tmn=squeeze(mean(p_ls_100km_last10m,3));
%p_ls_100km_ztmn=squeeze(mean(p_ls_100km_tmn,2));
%
%p_cv_100km_ztmn=scale1*p_cv_100km_ztmn;
%p_ls_100km_ztmn=scale1*p_ls_100km_ztmn;
%
%% evaluate precip for 100km run on the small domain
%p_cv_100km_s=p_cv_100km_s(:,:,an_t1:an_t2);
%p_cv_100km_s_tmn=squeeze(mean(p_cv_100km_s,3));
%p_cv_100km_s_ztmn=squeeze(mean(p_cv_100km_s_tmn,2));
%p_ls_100km_s=p_ls_100km_s(:,:,an_t1:an_t2);
%p_ls_100km_s_tmn=squeeze(mean(p_ls_100km_s,3));
%p_ls_100km_s_ztmn=squeeze(mean(p_ls_100km_s_tmn,2));
%
%p_cv_100km_s_ztmn=scale1*p_cv_100km_s_ztmn;
%p_ls_100km_s_ztmn=scale1*p_ls_100km_s_ztmn;


%f_ls=p_ls_25km_ztmn./(p_ls_25km_ztmn+p_cv_25km_ztmn);
%f_test=p_ls_25km_ztmn./(precip_25km_ztmn);

%f_100_large_ls=p_ls_100km_ztmn./(p_ls_100km_ztmn+p_cv_100km_ztmn);
%f_100_small_ls=p_ls_100km_s_ztmn./(p_ls_100km_s_ztmn+p_cv_100km_s_ztmn);

tit_st='What is your title string?';

figure
subplot(1,2,1)
plot(f_ls)
title('fraction of precip which is LS: 25km')
subplot(1,2,2)
plot(p_cv_25km_ztmn,'k');
hold on
plot(p_ls_25km_ztmn,'b');
title('conv (black) and ls (blue)')
tit_pr=strcat('Precip LS: ',tit_st);
suptitle(tit_pr)

figure
subplot(1,2,1)
plot(f_100_large_ls)
title('fraction of precip which is LS: 100km')
subplot(1,2,2)
plot(p_cv_100km_l_ztmn,'k');
hold on
plot(p_ls_100km_l_ztmn,'b');
title('conv (black) and ls (blue)')
tit_pr=strcat('Precip LS: ',tit_st);
suptitle(tit_pr)

figure
subplot(1,2,1)
plot(f_100_small_ls)
title('fraction of precip which is LS: 100km small')
subplot(1,2,2)
plot(p_cv_100km_s_ztmn,'k');
hold on
plot(p_ls_100km_s_ztmn,'b');
title('conv (black) and ls (blue)')
tit_pr=strcat('Precip LS: ',tit_st);
suptitle(tit_pr)



% code to plot 5 years of daily mean precip
path_tele='/Users/silvers/data/WalkerCell/testing_20181203';

path_exp_noconv_lwoff='/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff';
path_exp_ctl='/c8x160L33_am4p0_25km_wlkr_ent0p9';
path_exp_noconv='/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv';
path_exp_lwoff='/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff';

path_fname='/1979th1983_daily.nc';

path_ctl=strcat(path_tele,path_exp_ctl,path_fname);
path_lwoff=strcat(path_tele,path_exp_lwoff,path_fname);
path_noconv=strcat(path_tele,path_exp_noconv,path_fname);
path_noconv_lwoff=strcat(path_tele,path_exp_noconv_lwoff,path_fname);

precip_25km_ctl_raw=ncread(path_ctl,'precip');
precip_25km_lwoff_raw=ncread(path_lwoff,'precip');
precip_25km_noconv_lwoff_raw=ncread(path_noconv_lwoff,'precip');
precip_25km_noconv_raw=ncread(path_noconv,'precip');

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

% lwoff 
precip_znm=mean(precip_25km_lwoff_raw,2);
p_znm=scale.*(squeeze(precip_znm));
precip_daily_lwoff=squeeze(mean(p_znm,1));

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

figure
plot(precip_ctl_rm2,'Color',colyel,'LineWidth',2);
hold on
plot(precip_25km_lwoff,'Color',colyel,'LineWidth',1)
plot(precip_25km_noconv,'--','Color',colyel,'LineWidth',1)
plot(precip_25km_noconv_lwoff,'-.','Color',colyel,'LineWidth',1)
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










