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
%-----------------------------------------------------------------------------------

% for the DECK amip experiment
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

