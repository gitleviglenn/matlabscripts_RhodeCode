%----------------------------------------------------------------------
% toa_rad.m
%
% compute the net radiative flux at toa and at the surface.  
% if the getts (get time series) switch is on then time series
% of the budgets are also computed by calling glb_mon_mn_ts()
%
% for the record(as of sep 24, 2018, the atmospheric energy lack 
% of conservation is: 
%    atm_enimb_100km =
%
%    1.3216    1.5953    1.9002    2.1304    2.4228
%    3.2217    3.2727    3.2264    3.3200    3.1769
%
%    atm_enimb_25km =
%
%    2.2413    2.3575    2.3785    2.7769    2.2740
%    2.9332    2.7004    3.0250    3.0396    2.8745
%
% levi silvers                                                 oct 2018
%----------------------------------------------------------------------

% if these variables haven't already been set by a calling 
% script then use below:

%temp_ll_ts=v.tref_ts;
%olr_ts=v.olr_toa_ts;
%swdn_ts=v.swdn_toa_ts;
%swup_ts=v.swup_toa_ts;

% dimensions(time, grid_yt, grid_xt)
%olr
%olr_clr
%swdn_toa
%swdn_toa_clr
%swup_toa
%swup_toa_clr
%netrad_toa

%experimentn='/c8x160L33_am4p0_25km_wlkr_ent0p9'

% call script that opens data file and reads variables
% open_radflux % if using Matlab 2015 or later
switch wkstn_loc
  case 'wkstn'
    open_radflux_m2009 % if using Matlab 2009
  case 'macbook'
    open_radflux % if using Matlab 2015 or later
end

olr_dmn=domaintime_mn(olr);
olr_clr_dmn=domaintime_mn(olr_clr);
swdn_dmn=domaintime_mn(swdn_toa);
swup_dmn=domaintime_mn(swup_toa);
swup_clr_dmn=domaintime_mn(swup_toa_clr);

% for the surface
lwdn_s_dmn  = domaintime_mn(lwdn_sfc);
swdn_s_dmn  = domaintime_mn(swdn_sfc);
lwup_s_dmn  = domaintime_mn(lwup_sfc);
swup_s_dmn  = domaintime_mn(swup_sfc);
shflx_s_dmn = domaintime_mn(shflx);
evap_s_dmn  = domaintime_mn(evap);

lat_evap=2.5e6; % joules/kg

%% delR=incoming-outgoing=v.swdn_toa-v.olr_toa-v.swup_toa;

%toa_R=swdn_yearlymean-swup_yearlymean-olr_yearlymean;
toa_R=swdn_dmn-swup_dmn-olr_dmn;
toa_Rsw=swdn_dmn-swup_dmn;
toa_Rlw=-olr_dmn;
toa_R_clr=swdn_dmn-swup_clr_dmn-olr_clr_dmn;

% compute radiative budget at surface
lhflux_dmn=lat_evap.*evap_s_dmn;
sfc_R=-lhflux_dmn-shflx_s_dmn+lwdn_s_dmn-lwup_s_dmn+swdn_s_dmn-swup_s_dmn;

atm_imb=toa_R-sfc_R;

% compute the cloud radiative effect

% when clouds warm, swup_toa should be smaller than swup_toa_clr
% when clouds warm, olr should be smaller than olr_clr
sw_cre=swup_clr_dmn-swup_dmn; % positive for clouds warming 
lw_cre=olr_clr_dmn-olr_dmn; % positive for clouds warming
net_cre=toa_R-toa_R_clr; % swdn_toa-olr-swup_toar+olr_clr+swup_toa_clr;

%blahface=glb_mon_mn_ts(lwdn_sfc,60);

% compute time series of fluxes
% check the values of the indices used to read in the data: sind, eind
% these are defined in open_radflux_m2009.m
length=eind-sind+1;
switch comp_ts
  case 'getts'
  lwup_toa_ts=glb_mon_mn_ts(olr,length);
  lwup_clr_toa_ts=glb_mon_mn_ts(olr_clr,length);
  swdn_toa_ts=glb_mon_mn_ts(swdn_toa,length);
  swup_toa_ts=glb_mon_mn_ts(swup_toa,length);
  swup_clr_toa_ts=glb_mon_mn_ts(swup_toa_clr,length);
  
  lwdn_sfc_ts=glb_mon_mn_ts(lwdn_sfc,length);
  swdn_sfc_ts=glb_mon_mn_ts(swdn_sfc,length);
  lwup_sfc_ts=glb_mon_mn_ts(lwup_sfc,length);
  swup_sfc_ts=glb_mon_mn_ts(swup_sfc,length);
  shflx_sfc_ts=glb_mon_mn_ts(shflx,length);
  evap_ts=glb_mon_mn_ts(evap,length);
  lhflux_sfc_ts=lat_evap.*evap_ts;

  % compute budget time series
  toa_R_ts=swdn_toa_ts-swup_toa_ts-lwup_toa_ts;
  sfc_R_ts=-lhflux_sfc_ts-shflx_sfc_ts+lwdn_sfc_ts-lwup_sfc_ts+swdn_sfc_ts-swup_sfc_ts;
  atm_imb_ts=toa_R_ts-sfc_R_ts;
end

