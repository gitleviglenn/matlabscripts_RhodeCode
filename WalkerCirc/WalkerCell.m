%--------------------------------------------------------------------
% physical constants are defined in the script phys_constants
%
% experi and exptype both need to be defined in advance 
%
% use read_1var_ztmn to read a variable and take the zonal time mean
%
% levi silvers                                       dec 2018
%--------------------------------------------------------------------
path_base='/Users/silvers/data/WalkerCell/'

path=strcat(path_base,'gauss_d/');
path_n=strcat(path_base,'testing_20181203/');

% define physical constants
phys_constants

% default values for the first time WalkerCell is run:
experi=3 % experi=3 uses the ent0p9 experiment
exptype=2 % 0 is the default experimental configuration (lwcre is on)
% 2 corresponds to lwoff

if exptype==2
  ind=2;
end

lwstring='4K_lwoff/';
%lwstring='4K/';

lwcreonoff=' with LWCRE on';

%estr2='ent0p5_p4K'plot(tdt_heat_prof_25(1,10:33),zzfull(10:33),'-o','Color',colyel) 

initialrun=0;
if initialrun
% initialize several matrices to hold the ensemble of gcm experiments
p_mat            = zeros(5,160,1826);
prec_mn_mat      = zeros(6,1);
radh_mn_mat      = zeros(6,1);
rh_mat           = zeros(5,160,33);
cl_mat           = zeros(5,160,33);
liq_25km_tot_mat = zeros(5,160,33);
tdtlw_mat        = zeros(5,160,33);
tdtsw_mat        = zeros(5,160,33);
tdtconv_mat      = zeros(5,160,33);
tdt_totcl_mat    = zeros(5,160,33);
rad_heat_mat     = zeros(5,33);
lts_mat          = zeros(5,160);

% these arrays are for use in WalkerFigs.m
rh_tmp_arr       =zeros(5,33);
rh_sub_arr       =zeros(5,33);
ice_prof_arr     =zeros(5,33);
liq_prof_arr     =zeros(5,33);
gam_arr          =zeros(5,33);
gam_m_arr        =zeros(5,33);
rad_prof_arr     =zeros(5,33);
tdtconv_prof_arr =zeros(5,33);
tdtls_prof_arr   =zeros(5,33);
stap_arr         =zeros(5,33);
th_e_gcm_arr     =zeros(5,33);
th_gcm_arr       =zeros(5,33);
end

%exptype: 0: default; 2: lwoff; 3: p4K
if (experi < 2) 
    estr='ent0p5'
    estr2='ent0p5'
    if (exptype > 2)
        estr2='ent0p5_p4K'
    elseif (exptype > 1)
        estr2='ent0p5_lwoff'
    end
elseif (experi < 3)
  estr='ent0p7'
  estr2='ent0p7'
  if (exptype > 2)
    estr2='ent0p7_p4K'
  elseif (exptype > 1)
    estr2='ent0p7_lwoff'
  end
  ind=2
elseif (experi < 4)
  estr='ent0p9'
  estr2='ent0p9'
  ind=3
  if (exptype > 2)
    estr2='ent0p9_p4K'
  elseif (exptype > 1)
    estr2='ent0p9_lwoff'
  end
elseif (experi < 5)
  estr='ent1p1'
  estr2='ent1p1'
  if (exptype > 2)
    estr2='ent1p1_p4K'
  elseif (exptype > 1)
    estr2='ent1p1_lwoff'
  end
  ind=4
elseif (experi < 6)
  estr='ent1p3'
  estr2='ent1p3'
  if (exptype > 2)
    estr2='ent1p3_p4K'
  elseif (exptype > 1)
    estr2='ent1p3_lwoff'
  end
  ind=5
end 

%tit_st='4K ent1p1';
tit_st=strcat('4K ',estr2);


% timing variables for gcm 
an_t1=1; % for months
an_t2=4;

an_t1_d=120;
an_t2_d=365;

% timing variables for crm [days]
%t_end=181; % was 59 original
%t_mid=91; % was 30 originally
t_mid=3;
t_end=6;

yearstr='/1980th1983';
yearstr_79='/19790101';

% path strings... 
%path_25km=strcat(path,'c96L33_am4p0_8x160_nh_25km_wlkr_4K_',estr2,'/19790101');
path_25km         =strcat(path_n,'c8x160L33_am4p0_25km_wlkr_',estr2);
path_25km_lg      =strcat(path_n,'c8x640L33_am4p0_25km_wlkr_',estr2);

path_100km            =strcat(path_n,'c8x160L33_am4p0_100km_wlkr_',estr2);
path_100km_small      =strcat(path_n,'c8x40L33_am4p0_100km_wlkr_',estr2);
path_100km_small_dly  =strcat(path_n,'c8x40L33_am4p0_100km_wlkr_ent0p9');
path_100km_small_dly_lwoff  =strcat(path_n,'c8x40L33_am4p0_100km_wlkr_ent0p9_lwoff');

%path_2km=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790401');
%path_2km=strcat(path,'c50x2000L33_am4p0_2km_wlkr_4K/');
%path_1km=strcat(path,'c96L33_am4p0_10x4000_nh_1km_wlkr_4K/');
%path_1km=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_4K/');
% path_2km=strcat(path,'am4p0_50x2000_4K/','19790301');

%-------------------------------------------------------------------------------------------------
% source strings...
%-------------------------------------------------------------------------------------------------

%%% this should be the default definition of the path
ConvParam=1;% convective parameterization is on when ConvParam=1
ConvExp=0;  % explicit convection, meaning convective parameterization is off
ConvExpLwoff=0;

if exptype==2;
  ind=2;
end

if ConvParam
  source_gcm_month=strcat(path_25km,yearstr,'.atmos_month_tmn.nc');
  %source_gcm_month=strcat(path_100km,yearstr,'.atmos_month_tmn.nc');
  source_gcm_daily=strcat(path_25km,'/1979th1983_daily.nc');
  arr_ind=1;
  ind=3; %??
end
if ConvExp % explicit convection
  source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
  source_gcm_daily=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/','/1979th1983_daily.nc');
  %source_gcm_daily=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/','/1979th1983_daily.nc');
  arr_ind=2;
  ind=1
  %
  if ConvExpLwoff
    source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');
    source_gcm_daily=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/','/1979th1983_daily.nc');
    ind=4
  end
end

% in some cases the indices indicate differing entrainment values, in other cases diff exps
% ind 1 = either 0p5 or noconv
% ind 2 = either 0p7 or lwoff
% ind 3 = either 0p9 or control (0p9, lwon, conv on)
% ind 4 = either 1p1 or noconv lwoff
% ind 5 = either 1p3 or ...

% use the path below for noconv_lwoff or  noconv
%source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr,'.atmos_month_tmn.nc');
%source_gcm_daily=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/','1979th1983_daily.nc');
%source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
%source_gcm_daily=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/','1979th1983_daily.nc');
%source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_100km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');

%source_25km=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff/',yearstr_79,'.atmos_daily.nc');
%%source_gcm_month=strcat(path_25km,'_noconv',yearstr,'.atmos_month_tmn.nc');
%%source_gcm_month=strcat(path_100km,yearstr,'.atmos_month_tmn.nc');

source_25km_lg_month   =strcat(path_25km_lg,yearstr,'.atmos_month_tmn.nc');

source_100km_lg_month  =strcat(path_100km,yearstr,'.atmos_month_tmn.nc');
source_100km_sm_month  =strcat(path_100km_small,yearstr,'.atmos_month_tmn.nc');
source_100km_sm_lwoff_daily  =strcat(path_100km_small_dly_lwoff,'/1979th1983_daily.nc');
source_100km_sm_daily  =strcat(path_100km_small_dly,'/1979th1983_daily.nc');

source_1km_month=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
%source_1km_month=strcat(path_1km,'19790301.atmos_month_psivars.nc');
%source_1km_month=strcat(path_1km,'1979.mn3456.atmos_month_psivars.tmn.nc');
%source_1km_liq_month=strcat(path_1km,'1979.040506.atmos_month.liqvars.3months.nc');
%source_2km=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','1979_6mn.atmos_daily.nc');
%source_2km=strcat(path_2km,'.atmos_daily.nc');
%source_2km_month=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','1979_6mn.atmos_month.nc');
%source_2km_month=strcat(path,'c50x2000L33_am4p0_2km_wlkr_4K_lwoff/','1979_6mn.atmos_month.nc');
source_2km_month=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_',lwstring,'1979_6mn.atmos_month.nc');
%source_2km_dprecp=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_',lwstring,'1979.6mn.atmos_daily_selvars.nc');
%source_2km_month=strcat(path_2km,'.atmos_month.nc');
%source_2km_8xday=strcat(path_2km,'.atmos_8xdaily.nc');

%-------------------------------------------------------------------------------------------------

% domain related parameters:
xgcm=0:25:4000; % size of gcm domain in km
xgcm_ngp=160; % gcm number of grid points in x
xgcm_40=50:100:3950; % size of gcm domain in km
xgcm_640=0:25:16000; % size of gcm domain in km
xgcm_640=0:6.25:4000; % size of gcm domain in km
xgcm_sm_ngp=40; % gcm number of grid points in x
xgcm_lg_ngp=640; % gcm number of grid points in x
xcrm=0:2:4000; % size of crm domain in km
xcrm_ngp=2000; % crm number of grid points in x
xcrm_1km=0:1:4000;
xcrm_1km_ngp=4000;

% latent heat of vaporization
%latheat=2.26e6 % J/kg

% scaling factors
% precip can be converted into mm/day (scale1) 
% what is the value of the latent heat conversion used in AM4?
% or energy units of W/m2 (scale2)
scale1=86400.; % s m^2 mm / kg day
%scale2=2.265e6; % J/kg why the difference with the value below?
%scale2=2.501e6;
scale=scale1;
cltscale=100. % convert to percentage of cloud fraction

% read variables from input files

% precipitation
precip_25km_daily=ncread(source_gcm_daily,'precip');
precip_25km=ncread(source_gcm_month,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_lg=ncread(source_25km_lg_month,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_100km=ncread(source_100km_lg_month,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_100km_sm=ncread(source_100km_sm_month,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_2km=ncread(source_2km_month,'precip');
precip_2km=precip_2km(:,:,t_mid:t_end);
precip_1km=ncread(source_1km_month,'precip');
precip_1km=precip_1km(:,:,t_mid:t_end);
%precip_25km_8x=ncread(source_25km_8xday,'precip');
%precip_2km_8x=ncread(source_2km_8xday,'precip');
%p_cv_25km=ncread(source_25km,'prec_conv'); %kg(h2o)/m2/2
%p_ls_25km=ncread(source_25km,'prec_ls');
%p_cv_2km=ncread(source_2km_month,'prec_conv'); %kg(h2o)/m2/2
%p_ls_2km=ncread(source_2km_month,'prec_ls');

temp_2km=ncread(source_2km_month,'temp');
temp_crm_eq=temp_2km(:,:,:,t_mid:t_end);
temp_crm_zmn=squeeze(mean(temp_crm_eq,2)); 
%temp_crm_zmn=temp_crm_zmn(:,:,t_mid:t_end);
temp_crm_ztmn=squeeze(mean(temp_crm_zmn,3));
temp_crm_ztzmn=squeeze(mean(temp_crm_ztmn,1));

temp_1km=ncread(source_1km_month,'temp');
temp_crm1_zmn=squeeze(mean(temp_1km,2)); 
temp_crm1_zmn=temp_crm1_zmn(:,:,t_mid:t_end);
temp_crm1_ztmn=squeeze(mean(temp_crm1_zmn,3));

w_2km=ncread(source_2km_month,'w');
w_1km=ncread(source_1km_month,'w');

precip_100km_znm      =mean(precip_100km,2);
precip_100km_sm_znm   =mean(precip_100km_sm,2);
precip_25km_lg_znm    =mean(precip_25km_lg,2);
precip_25km_znm       =mean(precip_25km,2); 
precip_25km_daily_znm =mean(precip_25km_daily,2);
precip_2km_znm        =mean(precip_2km,2);
precip_1km_znm        =mean(precip_1km,2);
%precip_25km_8x_znm=mean(precip_25km_8x,2);

p_2km_znm             =scale.*(squeeze(precip_2km_znm));
p_1km_znm             =scale.*(squeeze(precip_1km_znm));
p_100km_znm           =scale.*(squeeze(precip_100km_znm));
p_100km_sm_znm        =scale.*(squeeze(precip_100km_sm_znm));
p_25km_lg_znm         =scale.*(squeeze(precip_25km_lg_znm));
p_25km_znm            =scale.*(squeeze(precip_25km_znm));
p_25km_daily_znm      =scale.*(squeeze(precip_25km_daily_znm));
%p_25km_8x_znm=scale.*(squeeze(precip_25km_8x_znm));

% time mean precip
%p_25km_8x_znm_equil=p_25km_8x_znm(:,960:2920);
%p_25km_tmean=mean(p_25km_8x_znm_equil,2);
p_100km_tmean=mean(p_100km_znm,2);
p_100km_sm_tmean=mean(p_100km_sm_znm,2);
p_25km_lg_tmean=mean(p_25km_lg_znm,2);
p_25km_tmean=mean(p_25km_znm,2);
p_25km_dly_tmean=mean(p_25km_daily_znm,2);
p_2km_tmean=mean(p_2km_znm,2);
p_1km_tmean=mean(p_1km_znm,2);

gcm_wvp=ncread(source_gcm_month,'WVP');
wvp_mn_a=squeeze(mean(gcm_wvp,1));
wvp_mn_b=squeeze(mean(wvp_mn_a,1));
wvp_mn_b=squeeze(wvp_mn_b);
wvp_mn_c=squeeze(mean(wvp_mn_b,2));

%Is the column integrated wvp/density of water equal to the precipitable water? 

% surface temperature
tsurf_fulltime=ncread(source_gcm_month,'t_surf');
%tsfc=tsurf_fulltime(:,:,:);
tsfc_mn=mean(tsurf_fulltime,3);
%tsfc_zmn=squeeze(mean(tsfc_mn,2)); computed in compTheta.m
tsurf_crm=ncread(source_2km_month,'t_surf');
tsurf_crm1=ncread(source_1km_month,'t_surf');

% surface pressure
%p_sfc_fulltime=ncread(source_25km,'ps');
p_sfc_fulltime=ncread(source_gcm_month,'ps');
psurf=mean(p_sfc_fulltime,3);
psurf_zmn=squeeze(mean(psurf,2));

p_sfc_2km_fulltime=ncread(source_2km_month,'ps');
psurf_2km=mean(p_sfc_2km_fulltime,3);
psurf_2km_zmn=squeeze(mean(psurf_2km,2));

p_sfc_1km_fulltime=ncread(source_1km_month,'ps');
psurf_1km=mean(p_sfc_1km_fulltime,3);
psurf_1km_zmn=squeeze(mean(psurf_1km,2));

% velocity
u_25km_ztmn    = read_1var_ztmn(source_gcm_month,'ucomp');
v_25km_ztmn    = read_1var_ztmn(source_gcm_month,'vcomp');
u_2km_ztmn     = read_1var_ztmn(source_2km_month,'ucomp');
v_2km_ztmn     = read_1var_ztmn(source_2km_month,'vcomp');
u_1km_ztmn     = read_1var_ztmn(source_1km_month,'ucomp');
v_1km_ztmn     = read_1var_ztmn(source_1km_month,'vcomp');

% look at horizontal shear...
u_25km_dmn     = squeeze(mean(u_25km_ztmn,1));
u_2km_dmn      = squeeze(mean(u_2km_ztmn,1));
u_1km_dmn      = squeeze(mean(u_1km_ztmn,1));

% vertical velocity
w_25km            = ncread(source_gcm_month,'w');
w_25km_ztmn       = read_1var_ztmn(source_gcm_month,'w');
w_25km_lg_ztmn    = read_1var_ztmn(source_25km_lg_month,'w');

w_100km_lg_ztmn   = read_1var_ztmn(source_100km_lg_month,'w');
w_100km_sm_ztmn   = read_1var_ztmn(source_100km_sm_month,'w');

omega_100km_ztmn  = read_1var_ztmn(source_100km_lg_month,'omega');
omega_25km_ztmn  = read_1var_ztmn(source_gcm_month,'omega');
omega_2km_ztmn   = read_1var_ztmn(source_2km_month,'omega');
omega_1km_ztmn   = read_1var_ztmn(source_1km_month,'omega');

%w500_25km=ncread(source_25km,'w500');
%w500_2km=ncread(source_2km_dprecp,'w500');

w_2km=ncread(source_2km_month,'w');
w_2km_zmn=squeeze(mean(w_2km,2));
w_2km_zmn=w_2km_zmn(:,:,t_mid:t_end);
w_2km_ztmn=squeeze(mean(w_2km_zmn,3));

w_1km=ncread(source_1km_month,'w');
w_1km_zmn=squeeze(mean(w_1km,2));
w_1km_zmn=w_1km_zmn(:,:,t_mid:t_end);
w_1km_ztmn=squeeze(mean(w_1km_zmn,3));

clt_2km=ncread(source_2km_month,'cld_amt');
clt_1km=ncread(source_1km_month,'cld_amt');
%clt_25km=ncread(source_25km,'cld_amt');
%clt_25km=ncread(source_gcm_month,'cld_amt');
clt_25km=ncread(source_gcm_month,'cld_amt');

liq_1km=ncread(source_1km_month,'tot_liq_amt');
liq_2km=ncread(source_2km_month,'tot_liq_amt');

ice_1km=ncread(source_1km_month,'tot_ice_amt');
ice_2km=ncread(source_2km_month,'tot_ice_amt');

hur_1km=ncread(source_1km_month,'rh');
hur_2km=ncread(source_2km_month,'rh');

pfull_25km=ncread(source_gcm_month,'pfull');
pfull_25km=100.*pfull_25km; % convert to Pa

pfull_2km=ncread(source_2km_month,'pfull');
pfull_2km=100.*pfull_2km; % convert to Pa

pfull_1km=ncread(source_1km_month,'pfull');
pfull_1km=100.*pfull_1km; % convert to Pa


%tsurf=ncread(source_25km,'t_surf');
%temp_25km=ncread(source_gcm_month,'temp');

zfull_25km_ztmn=read_1var_ztmn(source_gcm_month,'z_full');

zfull_2km=ncread(source_2km_month,'z_full');
zfull_2km_zmn=squeeze(mean(zfull_2km,2));
zfull_2km_ztmn=squeeze(mean(zfull_2km_zmn,3));

zfull_1km=ncread(source_1km_month,'z_full');
zfull_1km_zmn=squeeze(mean(zfull_1km,2));
zfull_1km_ztmn=squeeze(mean(zfull_1km_zmn,3));

liq_1km_tot=liq_1km+ice_1km;
liq_1km_zmn=squeeze(mean(liq_1km_tot,2));
liq_1km_zmn=liq_1km_zmn(:,:,t_mid:t_end);
liq_1km_zmn=squeeze(mean(liq_1km_zmn,3));

liq_2km_tot=liq_2km+ice_2km;
liq_2km_zmn=squeeze(mean(liq_2km_tot,2));
% if using last 3 months of crm data:
liq_2km_zmn=liq_2km_zmn(:,:,t_mid:t_end);
liq_2km_zmn=squeeze(mean(liq_2km_zmn,3));

%liq_25km=ncread(source_gcm_month,'tot_liq_amt');
liq_25km_ztmn=read_1var_ztmn(source_gcm_month,'tot_liq_amt');
liq_25km_prof=squeeze(mean(liq_25km_ztmn,1));
ice_25km_ztmn=read_1var_ztmn(source_gcm_month,'tot_ice_amt');
ice_25km_prof=squeeze(mean(ice_25km_ztmn,1));
liq_wat_25km_ztmn=read_1var_ztmn(source_gcm_month,'liq_wat');
liq_wat_25km_prof=squeeze(mean(liq_wat_25km_ztmn,1));

liq_2km_ztmn=read_1var_ztmn(source_2km_month,'tot_liq_amt');
liq_2km_prof=squeeze(mean(liq_2km_ztmn,1));
ice_2km_ztmn=read_1var_ztmn(source_2km_month,'tot_ice_amt');
ice_2km_prof=squeeze(mean(ice_2km_ztmn,1));

liq_1km_ztmn=read_1var_ztmn(source_1km_month,'tot_liq_amt');
liq_1km_prof=squeeze(mean(liq_1km_ztmn,1));
ice_1km_ztmn=read_1var_ztmn(source_1km_month,'tot_ice_amt');
ice_1km_prof=squeeze(mean(ice_1km_ztmn,1));

% compute the liquid condensate profiles in the subsidence region
liq_1km_sub_a=liq_1km_ztmn(1:500,:);
liq_1km_sub_prof_a=mean(liq_1km_sub_a,1);
liq_1km_sub_b=liq_1km_ztmn(3500:4000,:);
liq_1km_sub_prof_b=mean(liq_1km_sub_b,1);
liq_1km_sub_prof=(liq_1km_sub_prof_a+liq_1km_sub_prof_b)/2;


% total zonal time mean condensate
liq_25km_tot_ztmn=liq_25km_ztmn+ice_25km_ztmn;

% relative humidity
% for the 2km runs, the time dimension is often not present becuase it is 1

hur_25km_ztmn  = read_1var_ztmn(source_gcm_month,'rh');

hur_2km_zmn=squeeze(mean(hur_2km,2));
hur_1km_zmn=squeeze(mean(hur_1km,2));

% if using last 3 months of crm data:
hur_2km_zmn_a=hur_2km_zmn(:,:,t_mid:t_end);
hur_2km_zmn_b=squeeze(mean(hur_2km_zmn_a,3));
hur_2km_ztmn=hur_2km_zmn_b;

hur_1km_zmn=hur_1km_zmn(:,:,t_mid:t_end);
hur_1km_zmn=squeeze(mean(hur_1km_zmn,3));
hur_1km_ztmn=hur_1km_zmn;

% specific humidity
q_25km_ztmn    = read_1var_ztmn(source_gcm_month,'sphum');

q_2km=ncread(source_2km_month,'sphum');
q_2km_zmn=squeeze(mean(q_2km,2));
q_2km_ztmn=squeeze(q_2km_zmn(:,:,1));

q_1km=ncread(source_1km_month,'sphum');
q_1km_zmn=squeeze(mean(q_1km,2));
q_1km_ztmn=squeeze(q_1km_zmn(:,:,1));


temp_25km_ztmn = read_1var_ztmn(source_gcm_month,'temp');
tsurf1=squeeze(tsurf_fulltime(:,4,1)); % indices shouldn't matter here...

clt_100km_ztmn = read_1var_ztmn(source_100km_sm_month,'cld_amt');
clt_100km_sm_znm_tmn=cltscale.*clt_100km_ztmn;

clt_100km_lg_ztmn = read_1var_ztmn(source_100km_lg_month,'cld_amt');
clt_100km_lg_znm_tmn=cltscale.*clt_100km_lg_ztmn;

clt_25km_znm=cltscale.*squeeze(mean(clt_25km,2));
clt_25km_znm_2m=clt_25km_znm(:,:,an_t1:an_t2);
clt_25km_znm_2mtmn=squeeze(mean(clt_25km_znm_2m,3));
clt_25km_znm_tmn=mean(clt_25km_znm,3); % this is over a full year...

clt_2km_znm=cltscale.*squeeze(mean(clt_2km,2));
clt_2km_znm_end=clt_2km_znm(:,:,t_mid:t_end);
clt_2km_znm_start=clt_2km_znm(:,:,1:t_mid);
clt_2km_znm_eq=clt_2km_znm(:,:,t_mid:t_end);

clt_2km_znm_st_tmn=mean(clt_2km_znm_start,3);
clt_2km_znm_end_tmn=mean(clt_2km_znm_end,3);
clt_2km_znm_eq_tmn=mean(clt_2km_znm_eq,3);

clt_1km_znm=cltscale.*squeeze(mean(clt_1km,2));
clt_1km_znm_eq=clt_1km_znm(:,:,t_mid:t_end);
clt_1km_znm_eq_tmn=mean(clt_1km_znm_eq,3);

% select profiles in the subsidence region...
bc_a_1km=501;
bc_b_1km=3500;
bc_c_1km=4000;
bc_a_2km=251;
bc_b_2km=1750;
bc_c_2km=2000;
bc_a_25km=21;
bc_b_25km=140;
bc_c_25km=160;
bc_a_100km=6;
bc_b_100km=35;
bc_c_100km=40;

clt_1km_sub_a=clt_1km_znm_eq_tmn(1:bc_a_1km,:);
clt_1km_sub_prof_a=mean(clt_1km_sub_a,1);
clt_1km_sub_b=clt_1km_znm_eq_tmn(bc_b_1km:bc_c_1km,:);
clt_1km_sub_prof_b=mean(clt_1km_sub_b,1);
clt_1km_sub_prof=(clt_1km_sub_prof_a+clt_1km_sub_prof_b)/2;

clt_2km_sub_a=clt_2km_znm_eq_tmn(1:bc_a_2km,:);
clt_2km_sub_prof_a=mean(clt_2km_sub_a,1);
clt_2km_sub_b=clt_2km_znm_eq_tmn(bc_b_2km:bc_c_2km,:);
clt_2km_sub_prof_b=mean(clt_2km_sub_b,1);
clt_2km_sub_prof=(clt_2km_sub_prof_a+clt_2km_sub_prof_b)/2;

clt_25km_sub_a=clt_25km_znm_tmn(1:bc_a_25km,:);
clt_25km_sub_prof_a=mean(clt_25km_sub_a,1);
clt_25km_sub_b=clt_25km_znm_tmn(bc_b_25km:bc_c_25km,:);
clt_25km_sub_prof_b=mean(clt_25km_sub_b,1);
clt_25km_sub_prof=(clt_25km_sub_prof_a+clt_25km_sub_prof_b)/2;

clt_100km_sub_a=clt_100km_sm_znm_tmn(1:bc_a_100km,:);
clt_100km_sub_prof_a=mean(clt_100km_sub_a,1);
clt_100km_sub_b=clt_100km_sm_znm_tmn(bc_b_100km:bc_c_100km,:);
clt_100km_sub_prof_b=mean(clt_100km_sub_b,1);
clt_100km_sub_prof=(clt_100km_sub_prof_a+clt_100km_sub_prof_b)/2;

% grab w at or near 500 mb
w_25km_532=squeeze(w_25km(:,:,18,:)); % grab 532 level
w_25km_532_zmn=squeeze(mean(w_25km_532,2));
w_25km_532_ztmn=mean(w_25km_532_zmn,2);
%w500_25km_zmn=squeeze(mean(w500_25km,2)); % output on the 500mb level
%w500_25km_ztmn=mean(w500_25km_zmn,2);

w_2km_532=squeeze(w_2km(:,:,18,t_mid:t_end));
w_2km_532_zmn=squeeze(mean(w_2km_532,2));
w_2km_532_ztmn=mean(w_2km_532_zmn,2);
%w500_2km_zmn=squeeze(mean(w500_2km,2)); % output on the 500mb level
%w500_2km_ztmn=mean(w500_2km_zmn,2);

% w at all levels
%w_25km_zmn=squeeze(mean(w_25km,2));
%w_25km_ztmn_last8=squeeze(w_25km_zmn(:,:,an_t1:an_t2));
%w_25km_ztmn=squeeze(mean(w_25km_ztmn_last8,3));

w_2km_zmn=squeeze(mean(w_2km,2));
w_2km_ztmn=mean(w_2km_zmn(:,:,t_mid:t_end),3); 

w_1km_zmn=squeeze(mean(w_1km,2));
w_1km_ztmn=mean(w_1km_zmn(:,:,t_mid:t_end),3); 

%-----------------------------
% compute subsidence fraction:
w_25km_sm     =ncread(source_gcm_month,'w');
w_25km_lg     =ncread(source_25km_lg_month,'w');
w_100km_sm    =ncread(source_100km_sm_month,'w');
w_100km_lg    =ncread(source_100km_lg_month,'w');

w_100km_532_sm_sub =squeeze(w_100km_sm(:,:,18,:));
w_100km_532_lg_sub =squeeze(w_100km_lg(:,:,18,:));
w_25km_532_sm_sub  =squeeze(w_25km_sm(:,:,18,:));
w_25km_532_lg_sub  =squeeze(w_25km_lg(:,:,18,:));
w_2km_532_sub      =squeeze(w_2km(:,:,18,t_mid:t_end));
w_1km_532_sub      =squeeze(w_1km(:,:,18,t_mid:t_end));

w_100km_532_sm_sub_tmn =squeeze(mean(w_100km_532_sm_sub,3));
w_100km_532_lg_sub_tmn =squeeze(mean(w_100km_532_lg_sub,3));
w_25km_532_sm_sub_tmn  =squeeze(mean(w_25km_532_sm_sub,3));
w_25km_532_lg_sub_tmn  =squeeze(mean(w_25km_532_lg_sub,3));
w_2km_532_sub_tmn      =squeeze(mean(w_2km_532_sub,3));
w_1km_532_sub_tmn      =squeeze(mean(w_1km_532_sub,3));

w_1km_sub_532 = w_1km_532_sub_tmn < 0.0;
w_1km_subfrac_532 = mean(mean(w_1km_sub_532));
w_2km_sub_532 = w_2km_532_sub_tmn < 0.0;
w_2km_subfrac_532 = mean(mean(w_2km_sub_532));
w_25km_sub_lg_532 = w_25km_532_lg_sub_tmn < 0.0;
w_25km_subfrac_lg_532 = mean(mean(w_25km_sub_lg_532));
w_25km_sub_sm_532 = w_25km_532_sm_sub_tmn < 0.0;
w_25km_subfrac_sm_532 = mean(mean(w_25km_sub_sm_532));
w_100km_sub_lg_532 = w_100km_532_lg_sub_tmn < 0.0;
w_100km_subfrac_lg_532 = mean(mean(w_100km_sub_lg_532));
w_100km_sub_sm_532 = w_100km_532_sm_sub_tmn < 0.0;
w_100km_subfrac_sm_532 = mean(mean(w_100km_sub_sm_532));
%-----------------------------

q25=q_25km_ztmn';
q2=q_2km_ztmn';

%% compute precipitable water, which I think is just the vertical integral of sphum (q)
%%(1/g*rho_water)*integral(sphum)dp
%
%for j=2:33-1
%  pw_lev(j)=(1/10000.).*sphum(j)*(press(j+1)-press(j-1));
%end

% call script compTheta
% prelims to calling compTheta: 
clear rho_25km;
clear rho_2km;
clear rho_1km;

rho_25km=rho_2d_gen(temp_25km_ztmn,q_25km_ztmn,pfull_25km,160);
rho_2km=rho_2d_gen(temp_crm_ztmn,q_2km_ztmn,pfull_2km,2000);
rho_1km=rho_2d_gen(temp_crm1_ztmn,q_1km_ztmn,pfull_1km,4000);


% below for 25km
nlev=33;
nlat=160;
nlon=8;

% below for 2km
%nlat=2000;
%nlon=50;

pfull_gen=pfull_25km;
%temp_gen=temp_25km;

compTheta % compute the potential temperature
WalkerEnergetics % compute several of the radiative flux fields
%compTheta % compute the potential temperature

% compute the diabatic divergence
div_d_25km=diabdiv(vvel_d_25km,160,psurf_zmn,pfull_gen);
div_d_2km=diabdiv(vvel_d_2km,2000,psurf_2km_zmn,pfull_gen);
div_d_1km=diabdiv(vvel_d_1km,4000,psurf_1km_zmn,pfull_gen);


%StreamFun % compute the streamfunction
% call psi_driver to compute the streamfunction

%psi_mat(ind,:,:)=psi_3(:,:);
%p_mat(ind,:,:)=p_25km_daily_znm(:,1:365); % probably needs to be checked
p_mat(ind,:,:)=p_25km_daily_znm(:,1:1826); % probably needs to be checked
rh_mat(ind,:,:)=hur_25km_ztmn(:,:);
cl_mat(ind,:,:)=clt_25km_znm_tmn(:,:);
liq_25km_tot_mat(ind,:,:)=liq_25km_tot_ztmn(:,:);
tdtlw_mat(ind,:,:)=tdtlw_25_ztmn(:,:);
tdtsw_mat(ind,:,:)=tdtsw_25_ztmn(:,:);
tdtls_mat(ind,:,:)=tdtls_25km_ztmn(:,:);
tdtconv_mat(ind,:,:)=tdtconv_25km_ztmn(:,:);
lts_mat(ind,:)=lts_25km(:); % computed in compTheta.m
 
tdt_total_cloud=tdtconv_25km_ztmn+tdtls_25km_ztmn;
tdt_totcl_mat(ind,:,:)=tdt_total_cloud(:,:);

% make this crap into a function!!
tdt_con_prof=mean(tdtconv_25km_ztmn,1);
tdt_ls_prof=mean(tdtls_25km_ztmn,1);
tdt_total_prof=mean(tdt_total_cloud,1);

tdtlw_dmn=squeeze(mean(tdtlw_25_ztmn,1));
tdtsw_dmn=squeeze(mean(tdtsw_25_ztmn,1));
temprad=tdtlw_dmn+tdtsw_dmn;
rad_heat_mat(ind,:)=temprad;

MeanPrecip_100km=mean(p_100km_tmean,1)
MeanPrecip_100km_sm=mean(p_100km_sm_tmean,1)
MeanPrecip_25km_lg=mean(p_25km_lg_tmean,1)
MeanPrecip_25km_sm=mean(p_25km_tmean,1)
MeanPrecip_25km_dly=mean(p_25km_dly_tmean,1)
MeanPrecip_2km=mean(p_2km_tmean,1)
MeanPrecip_1km=mean(p_1km_tmean,1)

prec_mn_mat(6)=MeanPrecip_2km;
prec_mn_mat(ind)=MeanPrecip_25km;

radh_mn_mat(6)=MeanRadH_2km;
radh_mn_mat(ind)=MeanRadH_25km;

 
%-----------------------------------------------------------------------
% figures

% points at which to plot profiles
gcm_ris=xgcm_ngp/2;
gcm_sub=xgcm_ngp-4;
crm_ris=xcrm_ngp/2;
crm_sub=xcrm_ngp-100;

wlev=18;
tendindex=4000;
w_1km_ztmn_1lev=squeeze(w_1km_ztmn(:,wlev));
incoming_ts=w_1km_ztmn_1lev;
running_mean
tendindex=3992;
incoming_ts=output_ts;
running_mean
tendindex=3984;
incoming_ts=output_ts;
running_mean
w_1km_ztmn_1lev_smooth=output_ts;
w_1km_smooth_ts=w_1km_ztmn_1lev;
w_1km_smooth_ts(13:3988)=w_1km_ztmn_1lev_smooth(1:3976);

tendindex=2000;
w_2km_ztmn_1lev=squeeze(w_2km_ztmn(:,wlev));
incoming_ts=w_2km_ztmn_1lev;
running_mean
tendindex=1992;
incoming_ts=output_ts;
running_mean
tendindex=1984;
incoming_ts=output_ts;
running_mean
w_2km_ztmn_1lev_smooth=output_ts;
w_2km_smooth_ts=w_2km_ztmn_1lev;
w_2km_smooth_ts(13:1988)=w_2km_ztmn_1lev_smooth(1:1976);

figure
%subplot(1,2,1)
plot(xcrm(1:xcrm_ngp),w_2km_smooth_ts,'Color',colblu,'LineWidth',1.5);
%plot(xcrm(1:xcrm_ngp),w500_2km_ztmn(:),'k','LineWidth',2);
hold on
%plot(xcrm_1km(1:xcrm_1km_ngp),w_1km_ztmn(:,wlev),'k','LineWidth',2);
plot(xcrm_1km(1:xcrm_1km_ngp),w_1km_smooth_ts,'Color',colgrn,'LineWidth',1.5);
%plot(xgcm(1:xgcm_ngp),w_25km_ztmn(:,wlev),'c','LineWidth',2); % used for the lwoff
plot(xgcm(1:xgcm_ngp),w_25km_ztmn(:,wlev),'Color',colyel,'LineWidth',2);
%plot(xgcm_640(1:xgcm_lg_ngp),w_25km_lg_ztmn(:,wlev),'--','Color',colyel,'LineWidth',2);
%plot(xgcm(1:xgcm_ngp),w_100km_lg_ztmn(:,wlev),'--r','LineWidth',2);
plot(xgcm_40(1:xgcm_sm_ngp),w_100km_sm_ztmn(:,wlev),'r','LineWidth',2);
%plot(xgcm(1:xgcm_ngp),w500_25km_ztmn(:),'r','LineWidth',2);
ylabel('(m/s)','FontSize',20)
%xlabel('unitless','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontWeight','bold')
set(gca,'FontSize',16)
set(gca,'YLim',[-0.01 0.05]);
tit_e=strcat('Vertical Velocity without LWCRE');
title(tit_e)

figure
plot(liq_25km_prof,pfull_2km,'Color',colyel)
set(gca,'Ydir','reverse')
hold on
plot(ice_25km_prof,pfull_2km,'Color',colyel)
plot(ice_2km_prof,pfull_2km,'Color',colblu)
plot(liq_2km_prof,pfull_2km,'Color',colblu)
plot(liq_1km_prof,pfull_2km,'Color',colgrn)
plot(ice_1km_prof,pfull_2km,'Color',colgrn)
plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn)
plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2)
plot(ice_2km_prof+liq_2km_prof,pfull_2km,'Color',colblu,'LineWidth',2)
plot(ice_25km_prof+liq_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2)
title('Domain mean Liquid and Ice Amount [kg/kg]')

%stop

set(gca,'YLim',[10000 100000]);
%set(gca,'XLim',[0 100]);
set(gca,'YScale','log')
%set(gca,'Ydir','reverse')

figure
%clt_contours=[1.,3.,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.,55.,60.,65.,70.,75.,80.,85.,90.,95.];
%clt_contours=[1,3,5,10,15,20,25,30,35,40,45,50,55,60];
clt_contours=[5,10,15,20,25,30,35,40];
subplot(2,2,2)
%caxis=([1 25]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,clt_2km_znm_eq_tmn',clt_contours,'EdgeColor','None');
v=[5,10,20,30,40,50,60];
clabel(C,h,v);
tit_a=strcat('cloud fraction 2km')
title(tit_a)
set(gca,'YLim',[10000 100000]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
subplot(2,2,1)
[C,h]=contourf(1:xcrm_1km_ngp,pfull_2km,clt_1km_znm_eq_tmn',clt_contours,'EdgeColor','None');
v=[5,10,20,30,40,50,60];
clabel(C,h,v);
tit_a=strcat('cloud fraction 1km')
title(tit_a)
set(gca,'YLim',[10000 100000]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
subplot(2,2,3)
[C,h]=contourf(1:xgcm_ngp,pfull_2km,clt_25km_znm_tmn',clt_contours,'EdgeColor','None');
v=[5,10,20,30,40,50,60];
clabel(C,h,v);
tit_b=strcat('cloud fraction 25km')
title(tit_b)
set(gca,'YLim',[10000 100000]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
subplot(2,2,4)
[C,h]=contourf(1:xgcm_sm_ngp,pfull_2km,clt_100km_sm_znm_tmn',clt_contours,'EdgeColor','None');
%[C,h]=contourf(1:xgcm_ngp,pfull_2km,clt_100km_lg_znm_tmn',clt_contours,'EdgeColor','None');
v=[5,10,20,30,40,50,60];
clabel(C,h,v);
tit_b=strcat('cloud fraction 100km')
title(tit_b)
set(gca,'YLim',[10000 100000]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
suptitle(tit_st)

% plot time mean precip
figure
plot(xcrm(1:xcrm_ngp),p_2km_tmean(:),'Color',colblu,'LineWidth',2);
hold on
plot(xcrm_1km(1:xcrm_1km_ngp),p_1km_tmean(:),'Color',colgrn,'LineWidth',2);
plot(xgcm(1:xgcm_ngp),p_25km_tmean(:),'Color',colyel,'LineWidth',2);
%plot(xgcm(1:xgcm_ngp),p_100km_tmean(:),'r','LineWidth',2);
plot(xgcm_40(1:xgcm_sm_ngp),p_100km_sm_tmean(:),'r','LineWidth',2);
ylabel('mm/d','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontWeight','bold')
set(gca,'FontSize',16)
%tit_e=strcat('Precip 100km,25km,2km,1km:',num2str(MeanPrecip_100km_sm),';',num2str(MeanPrecip_25km),';',num2str(MeanPrecip_2km),';',num2str(MeanPrecip_1km));
tit_e=('Precipitation without LWCRE')
title(tit_e);
%suptitle(tit_st)

stop 

% the figure below is bet run after the matrix has been filled
figure
plot(squeeze(rad_heat_mat(1,:)),pfull_2km);
set(gca,'Ydir','reverse')
hold on
plot(squeeze(rad_heat_mat(2,:)),pfull_2km);
plot(squeeze(rad_heat_mat(3,:)),pfull_2km);
plot(squeeze(rad_heat_mat(4,:)),pfull_2km);
plot(squeeze(rad_heat_mat(5,:)),pfull_2km);
plot(rad_heat_prof_2,pfull_2km,'k','LineWidth',2);

% figure
% plot(lts_mat(1,:),'LineWidth',1);
% hold on
% title('Lower Tropospheric Stability');
% ylabel('K','FontSize',15)
% plot(lts_mat(2,:),'LineWidth',1.5);
% plot(lts_mat(3,:),'k','LineWidth',2);
% plot(lts_mat(4,:),'LineWidth',2.5);
% plot(lts_mat(5,:),'LineWidth',3);

% figure
% plot(rad_heat_prof_2,pfull_2km);
% set(gca,'Ydir','reverse')
% hold on
% plot(rad_heat_prof_25,pfull_2km);

figure
plot(q25(:,gcm_ris),pfull_2km,'--r','LineWidth',2);
set(gca,'Ydir','reverse')
hold on
plot(q25(:,gcm_sub),pfull_2km,'r','LineWidth',2);
plot(q2(:,crm_ris),pfull_2km,'--k','LineWidth',2);
plot(q2(:,crm_sub),pfull_2km,'k','LineWidth',2);
ylabel('Pressure','FontSize',20)
xlabel('kg/kg','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
set(gca,'XScale','log')
tit_c=strcat('Specific Humidity',tit_st);
title(tit_c)

% figure
% plot(xgcm(1:xgcm_ngp),tsurf1,'k','LineWidth',2);
% ylabel('Kelvin','FontSize',20)
% xlabel('km','FontSize',20)
% yt=get(gca,'YTick');
% set(gca,'FontSize',16)
% tit_d=strcat('Surface Temperature',tit_st);
% title(tit_d)


figure
liq_1km_zmn_scale=liq_1km_zmn*1000.;
liq_2km_zmn_scale=liq_2km_zmn*1000.;
liq_25km_zmn_scale=liq_25km_tot_ztmn*1000.;
q_contours=[0.4,0.1,0.06,0.04,0.03,0.02,0.01,0.001,0.0001,0.0001];
q_contours=[0.4,0.1,0.06,0.04,0.03,0.02];
subplot(1,3,1)
caxis=([0.0001 0.4]);
[C,h]=contourf(1:xcrm_1km_ngp,pfull_2km,liq_1km_zmn_scale',q_contours,'EdgeColor','None');
v=[0.4,0.1,0.06,0.04,0.03,0.02,0.01,0.001,0.0001,0.0001];
clabel(C,h,v);
tit_a=strcat('liq+ice water 1km');
title(tit_a);
set(gca,'Ydir','reverse')
%colorbar
subplot(1,3,2)
%caxis=([0.00001 0.03]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
%v=[0.03,0.01,0.001,0.0001,0.00001];
clabel(C,h,v);
tit_a=strcat('liq+ice water 2km');
title(tit_a);
set(gca,'Ydir','reverse')
%colorbar
subplot(1,3,3)
%caxis=([0.00001 0.03]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,liq_25km_zmn_scale',q_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('liq+ice 25km');
title(tit_b);
set(gca,'Ydir','reverse')
%colorbar
tit_liq=strcat('liq: ',tit_st);
suptitle(tit_liq)

figure
rh_contours=[5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85];
subplot(1,2,1)
caxis=([10 80]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,hur_2km_ztmn',rh_contours,'EdgeColor','None');
v=[10,20,30,50,70];
clabel(C,h,v);
tit_a=strcat('relative humidity 2km');
title(tit_a);
%set(gca,'Ydir','reverse')
%colorbar
%hold on
%contour(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
set(gca,'Ydir','reverse')
colorbar

subplot(1,2,2)
caxis=([10 80]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,hur_25km_ztmn',rh_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('relative humidity 25km');
title(tit_b);
set(gca,'Ydir','reverse')
colorbar
tit_rh=strcat('RH: ',tit_st);
suptitle(tit_rh)

% the code below only works if all fize ensemble members have been run...
% and stored in the matrices cl_mat and rh_mat

% plot the domain mean cloud fractions...
figure1=figure
axes2 = axes('Parent',figure1,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
    %'Position',[0.0415407854984894 0.10385253115539 0.86345921450151 0.753622122086883]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes2,[10000 100000]);
xlim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'on');
blab_cla=squeeze(mean(cl_mat,2));
plot(blab_cla(1,:),pfull_2km,'k','LineWidth',1);
%set(gca,'YLim',[10000 100000]);
%set(gca,'XLim',[0 100]);
%set(gca,'YScale','log')
%set(gca,'Ydir','reverse')
hold on
plot(blab_cla(2,:),pfull_2km,'k','LineWidth',1);
plot(blab_cla(3,:),pfull_2km,'k','LineWidth',1);
plot(blab_cla(4,:),pfull_2km,'k','LineWidth',1);
plot(blab_cla(5,:),pfull_2km,'k','LineWidth',1);
clt_crm=mean(clt_2km_znm_end_tmn,1);
clt_crm_1km=mean(clt_1km_znm_eq_tmn,1);
plot(clt_crm(:),pfull_2km,'--k','LineWidth',2);
plot(clt_crm_1km(:),pfull_2km,'-.k','LineWidth',2);

% plot the domain mean relative humidity
blab_rh=squeeze(mean(rh_mat,2));
plot(blab_rh(1,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(2,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(3,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(4,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(5,:),pfull_2km,'b','LineWidth',1);
hur_crm=mean(hur_2km_ztmn,1);
hur_crm_1km=mean(hur_1km_ztmn,1);
plot(hur_crm(:),pfull_2km,'--b','LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'-.b','LineWidth',2);
title('Mean Cloud and RH')

% plot the maximum value at each level
max_cl_mat=max(cl_mat,[],2);
max_cl_mat=squeeze(max_cl_mat);
max_cl_crm=max(clt_2km_znm_end_tmn,[],1);
max_cl_crm_1km=max(clt_1km_znm_eq_tmn,[],1);
max_cl_crm=squeeze(max_cl_crm);
max_cl_crm_1km=squeeze(max_cl_crm_1km);
figure2=figure
axes2 = axes('Parent',figure2,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
    %'Position',[0.0415407854984894 0.10385253115539 0.86345921450151 0.753622122086883]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes2,[10000 100000]);
xlim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'on');

plot(max_cl_mat(1,:),pfull_2km,'k','LineWidth',1);
%set(gca,'YLim',[10000 100000]);
%set(gca,'XLim',[0 100]);
%set(gca,'YScale','log')
%set(gca,'Ydir','reverse')
hold on
plot(max_cl_mat(2,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_mat(3,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_mat(4,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_mat(5,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_crm(:),pfull_2km,'--k','LineWidth',2);
plot(max_cl_crm_1km(:),pfull_2km,'-.k','LineWidth',2);


max_rh_mat=max(rh_mat,[],2);
max_rh_mat=squeeze(max_rh_mat);
max_rh_crm=max(hur_2km_ztmn,[],1);
max_rh_crm_1km=max(hur_1km_ztmn,[],1);
max_rh_crm=squeeze(max_rh_crm);
max_rh_crm_1km=squeeze(max_rh_crm_1km);
plot(max_rh_mat(1,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(2,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(3,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(4,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(5,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_crm(:),pfull_2km,'--b','LineWidth',2);
plot(max_rh_crm_1km(:),pfull_2km,'-.b','LineWidth',2);
title('Maximum Cloud and RH')

% plot the minimum value at each level
min_cl_mat=min(cl_mat,[],2);
min_cl_mat=squeeze(min_cl_mat);
min_cl_crm=min(clt_2km_znm_end_tmn,[],1);
min_cl_crm_1km=min(clt_1km_znm_eq_tmn,[],1);
min_cl_crm=squeeze(min_cl_crm);
min_cl_crm_1km=squeeze(min_cl_crm_1km);
figure3=figure
axes2 = axes('Parent',figure3,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
    %'Position',[0.0415407854984894 0.10385253115539 0.86345921450151 0.753622122086883]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes2,[10000 100000]);
xlim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'on');

plot(min_cl_mat(1,:),pfull_2km,'k','LineWidth',1);
%set(gca,'YLim',[10000 100000]);
%set(gca,'XLim',[0 100]);
%set(gca,'YScale','log')
%set(gca,'Ydir','reverse')
hold on
plot(min_cl_mat(2,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_mat(3,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_mat(4,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_mat(5,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_crm(:),pfull_2km,'--k','LineWidth',2);
plot(min_cl_crm_1km(:),pfull_2km,'-.k','LineWidth',2);


min_rh_mat=min(rh_mat,[],2);
min_rh_mat=squeeze(min_rh_mat);
min_rh_crm=min(hur_2km_ztmn,[],1);
min_rh_crm_1km=min(hur_1km_ztmn,[],1);
min_rh_crm=squeeze(min_rh_crm);
min_rh_crm_1km=squeeze(min_rh_crm_1km);
plot(min_rh_mat(1,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(2,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(3,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(4,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(5,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_crm(:),pfull_2km,'--b','LineWidth',2);
plot(min_rh_crm_1km(:),pfull_2km,'-.b','LineWidth',2);
title('Minimum Cloud and RH')
