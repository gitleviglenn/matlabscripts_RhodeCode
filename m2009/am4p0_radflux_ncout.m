%---------------------------------------------------------------------------------
% write output to netcdf file
% ultimate goal:                1 netcdf file with desired ts data for each ens mn
%
% The creation of the desired netcdf file requires 3 scripts:
% readvars_radlux.m
% am4p0_radflux_ncout.m
% am4p0_5ens_gmn_write_ncout
%
% the following variables are written to the netcdf output files: 
%
% lw_out   
% lw_cre_out    
% sw_clr_out   
% sw_out      
% sw_cre_out 
% net_rflux_out 
% net_clr_rflux_out
% net_cre_out     
%
%
% levi silvers                                  june 2017
%---------------------------------------------------------------------------------

tperiod='18702015';
temptype='tsfc';

% first we need to get the ensemble mean time series

pathbase='/net2/Levi.Silvers/data/amip_long/';
timest=1;  % timest and timeend are used in readvars_radflux
timeend=1740;

nmonths=1740;
timearray=1:nmonths;
%
%
%%%-------------------------------------------------------------------------------------
level700=5; % for AM3, and AM4
level500=7; % for AM3, and AM4
%
%---------------------------------------------------------------------------------
modtitle='am4';

path='/c96L33_am4p0_longamip_1850rad/ts_all/';
years2='atmos.187001-201412';

readvars_radflux

%---------------------------------------------------------------------------------

%% radiative fluxes...   should all be positive downwards

tref_ens1=tref_ts;
toa_lw_clr_ens1=olr_clr_ts;
toa_lw_ens1=olr_ts;
toa_sw_clr_ens1=swup_clr_ts;
toa_sw_ens1=swup_ts;
toa_swdn_ens1=swdn_ts;
toa_net_rflux_ens1=swdn_ts+swup_ts+olr_clr_ts;

for ti=1:timeend;
  fullfield=squeeze(toa_lw_clr_ens1(ti,:,:));
  global_wmean_script;
  toa_lw_clr_gmn_ens1(ti)=wgt_mean;
  fullfield=squeeze(toa_lw_ens1(ti,:,:));
  global_wmean_script;
  toa_lw_gmn_ens1(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_clr_ens1(ti,:,:));
  global_wmean_script;
  toa_sw_clr_gmn_ens1(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_ens1(ti,:,:));
  global_wmean_script;
  toa_sw_gmn_ens1(ti)=wgt_mean;
  fullfield=squeeze(toa_swdn_ens1(ti,:,:));
  global_wmean_script;
  toa_swdn_gmn_ens1(ti)=wgt_mean;
  fullfield=squeeze(toa_net_rflux_ens1(ti,:,:));
  global_wmean_script;
  toa_net_rflux_gmn_ens1(ti)=wgt_mean;
  fullfield=squeeze(tref_ens1(ti,:,:));
  global_wmean_script;
  tref_gmn_ens1(ti)=wgt_mean;
end

%---------------------------------------------------------------------------------
echo=' done with first am4 ensemble member'
%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_ens1/ts_all/';
readvars_radflux

%% radiative fluxes...

tref_ens2=tref_ts;
toa_lw_clr_ens2=olr_clr_ts;
toa_lw_ens2=olr_ts;
toa_sw_clr_ens2=swup_clr_ts;
toa_sw_ens2=swup_ts;
toa_swdn_ens2=swdn_ts;
toa_net_rflux_ens2=swdn_ts+swup_ts+olr_clr_ts;

for ti=1:timeend;
  fullfield=squeeze(toa_lw_clr_ens2(ti,:,:));
  global_wmean_script;
  toa_lw_clr_gmn_ens2(ti)=wgt_mean;
  fullfield=squeeze(toa_lw_ens2(ti,:,:));
  global_wmean_script;
  toa_lw_gmn_ens2(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_clr_ens2(ti,:,:));
  global_wmean_script;
  toa_sw_clr_gmn_ens2(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_ens2(ti,:,:));
  global_wmean_script;
  toa_sw_gmn_ens2(ti)=wgt_mean;
  fullfield=squeeze(toa_swdn_ens2(ti,:,:));
  global_wmean_script;
  toa_swdn_gmn_ens2(ti)=wgt_mean;
  fullfield=squeeze(toa_net_rflux_ens2(ti,:,:));
  global_wmean_script;
  toa_net_rflux_gmn_ens2(ti)=wgt_mean;
  fullfield=squeeze(tref_ens2(ti,:,:));
  global_wmean_script;
  tref_gmn_ens2(ti)=wgt_mean;
end

echo=' done with second am4 ensemble member'
%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_ens3/ts_all/';
readvars_radflux

%% radiative fluxes...

tref_ens3=tref_ts;
toa_lw_clr_ens3=olr_clr_ts;
toa_lw_ens3=olr_ts;
toa_sw_clr_ens3=swup_clr_ts;
toa_sw_ens3=swup_ts;
toa_swdn_ens3=swdn_ts;
toa_net_rflux_ens3=swdn_ts+swup_ts+olr_clr_ts;

for ti=1:timeend;
  fullfield=squeeze(toa_lw_clr_ens3(ti,:,:));
  global_wmean_script;
  toa_lw_clr_gmn_ens3(ti)=wgt_mean;
  fullfield=squeeze(toa_lw_ens3(ti,:,:));
  global_wmean_script;
  toa_lw_gmn_ens3(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_clr_ens3(ti,:,:));
  global_wmean_script;
  toa_sw_clr_gmn_ens3(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_ens3(ti,:,:));
  global_wmean_script;
  toa_sw_gmn_ens3(ti)=wgt_mean;
  fullfield=squeeze(toa_swdn_ens3(ti,:,:));
  global_wmean_script;
  toa_swdn_gmn_ens3(ti)=wgt_mean;
  fullfield=squeeze(toa_net_rflux_ens3(ti,:,:));
  global_wmean_script;
  toa_net_rflux_gmn_ens3(ti)=wgt_mean;
  fullfield=squeeze(tref_ens3(ti,:,:));
  global_wmean_script;
  tref_gmn_ens3(ti)=wgt_mean;
end

echo=' done with third am4 ensemble member'

%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_ens4/ts_all/';
readvars_radflux

%% radiative fluxes...

tref_ens4=tref_ts;
toa_lw_clr_ens4=olr_clr_ts;
toa_lw_ens4=olr_ts;
toa_sw_clr_ens4=swup_clr_ts;
toa_sw_ens4=swup_ts;
toa_swdn_ens4=swdn_ts;
toa_net_rflux_ens4=swdn_ts+swup_ts+olr_clr_ts;

for ti=1:timeend;
  fullfield=squeeze(toa_lw_clr_ens4(ti,:,:));
  global_wmean_script;
  toa_lw_clr_gmn_ens4(ti)=wgt_mean;
  fullfield=squeeze(toa_lw_ens4(ti,:,:));
  global_wmean_script;
  toa_lw_gmn_ens4(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_clr_ens4(ti,:,:));
  global_wmean_script;
  toa_sw_clr_gmn_ens4(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_ens4(ti,:,:));
  global_wmean_script;
  toa_sw_gmn_ens4(ti)=wgt_mean;
  fullfield=squeeze(toa_swdn_ens4(ti,:,:));
  global_wmean_script;
  toa_swdn_gmn_ens4(ti)=wgt_mean;
  fullfield=squeeze(toa_net_rflux_ens4(ti,:,:));
  global_wmean_script;
  toa_net_rflux_gmn_ens4(ti)=wgt_mean;
  fullfield=squeeze(tref_ens4(ti,:,:));
  global_wmean_script;
  tref_gmn_ens4(ti)=wgt_mean;
end

echo=' done with fourth am4 ensemble member'

%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_c4_ens2/ts_all/';
readvars_radflux

%% radiative fluxes...

tref_ens5=tref_ts;
toa_lw_clr_ens5=olr_clr_ts;
toa_lw_ens5=olr_ts;
toa_sw_clr_ens5=swup_clr_ts;
toa_sw_ens5=swup_ts;
toa_swdn_ens5=swdn_ts;
toa_net_rflux_ens5=swdn_ts+swup_ts+olr_clr_ts;

for ti=1:timeend;
  fullfield=squeeze(toa_lw_clr_ens5(ti,:,:));
  global_wmean_script;
  toa_lw_clr_gmn_ens5(ti)=wgt_mean;
  fullfield=squeeze(toa_lw_ens5(ti,:,:));
  global_wmean_script;
  toa_lw_gmn_ens5(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_clr_ens5(ti,:,:));
  global_wmean_script;
  toa_sw_clr_gmn_ens5(ti)=wgt_mean;
  fullfield=squeeze(toa_sw_ens5(ti,:,:));
  global_wmean_script;
  toa_sw_gmn_ens5(ti)=wgt_mean;
  fullfield=squeeze(toa_swdn_ens5(ti,:,:));
  global_wmean_script;
  toa_swdn_gmn_ens5(ti)=wgt_mean;
  fullfield=squeeze(toa_net_rflux_ens5(ti,:,:));
  global_wmean_script;
  toa_net_rflux_gmn_ens5(ti)=wgt_mean;
  fullfield=squeeze(tref_ens5(ti,:,:));
  global_wmean_script;
  tref_gmn_ens5(ti)=wgt_mean;
end

echo=' done with fifth am4 ensemble member'
%---------------------------------------------------------------------------------

% write out the data to a netcdf file
file_out='clobberface.nc'
am4p0_5ens_gmn_write_ncout
