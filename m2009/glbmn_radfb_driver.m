%-----------------------------------------------------------------------------------
% glbmn_radfb_driver.m
%
% used in a 2009 version of Matlab
%
% depends on glbmn_radfb.m, readvars_radflux.m, global_weights.m
%
% glbmn_radfb.m creates time series of the global mean of the desired
%               variables, then it computes the monthly means of those
%               time series.
%
% matlab driver script to compute radiative feedbacks of the 
% amip p4K and amip future experiments as part of cfmip 
%
% the amip arrays contain the following: 
% mnR, mncre, mncrelw, mncresw, mnclrlw, mnclrsw, mntas
%
% levi silvers                                                   sep 2018
%
% to add: computations for the aquaplanet control and p4K experiment
%         computations for the coupled 4xCO2
%
%-----------------------------------------------------------------------------------

% for the DECK amip experiment
do_aqua = 0;  % switch used in glbmn_radfb.m  set to 1 for aquaplanet
aqua_hack = 0; % hack necessary only for aqua-p4k, should eventually be removed

pathbase='/archive/oar.gfdl.cmip6/CM4/warsaw_201803/';
path='CM4_amip/gfdl.ncrc4-intel16-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';

glbmn_radfb;

amip_array=flux_array;

% for amip plus 4K 
pathbase='/archive/Oar.Gfdl.Mgrp-account/CMIP6/CM4/CFMIP/warsaw_201803/';
path='amip-p4K-a/gfdl.ncrc4-intel-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';

glbmn_radfb;

amip4k_array=flux_array;

%mnR,mncre,mncrelw,mncresw,mnclrlw,mnclrsw,mntas
amip_4k_fb=(amip4k_array-amip_array)/(amip4k_array(7)-amip_array(7))

% for amip future 4K
pathbase='/archive/Oar.Gfdl.Mgrp-account/CMIP6/CM4/CFMIP/warsaw_201803/';
path='CM4_amip_future4K/gfdl.ncrc4-intel-prod-openmp/pp/atmos_cmip/ts/monthly/36yr/';
glbmn_radfb;

amip_future_array=flux_array;

amip_future_fb=(amip_future_array-amip_array)/(amip_future_array(7)-amip_array(7))

%% for aquaplanet experiments
do_aqua = 1;  % switch used in glbmn_radfb.m  set to 1 for aquaplanet
%  put a switch into the glbmn_radfb.m script to account for the 
%  changing timescales when using an aquaplanet.  
% 
%  the p4K aquaplanet needs to be rerun because it doesn't yet have 
%  the additional surface variables like tas that we need.  
%  I hacked the glbmn_radfb.m and readvars_radflux.m...
%
%pathbase='/archive/Oar.Gfdl.Mgrp-account/CMIP6/CM4/CFMIP/warsaw_201803/';
pathbase='/archive/Oar.Gfdl.Mgrp-account/CMIP6/CM4/CFMIP/xanadu/';
path='aqua-control/gfdl.ncrc3-intel-prod-openmp/pp/atmos_cmip/ts/monthly/10yr/';
glbmn_radfb;
%
aqua_control_array=flux_array;
%
%%pathbase='/archive/Oar.Gfdl.Mgrp-account/CMIP6/CM4/CFMIP/warsaw_201803/';
pathbase='/archive/Levi.Silvers/CMIP6/CM4/CFMIP/warsaw_201803/';
path='aqua-p4K/gfdl.ncrc3-intel-prod-openmp/pp/atmos_cmip/ts/monthly/10yr/';
aqua_hack = 1; % hack necessary because we don't have tas in aqua-p4k yet...
glbmn_radfb;
%%
aqua_p4k_array=flux_array;
%%
aqua_p4k_fb=(aqua_p4k_array-aqua_control_array)/(aqua_p4k_array(7)-aqua_control_array(7))
%




