%------------------------------------------------------------------------------------
% alpha_window.m
%
% computes alpha (climate feedback parameter) and alpha_lcc (low-cloud cover with alpha
% method).  The method for computing alpha is the same as that used in Gregory and 
% Andrews 2016.  Each point in time represents the regression of TOA radiative imbalance
% against near surface temperature change.  Regression is performed over a 30 year 
% sliding window.  
%
% alpha and alpha_lcc are computed as global mean values, as well as over specific 
% windows.  
%
% This script relies on alpha_09.m to perform the regression analysis.
%
% is called by:  alpha_window_driver.m
%
% calls:         alpha_09.m
%
% Time series are computed from the following variables: 
%temp_ll_ts(tindex,vlat,vlon)
%lcloud_ts
%olr_ts
%olr_clr_ts
%swdn_ts
%swup_clr_ts
%swup_ts
%
% levi silvers                                                     aug 2017
%------------------------------------------------------------------------------------

% define input variables: 

% conversion factors for lat/lon
%conv_am4=288.0/360.;
%conv_lat_am2=90.0/180.;
%conv_lon_am2=144.0/360.;

%grid_conv_lon_am4=288.0/360.;
%grid_conv_lat_am4=180.0/180.;
%grid_conv_lat_am2=90.0/180.;
%grid_conv_lon_am2=144.0/360.;
%

%% satlantic window -------------------------------------
% begins 5 degrees more westward than Qu and is 2 further south
wlon1=int16(conv_lon*330);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);

%% nam 20x40 degrees (from Qu et al)
% west part
%wlon1=int16(conv_lon*335);
%wlon2=int16(conv_lon*360);
%wlat1=int16(conv_lat*62);
%wlat2=int16(conv_lat*82);
% east part
%wlon1=int16(1.);
%wlon2=int16(conv_lon*15);
%wlat1=int16(conv_lat*62);
%wlat2=int16(conv_lat*82);

%%% sh window -------------------------------------
%wlon1=int16(conv_lon*1);
%wlon2=int16(conv_lon*360); 
%wlat1=int16(1);
%wlat2=int16(59);

alpha_09;
alpha_full            =alpha_30y;
alpha_lcc_full        =alpha_lcc_30y;

alpha_window_satl     =alpha_30y_wind;
alpha_lcc_window_satl =alpha_lcc_30y_wind;

%% indian window -------------------------------------
% shifted 15 degrees to the west of Qu, 5 degrees north (twd equator)
wlon1=int16(conv_lon*60);
wlon2=int16(conv_lon*90); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);

%% aus 20x40 degrees (from Qu)
%wlon1=int16(conv_lon*75);
%wlon2=int16(conv_lon*115);
%wlat1=int16(conv_lat*55);
%wlat2=int16(conv_lat*75);

alpha_09;
alpha_window_sind=alpha_30y_wind;
alpha_lcc_window_sind=alpha_lcc_30y_wind;

%% peruvian window -------------------------------------
% within Qu's window (lat and lon)
wlon1=int16(conv_lon*250);
wlon2=int16(conv_lon*280); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);
%% per 20x40 degrees (from Qu)
%wlon1=int16(conv_lon*250);
%wlon2=int16(conv_lon*290);
%wlat1=int16(conv_lat*60);
%wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_sepac=alpha_30y_wind;
alpha_lcc_window_sepac=alpha_lcc_30y_wind;

%% california window (lon within Qu's window; lat shifted 5 south)
wlon1=int16(conv_lon*210);
wlon2=int16(conv_lon*240);
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);
%% Qu et al 2014 windows (guessing here)
%% cal 20x40 degrees
%wlon1=int16(conv_lon*205);
%wlon2=int16(conv_lon*245);
%wlat1=int16(conv_lat*105);
%wlat2=int16(conv_lat*125);

alpha_09;
alpha_window_nepac=alpha_30y_wind;
alpha_lcc_window_nepac=alpha_lcc_30y_wind;

%average the two eastern pacific windows together
alpha_window_epac=(alpha_window_nepac+alpha_window_sepac)/2;
alpha_lcc_window_epac=(alpha_lcc_window_nepac+alpha_lcc_window_sepac)/2;

%% southern ocean window -------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*40); % 40-50S as in Grise and Medeiros 2016
wlat2=int16(conv_lat*50);

alpha_09;
alpha_window_s_ocean=alpha_30y_wind;
alpha_lcc_window_s_ocean=alpha_lcc_30y_wind;

%% tropics ---------------------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*90);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_ntrops=alpha_30y_wind;
alpha_lcc_window_ntrops=alpha_lcc_30y_wind;

wlon1=int16(1);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*90);

alpha_09;
alpha_window_strops=alpha_30y_wind;
alpha_lcc_window_strops=alpha_lcc_30y_wind;

%% north of tropics ---------------------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*120);
wlat2=int16(conv_lat*180);

alpha_09;
alpha_window_nextrops=alpha_30y_wind;
alpha_lcc_window_nextrops=alpha_lcc_30y_wind;

%% south of tropics ---------------------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*1);
wlat2=int16(conv_lat*60);

alpha_09;
alpha_window_sextrops=alpha_30y_wind;
alpha_lcc_window_sextrops=alpha_lcc_30y_wind;

%% +/-10 tropics -------------------------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*80);
wlat2=int16(conv_lat*100);

alpha_09;
alpha_window_pm10trops=alpha_30y_wind;
alpha_lcc_window_pm10trops=alpha_lcc_30y_wind;

%% east of california window ------------------------------------------
wlon1=int16(conv_lon*240);
wlon2=int16(conv_lon*360); 
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_eofcali=alpha_30y_wind;
alpha_lcc_window_eofcali=alpha_lcc_30y_wind;

%% west of california window ------------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*210); 
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_wofcali=alpha_30y_wind;
alpha_lcc_window_wofcali=alpha_lcc_30y_wind;

%% west of s indian window------------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*60); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_wofindia=alpha_30y_wind;
alpha_lcc_window_wofindia=alpha_lcc_30y_wind;

%% central s pacific      ------------------------------------------
wlon1=int16(conv_lon*90);
wlon2=int16(conv_lon*250); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_centrpac=alpha_30y_wind;
alpha_lcc_window_centrpac=alpha_lcc_30y_wind;

%% east of peru window   ------------------------------------------
wlon1=int16(conv_lon*280);
wlon2=int16(conv_lon*330); 
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_eofperu=alpha_30y_wind;
alpha_lcc_window_eofperu=alpha_lcc_30y_wind;

%% below are the 5 tropical windows from Klein and Hartmann 1993

%% california window
wlon1=int16(conv_lon*230);
wlon2=int16(conv_lon*240);
wlat1=int16(conv_lat*110);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_khcal=alpha_30y_wind;
alpha_lcc_window_khcal=alpha_lcc_30y_wind;

%% peruvian window -------------------------------------
wlon1=int16(conv_lon*270);
wlon2=int16(conv_lon*280);
wlat1=int16(conv_lat*70);
wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_khper=alpha_30y_wind;
alpha_lcc_window_khper=alpha_lcc_30y_wind;

%% namibian window -------------------------------------
wlon1=int16(1);
wlon2=int16(conv_lon*10);
wlat1=int16(conv_lat*70);
wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_khnam=alpha_30y_wind;
alpha_lcc_window_khnam=alpha_lcc_30y_wind;

%% australian window -------------------------------------
wlon1=int16(conv_lon*95);
wlon2=int16(conv_lon*105);
wlat1=int16(conv_lat*55);
wlat2=int16(conv_lat*65);

alpha_09;
alpha_window_khaus=alpha_30y_wind;
alpha_lcc_window_khaus=alpha_lcc_30y_wind;

%% canarian window -------------------------------------
wlon1=int16(conv_lon*325);
wlon2=int16(conv_lon*335);
wlat1=int16(conv_lat*105);
wlat2=int16(conv_lat*115);

alpha_09;
alpha_window_khcan=alpha_30y_wind;
alpha_lcc_window_khcan=alpha_lcc_30y_wind;

%% below are the 5 windows that I am guessing Qu et al. 2014 used...

% Qu et al 2014 windows (guessing here)
% cal 20x40 degrees
wlon1=int16(conv_lon*205);
wlon2=int16(conv_lon*245);
wlat1=int16(conv_lat*105);
wlat2=int16(conv_lat*125);

alpha_09;
alpha_window_qucal=alpha_30y_wind;
alpha_lcc_window_qucal=alpha_lcc_30y_wind;

% per 20x40 degrees
wlon1=int16(conv_lon*250);
wlon2=int16(conv_lon*290);
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*80);

alpha_09;
alpha_window_quper=alpha_30y_wind;
alpha_lcc_window_quper=alpha_lcc_30y_wind;

% aus 20x40 degrees
wlon1=int16(conv_lon*75);
wlon2=int16(conv_lon*115);
wlat1=int16(conv_lat*55);
wlat2=int16(conv_lat*75);

alpha_09;
alpha_window_quaus=alpha_30y_wind;
alpha_lcc_window_quaus=alpha_lcc_30y_wind;

% nam 20x40 degrees
wlon1=int16(1.);
wlon2=int16(conv_lon*15);
wlat1=int16(conv_lat*62);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_qunam1=alpha_30y_wind;
alpha_lcc_window_qunam1=alpha_lcc_30y_wind;

wlon1=int16(conv_lon*335);
wlon2=int16(conv_lon*360);
wlat1=int16(conv_lat*62);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_qunam2=alpha_30y_wind;
alpha_lcc_window_qunam2=alpha_lcc_30y_wind;

% can
wlon1=int16(conv_lon*305);
wlon2=int16(conv_lon*345);
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_qucan=alpha_30y_wind;
alpha_lcc_window_qucan=alpha_lcc_30y_wind;

%% below are the 12 windows that I need to compute the tropics minus qu windows...

% A
wlon1=int16(1.);
wlon2=int16(conv_lon*360);
wlat1=int16(conv_lat*82);
wlat2=int16(conv_lat*100);

alpha_09;
alpha_window_quA=alpha_30y_wind;
alpha_lcc_window_quA=alpha_lcc_30y_wind;

% B1
wlon1=int16(conv_lon*345);
wlon2=int16(conv_lon*360);
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_quB1=alpha_30y_wind;
alpha_lcc_window_quB1=alpha_lcc_30y_wind;

% B2
wlon1=int16(1.);
wlon2=int16(conv_lon*205);
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_quB2=alpha_30y_wind;
alpha_lcc_window_quB2=alpha_lcc_30y_wind;

% C
wlon1=int16(conv_lon*205);
wlon2=int16(conv_lon*245);
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*105);

alpha_09;
alpha_window_quC=alpha_30y_wind;
alpha_lcc_window_quC=alpha_lcc_30y_wind;

% D
wlon1=int16(conv_lon*245);
wlon2=int16(conv_lon*305);
wlat1=int16(conv_lat*100);
wlat2=int16(conv_lat*120);

alpha_09;
alpha_window_quD=alpha_30y_wind;
alpha_lcc_window_quD=alpha_lcc_30y_wind;

% E
wlon1=int16(conv_lon*250);
wlon2=int16(conv_lon*290);
wlat1=int16(conv_lat*80);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_quE=alpha_30y_wind;
alpha_lcc_window_quE=alpha_lcc_30y_wind;

% F
wlon1=int16(conv_lon*115);
wlon2=int16(conv_lon*250);
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_quF=alpha_30y_wind;
alpha_lcc_window_quF=alpha_lcc_30y_wind;

% G
wlon1=int16(conv_lon*290);
wlon2=int16(conv_lon*335);
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_quG=alpha_30y_wind;
alpha_lcc_window_quG=alpha_lcc_30y_wind;

% H
wlon1=int16(conv_lon*335);
wlon2=int16(conv_lon*360);
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*62);

alpha_09;
alpha_window_quH=alpha_30y_wind;
alpha_lcc_window_quH=alpha_lcc_30y_wind;

% I
wlon1=int16(1.);
wlon2=int16(conv_lon*15);
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*62);

alpha_09;
alpha_window_quI=alpha_30y_wind;
alpha_lcc_window_quI=alpha_lcc_30y_wind;

% J
wlon1=int16(conv_lon*15);
wlon2=int16(conv_lon*75);
wlat1=int16(conv_lat*60);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_quJ=alpha_30y_wind;
alpha_lcc_window_quJ=alpha_lcc_30y_wind;

% K
wlon1=int16(conv_lon*75);
wlon2=int16(conv_lon*115);
wlat1=int16(conv_lat*75);
wlat2=int16(conv_lat*82);

alpha_09;
alpha_window_quK=alpha_30y_wind;
alpha_lcc_window_quK=alpha_lcc_30y_wind;


