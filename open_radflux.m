%
% open file and read radiative flux variables at toa
% intended to be used with Matlab versions from at least 2015...
%

experimentn='/c8x160L33_am4p0_25km_wlkr_ent0p9'

piece_a='/Users/silvers/data/WalkerCell/gauss_d';
piece_b=experimentn;
%piece_c='/19790101.atmos_month';
piece_c='/1980th1983.atmos_month_tmn';
%piece=strcat(pathbase,path,years2);

source_radflux    = strcat(piece_a,piece_b,piece_c,'.nc');

% for old versions of matlab (2009)
%fin_radflux       = netcdf(source_radflux,'nowrite');
%fileid(1)         = fopen(source_radflux);
%olr               = fin_radflux{'olr'}(:,:,:);

olr               = ncread(source_radflux,'olr');
olr_clr           = ncread(source_radflux,'olr_clr');
swdn_toa          = ncread(source_radflux,'swdn_toa');
swdn_toa_clr      = ncread(source_radflux,'swdn_toa_clr');
swup_toa          = ncread(source_radflux,'swup_toa');
swup_toa_clr      = ncread(source_radflux,'swup_toa_clr');

evap                 = ncread(source_radflux,'evap');
shflx                = ncread(source_radflux,'shflx');
lwdn_sfc             = ncread(source_radflux,'lwdn_sfc');
swdn_sfc             = ncread(source_radflux,'swdn_sfc');
lwup_sfc             = ncread(source_radflux,'lwup_sfc');
swup_sfc             = ncread(source_radflux,'swup_sfc');

% for old versions of matlab (2009)
%fclose(fileid(1));
