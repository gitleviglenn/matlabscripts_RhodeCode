%----------------------------------------------------------------
% scripts to read and open data from a netcdf files 
%
% this script is general and thus requires the 
% pathbase, path, and years2 vars to be predefined
%
% e.g.
%pathbase='/net2/Levi.Silvers/data/amip_long/';
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A1/';
%years2='atmos.187001-200412'; % 1620 months
%
% this should work for Matlab 2009 
%
% levi silvers                     march 2017
%----------------------------------------------------------------

piece=strcat(pathbase,path,years2);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_temp_ts     = strcat(piece,'.temp.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_rh_ts       = strcat(piece,'.rh.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')
source_hght_ts     = strcat(piece,'.hght.nc')
source_lcloud_ts   = strcat(piece,'.low_cld_amt.nc')
source_hcloud_ts   = strcat(piece,'.high_cld_amt.nc')
source_lwp_ts      = strcat(piece,'.LWP.nc')
source_omega_ts    = strcat(piece,'.omega.nc')      


fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_temp      = netcdf(source_temp_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_hght      = netcdf(source_hght_ts,'nowrite');
fin_rh        = netcdf(source_rh_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');
fin_lcloud    = netcdf(source_lcloud_ts,'nowrite');
fin_hcloud    = netcdf(source_hcloud_ts,'nowrite');
fin_lwp       = netcdf(source_lwp_ts,'nowrite');
fin_omega     = netcdf(source_omega_ts,'nowrite');

%% grab time series over a specified period:
%timest=1;
%timeend=1620;
%v.lon             = fin_temp{'lon'}(:); 
vlon               = fin_temp{'lon'}(:); 
%v.lat             = fin_temp{'lat'}(:);
vlat               = fin_temp{'lat'}(:);
%v.level           = fin_temp{'level'}(:);
vlevel             = fin_temp{'level'}(:);
%v.hght            = fin_hght{'hght'}(:,4,:,:);
hght               = fin_hght{'hght'}(timest:timeend,level700,:,:);
hght               = squeeze(hght);
%v.tsurf           = fin_tsurf{'t_surf'}(:,:,:); 
temp_sfc_ts        = fin_tsurf{'t_surf'}(timest:timeend,:,:); 
%v.temp            = fin_temp{'temp'}(:,:,:,:); 
temp3d             = fin_temp{'temp'}(timest:timeend,:,:,:); 
%v.tref            = fin_tref{'t_ref'}(:,:,:); 
temp_ll_ts         = fin_tref{'t_ref'}(timest:timeend,:,:); 
%v.rh              = fin_rh{'rh'}(:,1,:,:); 
rh_ll              = fin_rh{'rh'}(timest:timeend,1,:,:); 
rh_ll              = squeeze(rh_ll); 
v.lon             = fin_tref{'lon'}(:); 
v.lat             = fin_tref{'lat'}(:);
%v.swdn_toa        = fin_swdn{'swdn_toa'}(:,:,:,:);
swdn_ts            = fin_swdn{'swdn_toa'}(timest:timeend,:,:,:);
%v.swup_toa        = fin_swup{'swup_toa'}(:,:,:,:);
swup_ts            = fin_swup{'swup_toa'}(timest:timeend,:,:,:);
%v.swup_toa_clr    = fin_swup_clr{'swup_toa_clr'}(:,:,:,:);
swup_clr_ts        = fin_swup_clr{'swup_toa_clr'}(timest:timeend,:,:,:);
%v.olr_toa         = fin_olr{'olr'}(:,:,:,:);
olr_ts             = fin_olr{'olr'}(timest:timeend,:,:,:);
%v.olr_toa_clr     = fin_olr_clr{'olr_clr'}(:,:,:,:);
olr_clr_ts         = fin_olr_clr{'olr_clr'}(timest:timeend,:,:,:);
%
%v.lcloud          = fin_lcloud{'low_cld_amt'}(:,:,:);
lcloud_ts          = fin_lcloud{'low_cld_amt'}(timest:timeend,:,:);
hcloud_ts          = fin_hcloud{'high_cld_amt'}(timest:timeend,:,:);
omega_ts           = fin_omega{'omega'}(timest:timeend,:,:);
%v.lwp             = fin_lwp{'LWP'}(:,:,:);

nlat=size(vlat,1);
nlon=size(vlon,1);
v.nlat=size(vlat,1);
v.nlon=size(vlon,1);
