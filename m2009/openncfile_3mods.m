%----------------------------------------------------------------
% scripts to read and open data from a netcdf files from 
% 3 different sources and open them into Matlab
%
% this should work for Matlab 2009 
%
% levi silvers                     jan 2017
%----------------------------------------------------------------
'you are using a script in m2009'

% AM2 long amip run
%path='/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/';
path2='/net2/Levi.Silvers/data/amip_long/AM2.1_1870-2004/';
years2='atmos.187001-200412'; % 1620 months
endtime_am2=1620;
modtitle_am2='am2longamip';
piece=strcat(path2,years2);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')

fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');

% grab entire time series 
v.tsurf_am2ts           = fin_tsurf{'t_surf'}(:,:,:); 
v.tref_am2ts            = fin_tref{'t_ref'}(:,:,:); 
v.lon_am2               = fin_tref{'lon'}(:); 
v.lat_am2               = fin_tref{'lat'}(:);
v.swdn_toa_am2ts        = fin_swdn{'swdn_toa'}(:,:,:,:);
v.swup_toa_am2ts        = fin_swup{'swup_toa'}(:,:,:,:);
v.swup_toa_clr_am2ts    = fin_swup_clr{'swup_toa_clr'}(:,:,:,:);
v.olr_toa_am2ts         = fin_olr{'olr'}(:,:,:,:);
v.olr_toa_clr_am2ts     = fin_olr_clr{'olr_clr'}(:,:,:,:);

%% AM3 long amip
path3='/net2/Levi.Silvers/data/amip_long/c48L48_am3p9_1860_ext/';
years3='atmos.187001-200512'; % 1632 months
endtime_am3=1632;
modtitle_am3='am3p9longamip';
piece=strcat(path3,years3);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')

fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');

% grab entire time series 
v.tsurf_am3ts           = fin_tsurf{'t_surf'}(:,:,:); 
v.tref_am3ts            = fin_tref{'t_ref'}(:,:,:); 
v.lon_am3               = fin_tref{'lon'}(:); 
v.lat_am3               = fin_tref{'lat'}(:);
v.swdn_toa_am3ts        = fin_swdn{'swdn_toa'}(:,:,:,:);
v.swup_toa_am3ts        = fin_swup{'swup_toa'}(:,:,:,:);
v.swup_toa_clr_am3ts        = fin_swup_clr{'swup_toa_clr'}(:,:,:,:);
v.olr_toa_am3ts         = fin_olr{'olr'}(:,:,:,:);
v.olr_toa_clr_am3ts     = fin_olr_clr{'olr_clr'}(:,:,:,:);

% AM4 long amip
path4='/net2/Levi.Silvers/data/amip_long/c96L32_am4g10r8_longamip_1860rad/'
years4='atmos.187101-201512';
endtime_am4=1740;
modtitle_am4='am4g10r8longamip: ';
piece=strcat(path4,years4);

source_tsurf_ts    = strcat(piece,'.t_surf.nc')
source_tref_ts     = strcat(piece,'.t_ref.nc')
source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
source_swup_ts     = strcat(piece,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
source_olr_ts      = strcat(piece,'.olr.nc')
source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')

fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
fin_tref      = netcdf(source_tref_ts,'nowrite');
fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fin_swup      = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');

% grab entire time series 
v.tsurf_am4ts           = fin_tsurf{'t_surf'}(:,:,:); 
v.tref_am4ts            = fin_tref{'t_ref'}(:,:,:); 
v.lon_am4               = fin_tref{'lon'}(:); 
v.lat_am4               = fin_tref{'lat'}(:);
v.swdn_toa_am4ts        = fin_swdn{'swdn_toa'}(:,:,:,:);
v.swup_toa_am4ts        = fin_swup{'swup_toa'}(:,:,:,:);
v.swup_toa_clr_am4ts    = fin_swup_clr{'swup_toa_clr'}(:,:,:,:);
v.olr_toa_am4ts         = fin_olr{'olr'}(:,:,:,:);
v.olr_toa_clr_am4ts     = fin_olr_clr{'olr_clr'}(:,:,:,:);

