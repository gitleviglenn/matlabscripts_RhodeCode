%-----------------------------------------------------------------------------------------
%
% test driver to try and systemetize the computation of alpha, cre, and eis/lts 
% for various ensemble members from am2, am3, and am4.  
%
% some minor modifications are necessary to allow the scripts which have been developed in 
% the past 3 months to work for individual ensemble members
%
% calls the following scripts:
% readvars
% alpha_09
% eis_lts_ts
% compute_trends              
% amip_eiscltrends_ncout
% plot_alpha_3mods
%
% to compute radiative flux trends and write them to an netcdf file use a similar method as for compute_trends and amip_eiscltrends_ncout:
% compute_rad_trends.m
% amip_trends_ncout.m
%
% this was written to work with something like readvars.m to read in the data using the 
% 'pathbase' variables.  
%
% march 20, 2017                                                           levi silvers
%-----------------------------------------------------------------------------------------
%
pathbase='/net2/Levi.Silvers/data/amip_long/';

ts_length=360; % length of time series in months over which a trend will be computed
% rstime and rendtime are the starting and ending times for the period to compute the
% trend over.  
%rstime=1; 
%rendtime=360;  
% indices over which trends will be taken
% for early period
rstime=781; 
rendtime=1140;  
% for late period
%rstime=1261; 
%rendtime=1620;  

period='early'

% for AM2 and AM3
% indices over which data will be read from files
%timest=13;
%timeend=1620;
timest=1;
timeend=1620;

% define time array lengths
nyears_alpha=105;
%nyears_alpha=129; % for David P's method...
nmonths=1620;
tendindex=nmonths/12;

% alpha_09 now requires wlat1,wlat2,wlon1, and wlon2 to be defined
% when alpha_09 is called but a speicific window of interest is not defined 
% wlat1,wlat2,wlon1,wlon2 need to be defined:
wlat1=10;
wlat2=20;
wlon1=10;
wlon2=20;

%-----------------------------------------------------------------------------------------
% for AM2
%-----------------------------------------------------------------------------------------
% ens 1
%-----------------------------------------------------------------------------------------
%
% define the path to an ensemble member
%-----------------------------------------------------------------------------------------

modtitle='am2';
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A1/';
years2='atmos.187001-200412'; % 1620 months

%
level700=4; % for AM2, level700=5; for AM3, and AM4
level500=6; % for AM2

% open files and save necessary variables: 
%-----------------------------------------------------------------------------------------
%pathbase='/net2/Levi.Silvers/data/amip_long/';
readvars % openncfile_3mods
%
alpha_array=zeros(nyears_alpha,6);
alpha_cre_array=zeros(nyears_alpha,6);
eis_gmn_array=zeros(nmonths,6);
lts_gmn_array=zeros(nmonths,6);

eis_array=zeros(nmonths,nlat,nlon,6);
lts_array=zeros(nmonths,nlat,nlon,6);
omega500_array=zeros(nmonths,nlat,nlon,6);
temp700_array=zeros(nmonths,nlat,nlon,6);
temp_sfc_array=zeros(nmonths,nlat,nlon,6);
lcloud_array=zeros(nmonths,nlat,nlon,6);
hcloud_array=zeros(nmonths,nlat,nlon,6);
toa_sw_cre_array=zeros(nmonths,nlat,nlon,6);
%-----------------------------------------------------------------------------------------
%% variables on which to compute trends
%% lcloud_ts --> readvars
%% hcloud_ts --> readvars
%% omega_ts  --> readvars
%omega500_ts=squeeze(omega_ts(:,level500,:,:));
%einvs_ts=eis_ens_am2_mn;
%lowtrstab_ts=lts_ens_am2_mn;
%% temp_sfc_ts  --> readvars
%temp700_ts=squeeze(temp3d(:,level700,:,:));
%% lwp_ts --> not dealt with here.. because it wasn't in AM3 ensembles.



%
%temp_ts=v.tref_am2ts;
%olr_ts =v.olr_toa_am2ts;
%olr_clr_ts=v.olr_toa_clr_am2ts;
%swup_clr_ts=v.swup_toa_clr_am2ts;
%swdn_ts=v.swdn_toa_am2ts;
%swup_ts=v.swup_toa_am2ts;
%vlon   =v.lon_am2ts;
%vlat   =v.lat_am2ts;

alpha_09

%alpha_tsam2=alpha_30y;
%alpha_tsam2_cre=alpha_cre_30y;
alpha_array(:,1)=alpha_30y;
alpha_cre_array(:,1)=alpha_cre_30y;
delTs_am2=delTs;
delR_am2=delR;

%% compute time series of eis and lts at every grid point:
%-----------------------------------------------------------------------------------------
%
%% first we need to set am2,am3, or am4 in global_eis_09.m
%% second we need to set am2,am3, or am4 in eis_lts_driver_09
eis_lts_ts

% save output to appropriate local vars:
%eis_am2ts=eis_ts;
eis_gmn_array(:,1)=eis_gmn_ts; %=zeros(1620,6);
eis_array(:,:,:,1)=eis_ts;
%lts_am2ts=lts_ts;
lts_gmn_array(:,1)=lts_gmn_ts; %=zeros(1620,6);
lts_array(:,:,:,1)=lts_ts;
%
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array(:,:,:,1)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array(:,:,:,1)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,1)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,1)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,1)=hcloud_ens;
toa_sw_cre_array(:,:,:,1)=swup_clr_ts-swup_ts; 
%----------------------------------------------------------------------------------------- 
% ens 2 
%-----------------------------------------------------------------------------------------
'beginning work on ens 2'
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A2/';
readvars % openncfile_3mods
alpha_09
alpha_array(:,2)=alpha_30y;
alpha_cre_array(:,2)=alpha_cre_30y;
eis_lts_ts
eis_gmn_array(:,2)=eis_gmn_ts; %=zeros(1620,6);
eis_array(:,:,:,2)=eis_ts;
lts_gmn_array(:,2)=lts_gmn_ts; %=zeros(1620,6);
lts_array(:,:,:,2)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array(:,:,:,2)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array(:,:,:,2)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,2)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,2)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,2)=hcloud_ens;
toa_sw_cre_array(:,:,:,2)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 3
%-----------------------------------------------------------------------------------------
'beginning work on ens 3'
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A3/';
readvars % openncfile_3mods
alpha_09
alpha_array(:,3)=alpha_30y;
alpha_cre_array(:,3)=alpha_cre_30y;
eis_lts_ts
eis_gmn_array(:,3)=eis_gmn_ts; %=zeros(1620,6);
eis_array(:,:,:,3)=eis_ts;
lts_gmn_array(:,3)=lts_gmn_ts; %=zeros(1620,6);
lts_array(:,:,:,3)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array(:,:,:,3)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array(:,:,:,3)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,3)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,3)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,3)=hcloud_ens;
toa_sw_cre_array(:,:,:,3)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 4
%-----------------------------------------------------------------------------------------
'beginning work on ens 4'
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A4/';
readvars % openncfile_3mods
alpha_09
alpha_array(:,4)=alpha_30y;
alpha_cre_array(:,4)=alpha_cre_30y;
eis_lts_ts
eis_gmn_array(:,4)=eis_gmn_ts; %=zeros(1620,6);
eis_array(:,:,:,4)=eis_ts;
lts_gmn_array(:,4)=lts_gmn_ts; %=zeros(1620,6);
lts_array(:,:,:,4)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array(:,:,:,4)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array(:,:,:,4)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,4)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,4)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,4)=hcloud_ens;
toa_sw_cre_array(:,:,:,4)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 5
%-----------------------------------------------------------------------------------------
'beginning work on ens 5'
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A5/';
readvars % openncfile_3mods
alpha_09
alpha_array(:,5)=alpha_30y;
alpha_cre_array(:,5)=alpha_cre_30y;
eis_lts_ts
eis_gmn_array(:,5)=eis_gmn_ts; %=zeros(1620,6);
eis_array(:,:,:,5)=eis_ts;
lts_gmn_array(:,5)=lts_gmn_ts; %=zeros(1620,6);
lts_array(:,:,:,5)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array(:,:,:,5)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array(:,:,:,5)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,5)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,5)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,5)=hcloud_ens;
toa_sw_cre_array(:,:,:,5)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 6
%-----------------------------------------------------------------------------------------
'beginning work on ens 6'
path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/';
readvars % openncfile_3mods
alpha_09
alpha_array(:,6)=alpha_30y;
alpha_cre_array(:,6)=alpha_cre_30y;
eis_lts_ts
eis_gmn_array(:,6)=eis_gmn_ts; %=zeros(1620,6);
eis_array(:,:,:,6)=eis_ts;
lts_gmn_array(:,6)=lts_gmn_ts; %=zeros(1620,6);
lts_array(:,:,:,6)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array(:,:,:,6)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array(:,:,:,6)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array(:,:,:,6)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array(:,:,:,6)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array(:,:,:,6)=hcloud_ens;
toa_sw_cre_array(:,:,:,6)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% compute the ensemble means 
mean_alpha=mean(alpha_array,2);
mean_alpha_cre=mean(alpha_cre_array,2);
eis_ens_am2_mn =mean(eis_array,4);
lts_ens_am2_mn =mean(lts_array,4);
omega500_am2_mn=mean(omega500_array,4);
temp700_am2_mn =mean(temp700_array,4);
temp_sfc_am2_mn=mean(temp_sfc_array,4);
lcloud_am2_mn  =mean(lcloud_array,4);
hcloud_am2_mn  =mean(hcloud_array,4);
sw_cre_am2_mn  =mean(toa_sw_cre_array,4);

clear hcloud_array lcloud_array temp_sfc_array temp700_array omega500_array lts_array eis_array alpha_cre_array toa_sw_cre_array
%-----------------------------------------------------------------------------------------
% variables on which to compute trends
einvs_ts=eis_ens_am2_mn;
lowtrstab_ts=lts_ens_am2_mn;
omega500_mn_ts=omega500_am2_mn;
temp700_mn_ts=temp700_am2_mn;
temp_sfc_mn_ts=temp_sfc_am2_mn;
lcloud_mn_ts=lcloud_am2_mn;
hcloud_mn_ts=hcloud_am2_mn;
% lwp_ts --> not dealt with here.. because it wasn't in AM3 ensembles.

compute_trends

%ncfilename=strcat(modtitle,'_eiscl_trends_',period,'_test.nc')  
%file_out=ncfilename;   
%amip_eiscltrends_ncout
%%-----------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------
% for AM3
%-----------------------------------------------------------------------------------------
% ens 1
%-----------------------------------------------------------------------------------------
path='/AM3/c48L48_am3p9_1860_ext/';
years2='atmos.187001-200512'; % 1620 months
%
modtitle='am3';

%level700=4; % for AM2 
level700=5; % for AM3, and AM4
level500=7; % for AM3 and AM4

% open files and save necessary variables: 
%-----------------------------------------------------------------------------------------
%pathbase='/net2/Levi.Silvers/data/amip_long/';
readvars % openncfile_3mods

alpha_array_am3     =zeros(nyears_alpha,5);
alpha_cre_array_am3 =zeros(nyears_alpha,5);
eis_gmn_array_am3   =zeros(nmonths,5);
lts_gmn_array_am3   =zeros(nmonths,5);
eis_array_am3       =zeros(nmonths,nlat,nlon,5);
lts_array_am3       =zeros(nmonths,nlat,nlon,5);
omega500_array_am3  =zeros(nmonths,nlat,nlon,5);
temp700_array_am3   =zeros(nmonths,nlat,nlon,5);
temp_sfc_array_am3  =zeros(nmonths,nlat,nlon,5);
lcloud_array_am3    =zeros(nmonths,nlat,nlon,5);
hcloud_array_am3    =zeros(nmonths,nlat,nlon,5);
toa_sw_cre_array_am4=zeros(nmonths,nlat,nlon,5); 

alpha_09

alpha_array_am3(:,1)=alpha_30y;
alpha_cre_array_am3(:,1)=alpha_cre_30y;

eis_lts_ts

% save output to appropriate local vars:
eis_gmn_array_am3(:,1)=eis_gmn_ts; %=zeros(1620,6);
eis_array_am3(:,:,:,1)=eis_ts;
lts_gmn_array_am3(:,1)=lts_gmn_ts; %=zeros(1620,6);
lts_array_am3(:,:,:,1)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array_am3(:,:,:,1)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array_am3(:,:,:,1)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array_am3(:,:,:,1)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array_am3(:,:,:,1)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array_am3(:,:,:,1)=hcloud_ens;
toa_sw_cre_array_am3(:,:,:,1)=swup_clr_ts-swup_ts; 
%
%-----------------------------------------------------------------------------------------
% ens 2
%-----------------------------------------------------------------------------------------
path='/AM3/c48L48_am3p9_1860_ext2/';
years2='atmos.187001-200512'; % 1620 months
%

% open files and save necessary variables: 
%-----------------------------------------------------------------------------------------
%pathbase='/net2/Levi.Silvers/data/amip_long/';
readvars % openncfile_3mods
%
alpha_09

alpha_array_am3(:,2)=alpha_30y;
alpha_cre_array_am3(:,2)=alpha_cre_30y;

eis_lts_ts

% save output to appropriate local vars:
eis_gmn_array_am3(:,2)=eis_gmn_ts; %=zeros(1620,6);
eis_array_am3(:,:,:,2)=eis_ts;
lts_gmn_array_am3(:,2)=lts_gmn_ts; %=zeros(1620,6);
lts_array_am3(:,:,:,2)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array_am3(:,:,:,2)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array_am3(:,:,:,2)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array_am3(:,:,:,2)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array_am3(:,:,:,2)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array_am3(:,:,:,2)=hcloud_ens;
toa_sw_cre_array_am3(:,:,:,2)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 3
%-----------------------------------------------------------------------------------------
path='/AM3/c48L48_am3p9_1860_ext3/';
years2='atmos.187001-200512'; % 1620 months
%

% open files and save necessary variables: 
%-----------------------------------------------------------------------------------------
%pathbase='/net2/Levi.Silvers/data/amip_long/';
readvars % openncfile_3mods
%
alpha_09

alpha_array_am3(:,3)=alpha_30y;
alpha_cre_array_am3(:,3)=alpha_cre_30y;

eis_lts_ts

% save output to appropriate local vars:
eis_gmn_array_am3(:,3)=eis_gmn_ts; %=zeros(1620,6);
eis_array_am3(:,:,:,3)=eis_ts;
lts_gmn_array_am3(:,3)=lts_gmn_ts; %=zeros(1620,6);
lts_array_am3(:,:,:,3)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array_am3(:,:,:,3)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array_am3(:,:,:,3)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array_am3(:,:,:,3)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array_am3(:,:,:,3)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array_am3(:,:,:,3)=hcloud_ens;
toa_sw_cre_array_am3(:,:,:,3)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 4
%-----------------------------------------------------------------------------------------
%path='/AM3/c48L48_am3p9_1860_ext4/';
path='/AM3/c48L48_am3p9_1860_ext2a/';
years2='atmos.187001-200512'; % 1620 months
%

% open files and save necessary variables: 
%-----------------------------------------------------------------------------------------
%pathbase='/net2/Levi.Silvers/data/amip_long/';
readvars % openncfile_3mods
%
alpha_09

alpha_array_am3(:,4)=alpha_30y;
alpha_cre_array_am3(:,4)=alpha_cre_30y;

eis_lts_ts

% save output to appropriate local vars:
eis_gmn_array_am3(:,4)=eis_gmn_ts; %=zeros(1620,6);
eis_array_am3(:,:,:,4)=eis_ts;
lts_gmn_array_am3(:,4)=lts_gmn_ts; %=zeros(1620,6);
lts_array_am3(:,:,:,4)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array_am3(:,:,:,4)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array_am3(:,:,:,4)=temp700_ens;
temp_sfc_ens=temp_sfc_ts;
temp_sfc_array_am3(:,:,:,4)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array_am3(:,:,:,4)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array_am3(:,:,:,4)=hcloud_ens;
toa_sw_cre_array_am3(:,:,:,4)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
% ens 5
%-----------------------------------------------------------------------------------------
path='/AM3/c48L48_am3p9_1860_ext5/';
years2='atmos.187001-200512'; % 1620 months
%

% open files and save necessary variables: 
%-----------------------------------------------------------------------------------------
readvars % openncfile_3mods
%
alpha_09

alpha_array_am3(:,5)=alpha_30y;
alpha_cre_array_am3(:,5)=alpha_cre_30y;

eis_lts_ts

% save output to appropriate local vars:
eis_gmn_array_am3(:,5)=eis_gmn_ts; %=zeros(1620,6);
eis_array_am3(:,:,:,5)=eis_ts;
lts_gmn_array_am3(:,5)=lts_gmn_ts; %=zeros(1620,6);
lts_array_am3(:,:,:,5)=lts_ts;
omega500_ens=squeeze(omega_ts(:,level500,:,:));
omega500_array_am3(:,:,:,5)=omega500_ens;
temp700_ens=squeeze(temp3d(:,level700,:,:));
temp700_array_am3(:,:,:,5)=temp700_ens;
%temp_sfc_ens=temp_sfc_ts; % it looks like there is something wrong 
% with temp_sfc_ens from the 5th ensemble member...
temp_sfc_array_am3(:,:,:,5)=temp_sfc_ens;
lcloud_ens=lcloud_ts;
lcloud_array_am3(:,:,:,5)=lcloud_ens;
hcloud_ens=hcloud_ts;
hcloud_array_am3(:,:,:,5)=hcloud_ens;
toa_sw_cre_array_am3(:,:,:,5)=swup_clr_ts-swup_ts; 
%-----------------------------------------------------------------------------------------
%
%% compute the ensemble means 
mean_alpha_am3=mean(alpha_array_am3,2);
mean_alpha_cre_am3=mean(alpha_cre_array_am3,2);
eis_ens_am3_mn=mean(eis_array_am3,4);
lts_ens_am3_mn=mean(lts_array_am3,4);
omega500_am3_mn=mean(omega500_array_am3,4);
temp700_am3_mn =mean(temp700_array_am3,4);
temp_sfc_am3_mn=mean(temp_sfc_array_am3,4);
lcloud_am3_mn  =mean(lcloud_array_am3,4);
hcloud_am3_mn  =mean(hcloud_array_am3,4);
sw_cre_am3_mn  =mean(toa_sw_cre_array_am3,4);

clear hcloud_array_am3 lcloud_array_am3 temp_sfc_array_am3 temp700_array_am3 omega500_array_am3 lts_array_am3 eis_array_am3 alpha_cre_array_am3 toa_sw_cre_array_am3

% variables on which to compute trends
einvs_ts=eis_ens_am3_mn;
lowtrstab_ts=lts_ens_am3_mn;
omega500_mn_ts=omega500_am3_mn;
temp700_mn_ts=temp700_am3_mn;
temp_sfc_mn_ts=temp_sfc_am3_mn;
lcloud_mn_ts=lcloud_am3_mn;
hcloud_mn_ts=hcloud_am3_mn;
%omega500_ts=squeeze(omega_ts(:,level500,:,:));
%einvs_ts=eis_ens_am3_mn;
%lowtrstab_ts=lts_ens_am3_mn;
% temp_sfc_ts  --> readvars
%temp700_ts=squeeze(temp3d(:,level700,:,:));
% lwp_ts --> not dealt with here.. because it wasn't in AM3 ensembles.

compute_trends

%ncfilename=strcat(modtitle,'_eiscl_trends_',period,'_test.nc')  
%file_out=ncfilename;   
%amip_eiscltrends_ncout
%%-----------------------------------------------------------------------------------------
% for AM4
%-----------------------------------------------------------------------------------------
% ens 1
%-----------------------------------------------------------------------------------------
%path='/c96L32_am4g10r8_longamip_1860rad/';
%years2='atmos.187101-201512'; 
path='c96L33_am4p0_longamip_1850rad/ts_all/';
years2='atmos.187001-201412'; 

modtitle='AM4p0';

% for AM4
%timest=13;
timest=1;
%timeend=1632;
timeend=1620;

level700=5; % for AM3, and AM4

%-----------------------------------------------------------------------------------------
readvars 

% create arrays to fill
alpha_array_am4     =zeros(nyears_alpha,4);
alpha_cre_array_am4 =zeros(nyears_alpha,4);
eis_gmn_array_am4   =zeros(nmonths,4);
lts_gmn_array_am4   =zeros(nmonths,4);
eis_array_am4       =zeros(nmonths,nlat,nlon,4);
lts_array_am4       =zeros(nmonths,nlat,nlon,4);
omega500_array_am4  =zeros(nmonths,nlat,nlon,4);
temp700_array_am4   =zeros(nmonths,nlat,nlon,4);
temp_sfc_array_am4  =zeros(nmonths,nlat,nlon,4);
lcloud_array_am4    =zeros(nmonths,nlat,nlon,4);
hcloud_array_am4    =zeros(nmonths,nlat,nlon,4);
toa_sw_cre_array_am4=zeros(nmonths,nlat,nlon,4);

%

alpha_09

alpha_array_am4(:,1)=alpha_30y;
alpha_cre_array_am4(:,1)=alpha_cre_30y;

eis_lts_ts % compute time series of eis and lts.  both gmn and full fields are computed.

% save output to appropriate local vars:
eis_gmn_array_am4(:,1)      =eis_gmn_ts; %=zeros(1620,6);
lts_gmn_array_am4(:,1)      =lts_gmn_ts; %=zeros(1620,6);
eis_array_am4(:,:,:,1)      =eis_ts;
lts_array_am4(:,:,:,1)      =lts_ts;
omega500_ens                =squeeze(omega_ts(:,level500,:,:));
omega500_array_am4(:,:,:,1) =omega500_ens;
temp700_ens                 =squeeze(temp3d(:,level700,:,:));
temp700_array_am4(:,:,:,1)  =temp700_ens;
%temp_sfc_ens=temp_sfc_ts; % it looks like there is something wrong 
% with temp_sfc_ens from the 5th ensemble member...
temp_sfc_array_am4(:,:,:,1) =temp_sfc_ts;
lcloud_array_am4(:,:,:,1)   =lcloud_ts;
hcloud_array_am4(:,:,:,1)   =hcloud_ts;

toa_sw_cre_array_am4(:,:,:,1)=swup_clr_ts-swup_ts;
% done with first ensemble member for AM4p0
%----------------------------------------------------------------------------------

%%/net2/Levi.Silvers/data/amip_long/c96L33_am4p0_longamip_1850rad/ts_all
pathbase='/net2/Levi.Silvers/data/amip_long/';
%path='c96L33_am4p0_longamip_1850rad/ts_all/';
path='c96L33_am4p0_longamip_1850rad_ens1/ts_all/';
%years2='atmos.187001-201412'; 

modtitle='AM4p0';

%%% for AM4
%%timest=13;
%timest=1;
%%%timeend=1632;
%timeend=1620;
%%timeend=1608;
%
%level700=5; % for AM3, and AM4
%
readvars
%
alpha_09
%
alpha_array_am4(:,2)=alpha_30y;
alpha_cre_array_am4(:,2)=alpha_cre_30y;
%
eis_lts_ts
%
%% save output to appropriate local vars:
eis_gmn_array_am4(:,2)      =eis_gmn_ts; %=zeros(1620,6);
lts_gmn_array_am4(:,2)      =lts_gmn_ts; %=zeros(1620,6);
eis_array_am4(:,:,:,2)      =eis_ts;
lts_array_am4(:,:,:,2)      =lts_ts;
omega500_ens                =squeeze(omega_ts(:,level500,:,:));
omega500_array_am4(:,:,:,2) =omega500_ens;
temp700_ens                 =squeeze(temp3d(:,level700,:,:));
temp700_array_am4(:,:,:,2)  =temp700_ens;
%temp_sfc_ens=temp_sfc_ts; % it looks like there is something wrong 
% with temp_sfc_ens from the 5th ensemble member...
temp_sfc_array_am4(:,:,:,2) =temp_sfc_ts;
lcloud_array_am4(:,:,:,2)   =lcloud_ts;
hcloud_array_am4(:,:,:,2)   =hcloud_ts;
toa_sw_cre_array_am4(:,:,:,2)=swup_clr_ts-swup_ts;
%
% done with second ensemble member for AM4p0
%----------------------------------------------------------------------------------
% ensemble 2 
%%/net2/Levi.Silvers/data/amip_long/c96L33_am4p0_longamip_1850rad/ts_all
pathbase='/net2/Levi.Silvers/data/amip_long/';
path='c96L33_am4p0_longamip_1850rad_ens3/ts_all/';
%years2='atmos.187001-201412'; 

%modtitle='AM4p0';

%%% for AM4
%timest=13;
%%timest=1;
%%%timeend=1632;
%timeend=1620;
%%timeend=1608;
%
%level700=5; % for AM3, and AM4
%
readvars
%
alpha_09
%
alpha_array_am4(:,3)=alpha_30y;
alpha_cre_array_am4(:,3)=alpha_cre_30y;
%
eis_lts_ts
%
%% save output to appropriate local vars:
eis_gmn_array_am4(:,3)      =eis_gmn_ts; %=zeros(1620,6);
lts_gmn_array_am4(:,3)      =lts_gmn_ts; %=zeros(1620,6);
eis_array_am4(:,:,:,3)      =eis_ts;
lts_array_am4(:,:,:,3)      =lts_ts;
omega500_ens                =squeeze(omega_ts(:,level500,:,:));
omega500_array_am4(:,:,:,3) =omega500_ens;
temp700_ens                 =squeeze(temp3d(:,level700,:,:));
temp700_array_am4(:,:,:,3)  =temp700_ens;
%temp_sfc_ens=temp_sfc_ts; % it looks like there is something wrong 
% with temp_sfc_ens from the 5th ensemble member...
temp_sfc_array_am4(:,:,:,3) =temp_sfc_ts;
lcloud_array_am4(:,:,:,3)   =lcloud_ts;
hcloud_array_am4(:,:,:,3)   =hcloud_ts;
toa_sw_cre_array_am4(:,:,:,3)=swup_clr_ts-swup_ts;
%
% done with third ensemble member for AM4p0
%----------------------------------------------------------------------------------
% ensemble 4 
%%/net2/Levi.Silvers/data/amip_long/c96L33_am4p0_longamip_1850rad/ts_all
pathbase='/net2/Levi.Silvers/data/amip_long/';
path='c96L33_am4p0_longamip_1850rad_ens4/ts_all/';
%years2='atmos.187001-201412'; 

%%modtitle='AM4p0';
%
%%% for AM4
%%timest=13;
%timest=1;
%%%timeend=1632;
%timeend=1620;
%%timeend=1608;
%%
%%level700=5; % for AM3, and AM4
%
readvars
%
alpha_09
%
alpha_array_am4(:,4)=alpha_30y;
alpha_cre_array_am4(:,4)=alpha_cre_30y;
%
eis_lts_ts
%
%% save output to appropriate local vars:
eis_gmn_array_am4(:,4)      =eis_gmn_ts; %=zeros(1620,6);
lts_gmn_array_am4(:,4)      =lts_gmn_ts; %=zeros(1620,6);
eis_array_am4(:,:,:,4)      =eis_ts;
lts_array_am4(:,:,:,4)      =lts_ts;
omega500_ens                =squeeze(omega_ts(:,level500,:,:));
omega500_array_am4(:,:,:,4) =omega500_ens;
temp700_ens                 =squeeze(temp3d(:,level700,:,:));
temp700_array_am4(:,:,:,4)  =temp700_ens;
%temp_sfc_ens=temp_sfc_ts; % it looks like there is something wrong 
% with temp_sfc_ens from the 5th ensemble member...
temp_sfc_array_am4(:,:,:,4) =temp_sfc_ts;
lcloud_array_am4(:,:,:,4)   =lcloud_ts;
hcloud_array_am4(:,:,:,4)   =hcloud_ts;
toa_sw_cre_array_am4(:,:,:,4)=swup_clr_ts-swup_ts;
%
% done with fourth ensemble member for AM4p0
%----------------------------------------------------------------------------------
%
%----------------------------------------------------------------
% done with AM4 ensemble members
%----------------------------------------------------------------

mean_alpha_am4=mean(alpha_array_am4,2);
mean_alpha_cre_am4=mean(alpha_cre_array_am4,2);

%%% compute the ensemble means 
eis_ens_am4_mn  =mean(eis_array_am4,4);
lts_ens_am4_mn  =mean(lts_array_am4,4);
omega500_am4_mn =mean(omega500_array_am4,4);
temp700_am4_mn  =mean(temp700_array_am4,4);
temp_sfc_am4_mn =mean(temp_sfc_array_am4,4);
lcloud_am4_mn   =mean(lcloud_array_am4,4);
hcloud_am4_mn   =mean(hcloud_array_am4,4);
sw_cre_am4_mn   =mean(toa_sw_cre_array_am4,4);

clear hcloud_array_am4 lcloud_array_am4 temp_sfc_array_am4 temp700_array_am4 omega500_array_am4 lts_array_am4 eis_array_am4 alpha_cre_array_am4 toa_sw_cre_array_am4

% variables on which to compute trends
einvs_ts=eis_ens_am4_mn;
lowtrstab_ts=lts_ens_am4_mn;
omega500_mn_ts=omega500_am4_mn;
temp700_mn_ts=temp700_am4_mn;
temp_sfc_mn_ts=temp_sfc_am4_mn;
lcloud_mn_ts=lcloud_am4_mn;
hcloud_mn_ts=hcloud_am4_mn;

compute_trends

%ncfilename=strcat(modtitle,'_eiscl_trends_',period,'_test.nc')  
%file_out=ncfilename;   
%amip_eiscltrends_ncout

% create a figure of alpha for 3 different models: 
plot_alpha_3mods

eis_gmn_ensmn_am2=mean(eis_gmn_array,2);
eis_gmn_ensmn_am3=mean(eis_gmn_array_am3,2);
%eis_gmn_ensmn_am4=eis_gmn_array_am4;
eis_gmn_ensmn_am4=mean(eis_gmn_array_am4,2);

eis_gmn_am4_re=reshape(eis_gmn_ensmn_am4,[12,135]);
eis_gymn_am4=mean(eis_gmn_am4_re,1);
eis_gmn_am3_re=reshape(eis_gmn_ensmn_am3,[12,135]);
eis_gymn_am3=mean(eis_gmn_am3_re,1);
eis_gmn_am2_re=reshape(eis_gmn_ensmn_am2,[12,135]);
eis_gymn_am2=mean(eis_gmn_am2_re,1);

%%-----------------------------------------------------------------------------------------
%%contsin=[-1.25,-1.0,-0.75,-0.5,-0.25,0,0.25,0.5,0.75,1.0,1.25];
%%caxisin=[-1.25 1.25];
%
%% all of these variables related to trend computation should be set at top of file
%%ts_length=360; % length of time series in months over which a trend will be computed
%% rstime and rendtime are the starting and ending times for the period to compute the
%% trend over.  
%%rstime=1; 
%%rendtime=360;  
%%rstime=1261; 
%%rendtime=1620;  
%
%% variables on which to compute trends
%% lcloud_ts --> readvars
%% hcloud_ts --> readvars
%% omega_ts  --> readvars
%omega500_ts=squeeze(omega_ts(:,level500,:,:));
%einvs_ts=eis_array_am4;
%lowtrstab_ts=lts_array_am4;
%% temp_sfc_ts  --> readvars
%temp700_ts=squeeze(temp3d(:,level700,:,:));
%% lwp_ts --> not dealt with here.. because it wasn't in AM3 ensembles.
%
%compute_trends
%
%ncfilename=strcat(modtitle,'_eiscl_trends_',period,'_test.nc')  
%file_out=ncfilename;   
%amip_eiscltrends_ncout
%
%%rstime=781; 
%%rendtime=1140;  
%%reg_trend
%%eis_trend_early=regtrend_var_oo;
%%
%%cont_map_modis(eis_trend_late,vlat,vlon,contsin,caxisin)
%%colorbar 
%%title('AM4g10r8 EIS trend 1975-2005')
%%
%%cont_map_modis(eis_trend_early,vlat,vlon,contsin,caxisin)
%%colorbar 
%%title('AM4g10r8 EIS trend 1935-1965')
%%
%%-----------------------------------------------------------------------------------------
%
%
%%% for additional variables such as lcloud, hcloud, and omega use
%%openncfile_new
