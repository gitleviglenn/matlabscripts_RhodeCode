%------------------------------------------------------------------------------------
% window_table.m
%
% levi silvers                                                     june 2017
%------------------------------------------------------------------------------------

path='/net2/Levi.Silvers/data/amip_long/pp_files/';
%variable='toa_sw_cre_out'
variable_sw='sw_cre_trend'
variable_eis='eis_trend'
%variable='hcloud_trend'
variable='lcloud_trend'
%filein='am4_ensmn_tref_early_pdown.nc';
%filein='am4_trends_tref_early_pdown.nc';
filein='am4_trends_tref_late_pdown.nc';
filein_early='am4_trends_tref_early_pdown.nc';
source=strcat(path,filein);
source_e=strcat(path,filein_early);
file=netcdf(source,'nowrite');
file_early=netcdf(source_e,'nowrite');
varin_late=file{variable}(:,:,:); 
varin_early=file_early{variable}(:,:,:); 
sw_late=file{variable_sw}(:,:,:); 
sw_early=file_early{variable_sw}(:,:,:); 
eis_late=file{variable_eis}(:,:,:); 
eis_early=file_early{variable_eis}(:,:,:); 

%varin=-varin;
%useme=squeeze(mean(varin,1));
%useme=varin_late;

%% compute difference between time mean of each period
%filelate='am4_ensmn_tref_late_pdown.nc';
%sourcelate=strcat(path,filelate);
%file=netcdf(sourcelate,'nowrite');
%varlate=file{'toa_sw_cre_out'}(:,:,:); 
%varlatemn=squeeze(mean(varlate,1));
%
%fileearly='am4_ensmn_tref_early_pdown.nc';
%sourceearly=strcat(path,fileearly);
%file=netcdf(sourceearly,'nowrite');
%varearly=file{'toa_sw_cre_out'}(:,:,:); 
%varearlymn=squeeze(mean(varearly,1));
%useme=varlatemn-varearlymn;

%fieldin=squeeze(eis_ens_am4_mn(100,:,:));
%fieldin=squeeze(sw_cre_am4_mn(100,:,:));
%fieldin=squeeze(mean(sw_cre_am4_mn,1));
%sw_cre_late=sw_cre_am4_mn(1260:1620,:,:);
%sw_cre_early=sw_cre_am4_mn(660:1020,:,:);
%sw_change=sw_cre_late-sw_cre_early;
%fieldin=squeeze(mean(sw_change,1));

%fieldin=useme;
fieldin_early=varin_early;
fieldin=varin_late;
fieldin_sw_early=sw_early;
fieldin_sw_late=sw_late;
fieldin_eis_early=eis_early;
fieldin_eis_late=eis_late;

% these two fields are only for plotting purposes
plotfield=fieldin;
plot_newwind=fieldin;

% conversion factors for lat/lon
conv_am4=288.0/360.;
conv_lat_am2=90.0/180.;
conv_lon_am2=144.0/360.;

%%% test window -------------------------------------
%wlon1=conv_am4*65;
%wlon2=conv_am4*75; 
%wlat1=80;
%wlat2=90;
%plotfield(wlat1:wlat2,wlon1:wlon2)=5;
%[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
%test_wind=wgt_mean_wind

% the following 8 windows are as defined in Klein and Hartmann 1993
%% north atlantic window -------------------------------------
wlon1=conv_am4*315; % 35 W - 45 W
wlon2=conv_am4*325; 
wlat1=140;
wlat2=150;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);

%% north pacific window -------------------------------------
wlon1=conv_am4*170;
wlon2=conv_am4*180; 
wlat1=130;
wlat2=140;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,reg_mean_wind,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);

% these are the windows defined in Klein and Hartmann 1993
%% california window
wlon1=conv_am4*230;
wlon2=conv_am4*240;
wlat1=110;
wlat2=120;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
cal_wind_wgt_mean=wgt_mean;
cal_wind_wgt_mean_wind=wgt_mean_wind;
cal_wind_reg_mean_wind=wind_mean;
cal_wind_relarea_wind=relarea_wind;
%% peruvian window -------------------------------------
wlon1=conv_am4*270;
wlon2=conv_am4*280; 
wlat1=70;
wlat2=80;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
peru_wind_wgt_mean=wgt_mean;
peru_wind_wgt_mean_wind=wgt_mean_wind;
peru_wind_reg_mean_wind=wind_mean;
peru_wind_relarea_wind=relarea_wind;
%% namibian window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*10; 
wlat1=70;
wlat2=80;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nam_wind_wgt_mean=wgt_mean;
nam_wind_wgt_mean_wind=wgt_mean_wind;
nam_wind_reg_mean_wind=wind_mean;
nam_wind_relarea_wind=relarea_wind;
%% australian window -------------------------------------
wlon1=conv_am4*95;
wlon2=conv_am4*105; 
wlat1=55;
wlat2=65;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
aus_wind_wgt_mean=wgt_mean;
aus_wind_wgt_mean_wind=wgt_mean_wind;
aus_wind_reg_mean_wind=wind_mean;
aus_wind_relarea_wind=relarea_wind;
%% canarian window -------------------------------------
wlon1=conv_am4*325;
wlon2=conv_am4*335; 
wlat1=105;
wlat2=115;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
can_wind_wgt_mean=wgt_mean;
can_wind_wgt_mean_wind=wgt_mean_wind;
can_wind_reg_mean_wind=wind_mean;
can_wind_relarea_wind=relarea_wind;


kh_wind_wgt_mean=(cal_wind_wgt_mean+peru_wind_wgt_mean+nam_wind_wgt_mean+aus_wind_wgt_mean+can_wind_wgt_mean)/5;
kh_wind_wgt_mean_wind=cal_wind_wgt_mean_wind+peru_wind_wgt_mean_wind+nam_wind_wgt_mean_wind+aus_wind_wgt_mean_wind+can_wind_wgt_mean_wind;
kh_wind_reg_mean_wind=(cal_wind_reg_mean_wind+peru_wind_reg_mean_wind+nam_wind_reg_mean_wind+aus_wind_reg_mean_wind+can_wind_reg_mean_wind)/5;
kh_wind_relarea_wind=cal_wind_relarea_wind+peru_wind_relarea_wind+nam_wind_relarea_wind+aus_wind_relarea_wind+can_wind_relarea_wind;

windows=zeros(5,1);

windows(1)=cal_wind;
windows(2)=peru_wind;
windows(3)=nam_wind;
windows(4)=aus_wind;
windows(5)=can_wind;


%% southern ocean window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
%wlat1=25; Klein and Hartmann 1993 use latitudes between 50-65 S
%wlat2=40;
wlat1=40;
wlat2=50;
plotfield(wlat1:wlat2,wlon1:wlon2)=5;
plot_newwind(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean_wgt_mean=wgt_mean;
s_ocean_wgt_mean_wind=wgt_mean_wind;
s_ocean_reg_mean_wind=wind_mean;
s_ocean_relarea_wind=relarea_wind;

% for the early period
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean_reg_mean_early=wind_mean;
% for sw trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean_reg_mean_sw_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean_reg_mean_sw_late=wind_mean;
% for eis trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean_reg_mean_eis_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
s_ocean_reg_mean_eis_late=wind_mean;
% the following windows are of my own design....

%% sh mid lat window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=30;
wlat2=60;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sh_wind_wgt_mean=wgt_mean;
sh_wind_wgt_mean_wind=wgt_mean_wind;
sh_wind_reg_mean_wind=wind_mean;
sh_wind_relarea_wind=relarea_wind;

%% tropics window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=60;
wlat2=120;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
tropics_wgt_mean=wgt_mean;
tropics_wgt_mean_wind=wgt_mean_wind;
tropics_reg_mean_wind=wind_mean;
tropics_relarea_wind=relarea_wind;

%% nh mid lat window -------------------------------------
wlon1=conv_am4*1;
wlon2=conv_am4*360; 
wlat1=120;
wlat2=150;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nh_wind_wgt_mean=wgt_mean;
nh_wind_wgt_mean_wind=wgt_mean_wind;
nh_wind_reg_mean_wind=wind_mean;
nh_wind_relarea_wind=relarea_wind;

midlat_wind_wgt_mean=(nh_wind_wgt_mean+sh_wind_wgt_mean)/2;
midlat_wind_wgt_mean_wind=nh_wind_wgt_mean_wind+sh_wind_wgt_mean_wind;
midlat_wind_reg_mean_wind=(nh_wind_reg_mean_wind+sh_wind_reg_mean_wind)/2;
midlat_wind_relarea_wind=nh_wind_relarea_wind+sh_wind_relarea_wind;

%%%
%  try to create some sort of eastern pacific window to compare with zhou et al....
%  these are both 20lat by 30 deg lon
%% california window
wlon1=conv_am4*210;
wlon2=conv_am4*240;
wlat1=100;
wlat2=120;
plot_newwind(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nepac_wind_wgt_mean=wgt_mean;
nepac_wind_wgt_mean_wind=wgt_mean_wind;
nepac_wind_reg_mean_wind=wind_mean;
nepac_wind_relarea_wind=relarea_wind;
% for the early period
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nepac_reg_mean_early=wind_mean;
% for sw trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nepac_reg_mean_sw_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nepac_reg_mean_sw_late=wind_mean;
% for eis trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nepac_reg_mean_eis_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
nepac_reg_mean_eis_late=wind_mean;
%% peruvian window -------------------------------------
wlon1=conv_am4*250;
wlon2=conv_am4*280; 
wlat1=60;
wlat2=80;
plot_newwind(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sepac_wind_wgt_mean=wgt_mean;
sepac_wind_wgt_mean_wind=wgt_mean_wind;
sepac_wind_reg_mean_wind=wind_mean;
sepac_wind_relarea_wind=relarea_wind;

% for the early period
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sepac_reg_mean_early=wind_mean;
% for sw trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sepac_reg_mean_sw_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sepac_reg_mean_sw_late=wind_mean;
% for eis trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sepac_reg_mean_eis_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sepac_reg_mean_eis_late=wind_mean;

% average the two eastern pacific windows together 
epac_wind_reg_mean_wind =(sepac_wind_reg_mean_wind+nepac_wind_reg_mean_wind)/2;
epac_reg_mean_early     =(sepac_reg_mean_early+nepac_reg_mean_early)/2;
epac_reg_mean_sw_early  =(sepac_reg_mean_sw_early+nepac_reg_mean_sw_early)/2;
epac_reg_mean_sw_late   =(sepac_reg_mean_sw_late+nepac_reg_mean_sw_late)/2;
epac_reg_mean_eis_early  =(sepac_reg_mean_eis_early+nepac_reg_mean_eis_early)/2;
epac_reg_mean_eis_late   =(sepac_reg_mean_eis_late+nepac_reg_mean_eis_late)/2;

% and my own two windows....
%% indian window -------------------------------------
wlon1=conv_am4*60;
wlon2=conv_am4*90; 
wlat1=60;
wlat2=80;
plot_newwind(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sind_wind_wgt_mean=wgt_mean;
sind_wind_wgt_mean_wind=wgt_mean_wind;
sind_wind_reg_mean_wind=wind_mean;
sind_wind_relarea_wind=relarea_wind;

% for the early period
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sind_reg_mean_early=wind_mean;
% for sw trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sind_reg_mean_sw_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sind_reg_mean_sw_late=wind_mean;
% for eis trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sind_reg_mean_eis_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
sind_reg_mean_eis_late=wind_mean;

%% satlantic window -------------------------------------
wlon1=conv_am4*330;
wlon2=conv_am4*360; 
wlat1=60;
wlat2=80;
plot_newwind(wlat1:wlat2,wlon1:wlon2)=5;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
satl_wind_wgt_mean=wgt_mean;
satl_wind_wgt_mean_wind=wgt_mean_wind;
satl_wind_reg_mean_wind=wind_mean;
satl_wind_relarea_wind=relarea_wind;

% for the early period
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(fieldin_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
satl_reg_mean_early=wind_mean;
% for sw trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
satl_reg_mean_sw_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(sw_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
satl_reg_mean_sw_late=wind_mean;
% for eis trend early and late periods
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_early,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
satl_reg_mean_eis_early=wind_mean;
[wgt_mean,wgt_mean_wind,wind_mean,relarea_wind]=window_wmean_fun(eis_late,vlon,vlat,wlat1,wlat2,wlon1,wlon2);
satl_reg_mean_eis_late=wind_mean;

% table for comparing swcre and llc from eastern pacific, indian, and atlantic oceans
swcre_llc_array=zeros(4,6);
% early period
swcre_llc_array(1,1)=epac_reg_mean_early;
swcre_llc_array(2,1)=sind_reg_mean_early;
swcre_llc_array(3,1)=satl_reg_mean_early;
swcre_llc_array(4,1)=s_ocean_reg_mean_early;
% late period
swcre_llc_array(1,2)=epac_wind_reg_mean_wind;
swcre_llc_array(2,2)=sind_wind_reg_mean_wind;
swcre_llc_array(3,2)=satl_wind_reg_mean_wind;
swcre_llc_array(4,2)=s_ocean_reg_mean_wind;
% sw early period
swcre_llc_array(1,3)=epac_reg_mean_sw_early;
swcre_llc_array(2,3)=sind_reg_mean_sw_early;
swcre_llc_array(3,3)=satl_reg_mean_sw_early;
swcre_llc_array(4,3)=s_ocean_reg_mean_sw_early;
% sw late period
swcre_llc_array(1,4)=epac_reg_mean_sw_late;
swcre_llc_array(2,4)=sind_reg_mean_sw_late;
swcre_llc_array(3,4)=satl_reg_mean_sw_late;
swcre_llc_array(4,4)=s_ocean_reg_mean_sw_late;
% eis early period
swcre_llc_array(1,5)=epac_reg_mean_eis_early;
swcre_llc_array(2,5)=sind_reg_mean_eis_early;
swcre_llc_array(3,5)=satl_reg_mean_eis_early;
swcre_llc_array(4,5)=s_ocean_reg_mean_eis_early;
% eis late period
swcre_llc_array(1,6)=epac_reg_mean_eis_late;
swcre_llc_array(2,6)=sind_reg_mean_eis_late;
swcre_llc_array(3,6)=satl_reg_mean_eis_late;
swcre_llc_array(4,6)=s_ocean_reg_mean_eis_late;

% original table below.....
wind_table=zeros(4,4);

wind_table(1,1)=kh_wind_wgt_mean;
wind_table(1,2)=kh_wind_wgt_mean_wind;
wind_table(1,3)=kh_wind_reg_mean_wind;
wind_table(1,4)=kh_wind_relarea_wind;

wind_table(2,1)=tropics_wgt_mean;
wind_table(2,2)=tropics_wgt_mean_wind;
wind_table(2,3)=tropics_reg_mean_wind;
wind_table(2,4)=tropics_relarea_wind;

wind_table(3,1)=midlat_wind_wgt_mean;
wind_table(3,2)=midlat_wind_wgt_mean_wind;
wind_table(3,3)=midlat_wind_reg_mean_wind;
wind_table(3,4)=midlat_wind_relarea_wind;

wind_table(4,1)=s_ocean_wgt_mean;
wind_table(4,2)=s_ocean_wgt_mean_wind;
wind_table(4,3)=s_ocean_reg_mean_wind;
wind_table(4,4)=s_ocean_relarea_wind;

%print the table to screen
wind_table

%print the LLC and SWCRE table to screen
swcre_llc_array

% make a figure
% contours for swcre
conts=[-5,-4,-3,-2,-1,1,2,3,4,5];
caxisin=([-5 5]);
%conts=[10,20,30,40,50,60,70,80,90,100];
%caxisin=([10 100]);
%cont_map_modis(plotfield,vlat,vlon,conts,caxisin)
cont_map_modis(plot_newwind,vlat,vlon,conts,caxisin)
colorbar



%% end
