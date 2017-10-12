%------------------------------------------------------------------------------------
% alpha_window_driver.m
%
% Purpose: stores data from particular windows in arrays for future use. this is 
%          where the 14 windows are defined.  this is called for each ensemble 
%          member after alpha_09.m is called.  
%
% is called by:   driver_ensembles
%
% calls:          alpha_window.m
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

