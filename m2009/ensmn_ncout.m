%---------------------------------------------------------------------------------
% write output to netcdf file
% ultimate goal:                1 netcdf file with desired ts data for each ens mn
%                               1 netcdf file with desired trends for each ens mn
%                               total of 6 or 9 files files
%
%  the following variables are written to the netcdf output files: 
% temp_sfc_out
% temp700_out 
% omega500_out
% lcloud_out 
% hcloud_out
% eis_out   
% lts_out  
% 
% lw_clr_out
% lw_out   
% lw_cre_out    
% sw_clr_out   
% sw_out      
% sw_cre_out 
% net_rflux_out 
% net_clr_rflux_out
% net_cre_out     
%
% the trends have yet to be computed and written out
%
% levi silvers                                  may 2017
%---------------------------------------------------------------------------------

% first we need to get the ensemble mean time series

pathbase='/net2/Levi.Silvers/data/amip_long/';
timest=1;
timeend=1620;

nmonths=360; % 30 years
timearray=1:nmonths;
%
%
perend=1620; % for late period
%perend=1008; % for early period 
perst=perend-nmonths+1;
%
%%-------------------------------------------------------------------------------------
%% am2
%%-------------------------------------------------------------------------------------
%%timeend=1380;
%modtitle='am2';
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A1/';
%years2='atmos.187001-200412'; % 1620 months
%level700=4; % for AM2, level700=5; for AM3, and AM4
%level500=6; % for AM2
%
%eis_gmn_array=zeros(nmonths,6);
%lts_gmn_array=zeros(nmonths,6);
%
%eis_array=zeros(nmonths,nlat,nlon,6);
%lts_array=zeros(nmonths,nlat,nlon,6);
%omega500_array=zeros(nmonths,nlat,nlon,6);
%temp700_array=zeros(nmonths,nlat,nlon,6);
%temp_sfc_array=zeros(nmonths,nlat,nlon,6);
%lcloud_array=zeros(nmonths,nlat,nlon,6);
%hcloud_array=zeros(nmonths,nlat,nlon,6);
%
%toa_net_rflux_array=zeros(nmonths,nlat,nlon,6);
%toa_net_clr_rflux_array=zeros(nmonths,nlat,nlon,6);
%toa_net_cre_array=zeros(nmonths,nlat,nlon,6);
%toa_sw_array=zeros(nmonths,nlat,nlon,6);
%toa_swdn_array=zeros(nmonths,nlat,nlon,6);
%toa_sw_clr_array=zeros(nmonths,nlat,nlon,6);
%toa_sw_cre_array=zeros(nmonths,nlat,nlon,6);
%toa_lw_array=zeros(nmonths,nlat,nlon,6);
%toa_lw_clr_array=zeros(nmonths,nlat,nlon,6);
%toa_lw_cre_array=zeros(nmonths,nlat,nlon,6);
%
%% beginning of work with first ens member
%%---------------------------------------------------------------------------------
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,1)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,1)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,1)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,1)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,1)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,1)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,1)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,1)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,1)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,1)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,1)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,1)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%% all of these are pos downward... positive net_rflux indicates system is gaining en.
%toa_net_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,1)=-toa_net_clr_rflux_array(:,:,:,1)+toa_net_rflux_array(:,:,:,1);
%
%echo=' done with first ensemble member'
%%---------------------------------------------------------------------------------
%
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A2/'; 
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,2)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,2)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,2)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,2)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,2)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,2)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,2)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,2)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,2)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,2)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,2)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,2)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,2)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,2)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,2)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,2)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,2)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,2)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,2)=-toa_net_clr_rflux_array(:,:,:,2)+toa_net_rflux_array(:,:,:,2);
%
%echo=' done with second ensemble member'
%%---------------------------------------------------------------------------------
%
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A3/'; 
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,3)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,3)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,3)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,3)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,3)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,3)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,3)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,3)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,3)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,3)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,3)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,3)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,3)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,3)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,3)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,3)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,3)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,3)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,3)=-toa_net_clr_rflux_array(:,:,:,3)+toa_net_rflux_array(:,:,:,3);
%
%echo=' done with third ensemble member'
%%---------------------------------------------------------------------------------
%
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A4/'; 
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,4)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,4)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,4)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,4)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,4)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,4)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,4)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,4)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,4)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,4)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,4)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,4)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,4)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,4)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,4)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,4)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,4)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,4)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,4)=-toa_net_clr_rflux_array(:,:,:,4)+toa_net_rflux_array(:,:,:,4);
%
%echo=' done with fourth am2 ensemble member'
%%---------------------------------------------------------------------------------
%
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A5/'; 
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,5)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,5)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,5)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,5)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,5)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,5)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,5)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,5)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,5)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,5)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,5)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,5)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,5)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,5)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,5)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,5)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,5)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,5)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,5)=-toa_net_clr_rflux_array(:,:,:,5)+toa_net_rflux_array(:,:,:,5);
%
%echo=' done with fifth am2 ensemble member'
%%---------------------------------------------------------------------------------
%
%% compute ensemble mean arrays
%temp_sfc_ensmn =mean(temp_sfc_array,4);
%temp700_ensmn  =mean(temp700_array,4);
%omega500_ensmn =mean(omega500_array,4);
%lcloud_ensmn   =mean(lcloud_array,4);
%hcloud_ensmn   =mean(hcloud_array,4);
%eis_ensmn      =mean(eis_array,4);
%lts_ensmn      =mean(lts_array,4);
%
%toa_lw_clr_ensmn        =mean(toa_lw_clr_array,4);
%toa_lw_ensmn            =mean(toa_lw_array,4);
%toa_lw_cre_ensmn        =mean(toa_lw_cre_array,4);
%toa_sw_clr_ensmn        =mean(toa_sw_clr_array,4);
%toa_sw_ensmn            =mean(toa_sw_array,4);
%toa_sw_cre_ensmn        =mean(toa_sw_cre_array,4);
%toa_net_rflux_ensmn     =mean(toa_net_rflux_array,4);
%toa_net_clr_rflux_ensmn =mean(toa_net_clr_rflux_array,4);
%toa_net_cre_ensmn       =mean(toa_net_cre_array,4);
%
%% variables to write to netcdf (this will usually be the ensmn values...)
%
%temp_sfc_out      =temp_sfc_ensmn;
%temp700_out       =temp700_ensmn;
%omega500_out      =omega500_ensmn;
%lcloud_out        =lcloud_ensmn;
%hcloud_out        =hcloud_ensmn;
%eis_out           =eis_ensmn;
%lts_out           =lts_ensmn;
%
%lw_clr_out        =toa_lw_clr_ensmn;
%lw_out            =toa_lw_ensmn;
%lw_cre_out        =toa_lw_cre_ensmn;
%sw_clr_out        =toa_sw_clr_ensmn;
%sw_out            =toa_sw_ensmn;
%sw_cre_out        =toa_sw_cre_ensmn;
%net_rflux_out     =toa_net_rflux_ensmn;
%net_clr_rflux_out =toa_net_clr_rflux_ensmn;
%net_cre_out       =toa_net_cre_ensmn;
%
%%temp_sfc_out      =temp_sfc_array(:,:,:,1);
%%temp700_out       =temp700_array(:,:,:,1);
%%omeg500_out       =omega500_array(:,:,:,1);
%%lcloud_out        =lcloud_array(:,:,:,1);
%%hcloud_out        =hcloud_array(:,:,:,1);
%%eis_out           =eis_array(:,:,:,1);
%%lts_out           =lts_array(:,:,:,1);
%%
%%lw_clr_out        =toa_lw_clr_array(:,:,:,1);
%%lw_out            =toa_lw_array(:,:,:,1);
%%lw_cre_out        =toa_lw_cre_array(:,:,:,1);
%%sw_clr_out        =toa_sw_clr_array(:,:,:,1);
%%sw_out            =toa_sw_array(:,:,:,1);
%%sw_cre_out        =toa_sw_cre_array(:,:,:,1);
%%net_rflux_out     =toa_net_rflux_array(:,:,:,1);
%%net_clr_rflux_out =toa_net_clr_rflux_array(:,:,:,1);
%%net_cre_out       =toa_net_cre_array(:,:,:,1);
%
%%% write out variables to netcdf file
%echo=' writing out netcdf file for am2'
%file_out='am2_ensmn_tref_late_crediff.nc';
%ensmn_write_ncout
%%
%file_out='am2_trends_tref_late_crediff.nc';
%compute_write_trends
%trends_write_ncout
%
%%---------------------------------------------------------------------------------
%% done with AM2
%%---------------------------------------------------------------------------------
%
%%---------------------------------------------------------------------------------
%
%timest=13;
%timeend=1620;
%modtitle='am3';
%path='/AM3/c48L48_am3p9_1860_ext/';
%years2='atmos.187001-200512'; 
level700=5; % for AM3, and AM4
level500=7; % for AM3, and AM4
%
%readvars
%
%%---------------------------------------------------------------------------------
%% we only have 5 ensemble members for AM3
%eis_gmn_array=zeros(nmonths,5);
%lts_gmn_array=zeros(nmonths,5);
%
%eis_array=zeros(nmonths,nlat,nlon,5);
%lts_array=zeros(nmonths,nlat,nlon,5);
%omega500_array=zeros(nmonths,nlat,nlon,5);
%temp700_array=zeros(nmonths,nlat,nlon,5);
%temp_sfc_array=zeros(nmonths,nlat,nlon,5);
%temp_sfc_array_am3=zeros(nmonths,nlat,nlon,5);
%lcloud_array=zeros(nmonths,nlat,nlon,5);
%hcloud_array=zeros(nmonths,nlat,nlon,5);
%
%toa_net_rflux_array=zeros(nmonths,nlat,nlon,5);
%toa_net_clr_rflux_array=zeros(nmonths,nlat,nlon,5);
%toa_net_cre_array=zeros(nmonths,nlat,nlon,5);
%toa_sw_array=zeros(nmonths,nlat,nlon,5);
%toa_swdn_array=zeros(nmonths,nlat,nlon,5);
%toa_sw_clr_array=zeros(nmonths,nlat,nlon,5);
%toa_sw_cre_array=zeros(nmonths,nlat,nlon,5);
%toa_lw_array=zeros(nmonths,nlat,nlon,5);
%toa_lw_clr_array=zeros(nmonths,nlat,nlon,5);
%toa_lw_cre_array=zeros(nmonths,nlat,nlon,5);
%
%%---------------------------------------------------------------------------------
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,1)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,1)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,1)=temp_sfc_ts(perst:perend,:,:);
%temp_sfc_array_am3(:,:,:,1)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,1)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,1)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,1)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,1)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,1)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,1)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,1)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,1)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,1)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,1)=-toa_net_clr_rflux_array(:,:,:,1)+toa_net_rflux_array(:,:,:,1);
%
%echo=' done with first am3 ensemble member'
%%---------------------------------------------------------------------------------
%path='/AM3/c48L48_am3p9_1860_ext2/';
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,2)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,2)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,2)=temp_sfc_ts(perst:perend,:,:);
%temp_sfc_array_am3(:,:,:,2)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,2)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,2)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,2)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,2)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,2)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,2)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,2)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,2)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,2)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,2)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,2)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,2)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,2)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,2)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,2)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,2)=-toa_net_clr_rflux_array(:,:,:,2)+toa_net_rflux_array(:,:,:,2);
%
%echo=' done with second am3 ensemble member'
%%---------------------------------------------------------------------------------
%path='/AM3/c48L48_am3p9_1860_ext3/';
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,3)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,3)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,3)=temp_sfc_ts(perst:perend,:,:);
%temp_sfc_array_am3(:,:,:,3)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,3)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,3)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,3)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,3)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,3)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,3)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,3)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,3)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,3)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,3)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,3)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,3)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,3)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,3)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,3)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,3)=-toa_net_clr_rflux_array(:,:,:,3)+toa_net_rflux_array(:,:,:,3);
%
%echo=' done with third am3 ensemble member'
%%---------------------------------------------------------------------------------
%path='/AM3/c48L48_am3p9_1860_ext2a/';
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,4)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,4)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,4)=temp_sfc_ts(perst:perend,:,:);
%temp_sfc_array_am3(:,:,:,4)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,4)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,4)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,4)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,4)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,4)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,4)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,4)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,4)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,4)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,4)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,4)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,4)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,4)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,4)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,4)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,4)=-toa_net_clr_rflux_array(:,:,:,4)+toa_net_rflux_array(:,:,:,4);
%
%echo=' done with fourth am3 ensemble member'
%%---------------------------------------------------------------------------------
%path='/AM3/c48L48_am3p9_1860_ext5/';
%readvars
%
%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,5)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,5)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,5)=temp_sfc_ts(perst:perend,:,:);
%temp_sfc_array_am3(:,:,:,5)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,5)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,5)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,5)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,5)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,5)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,5)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,5)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,5)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,5)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,5)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,5)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,5)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,5)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,5)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,5)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,5)=-toa_net_clr_rflux_array(:,:,:,5)+toa_net_rflux_array(:,:,:,5);
%
%echo=' done with fifth am3 ensemble member'
%%---------------------------------------------------------------------------------
%% compute ensemble mean arrays
%temp_sfc_ensmn =mean(temp_sfc_array,4);
%temp_sfc_ensmn_am3 = mean(temp_sfc_array_am3,4);
%temp700_ensmn  =mean(temp700_array,4);
%omega500_ensmn =mean(omega500_array,4);
%lcloud_ensmn   =mean(lcloud_array,4);
%hcloud_ensmn   =mean(hcloud_array,4);
%eis_ensmn      =mean(eis_array,4);
%lts_ensmn      =mean(lts_array,4);
%
%toa_lw_clr_ensmn        =mean(toa_lw_clr_array,4);
%toa_lw_ensmn            =mean(toa_lw_array,4);
%toa_lw_cre_ensmn        =mean(toa_lw_cre_array,4);
%toa_sw_clr_ensmn        =mean(toa_sw_clr_array,4);
%toa_sw_ensmn            =mean(toa_sw_array,4);
%toa_sw_cre_ensmn        =mean(toa_sw_cre_array,4);
%toa_net_rflux_ensmn     =mean(toa_net_rflux_array,4);
%toa_net_clr_rflux_ensmn =mean(toa_net_clr_rflux_array,4);
%toa_net_cre_ensmn       =mean(toa_net_cre_array,4);
%
%% variables to write to netcdf (this will usually be the ensmn values...)
%
%temp_sfc_out      =temp_sfc_ensmn;
%temp700_out       =temp700_ensmn;
%omega500_out       =omega500_ensmn;
%lcloud_out        =lcloud_ensmn;
%hcloud_out        =hcloud_ensmn;
%eis_out           =eis_ensmn;
%lts_out           =lts_ensmn;
%
%lw_clr_out        =toa_lw_clr_ensmn;
%lw_out            =toa_lw_ensmn;
%lw_cre_out        =toa_lw_cre_ensmn;
%sw_clr_out        =toa_sw_clr_ensmn;
%sw_out            =toa_sw_ensmn;
%sw_cre_out        =toa_sw_cre_ensmn;
%net_rflux_out     =toa_net_rflux_ensmn;
%net_clr_rflux_out =toa_net_clr_rflux_ensmn;
%net_cre_out       =toa_net_cre_ensmn;
%
%%% write out variables to netcdf file
%%echo=' writing out netcdf file for am3 '
%%
%file_out='am3_ensmn_tref_late_crediff.nc';
%ensmn_write_ncout
%%
%file_out='am3_trends_tref_late_crediff.nc';
%compute_write_trends
%trends_write_ncout
%%---------------------------------------------------------------------------------
%% done with AM3
%%---------------------------------------------------------------------------------

%---------------------------------------------------------------------------------
%---------------------------------------------------------------------------------
timest=1;
timeend=1620;
modtitle='am4';
%path='/c96L32_am4g10r8_longamip_1860rad/';
%years2='atmos.187101-201512';

path='/c96L33_am4p0_longamip_1850rad/ts_all/';
years2='atmos.187001-201412';

readvars

% we only have 1 ensemble members for AM4
eis_gmn_array=zeros(nmonths,4);
lts_gmn_array=zeros(nmonths,4);

eis_array=zeros(nmonths,nlat,nlon,4);
lts_array=zeros(nmonths,nlat,nlon,4);
omega500_array=zeros(nmonths,nlat,nlon,4);
temp700_array=zeros(nmonths,nlat,nlon,4);
temp_sfc_array=zeros(nmonths,nlat,nlon,4);
lcloud_array=zeros(nmonths,nlat,nlon,4);
hcloud_array=zeros(nmonths,nlat,nlon,4);

toa_net_rflux_array=zeros(nmonths,nlat,nlon,4);
toa_net_clr_rflux_array=zeros(nmonths,nlat,nlon,4);
toa_net_cre_array=zeros(nmonths,nlat,nlon,4);
toa_sw_array=zeros(nmonths,nlat,nlon,4);
toa_swdn_array=zeros(nmonths,nlat,nlon,4);
toa_sw_clr_array=zeros(nmonths,nlat,nlon,4);
toa_sw_cre_array=zeros(nmonths,nlat,nlon,4);
toa_lw_array=zeros(nmonths,nlat,nlon,4);
toa_lw_clr_array=zeros(nmonths,nlat,nlon,4);
toa_lw_cre_array=zeros(nmonths,nlat,nlon,4);

%---------------------------------------------------------------------------------
omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
omega500_array(:,:,:,1)=omega500_ens;
temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
temp700_array(:,:,:,1)=temp700_ens;
%temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,1)=temp_sfc_ts(perst:perend,:,:);
%lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,1)=lcloud_ts(perst:perend,:,:);
%hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,1)=hcloud_ts(perst:perend,:,:);

% compute the eis and lts time series:
eis_lts_ts % uses global_eis.m to compute eis

eis_array(:,:,:,1)=eis_ts(perst:perend,:,:);
lts_array(:,:,:,1)=lts_ts(perst:perend,:,:);
eis_gmn_array(:,1)=eis_gmn_ts(perst:perend,:,:);
lts_gmn_array(:,1)=lts_gmn_ts(perst:perend,:,:);

% radiative fluxes...
toa_lw_clr_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:);
toa_lw_array(:,:,:,1)=olr_ts(perst:perend,:,:);
toa_lw_cre_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);

toa_sw_array(:,:,:,1)=swup_ts(perst:perend,:,:);
toa_swdn_array(:,:,:,1)=swdn_ts(perst:perend,:,:);
toa_sw_clr_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:);
toa_sw_cre_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);

toa_net_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
toa_net_clr_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
toa_net_cre_array(:,:,:,1)=-toa_net_clr_rflux_array(:,:,:,1)+toa_net_rflux_array(:,:,:,1);
%---------------------------------------------------------------------------------
echo=' done with first am4 ensemble member'
%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_ens1/ts_all/';
readvars

omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
omega500_array(:,:,:,2)=omega500_ens;
temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
temp700_array(:,:,:,2)=temp700_ens;
%temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,2)=temp_sfc_ts(perst:perend,:,:);
%lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,2)=lcloud_ts(perst:perend,:,:);
%hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,2)=hcloud_ts(perst:perend,:,:);

% compute the eis and lts time series:
eis_lts_ts % uses global_eis.m to compute eis

eis_array(:,:,:,2)=eis_ts(perst:perend,:,:);
lts_array(:,:,:,2)=lts_ts(perst:perend,:,:);
eis_gmn_array(:,2)=eis_gmn_ts(perst:perend,:,:);
lts_gmn_array(:,2)=lts_gmn_ts(perst:perend,:,:);

% radiative fluxes...
toa_lw_clr_array(:,:,:,2)=olr_clr_ts(perst:perend,:,:);
toa_lw_array(:,:,:,2)=olr_ts(perst:perend,:,:);
toa_lw_cre_array(:,:,:,2)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);

toa_sw_array(:,:,:,2)=swup_ts(perst:perend,:,:);
toa_swdn_array(:,:,:,2)=swdn_ts(perst:perend,:,:);
toa_sw_clr_array(:,:,:,2)=swup_clr_ts(perst:perend,:,:);
toa_sw_cre_array(:,:,:,2)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);

toa_net_rflux_array(:,:,:,2)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
toa_net_clr_rflux_array(:,:,:,2)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
toa_net_cre_array(:,:,:,2)=-toa_net_clr_rflux_array(:,:,:,2)+toa_net_rflux_array(:,:,:,2);


echo=' done with second am4 ensemble member'
%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_ens3/ts_all/';
readvars

omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
omega500_array(:,:,:,3)=omega500_ens;
temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
temp700_array(:,:,:,3)=temp700_ens;
%temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,3)=temp_sfc_ts(perst:perend,:,:);
%lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,3)=lcloud_ts(perst:perend,:,:);
%hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,3)=hcloud_ts(perst:perend,:,:);

% compute the eis and lts time series:
eis_lts_ts % uses global_eis.m to compute eis

eis_array(:,:,:,3)=eis_ts(perst:perend,:,:);
lts_array(:,:,:,3)=lts_ts(perst:perend,:,:);
eis_gmn_array(:,3)=eis_gmn_ts(perst:perend,:,:);
lts_gmn_array(:,3)=lts_gmn_ts(perst:perend,:,:);

% radiative fluxes...
toa_lw_clr_array(:,:,:,3)=olr_clr_ts(perst:perend,:,:);
toa_lw_array(:,:,:,3)=olr_ts(perst:perend,:,:);
toa_lw_cre_array(:,:,:,3)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);

toa_sw_array(:,:,:,3)=swup_ts(perst:perend,:,:);
toa_swdn_array(:,:,:,3)=swdn_ts(perst:perend,:,:);
toa_sw_clr_array(:,:,:,3)=swup_clr_ts(perst:perend,:,:);
toa_sw_cre_array(:,:,:,3)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);

toa_net_rflux_array(:,:,:,3)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
toa_net_clr_rflux_array(:,:,:,3)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
toa_net_cre_array(:,:,:,3)=-toa_net_clr_rflux_array(:,:,:,3)+toa_net_rflux_array(:,:,:,3);

echo=' done with third am4 ensemble member'

%---------------------------------------------------------------------------------
path='/c96L33_am4p0_longamip_1850rad_ens4/ts_all/';
readvars

omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
omega500_array(:,:,:,4)=omega500_ens;
temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
temp700_array(:,:,:,4)=temp700_ens;
%temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,4)=temp_sfc_ts(perst:perend,:,:);
%lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,4)=lcloud_ts(perst:perend,:,:);
%hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,4)=hcloud_ts(perst:perend,:,:);

% compute the eis and lts time series:
eis_lts_ts % uses global_eis.m to compute eis

eis_array(:,:,:,4)=eis_ts(perst:perend,:,:);
lts_array(:,:,:,4)=lts_ts(perst:perend,:,:);
eis_gmn_array(:,4)=eis_gmn_ts(perst:perend,:,:);
lts_gmn_array(:,4)=lts_gmn_ts(perst:perend,:,:);

% radiative fluxes...
toa_lw_clr_array(:,:,:,4)=olr_clr_ts(perst:perend,:,:);
toa_lw_array(:,:,:,4)=olr_ts(perst:perend,:,:);
toa_lw_cre_array(:,:,:,4)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);

toa_sw_array(:,:,:,4)=swup_ts(perst:perend,:,:);
toa_swdn_array(:,:,:,4)=swdn_ts(perst:perend,:,:);
toa_sw_clr_array(:,:,:,4)=swup_clr_ts(perst:perend,:,:);
toa_sw_cre_array(:,:,:,4)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);

toa_net_rflux_array(:,:,:,4)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
toa_net_clr_rflux_array(:,:,:,4)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
toa_net_cre_array(:,:,:,4)=-toa_net_clr_rflux_array(:,:,:,4)+toa_net_rflux_array(:,:,:,4);

echo=' done with fourth am4 ensemble member'

%---------------------------------------------------------------------------------
%---------------------------------------------------------------------------------

%omega500_ens=squeeze(omega_ts(perst:perend,level500,:,:));
%omega500_array(:,:,:,1)=omega500_ens;
%temp700_ens=squeeze(temp3d(perst:perend,level700,:,:));
%temp700_array(:,:,:,1)=temp700_ens;
%%temp_sfc_ens=temp_sfc_ts;
%temp_sfc_array(:,:,:,1)=temp_sfc_ts(perst:perend,:,:);
%%lcloud_ens=lcloud_ts;
%lcloud_array(:,:,:,1)=lcloud_ts(perst:perend,:,:);
%%hcloud_ens=hcloud_ts;
%hcloud_array(:,:,:,1)=hcloud_ts(perst:perend,:,:);
%
%% compute the eis and lts time series:
%eis_lts_ts % uses global_eis.m to compute eis
%
%eis_array(:,:,:,1)=eis_ts(perst:perend,:,:);
%lts_array(:,:,:,1)=lts_ts(perst:perend,:,:);
%eis_gmn_array(:,1)=eis_gmn_ts(perst:perend,:,:);
%lts_gmn_array(:,1)=lts_gmn_ts(perst:perend,:,:);
%
%% radiative fluxes...
%toa_lw_clr_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:);
%toa_lw_array(:,:,:,1)=olr_ts(perst:perend,:,:);
%toa_lw_cre_array(:,:,:,1)=olr_clr_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%
%toa_sw_array(:,:,:,1)=swup_ts(perst:perend,:,:);
%toa_swdn_array(:,:,:,1)=swdn_ts(perst:perend,:,:);
%toa_sw_clr_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:);
%toa_sw_cre_array(:,:,:,1)=swup_clr_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:);
%
%toa_net_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_ts(perst:perend,:,:)-olr_ts(perst:perend,:,:);
%toa_net_clr_rflux_array(:,:,:,1)=swdn_ts(perst:perend,:,:)-swup_clr_ts(perst:perend,:,:)-olr_clr_ts(perst:perend,:,:);
%toa_net_cre_array(:,:,:,1)=-toa_net_clr_rflux_array(:,:,:,1)+toa_net_rflux_array(:,:,:,1);
%
%echo=' finished with first ensemble member for am4 '
%
%---------------------------------------------------------------------------------
% compute ensemble mean values 
temp_sfc_ensmn =mean(temp_sfc_array,4);
temp700_ensmn  =mean(temp700_array,4);
omega500_ensmn =mean(omega500_array,4);
lcloud_ensmn   =mean(lcloud_array,4);
hcloud_ensmn   =mean(hcloud_array,4);
eis_ensmn      =mean(eis_array,4);
lts_ensmn      =mean(lts_array,4);

toa_lw_clr_ensmn        =mean(toa_lw_clr_array,4);
toa_lw_ensmn            =mean(toa_lw_array,4);
toa_lw_cre_ensmn        =mean(toa_lw_cre_array,4);
toa_sw_clr_ensmn        =mean(toa_sw_clr_array,4);
toa_sw_ensmn            =mean(toa_sw_array,4);
toa_sw_cre_ensmn        =mean(toa_sw_cre_array,4);
toa_net_rflux_ensmn     =mean(toa_net_rflux_array,4);
toa_net_clr_rflux_ensmn =mean(toa_net_clr_rflux_array,4);
toa_net_cre_ensmn       =mean(toa_net_cre_array,4);

%temp_sfc_out      =temp_sfc_array(:,:,:,1);
%temp700_out       =temp700_array(:,:,:,1);
%omeg500_out       =omega500_array(:,:,:,1);
%lcloud_out        =lcloud_array(:,:,:,1);
%hcloud_out        =hcloud_array(:,:,:,1);
%eis_out           =eis_array(:,:,:,1);
%lts_out           =lts_array(:,:,:,1);
%
%lw_clr_out        =toa_lw_clr_array(:,:,:,1);
%lw_out            =toa_lw_array(:,:,:,1);
%lw_cre_out        =toa_lw_cre_array(:,:,:,1);
%sw_clr_out        =toa_sw_clr_array(:,:,:,1);
%sw_out            =toa_sw_array(:,:,:,1);
%sw_cre_out        =toa_sw_cre_array(:,:,:,1);
%net_rflux_out     =toa_net_rflux_array(:,:,:,1);
%net_clr_rflux_out =toa_net_clr_rflux_array(:,:,:,1);
%net_cre_out       =toa_net_cre_array(:,:,:,1);

% variables to write to netcdf (this will usually be the ensmn values...)

temp_sfc_out      =temp_sfc_ensmn;
temp700_out       =temp700_ensmn;
omega500_out       =omega500_ensmn;
lcloud_out        =lcloud_ensmn;
hcloud_out        =hcloud_ensmn;
eis_out           =eis_ensmn;
lts_out           =lts_ensmn;

lw_clr_out        =toa_lw_clr_ensmn;
lw_out            =toa_lw_ensmn;
lw_cre_out        =toa_lw_cre_ensmn;
sw_clr_out        =toa_sw_clr_ensmn;
sw_out            =toa_sw_ensmn;
sw_cre_out        =toa_sw_cre_ensmn;
net_rflux_out     =toa_net_rflux_ensmn;
net_clr_rflux_out =toa_net_clr_rflux_ensmn;
net_cre_out       =toa_net_cre_ensmn;

% write out variables to netcdf file
echo=' writing out netcdf file for am4 '

file_out='am4_ensmn_tref_early_crediff.nc';
ensmn_write_ncout

file_out='am4_trends_tref_early_crediff.nc';
compute_write_trends
trends_write_ncout
%---------------------------------------------------------------------------------
% done with AM4
%---------------------------------------------------------------------------------

% compute the net fluxes
%cre_trend=sw_cre_trend+lw_cre_trend;
%toa_clr_trend=sw_clr_trend+lw_clr_trend;
%toa_trend=toa_clr_trend-cre_trend;

%% next we use the ensemble mean time series to compute ens trends
%
%% lw_clr 
%%vartotrend=v.olr_toa_clr;
%vartotrend=olr_toa_clr_ensmn;
%reg_trend
%lw_clr_trend=regtrend_var_oo;
%
%% lw_cre 
%%lw_crecre=v.olr_toa_clr-v.olr_toa;
%lw_cre_ensmn=olr_toa_clr_ensmn-olr_toa_ensmn;
%vartotrend=lw_cre_ensmn;
%reg_trend
%lw_cre_trend=regtrend_var_oo;
