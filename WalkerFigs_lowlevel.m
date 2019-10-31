% plots domain mean vertical profiles for the total condensate
% variables to be plotted:
%1. surface enthalpy flux
%2. theta_e_gcm_ctl   
%3. u_25km_ztmn_ctl: at lowest atm model level   
%4. u_25km_dmn_ctl : domain mean (shear) 

% variables needed for plot: 
%1. evap
%2. sh % sensible heat flux
%3. theta_e
%4. u_ztmn


path_base='/Users/silvers/data/WalkerCell/'

path=strcat(path_base,'gauss_d/');
path_n=strcat(path_base,'testing_20181203/');

% default values for the first time WalkerCell is run:
experi=3 % experi=3 uses the ent0p9 experiment
exptype=0 % 0 is the default experimental configuration (lwcre is on)
% 2 corresponds to lwoff

%lwstring='4K_lwoff/';
lwstring='4K/';

%lwcreonoff=' with LWCRE';

%source_gcm_noconv=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
source_gcm_noconv_lwoff=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');
source_gcm_ctl=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9/',yearstr,'.atmos_month_tmn.nc');
source_gcm_lwoff=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff/',yearstr,'.atmos_month_tmn.nc');


%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
% lwcre on
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
% source paths for lwcre on experiments: 
source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
source_1km_month=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
source_2km_month=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');

compTheta % script that computes theta and Tv for gcm_month, 2km_month, and 1km_month

% gcm-like resolutions 
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
evap_25km_full=ncread(source_gcm_month,'evap');
sh_25km_en_ztmn=read_1var_ztmn(source_gcm_month,'shflx');
lwdn_25km_ztmn=read_1var_ztmn(source_gcm_month,'lwdn_sfc');
u_25km_ztmn        = read_1var_ztmn(source_gcm_month,'ucomp');

evap_25km_tmn=squeeze(mean(evap_25km_full,3));
evap_25km_ztmn=squeeze(mean(evap_25km_tmn,2));
evap_25km_en_ztmn=latheat.*evap_25km_ztmn;

sh_25km_ztmn=squeeze(mean(sh_25km_en_ztmn,2));
u_25km_dmn         = squeeze(mean(u_25km_ztmn,1));
%theta_e_gcm_ctl    =theta_e_gcm;
s_enth_25km        =evap_25km_en_ztmn+sh_25km_ztmn;

u_25km_dmn_noconv_plot    =u_25km_dmn;
u_25km_ztmn_noconv_plot   =u_25km_ztmn;
s_enth_25km_noconv_plot   =s_enth_25km;
theta_e_gcm_noconv_plot  =theta_e_gcm; % panel 2

% crm-like resolutions lwcre on
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
%compTheta % computes variables for both 1km and 2km

% for 2km experiments
evap_2km          =ncread(source_2km_month,'evap');
sh_2km            =ncread(source_2km_month,'shflx');
u_2km_ztmn        = read_1var_ztmn(source_2km_month,'ucomp');

evap_2km_zmn      =squeeze(mean(evap_2km,2));
evap_2km_zmn_last3=squeeze(evap_2km_zmn(:,4:6));
evap_2km_ztmn     =squeeze(mean(evap_2km_zmn,2));
evap_2km_en_ztmn  =latheat.*evap_2km_ztmn;

sh_2km_zmn        =squeeze(mean(sh_2km,2));
sh_2km_zmn_last3  =squeeze(sh_2km_zmn(:,4:6));
sh_2km_ztmn       =squeeze(mean(sh_2km_zmn_last3,2));

u_2km_dmn         = squeeze(mean(u_2km_ztmn,1));  % panel 3
s_enth_2km        =evap_2km_en_ztmn+sh_2km_ztmn;  % panel 1
theta_e_2km=theta_e_crm2; % panel 2

u_2km_dmn_plot    =u_2km_dmn;
u_2km_ztmn_plot   =u_2km_ztmn;
s_enth_2km_plot   =s_enth_2km;
theta_e_2km_plot  =theta_e_crm2; % panel 2

% for 1km experiments
evap_1km          =ncread(source_1km_month,'evap');
sh_1km            =ncread(source_1km_month,'shflx');
u_1km_ztmn        = read_1var_ztmn(source_1km_month,'ucomp');

evap_1km_zmn      =squeeze(mean(evap_1km,2));
evap_1km_zmn_last3=squeeze(evap_1km_zmn(:,4:6));
evap_1km_ztmn     =squeeze(mean(evap_1km_zmn,2));
evap_1km_en_ztmn  =latheat.*evap_1km_ztmn;

sh_1km_zmn        =squeeze(mean(sh_1km,2));
sh_1km_zmn_last3  =squeeze(sh_1km_zmn(:,4:6));
sh_1km_ztmn       =squeeze(mean(sh_1km_zmn_last3,2));

u_1km_dmn         = squeeze(mean(u_1km_ztmn,1));  % panel 3
s_enth_1km        =evap_1km_en_ztmn+sh_1km_ztmn;  % panel 1

u_1km_dmn_plot    =u_1km_dmn;
u_1km_ztmn_plot   =u_1km_ztmn;
s_enth_1km_plot   =s_enth_1km;
theta_e_1km_plot  =theta_e_crm1; % panel 2

%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
% lwcre off
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
% source paths for experiments with lwcre off
source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');
lwstring='4K_lwoff/';
source_1km_month=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
source_2km_month=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------

compTheta % computes variables for both 1km and 2km

%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
evap_25km_full=ncread(source_gcm_month,'evap');
sh_25km_en_ztmn=read_1var_ztmn(source_gcm_month,'shflx');
u_25km_ztmn        = read_1var_ztmn(source_gcm_month,'ucomp');

evap_25km_tmn=squeeze(mean(evap_25km_full,3));
evap_25km_ztmn=squeeze(mean(evap_25km_tmn,2));
evap_25km_en_ztmn=latheat.*evap_25km_ztmn;

sh_25km_ztmn=squeeze(mean(sh_25km_en_ztmn,2));
u_25km_dmn         = squeeze(mean(u_25km_ztmn,1));
%theta_e_gcm_ctl    =theta_e_gcm;
s_enth_25km        =evap_25km_en_ztmn+sh_25km_ztmn;

u_25km_dmn_noconvlwoff_plot    =u_25km_dmn;
u_25km_ztmn_noconvlwoff_plot   =u_25km_ztmn;
s_enth_25km_noconvlwoff_plot   =s_enth_25km;
theta_e_gcm_noconvlwoff_plot  =theta_e_gcm; % panel 2

% for 2km experiments
evap_2km          =ncread(source_2km_month,'evap');
sh_2km            =ncread(source_2km_month,'shflx');
u_2km_ztmn        = read_1var_ztmn(source_2km_month,'ucomp');

evap_2km_zmn      =squeeze(mean(evap_2km,2));
evap_2km_zmn_last3=squeeze(evap_2km_zmn(:,4:6));
evap_2km_ztmn     =squeeze(mean(evap_2km_zmn,2));
evap_2km_en_ztmn  =latheat.*evap_2km_ztmn;

sh_2km_zmn        =squeeze(mean(sh_2km,2));
sh_2km_zmn_last3  =squeeze(sh_2km_zmn(:,4:6));
sh_2km_ztmn       =squeeze(mean(sh_2km_zmn_last3,2));

u_2km_dmn   = squeeze(mean(u_2km_ztmn,1));  % panel 3
s_enth_2km  =evap_2km_en_ztmn+sh_2km_ztmn;  % panel 1
%theta_e_2km=theta_e_crm2; % panel 2

u_2km_dmn_lwoff_plot    =u_2km_dmn;
u_2km_ztmn_lwoff_plot   =u_2km_ztmn;
s_enth_2km_lwoff_plot   =s_enth_2km;
theta_e_2km_lwoff_plot  =theta_e_crm2; % panel 2

% for 1km experiments
evap_1km          =ncread(source_1km_month,'evap');
sh_1km            =ncread(source_1km_month,'shflx');
u_1km_ztmn        = read_1var_ztmn(source_1km_month,'ucomp');

evap_1km_zmn      =squeeze(mean(evap_1km,2));
evap_1km_zmn_last3=squeeze(evap_1km_zmn(:,4:6));
evap_1km_ztmn     =squeeze(mean(evap_1km_zmn,2));
evap_1km_en_ztmn  =latheat.*evap_1km_ztmn;

sh_1km_zmn        =squeeze(mean(sh_1km,2));
sh_1km_zmn_last3  =squeeze(sh_1km_zmn(:,4:6));
sh_1km_ztmn       =squeeze(mean(sh_1km_zmn_last3,2));

u_1km_dmn         = squeeze(mean(u_1km_ztmn,1));  % panel 3
s_enth_1km        =evap_1km_en_ztmn+sh_1km_ztmn;  % panel 1

%theta_e_1km_lwoff=theta_e_crm1;

u_1km_dmn_lwoff_plot    =u_1km_dmn;
u_1km_ztmn_lwoff_plot   =u_1km_ztmn;
s_enth_1km_lwoff_plot   =s_enth_1km;
theta_e_1km_lwoff_plot  =theta_e_crm1; % panel 2

%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------

%theta_e_crm2_ctl = theat_e_crm2;   % panel 2               
%u_2km_dmn        = squeeze(mean(u_2km_ztmn,1));  % panel 3
%s_enth_2km       =evap_2km_en_ztmn+sh_2km_ztmn;  % panel 1
% panel 4 shows the low level wind, which uses u_2km_ztmn(:,33)

% variables needed to plot
%s_enth_25km_noconv
%s_enth_25km_noconvlwoff
%s_enth_2km
%s_enth_1km
%s_enth_2km_lwoff
%s_enth_1km_lwoff
%
%theta_e_gcm_noconv
%theta_e_gcm_noconvlwoff
%theta_e_crm1
%theta_e_crm1_lwoff
%theta_e_crm2
%theta_e_crm2_lwoff
%
%u_1km_ztmn
%u_1km_ztmn_lwoff
%u_2km_ztmn
%u_2km_ztmn_lwoff
%u_25km_ztmn_noconv
%u_25km_ztmn_noconvlwoff
%
%u_1km_dmn
%u_1km_dmn_lwoff
%u_2km_dmn
%u_2km_dmn_lwoff
%u_25km_dmn_noconv
%u_25km_dmn_noconvlwoff

% make figure
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------
thin=0.5;
thick=2;

  figure
  subplot(2,2,1)
  plot(xcrm_2to1,s_enth_2km_plot,'Color',colblu,'LineWidth',thick)
  hold on
  plot(xcrm_2to1,s_enth_2km_lwoff_plot,'Color',colblu,'LineWidth',thin)
  plot(s_enth_1km_plot,'Color',colgrn,'LineWidth',thick)
  plot(s_enth_1km_lwoff_plot,'Color',colgrn,'LineWidth',thin)
  plot(xaxis_gcm2crm,s_enth_25km_noconvlwoff_plot,'Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,s_enth_25km_noconv_plot,'Color',colyel,'LineWidth',thick)
  ylabel('W/m2')
  xlabel('km')
  title('Surface Enthalpy Flux')
 
  subplot(2,2,2)
  plot(xcrm_2to1,theta_e_2km_plot(:,33),'Color',colblu,'LineWidth',thick)
  hold on
  plot(xcrm_2to1,theta_e_2km_lwoff_plot(:,33),'Color',colblu,'LineWidth',thin)
  plot(theta_e_1km_plot(:,33),'Color',colgrn,'LineWidth',thick)
  plot(theta_e_1km_lwoff_plot(:,33),'Color',colgrn,'LineWidth',thin)
  plot(xaxis_gcm2crm,theta_e_gcm_noconvlwoff_plot(:,33),'Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,theta_e_gcm_noconv_plot(:,33),'Color',colyel,'LineWidth',thick)
  ylabel('K')
  xlabel('km')
  title('equivalent theta')
 
  subplot(2,2,3)
  plot(u_1km_ztmn_plot(:,33),'Color',colgrn,'LineWidth',thick)
  hold on
  plot(u_1km_ztmn_lwoff_plot(:,33),'Color',colgrn,'LineWidth',thin)
  title('u-wind lowest atm level')
  plot(xcrm_2to1,u_2km_ztmn_plot(:,33),'Color',colblu,'LineWidth',thick)
  plot(xcrm_2to1,u_2km_ztmn_lwoff_plot(:,33),'Color',colblu,'LineWidth',thin)
  plot(xaxis_gcm2crm,u_25km_ztmn_noconvlwoff_plot(:,33),'Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,u_25km_ztmn_noconv_plot(:,33),'Color',colyel,'LineWidth',thick)
  xlabel('km')
  ylabel('m/s')

  subplot(2,2,4)
  plot(u_1km_dmn_plot(10:33),zzfull(10:33),'Color',colgrn,'LineWidth',thick)
  hold on
  plot(u_1km_dmn_lwoff_plot(10:33),zzfull(10:33),'Color',colgrn,'LineWidth',thin)
  plot(u_2km_dmn_plot(10:33),zzfull(10:33),'Color',colblu,'LineWidth',thick)
  plot(u_2km_dmn_lwoff_plot(10:33),zzfull(10:33),'Color',colblu,'LineWidth',thin)
  plot(u_25km_dmn_noconvlwoff_plot(10:33),zzfull(10:33),'Color',colyel,'LineWidth',thin)
  plot(u_25km_dmn_noconv_plot(10:33),zzfull(10:33),'Color',colyel,'LineWidth',thick)
  xlabel('m/s')
  title('Domain mean u-wind')
  ylabel('height (m)')
  ylim([0 16000])
%-----------------------------@#$%@#%$&#@$%@#$%^------------------------------------

