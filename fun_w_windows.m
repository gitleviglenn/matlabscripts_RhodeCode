%------------------------------------------------------------------------------------
% fun_w_windows.m
%
% computes a few statistics with over the specified windows
%
% calls:            window_wmean_fun
% 
% levi silvers                                                     june 2017
%------------------------------------------------------------------------------------
% conversion factors for lat/lon
conv_am4=288.0/360.;
conv_lat_am2=90.0/180.;
conv_lon_am2=144.0/360.;

%fieldin=squeeze(eis_ens_am4_mn(100,:,:));
fieldin=squeeze(sw_cre_am4_mn(100,:,:));
%fieldin=squeeze(mean(sw_cre_am4_mn,1));
sw_cre_late=sw_cre_am4_mn(1260:1620,:,:);
sw_cre_early=sw_cre_am4_mn(660:1020,:,:);
sw_change=sw_cre_late-sw_cre_early;
%fieldin=squeeze(mean(sw_change,1));
plotfield=fieldin;

wlon1=1;
wlon2=288;
wlat1=1;
wlat2=30;

[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);

sh_wind=wgt_mean_wind;

%global_mean1=wgt_mean

wlon1=1;
wlon2=288;
wlat1=31;
wlat2=180;

%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);

nh_wind=wgt_mean_wind;

global_mean=wgt_mean

% the 'weighting is already done in window_wmean_fun by dividing by the 
% total sum of all weighted grid points
%nh_plus_sh_new=nh_wind+sh_wind

%nh_plus_sh_gp=(nh_wind*double(180*100)+sh_wind*double(180*188))/tgp


%% test window -------------------------------------
%wlon1=conv_am4*65;
%wlon2=conv_am4*75; 
%wlat1=80;
%wlat2=90;
wlon1=conv_am4*1;
wlon2=conv_am4*30; 
wlat1=1;
wlat2=15;

fillwindowval=0.2;
plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
test_wind=wgt_mean_wind

%% southern ocean window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=30;
wlat2=40;
plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean=wgt_mean_wind

%% california window
wlon1=conv_am4*220;
wlon2=conv_am4*230;
wlat1=110;
wlat2=120;

plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;

%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);

%wlon1_cal=wlon1
%wlon2_cal=wlon2
cal_wind=wgt_mean_wind

% south
wlon1=conv_am4*1;
wlon2=conv_am4*360;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,1,109,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_wind=wgt_mean_wind;

% north
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,121,180,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
n_wind=wgt_mean_wind;

%wlon1_full=wlon1
%wlon2_full=wlon2

% left
wlat1=110;
wlat2=120;
wlon1=1;
wlon2=conv_am4*219;

%wlon1_left=wlon1
%wlon2_left=wlon2

%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
l_wind=wgt_mean_wind;

% right

wlon1=conv_am4*231;
wlon2=288;

%wlon1_right=wlon1
%wlon2_right=wlon2

%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
r_wind=wgt_mean_wind;

%%total_wind=(cal_wind+s_wind+n_wind+l_wind+r_wind)/5
total_calwind_plusrest=cal_wind+s_wind+n_wind+l_wind+r_wind
%
global_mean=wgt_mean

%% peruvian window -------------------------------------
wlon1=conv_am4*270;
wlon2=conv_am4*280; 
wlat1=70;
wlat2=80;
plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
peru_wind=wgt_mean_wind
%% namibian window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*10; 
wlat1=70;
wlat2=80;
plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nam_wind=wgt_mean_wind
%% australian window -------------------------------------
wlon1=conv_am4*95;
wlon2=conv_am4*105; 
wlat1=55;
wlat2=65;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
aus_wind=wgt_mean_wind

plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;

%% canarian window -------------------------------------
wlon1=conv_am4*325;
wlon2=conv_am4*335; 
wlat1=105;
wlat2=115;
plotfield(wlat1:wlat2,wlon1:wlon2)=fillwindowval;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
can_wind=wgt_mean_wind

%% sh window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=1;
wlat2=55;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sh_wind=wgt_mean_wind

%% middle window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=56;
wlat2=120;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
middle_wind=wgt_mean_wind

%% nh window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=121;
wlat2=180;
%[wgt_mean,wgt_mean_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nh_wind=wgt_mean_wind

sh_nh_middle_tot=sh_wind+nh_wind+middle_wind

windows=zeros(5,1);

windows(1)=cal_wind;
windows(2)=peru_wind;
windows(3)=nam_wind;
windows(4)=aus_wind;
windows(5)=can_wind;

%plotfield(wlat1:wlat2,wlon1:wlon2)=5;


% contours for swcre
conts=[-5,-4,-3,-2,-1,1,2,3,4,5];
caxisin=([-5 5]);
cont_map_modis(plotfield,vlat,vlon,conts,caxisin)
colorbar



%% end
