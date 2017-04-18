%----------------------------------------------------------------
% scripts to read and open data from a netcdf file into Matlab
%
% this should work for Matlab 2009 
%
% levi silvers                     jan 2017
%----------------------------------------------------------------
'you are using a script in m2009'

%% for data which has already been averaged and concatinated
%% into a single file:
%fin =netcdf(source,'nowrite');
%
%v.lon=fin{'lon'}(:); 
%v.lat =fin{'lat'}(:);
%v.level =fin{'level'}(:);
%v.temp =fin{'temp'}(:,:,:,:); 
%v.tsurf =fin{'t_surf'}(:,:,:); 
%v.tref =fin{'t_ref'}(:,:,:); 
%v.lcloud=fin{'low_cld_amt'}(:,:,:);
%v.mcloud=fin{'mid_cld_amt'}(:,:,:);
%v.hcloud=fin{'high_cld_amt'}(:,:,:);
%v.hght=fin{'hght'}(:,:,:,:);
%v.rh=fin{'rh'}(:,:,:,:);

% analyze two periods in time
%lateper=1975-2005;  % 1260:1620   Zhou et al. look at 1980-2010;
%earlyper=1930-1960; % 720:1080

%%%% AM2
%%%path='/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/';
%%path='/net2/Levi.Silvers/data/amip_long/AM2.1_1870-2004/';
%path='/net2/Levi.Silvers/data/amip_long/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/';
%years='atmos.187001-200412'; % 1620 months
%endtime=1620;
%%endtime=1080;
%modtitle='am2';
%%%%% AM3
%path='/net2/Levi.Silvers/data/amip_long/c48L48_am3p9_1860_ext/';
%years='atmos.187001-200512'; % 1632 months
%%endtime=1632;
%endtime=1620;
%%%endtime=1080;
%modtitle='am3p9';
%%% AM4 long amip
path='/net2/Levi.Silvers/data/amip_long/c96L32_am4g10r8_longamip_1860rad/'
years='atmos.187101-201512';
%endtime=1740; % complete endtime
endtime=1620;
%%%endtime=1080;
modtitle='am4g10r8';
%% AM4 normal amip
%path='/net2/Levi.Silvers/data/amip_long/c96L32_am4g12r04_cosp/'
%years='atmos.198101-201012'; % 1740 months
%endtime=360;
%modtitle='c96L32 am4g12r04: ';

% rstime and rendtime are used in reg_trend

ts_length=360; % length of time series in months
% for time series data from a variety of files: 
% stime and endtime need to be defined
% tlength = endtime-stime+1; as used in reg_trend.m
stime=endtime-ts_length+1;


piece1=strcat(path,years);

source_tsurf_ts = strcat(piece1,'.t_surf.nc')
source_temp_ts  = strcat(piece1,'.temp.nc')
source_rh_ts    = strcat(piece1,'.rh.nc')
source_hght_ts  = strcat(piece1,'.hght.nc')
source_tref_ts  = strcat(piece1,'.t_ref.nc')
source_omega_ts  = strcat(piece1,'.omega.nc')

source_lca_ts      = strcat(piece1,'.low_cld_amt.nc')
source_mca_ts      = strcat(piece1,'.mid_cld_amt.nc')
source_hca_ts      = strcat(piece1,'.high_cld_amt.nc')
source_swdn_ts     = strcat(piece1,'.swdn_toa.nc')
source_swup_ts     = strcat(piece1,'.swup_toa.nc')
source_swup_clr_ts = strcat(piece1,'.swup_toa_clr.nc')
source_olr_ts     = strcat(piece1,'.olr.nc')
source_olr_clr_ts     = strcat(piece1,'.olr_clr.nc')
source_lwp_ts     = strcat(piece1,'.LWP.nc')

fin_temp  = netcdf(source_temp_ts,'nowrite');
fin_tsurf = netcdf(source_tsurf_ts,'nowrite');
fin_tref  = netcdf(source_tref_ts,'nowrite');
fin_rh    = netcdf(source_rh_ts,'nowrite');
fin_lca   = netcdf(source_lca_ts,'nowrite');
fin_mca   = netcdf(source_mca_ts,'nowrite');
fin_hca   = netcdf(source_hca_ts,'nowrite');
fin_hght  = netcdf(source_hght_ts,'nowrite');
fin_swdn  = netcdf(source_swdn_ts,'nowrite');
fin_swup  = netcdf(source_swup_ts,'nowrite');
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fin_olr       = netcdf(source_olr_ts,'nowrite');
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');
fin_omega     = netcdf(source_omega_ts,'nowrite');
fin_lwp       = netcdf(source_lwp_ts,'nowrite');

v.lon            = fin_temp{'lon'}(:); 
v.lat            = fin_temp{'lat'}(:);
v.level          = fin_temp{'level'}(:);
v.temp_full      = fin_temp{'temp'}(stime:endtime,:,:,:); 
v.tsurf_full     = fin_tsurf{'t_surf'}(stime:endtime,:,:); 
v.tref_full      = fin_tref{'t_ref'}(stime:endtime,:,:); 
v.lcloud         = fin_lca{'low_cld_amt'}(stime:endtime,:,:);
v.mcloud         = fin_mca{'mid_cld_amt'}(stime:endtime,:,:);
v.hcloud         = fin_hca{'high_cld_amt'}(stime:endtime,:,:);
v.hght_full      = fin_hght{'hght'}(stime:endtime,:,:,:);
v.rh_full        = fin_rh{'rh'}(stime:endtime,:,:,:);
v.omega          = fin_omega{'omega'}(stime:endtime,:,:,:);

v.swdn_toa       = fin_swdn{'swdn_toa'}(stime:endtime,:,:,:);
v.swup_toa       = fin_swup{'swup_toa'}(stime:endtime,:,:,:);
v.swup_toa_clr   = fin_swup_clr{'swup_toa_clr'}(stime:endtime,:,:,:);
v.olr_toa       = fin_olr{'olr'}(stime:endtime,:,:,:);
v.olr_toa_clr   = fin_olr_clr{'olr_clr'}(stime:endtime,:,:,:);

% grab entire time series 
v.tsurf_ts       = fin_tsurf{'t_surf'}(stime:endtime,:,:); 
v.tref_ts        = fin_tref{'t_ref'}(stime:endtime,:,:); 
v.swdn_toa_ts    = fin_swdn{'swdn_toa'}(stime:endtime,:,:,:);
v.swup_toa_ts    = fin_swup{'swup_toa'}(stime:endtime,:,:,:);
v.olr_toa_ts     = fin_olr{'olr'}(stime:endtime,:,:,:);
v.lwp_ts         = fin_lwp{'LWP'}(stime:endtime,:,:,:);

v.level=100.*v.level;
v.nlon=length(v.lon); 
v.nlat=length(v.lat); 
v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; 
v.xe0=v.nlon;
v.ys0=1; 
v.ye0=v.nlat;

nlat=v.nlat;
nlon=v.nlon;

%v.nt=length(v.time);

% code for matlab 2015
%v.lat=ncread(source,'lat');
%v.lon=ncread(source,'lon');
%v.level=ncread(source,'level');
%v.level=100.*v.level;
%v.temp=ncread(source,'temp');
%v.tsurf=ncread(source,'t_surf');
%v.tref=ncread(source,'t_ref');
%v.lcloud=ncread(source,'low_cld_amt');
%v.mcloud=ncread(source,'mid_cld_amt');
%v.hcloud=ncread(source,'high_cld_amt');
%v.hght=ncread(source,'hght');
%v.rh=ncread(source,'rh');
