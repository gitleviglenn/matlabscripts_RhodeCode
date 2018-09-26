%---------------------------------------
% toa_rad.m
%
% compute the net radiative flux at toa
%
% levi silvers                sep 2018
%---------------------------------------

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
if (cmip_format=='true')
  open_radflux_m2009 % if using Matlab 2009
else
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



