%----------------------------------------------------------------------------
% script to take a global field and produce a time mean vertical profile.
%
% large negative numbers are substituted to NaNs, which matlab then deals with 
% in global_wmean3d
%
% a basic plot is then made
%
% levi silvers                                            oct 2016
%----------------------------------------------------------------------------

%stringpath='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_had_p_4xCO2_climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_10yr/atmos_subsvar3d.0002-0011.all.p60.nc';
%stringpath='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_had_p_1pctco2_climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_10yr/atmos_subsvar3d.0002-0011.all.p60.nc';
stringpath='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_p2K/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_10yr/atmos_subsvar3d.0002-0011.all.p60.nc';
%stringpath='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_10yr/atmos_subsvar3d.0002-0011.all.p60.nc';

fin1=netcdf(stringpath,'nowrite');

%varname='cld_amt';
varname='tot_liq_amt';

vin.lon=fin1{'lon'}(:); vin.lat =fin1{'lat'}(:);
vin.lev=fin1{'level'}(:); % for the example given this is hPa
nlev=length(vin.lev);

vaxis=vin.lev;

varp_cnt_full=fin1{varname}(:,:,:,:);

% if incoming file has multiple times, they need to be averaged...
%varp_cnt=varp_cnt_full;
varp_cnt=squeeze(mean(varp_cnt_full,1));

varp_cnt_nan=varp_cnt;

varp_cnt_nan(varp_cnt<-1.0)=NaN;

size(varp_cnt_nan)
size(nlev)
size(vin.lon)
size(vin.lat)

varp_p_cnt=global_wmean3d(varp_cnt_nan,nlev,vin.lon,vin.lat);

%figure;
% black 'k' -- control experiment
% blue  'b' -- plus 2K
% red   'r' -- 4xCO2 patter
%plot(varp_p_cnt,1:nlev);
plot(varp_p_cnt,vaxis,'k');
%this reverses the y axis
set(gca,'YDir','reverse')
