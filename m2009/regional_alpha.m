%---------------------------------------------------------
% compute the cliamate feedback parameter over the whole
% globe as well as over particular window regions
%
% calls:
%   alpha_09.m
%
% needs: 
%   readvars.m or something equivalent
%
% levi silvers                                mar 2017
%
% updated                                     apr 2017
%---------------------------------------------------------
% if the memory has been cleared, it is likely that 
% readvars.m will need to be run...

conv_am4=288.0/360.;
conv_lat_am2=90.0/180.;

%---------------------------------------------------------
% if running this independent of preloaded data use something like:
pathbase='/net2/Levi.Silvers/data/amip_long/';
modelver='AM4';path='/c96L32_am4g10r8_longamip_1860rad/';
years2='atmos.187101-201512';
piece=strcat(pathbase,path,years2);
%level500=6; % for AM2 
%level700=4; % for AM2, 
level500=7; % for AM3 and AM4 
level700=5; % for AM3, and AM4

%
timest=13;
timeend=1632;
%
readvars
%
%---------------------------------------------------------
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

wlat1=70;
wlat2=110;
wlon1=1;
wlon2=288;

alpha_09

alpha_full=alpha_30y;
tref_full=tref_gmn_ts;
alpha_window_70th110=alpha_30y_wind;
tref_window_70th110=tref_wind_ts;

wlat1=1;
wlat2=70;
wlon1=1;
wlon2=288;

alpha_09
tref_window_1th70=tref_wind_ts;
alpha_window_1th70=alpha_30y_wind;

wlat1=110;
wlat2=180;
wlon1=1;
wlon2=288;

alpha_09
tref_window_110th180=tref_wind_ts;
alpha_window_110th180=alpha_30y_wind;

figure
plot(alpha_full,'k')
hold on
plot(alpha_window_1th70)
plot(alpha_window_70th110)
plot(alpha_window_110th180)
alpha_app_tot=(alpha_window_1th70+alpha_window_70th110+alpha_window_110th180)./3;
plot(alpha_app_tot,'r')
title('alpha')

alpha_diff=alpha_full-alpha_app_tot;
figure
plot(alpha_diff)


figure
plot(tref_full(100:150),'k')
hold on
plot(tref_window_1th70(100:150))
plot(tref_window_70th110(100:150))
plot(tref_window_110th180(100:150))
tref_app_tot=(tref_window_1th70+tref_window_70th110+tref_window_110th180)./3;
plot(tref_app_tot(100:150),'r')
title('tref')
