%------------------------------------------------------------------------------------
% alpha_window_driver.m
%
% Purpose: stores data from particular windows in arrays for future use. this is 
%          where the 14 windows are defined.  this is called for each ensemble 
%          member after alpha_09.m is called.  
%
% is called by:   driver_ensembles --> main driver program
%
% calls:          alpha_window.m --> defines lat/lon of windows
%
% creates alpha_wind and alpha_lcc_wind arrays
%
% levi silvers                                                     aug 2017
%------------------------------------------------------------------------------------
clear alpha_window_satl alpha_window_sind alpha_window_epac alpha_window_s_ocean alpha_window_trops alpha_window_ntrops alpha_window_strops;
clear alpha_lcc_window_satl alpha_lcc_window_sind alpha_lcc_window_epac alpha_lcc_window_s_ocean alpha_lcc_window_trops alpha_lcc_window_ntrops alpha_lcc_window_strops;

% call alpha_window.m script which calls alpha_09.m
alpha_window % computes alpha and alpha_lcc over many different windows

%alpha_wind(ens,window,time) : 15,7,105
%alpha_lcc_wind(ens,window,time) : 15,7,105

%ensnum is set in calling script

alpha_wind(ensnum,1,:)=alpha_window_satl;
alpha_lcc_wind(ensnum,1,:)=alpha_lcc_window_satl;

alpha_wind(ensnum,2,:)=alpha_window_sind;
alpha_lcc_wind(ensnum,2,:)=alpha_lcc_window_sind;

alpha_wind(ensnum,3,:)=alpha_window_epac;
alpha_lcc_wind(ensnum,3,:)=alpha_lcc_window_epac;

alpha_wind(ensnum,4,:)=alpha_window_s_ocean;
alpha_lcc_wind(ensnum,4,:)=alpha_lcc_window_s_ocean;

alpha_wind(ensnum,5,:)=alpha_window_ntrops;
alpha_lcc_wind(ensnum,5,:)=alpha_lcc_window_ntrops;
alpha_wind(ensnum,6,:)=alpha_window_strops;
alpha_lcc_wind(ensnum,6,:)=alpha_lcc_window_strops;
alpha_wind(ensnum,7,:)=alpha_window_nextrops;
alpha_lcc_wind(ensnum,7,:)=alpha_lcc_window_nextrops;
alpha_wind(ensnum,8,:)=alpha_window_sextrops;
alpha_lcc_wind(ensnum,8,:)=alpha_lcc_window_sextrops;

% additional 6 windows to compute values for the rest of the tropics

alpha_wind(ensnum,9,:)      =alpha_window_pm10trops;
alpha_lcc_wind(ensnum,9,:)  =alpha_lcc_window_pm10trops;
alpha_wind(ensnum,10,:)     =alpha_window_eofcali;
alpha_lcc_wind(ensnum,10,:) =alpha_lcc_window_eofcali;
alpha_wind(ensnum,11,:)     =alpha_window_wofcali;
alpha_lcc_wind(ensnum,11,:) =alpha_lcc_window_wofcali;
alpha_wind(ensnum,12,:)     =alpha_window_wofindia;
alpha_lcc_wind(ensnum,12,:) =alpha_lcc_window_wofindia;
alpha_wind(ensnum,13,:)     =alpha_window_centrpac;
alpha_lcc_wind(ensnum,13,:) =alpha_lcc_window_centrpac;
alpha_wind(ensnum,14,:)     =alpha_window_eofperu;
alpha_lcc_wind(ensnum,14,:) =alpha_lcc_window_eofperu;

% 5 windows from Klein and Hartmann 1993
alpha_wind(ensnum,15,:)     =alpha_window_khcal;
alpha_lcc_wind(ensnum,15,:) =alpha_lcc_window_khcal;
alpha_wind(ensnum,16,:)     =alpha_window_khper;
alpha_lcc_wind(ensnum,16,:) =alpha_lcc_window_khper;
alpha_wind(ensnum,17,:)     =alpha_window_khnam;
alpha_lcc_wind(ensnum,17,:) =alpha_lcc_window_khnam;
alpha_wind(ensnum,18,:)     =alpha_window_khaus;
alpha_lcc_wind(ensnum,18,:) =alpha_lcc_window_khaus;
alpha_wind(ensnum,19,:)     =alpha_window_khcan;
alpha_lcc_wind(ensnum,19,:) =alpha_lcc_window_khcan;

% approximate windows from Qu et al. 2014
alpha_wind(ensnum,20,:)     =alpha_window_qucal;
alpha_lcc_wind(ensnum,20,:) =alpha_lcc_window_qucal;
alpha_wind(ensnum,21,:)     =alpha_window_quper;
alpha_lcc_wind(ensnum,21,:) =alpha_lcc_window_quper;
alpha_wind(ensnum,22,:)     =alpha_window_quaus;
alpha_lcc_wind(ensnum,22,:) =alpha_lcc_window_quaus;
alpha_wind(ensnum,23,:)     =alpha_window_qunam1;
alpha_lcc_wind(ensnum,23,:) =alpha_lcc_window_qunam1;
alpha_wind(ensnum,24,:)     =alpha_window_qunam2;
alpha_lcc_wind(ensnum,24,:) =alpha_lcc_window_qunam2;
alpha_wind(ensnum,25,:)     =alpha_window_qucan;
alpha_lcc_wind(ensnum,25,:) =alpha_lcc_window_qucan;

% windows to compute rest of tropics for Qu et al. 2014
alpha_wind(ensnum,26,:)     =alpha_window_quA;
alpha_lcc_wind(ensnum,26,:) =alpha_lcc_window_quA;
alpha_wind(ensnum,27,:)     =alpha_window_quB1;
alpha_lcc_wind(ensnum,27,:) =alpha_lcc_window_quB1;
alpha_wind(ensnum,28,:)     =alpha_window_quB2;
alpha_lcc_wind(ensnum,28,:) =alpha_lcc_window_quB2;
alpha_wind(ensnum,29,:)     =alpha_window_quC;
alpha_lcc_wind(ensnum,29,:) =alpha_lcc_window_quC;
alpha_wind(ensnum,30,:)     =alpha_window_quD;
alpha_lcc_wind(ensnum,30,:) =alpha_lcc_window_quD;
alpha_wind(ensnum,31,:)     =alpha_window_quE;
alpha_lcc_wind(ensnum,31,:) =alpha_lcc_window_quE;
alpha_wind(ensnum,32,:)     =alpha_window_quF;
alpha_lcc_wind(ensnum,32,:) =alpha_lcc_window_quF;
alpha_wind(ensnum,33,:)     =alpha_window_quG;
alpha_lcc_wind(ensnum,33,:) =alpha_lcc_window_quG;
alpha_wind(ensnum,34,:)     =alpha_window_quH;
alpha_lcc_wind(ensnum,34,:) =alpha_lcc_window_quH;
alpha_wind(ensnum,35,:)     =alpha_window_quI;
alpha_lcc_wind(ensnum,35,:) =alpha_lcc_window_quI;
alpha_wind(ensnum,36,:)     =alpha_window_quJ;
alpha_lcc_wind(ensnum,36,:) =alpha_lcc_window_quJ;
alpha_wind(ensnum,37,:)     =alpha_window_quK;
alpha_lcc_wind(ensnum,37,:) =alpha_lcc_window_quK;



