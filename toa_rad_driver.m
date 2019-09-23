%---------------------------------------
% toa_rad_driver.m
%
% compute the change in net radiative flux at toa
% between experiments
%
% levi silvers                sep 2018
%---------------------------------------

del_R=[0,0,0,0,0];
del_Rsw=[0,0,0,0,0];
del_Rlw=[0,0,0,0,0];
del_cre=[0,0,0,0,0];
del_swcre=[0,0,0,0,0];
del_lwcre=[0,0,0,0,0];
atm_enimb=zeros(2,5);

%grid_spac='100km';
grid_spac='25km';

wkstn_loc='macbook';  % true if running scripts on my gfdl workstation
%wkstn_loc='wkstn';  % true if running scripts on my gfdl workstation
comp_ts  ='getts';  % switch for computing time series of fluxes, getts corresponds to yes

entval='0p5';

% for files on macbook
%experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
% for files on archive
switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/3/history/');
      end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
end

toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

figure
%plot(precip_ts-evap_ts);
hold on

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/2/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
end

toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

%plot(precip_ts-evap_ts,'r');

del_R(1)=toa_R_ctl-toa_R_p4K;
del_cre(1)=net_cre_ctl-net_cre_p4K;
del_swcre(1)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(1)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(1)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(1)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,1)=atm_enimb_ctl;
atm_enimb(2,1)=atm_enimb_p4K;
%
entval='0p7';

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
end
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

%plot(precip_ts-evap_ts);

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
end
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

%plot(precip_ts-evap_ts,'r');

del_R(2)=toa_R_ctl-toa_R_p4K;
del_cre(2)=net_cre_ctl-net_cre_p4K;
del_swcre(2)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(2)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(2)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(2)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,2)=atm_enimb_ctl;
atm_enimb(2,2)=atm_enimb_p4K;

%
entval='0p9_1consv';
%entval='0p9';

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
end
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

%plot(precip_ts-evap_ts);

%swup_toa_ts_ctl=swup_toa_ts;
%evap_ts_ctl=evap_ts;
%lhflux_sfc_ts_ctl=lhflux_sfc_ts;
%atm_imb_ts_ctl=atm_imb_ts;

%lhflux_dmn
%shflx_s_dmn
%lwdn_s_dmn
%lwup_s_dmn
%swdn_s_dmn
%swup_s_dmn

switch wkstn_loc
  case 'wkstn'
    %experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent','0p9_p4K_1consv');
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
end
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

%plot(precip_ts-evap_ts,'r');

%swup_toa_ts_p4K=swup_toa_ts;
%evap_ts_p4K=evap_ts;
%lhflux_sfc_ts_p4K=lhflux_sfc_ts;
%atm_imb_ts_p4K=atm_imb_ts;
%lhflux_dmn
%shflx_s_dmn
%lwdn_s_dmn
%lwup_s_dmn
%swdn_s_dmn
%swup_s_dmn

del_R(3)=toa_R_ctl-toa_R_p4K;
del_cre(3)=net_cre_ctl-net_cre_p4K;
del_swcre(3)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(3)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(3)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(3)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,3)=atm_enimb_ctl;
atm_enimb(2,3)=atm_enimb_p4K;
%
entval='1p1';

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
end
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

%plot(precip_ts-evap_ts);

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
end
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

%plot(precip_ts-evap_ts,'r');

del_R(4)=toa_R_ctl-toa_R_p4K;
del_cre(4)=net_cre_ctl-net_cre_p4K;
del_swcre(4)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(4)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(4)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(4)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,4)=atm_enimb_ctl;
atm_enimb(2,4)=atm_enimb_p4K;
%
entval='1p3';

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
end
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

%plot(precip_ts-evap_ts);

switch wkstn_loc
  case 'wkstn'
    experimentn_a=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
    switch grid_spac
      case '100km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/history/');
      case '25km'
        experimentn=strcat(experimentn_a,'/gfdl.ncrc3-intel-prod-openmp/1/history/');
    end
  case 'macbook'
    experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
end

toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

%plot(precip_ts-evap_ts,'r');

del_R(5)=toa_R_ctl-toa_R_p4K;
del_cre(5)=net_cre_ctl-net_cre_p4K;
del_swcre(5)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(5)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(5)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(5)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,5)=atm_enimb_ctl;
atm_enimb(2,5)=atm_enimb_p4K;
