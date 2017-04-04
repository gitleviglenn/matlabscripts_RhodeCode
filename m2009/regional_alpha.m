%---------------------------------------------------------
% compute the cliamate feedback parameter over the whole
% globe as well as over particular window regions
%
% uses:
%   alpha_09.m
%
% levi silvers                              march 2017
%---------------------------------------------------------
% if the memory has been cleared, it is likely that 
% readvars.m will need to be run...

conv_am4=288.0/360.;
conv_lat_am2=90.0/180.;
%pathbase='/net2/Levi.Silvers/data/amip_long/';
%modelver='AM4';path='/c96L32_am4g10r8_longamip_1860rad/';
%years2='atmos.187101-201512';
%piece=strcat(pathbase,path,years2);
%
timest=13;
timeend=1632;
%
%source_tsurf_ts    = strcat(piece,'.t_surf.nc')
%source_tref_ts    = strcat(piece,'.t_ref.nc')
%fin_tsurf     = netcdf(source_tsurf_ts,'nowrite');
%fin_tref      = netcdf(source_tref_ts,'nowrite');
%temp_sfc_ts   = fin_tsurf{'t_surf'}(timest:timeend,:,:);
temp_ref_ts   = fin_tref{'t_ref'}(timest:timeend,:,:);
%vlat          = fin_tsurf{'lat'}(:);
%vlon          = fin_tsurf{'lon'}(:);

temp_ll_ts = temp_ref_ts;
%eis_ts  =eis_ens_am4_mn;
%lcloud_ts=lcloud_am4_mn;

wlat1=71;
wlat2=110;
wlon1=1;
wlon2=288;

alpha_09

alpha_full=alpha_30y;
tref_full=tref_gmn_ts;
alpha_window_71th110=alpha_30y_wind;
tref_window_71th110=tref_wind_ts;

wlat1=1;
wlat2=70;
wlon1=1;
wlon2=288;

alpha_09
tref_window_1th70=tref_wind_ts;
alpha_window_1th70=alpha_30y_wind;

wlat1=111;
wlat2=180;
wlon1=1;
wlon2=288;

alpha_09
tref_window_111th180=tref_wind_ts;
alpha_window_111th180=alpha_30y_wind;

figure
plot(alpha_full,'k')
hold on
plot(alpha_window_1th70)
plot(alpha_window_71th110)
plot(alpha_window_111th180)
alpha_app_tot=(alpha_window_1th70+alpha_window_71th110+alpha_window_111th180)./3;
plot(alpha_app_tot,'r')

