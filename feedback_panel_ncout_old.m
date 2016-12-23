%------------------------------------------------------------------------------------------
% feedback_panel_ncout.m
%
% 1. read in variables from input files
% 2. compute cosine weighted global mean values
% 3. compute radiative flux at toa and temp diff pattern
% 4. compute feedbacks between two experiments
% 5. compute cloud radiative effects
% 6. compute zonal mean of feedbacks and cre's
% 7. normalize the feedbacks and zonal means
% 8. make figures
%         - zonal mean temp chng
%         - 4 panel plot of global temp change during 20 increments
%         - global mean patterns of cre
%         - zonal mean of cre, basic and normalized
% 9. write output to a netcdf file for use in ncl
%
% levi silvers                                        Apr 2016
%------------------------------------------------------------------------------------------

% name the output nc files
%fnout_cm4_diff='AM4OM2F_c96l32_am4g5r11_2000climo_1pct_response.nc'
file_out='testout.nc'
%fnout_cm2_1_diff='CM2.1U-D4_1PctTo2X_response.nc'

dirMing='/archive/Ming.Zhao/awglg/ulm/'; % directory for AM4OM2
%dirMing='/archive/Ming.Zhao/awg/ulm/'; % directory for CM2.1
dirLevi='/archive/Levi.Silvers/awg/ulm_201505/';
basedir=dirLevi;

%------------beginning of new block
%%% 1pct increase in CO2 experiment and control
%%% for AM4 model: 
%exp1name='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
%exp2name='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
%expyrs1='atmos.006101-014012.';
%expyrs2='atmos.000101-014012.';
%modelname='Model: AM4OM2'
%lengthyr=80; % length of time series in years
%%latinc=30;
%%sonic=1:latinc:180;
%% it is possible to have time series of two different lengths
%% depending on how the output from the forced vs control run was saved...
%iend=960;
%iend2=1680;
%% endt is the end index for the time series that have been computed
%% with a running mean of +/- 6 months so it is 13 months shorter
%endt=947; % needs to be iend -1 year and one month

%%% for CM2 model: 
%exp1name='CM2.1U-D4_1PctTo2X_I1/ts_all/';
%%exp2name='CM2.1U_Control-1990_E1/ts_all/';
%exp2name='CM2.1U_Control-1860_D4/ts_all/';
%expyrs1='atmos.000101-010012.';
%expyrs2='atmos.000101-010012.';
%modelname='Model: CM2'
%% for time series 100 years in length:
%lengthyr=100;
%iend=1200;
%iend2=1200; % istart2=iend2-iend+1; 
%% endt is the end index for the time series that have been computed
%% with a running mean of +/- 6 months so it is 13 months shorter
%endt=1187;
%%istart2=iend2-iend+1;
%%latinc=15;
%%sonic=1:latinc:90;
%
%exp1=strcat(basedir,exp1name);
%exp2=strcat(basedir,exp2name);
%
%%% ------------------
%% use below for coupled experiments
%% pstart and pend define the period over which the feedbacks are computed
%pstart=720;
%%pend=1200;
%pend=960;
%iarr=[1 120 240 480 720 960];
%%% end coupled block
%%%

%% abrupt 4XCO2 forcing
%exp1name='AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/';
%expyrs1='atmos.006101-015012.';

%%%% from ctl+sst pattern experiments
%%%----- Beginning of block for reg+pattern experiments
  %
  %x1name='c96L32_am4g6_1860climo_ctlpreg_1per_co2_weaker/';
  %modelname='Model: AM4 1860 sst patt 1Pcnt 80yrscale'
  %modelname='Model: AM4 2000 sst patt 1Pcnt'
  %x1name='c96L32_am4g6_2000climo_ctlpreg_1per_co2/';
  modelname='Model: AM4 1860 sst patt 4co2'
  x1name='c96L32_am4g6_1860climo_ctlpreg_4co2/';
  %modelname='Model: AM4 sst patt 4XCO2'
  %x1name='c96L32_am4g6_1860climo_ctl_cess/';
  %modelname='Model: AM4 sst patt p2K'
  %x2name='c96L32_am4g6_2000climo_ctl/';
  x2name='c96L32_am4g6_1860climo_ctl/';
  addpath='gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/5yr/';
  years='000201-002112.';
  lengthyr=20; % length of time series in years
  %% it is possible to have time series of two different lengths
  %% depending on how the output from the forced vs control run was saved...
  iend=240;
  iend2=240;
  %% endt is the end index for the time series that have been computed
  %% with a running mean of +/- 6 months so it is 13 months shorter
  endt=227; % needs to be iend -1 year and one month
  
  % use below for reg + pattern experiments
  % pstart and pend define the period over which the feedbacks are computed
  pstart=1;
  pend=239;
  iarr=[1 10 60 120 180 240];
%%%%----- End of block for reg+pattern experiments

%%%% use below for Ming's am4 cess experiment
%  %% Beginning of block for Ming's cess experiment
%  basedir='/archive/Ming.Zhao/awglg/ulm/'
%  modelname='Model: c96L32_am4g5r11_2000climo_p2K'
%  x1name='c96L32_am4g5r11_2000climo_p2K/';
%  x2name='c96L32_am4g5r11_2000climo/';
%  addpath='/ts_all/';
%  years='000201-001112.';
%  %
%  lengthyr=10; % length of time series in years
%  %% it is possible to have time series of two different lengths
%  %% depending on how the output from the forced vs control run was saved...
%  iend=120;
%  iend2=120;
%  %% endt is the end index for the time series that have been computed
%  %% with a running mean of +/- 6 months so it is 13 months shorter
%  endt=107; % needs to be iend -1 year and one month
%  %
%  % use below for reg + pattern experiments
%  %% pstart and pend define the period over which the feedbacks are computed
%  pstart=1;
%  pend=119;
%  iarr=[1 10 60 80 100 120];
%  %%% end of block for Ming's cess experiment
%%
%%% use below for cm2 cess experiment
%%% end of block for cm2 cess experiment
atm='atmos.';
expyrs1=strcat(atm,years); 
expyrs2=strcat(atm,years); 

exp1name=strcat(x1name,addpath,expyrs1);
exp2name=strcat(x2name,addpath,expyrs2);
exp1=strcat(basedir,x1name,addpath);
exp2=strcat(basedir,x2name,addpath);

%% end sst pattern block
%%

%------------------------------------------------------------------------------------------
%%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.t_surf.nc'
base1=strcat(exp1,expyrs1);
base2=strcat(exp2,expyrs2);
%
%compute a time in months: 
timeindex=0:0.0833:lengthyr-1;
istart=1;
istart2=iend2-iend+1;
%
%%
landm='/archive/Ming.Zhao/awg/ulm/CM2.1U-D4_1PctTo2X_I1/gfdl.ncrc2-intel-prod-openmp/pp/atmos_scalar/atmos_scalar.static.nc'
fland=netcdf(landm,'nowrite');

%%-----end of new block
%%% 1pct increase in CO2 experiment and control
%%% for AM4 model: 
%exp1name='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
%exp2name='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
%expyrs1='atmos.006101-014012.';
%expyrs2='atmos.000101-014012.';
%modelname='Model: AM4OM2'
%lengthyr=80; % length of time series in years
%%latinc=30;
%%sonic=1:latinc:180;
%% it is possible to have time series of two different lengths
%% depending on how the output from the forced vs control run was saved...
%iend=960;
%iend2=1680;
%% endt is the end index for the time series that have been computed
%% with a running mean of +/- 6 months so it is 13 months shorter
%endt=947; % needs to be iend -1 year and one month
%
%%%% for CM2 model: 
%%exp1name='CM2.1U-D4_1PctTo2X_I1/ts_all/';
%%%exp2name='CM2.1U_Control-1990_E1/ts_all/';
%%exp2name='CM2.1U_Control-1860_D4/ts_all/';
%%expyrs1='atmos.000101-010012.';
%%expyrs2='atmos.000101-010012.';
%%modelname='Model: CM2'
%%% for time series 100 years in length:
%%lengthyr=100;
%%iend=1200;
%%iend2=1200; % istart2=iend2-iend+1; 
%%% endt is the end index for the time series that have been computed
%%% with a running mean of +/- 6 months so it is 13 months shorter
%%endt=1187;
%%%istart2=iend2-iend+1;
%%%latinc=15;
%%%sonic=1:latinc:90;
%
%%%% abrupt 4XCO2 forcing
%%%exp1name='AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/';
%%expyrs1='atmos.006101-015012.';
%%
%%%%%% from ctl+sst pattern experiments
%%%x1name='c96L32_am4g6_1860climo_ctlpreg_1per_co2_weaker/';
%%%modelname='Model: AM4 1860 sst patt 1Pcnt 80yrscale'
%%modelname='Model: AM4 2000 sst patt 1Pcnt'
%%x1name='c96L32_am4g6_2000climo_ctlpreg_1per_co2/';
%%%modelname='Model: AM4 2000 sst patt 1Pcnt'
%%%x1name='c96L32_am4g6_1860climo_ctlpreg_4co2/';
%%%modelname='Model: AM4 sst patt 4XCO2'
%%%x1name='c96L32_am4g6_1860climo_ctl_cess/';
%%%modelname='Model: AM4 sst patt p2K'
%%x2name='c96L32_am4g6_2000climo_ctl/';
%%%x2name='c96L32_am4g6_1860climo_ctl/';
%%addpath='gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/5yr/';
%%years='000201-002112.';
%%atm='atmos.';
%%expyrs1=strcat(atm,years); 
%%expyrs2=strcat(atm,years); 
%%
%%lengthyr=20; % length of time series in years
%%%% it is possible to have time series of two different lengths
%%%% depending on how the output from the forced vs control run was saved...
%%iend=240;
%%iend2=240;
%%%% endt is the end index for the time series that have been computed
%%%% with a running mean of +/- 6 months so it is 13 months shorter
%%endt=227; % needs to be iend -1 year and one month
%%
%%exp1name=strcat(x1name,addpath,expyrs1);
%%exp2name=strcat(x2name,addpath,expyrs2);
%%exp1=strcat(basedir,x1name,addpath);
%%exp2=strcat(basedir,x2name,addpath);
%%%%%
%%------------------
%exp1=strcat(basedir,exp1name);
%exp2=strcat(basedir,exp2name);
%%
%%%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%%%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.t_surf.nc'
%base1=strcat(exp1,expyrs1);
%base2=strcat(exp2,expyrs2);
%%
%%compute a time in months: 
%timeindex=0:0.0833:lengthyr-1;
%istart=1;
%istart2=iend2-iend+1;
%%
%%%
%landm='/archive/Ming.Zhao/awg/ulm/CM2.1U-D4_1PctTo2X_I1/gfdl.ncrc2-intel-prod-openmp/pp/atmos_scalar/atmos_scalar.static.nc'
%fland=netcdf(landm,'nowrite');
%%% pstart and pend define the period over which the feedbacks are computed
%%%% use below for coupled experiments
%pstart=720;
%%%pend=1200;
%pend=960;
%iarr=[1 120 240 480 720 960];
%%% use below for reg + pattern experiments
%%pstart=1;
%%pend=239;
%%iarr=[1 10 60 120 180 240];
%%------------------------------------------------------------------------------------------
singlefilein=0 % default behavior is singlefilein=0
if (singlefilein < 1 )
  var1='t_surf.nc';
  fin=strcat(base1,var1);
  fin2=strcat(base2,var1);
else
  %finput=strcat(base1,'t_surf.nc');
  finput='/archive/Levi.Silvers/cm21_vs_cm4/c48l24_am2p14_climo_10yr.atmos.mon.nc';
  finput_pert='/archive/Levi.Silvers/cm21_vs_cm4/c48l24_am2p14_climo_10yr_p2k.atmos.mon.nc';
  fin=finput;
  fin2=finput_pert;
end
  % read input file
  f =netcdf(fin,'nowrite');
  f2 =netcdf(fin2,'nowrite');
  %ncid=netcdf.open(fin,'NC_NOWRITE');
  % set up a structure(v) to hold info related to variables
%------------------------------------------------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
v.sst =f{'t_surf'}(istart:iend,:,:); 
v.sst2 =f2{'t_surf'}(istart2:iend2,:,:); 
v.landm = fland{'land_mask'}(:,:);
tend=iend-istart;
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
close(f);
close(f2);
%-----------------------------------------------------%
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight=v.latweight;
%
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));
%------------------------------------------------------------------------------------------
%startan=1;
%endan=59;
in_var=v.sst;
%wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.sst_mn_ts=out_var;
in_var=v.sst2;
%wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.sst_mn_ts2=out_var;
%------------------------------------------------------------------------------------------

var2='swdn_toa.nc';
%var2='olr.nc';
fin=strcat(base1,var2);
fin2=strcat(base2,var2);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swdn_toa =f{'swdn_toa'}(istart:iend,:,:); 
v.swdn_toa2 =f2{'swdn_toa'}(istart2:iend2,:,:); 
%v.swdn_toa =f{'olr'}(istart:iend,:,:); 
%v.swdn_toa2 =f2{'olr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swdn_toa;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_toa_mn_ts=out_var;
in_var=v.swdn_toa2;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_toa2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var3='swup_toa.nc';
fin=strcat(base1,var3);
fin2=strcat(base2,var3);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swup_toa =f{'swup_toa'}(istart:iend,:,:); 
v.swup_toa2 =f2{'swup_toa'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swup_toa;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_toa_mn_ts=out_var;
in_var=v.swup_toa2;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_toa2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var4='swup_toa_clr.nc';
fin=strcat(base1,var4);
fin2=strcat(base2,var4);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swup_clr =f{'swup_toa_clr'}(istart:iend,:,:); 
v.swup2_clr =f2{'swup_toa_clr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swup_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_clr_mn_ts=out_var;
in_var=v.swup2_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swup_clr2_mn_ts=out_var;
%------------------------------------------------------------------------------------------
var5='swdn_toa_clr.nc';
fin=strcat(base1,var5);
fin2=strcat(base2,var5);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swdn_clr =f{'swdn_toa_clr'}(istart:iend,:,:); 
v.swdn2_clr =f2{'swdn_toa_clr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.swdn_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_clr_mn_ts=out_var;
in_var=v.swdn2_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.swdn_clr2_mn_ts=out_var;
%% compute the anomaly
%v.swdn2_clr=v.swdn2_clr-mean(v.swdn_clr2_mn_ts,2);
%v.swdn_clr=v.swdn_clr-mean(v.swdn_clr_mn_ts,2);
%------------------------------------------------------------------------------------------
var6='olr.nc';
fin=strcat(base1,var6);
fin2=strcat(base2,var6);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.olr =f{'olr'}(istart:iend,:,:); 
v.olr2 =f2{'olr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.olr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr_mn_ts=out_var;
in_var=v.olr2;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr2_mn_ts=out_var;
%% compute the anomaly
%v.olr2=v.olr2-mean(v.olr2_mn_ts,2);
%v.olr=v.olr-mean(v.olr_mn_ts,2);
%------------------------------------------------------------------------------------------
var7='olr_clr.nc';
fin=strcat(base1,var7);
fin2=strcat(base2,var7);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.olr_clr =f{'olr_clr'}(istart:iend,:,:); 
v.olr2_clr =f2{'olr_clr'}(istart2:iend2,:,:); 
close(f);
close(f2);
%
in_var=v.olr_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr_clr_mn_ts=out_var;
in_var=v.olr2_clr;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
v.olr_clr2_mn_ts=out_var;
%% compute the anomaly
%v.olr2_clr=v.olr2_clr-mean(v.olr_clr2_mn_ts,2);
%v.olr_clr=v.olr_clr-mean(v.olr_clr_mn_ts,2);

%------------------------------------------------------------------------------------------
var8='precip.nc';
fin=strcat(base1,var8);
fin2=strcat(base2,var8);

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.precip =f{'precip'}(istart:iend,:,:); 
v.precip2=f2{'precip'}(istart2:iend2,:,:); 
close(f);
close(f2);

%% compute the anomalies
%v.sst2=v.sst2-mean(v.sst_mn_ts2,2);
%v.sst=v.sst-mean(v.sst_mn_ts(startan:endan),2);
%v.swup_toa2=v.swup_toa2-mean(v.swup_toa2_mn_ts,2);
%v.swup_toa=v.swup_toa-mean(v.swup_toa_mn_ts,2);
%v.swup2_clr=v.swup2_clr-mean(v.swup_clr2_mn_ts,2);
%v.swup_clr=v.swup_clr-mean(v.swup_clr_mn_ts,2);
%v.swdn_toa2=v.swdn_toa2-mean(v.swdn_toa2_mn_ts,2);
%v.swdn_toa=v.swdn_toa-mean(v.swdn_toa_mn_ts,2);
%v.swdn2_clr=v.swdn2_clr-mean(v.swdn_clr2_mn_ts,2);
%v.swdn_clr=v.swdn_clr-mean(v.swdn_clr_mn_ts,2);
%v.olr2=v.olr2-mean(v.olr2_mn_ts,2);
%v.olr=v.olr-mean(v.olr_mn_ts,2);
%v.olr2_clr=v.olr2_clr-mean(v.olr_clr2_mn_ts,2);
%v.olr_clr=v.olr_clr-mean(v.olr_clr_mn_ts,2);
%-----------------------------------------------------------------------------------------
% compute radiative budget
% feedbacks should be computed with exp1-exp2, and positive values should lead to warming
%-----------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux=v.swdn_toa-v.olr-v.swup_toa;
v.radflux2=v.swdn_toa2-v.olr2-v.swup_toa2;
toa_net_fdbck=v.radflux-v.radflux2;
olr_fdbck=v.olr-v.olr2;
sw_fdbck=v.swdn_toa-v.swup_toa-v.swdn_toa2+v.swup_toa2;

% compute global mean radiative imbalance
in_var=v.radflux;
in_var2=v.radflux2;
%wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  temp_var2      = in_var2(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  wgt_var2       = squeeze(temp_var2).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
  out_var2(ti) = sum(wgt_var2(:))/glbsumweight;
end
v.radflux_mn_ts=out_var;
v.radflux2_mn_ts=out_var2;
mean_radflux=mean(v.radflux_mn_ts);
mean_radflux2=mean(v.radflux2_mn_ts);
radimb=mean_radflux-mean_radflux2;

v.radflux_tmn=mean(v.radflux,1);
v.radflux2_tmn=mean(v.radflux2,1);
%toa_feedback=(v.radflux_tmn-v.radflux2_tmn)/2.;
%toa_feedback_zmn=mean(toa_feedback,3);

% clear sky
lw_clr_fdbck=v.olr_clr-v.olr2_clr;
% the sign should be flipped here because larger olr values correspond to cooling
lw_clr_fdbck=-lw_clr_fdbck;
% swdn_clr=swdn, should swdn_clr be part of the computation for 
% sw_cre?
sw_clr_fdbck=v.swdn_clr-v.swup_clr-v.swdn2_clr+v.swup2_clr;

% cloud radiative effects: clear sky - all sky  
olr_cre1=v.olr_clr-v.olr; % pos means clouds warm
olr_cre2=v.olr2_clr-v.olr2;
sw_cre1=v.swup_clr-v.swup_toa; % pos means clouds cool, so we plot -sw_cre
sw_cre2=v.swup2_clr-v.swup_toa2;
tot_cre1=olr_cre1-sw_cre1; % pos means clouds warm
tot_cre2=olr_cre2-sw_cre2;
% CRE = lw_cre - sw_cre; positive values correspond to warming from clouds
%olr_cre_fdbck=lw_clr_fdbck - olr_fdbck;
%sw_cre_fdbck=sw_clr_fdbck - sw_fdbck;
%toa_cre_fdbck=sw_cre_fdbck+olr_cre_fdbck;
olr_cre_fdbck=olr_cre1-olr_cre2;
sw_cre_fdbck=sw_cre1-sw_cre2;
toa_cre_fdbck=olr_cre_fdbck+sw_cre_fdbck;
%toa_cre_fdbck_test=tot_cre1-tot_cre2;

tempdiff_full=v.sst-v.sst2;  % forced minus control
tempdiff=mean(tempdiff_full,1); % take the time mean
tempdiff_zmn=mean(tempdiff,3); % take the zonal mean

%iarr=[1 10 20 30 40 50 60];
%iarr=[1 120 240 480 720 960];

tempdiff_fulla = mean(tempdiff_full(iarr(1):iarr(3),:,:),1);
tempdiffa_zmn=mean(tempdiff_fulla,3); % take the zonal mean
tempdiff_fullb = mean(tempdiff_full(iarr(3):iarr(4),:,:),1);
tempdiffb_zmn=mean(tempdiff_fullb,3); % take the zonal mean
tempdiff_fullc = mean(tempdiff_full(iarr(4):iarr(5),:,:),1);
tempdiffc_zmn=mean(tempdiff_fullc,3); % take the zonal mean
tempdiff_fulld = mean(tempdiff_full(iarr(5):iarr(6),:,:),1);
tempdiffd_zmn=mean(tempdiff_fulld,3); % take the zonal mean

%-----------------------------------------------------%
% compute global mean temp diff
%-----------------------------------------------------%
in_var=tempdiff_full; % in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
glb_mn_delt=out_var;

%
toa_f_part=toa_net_fdbck(pstart:pend,:,:);
toa_fdbck_part_mn=mean(toa_f_part,1);
toa_fdbck_part_zmn=mean(toa_fdbck_part_mn,3);
%
olr_f_part=olr_fdbck(pstart:pend,:,:);
olr_fdbck_part_mn=mean(olr_f_part,1);
olr_fdbck_part_zmn=mean(olr_fdbck_part_mn,3);
%
sw_f_part=sw_fdbck(pstart:pend,:,:);
sw_fdbck_part_mn=mean(sw_f_part,1);
sw_fdbck_part_zmn=mean(sw_fdbck_part_mn,3);
%
lw_clr_f_part=lw_clr_fdbck(pstart:pend,:,:);
lw_clr_fdbck_part_mn=mean(lw_clr_f_part,1);
lw_clr_fdbck_part_zmn=mean(lw_clr_fdbck_part_mn,3);
%
sw_clr_f_part=sw_clr_fdbck(pstart:pend,:,:);
sw_clr_fdbck_part_mn=mean(sw_clr_f_part,1);
sw_clr_fdbck_part_zmn=mean(sw_clr_fdbck_part_mn,3);
%
toa_cre_f_part=toa_cre_fdbck(pstart:pend,:,:);
toa_cre_fdbck_part_mn=mean(toa_cre_f_part,1);
toa_cre_fdbck_part_zmn=mean(toa_cre_fdbck_part_mn,3);
%
olr_cre_f_part=olr_cre_fdbck(pstart:pend,:,:);
olr_cre_fdbck_part_mn=mean(olr_cre_f_part,1);
olr_cre_fdbck_part_zmn=mean(olr_cre_fdbck_part_mn,3);
%
sw_cre_f_part=sw_cre_fdbck(pstart:pend,:,:);
sw_cre_fdbck_part_mn=mean(sw_cre_f_part,1);
sw_cre_fdbck_part_zmn=mean(sw_cre_fdbck_part_mn,3);

%%------------------------------------------------------------------------------------------
%
%Normalize the feedbacks...
% plot one map of normalized by mn_sfc_temp_ch and one normalized
% with the sfc_temp change at every grid point
% glb_mn_delt is global mean temp diff time series
%normfac=mean(glb_mn_delt(pstart-1:pend-1));
% 
%% COUPLED MODEL EXPERIMENTS 
global_tempdiff_end=v.sst_mn_ts(pstart:pend-1)-v.sst_mn_ts2(pstart:pend-1);
mn_sfc_temp_ch=mean(global_tempdiff_end)
normfac=mn_sfc_temp_ch; % this is the global mean temp difference 
%% old way of normalizing
%tempdiff_first10 = mean(tempdiff_full(1:120,:,:),1);
%tempdiff_60t70 = mean(tempdiff_full(720:840,:,:),1);
%global_tempdiff=tempdiff_60t70-tempdiff_first10;
% compute the lat weighted global mean temp change
%wgt_var       = squeeze(global_tempdiff).*glblatweight;
%mn_sfc_temp_ch   = sum(wgt_var(:))/glbsumweight;
%
%normfac=mn_sfc_temp_ch; % this is the global mean temp difference 
%%normfaclocal=global_tempdiff; % this is the global mean change
%norm_tempdiff_zmn=mean(global_tempdiff,3);
%
%%% CLIMATOLOGY PLUS SST PATTERN 
%%% this is simpler than the coupled runs because we shouldn't have to deal with drift
%normfac=mean(v.sst_mn_ts)-mean(v.sst_mn_ts2);
%normfaclocal=tempdiff;
%norm_tempdiff_zmn=mean(tempdiff,3);
%%
% normalized by global mean tsfc diff
toa_fdbck_gnorm=toa_fdbck_part_mn./normfac;
olr_fdbck_gnorm=olr_fdbck_part_mn./normfac;
sw_fdbck_gnorm=sw_fdbck_part_mn./normfac;
lw_clr_fdbck_gnorm=lw_clr_fdbck_part_mn./normfac;
sw_clr_fdbck_gnorm=sw_clr_fdbck_part_mn./normfac;
toa_cre_fdbck_gnorm=toa_cre_fdbck_part_mn./normfac;
olr_cre_fdbck_gnorm=olr_cre_fdbck_part_mn./normfac;
sw_cre_fdbck_gnorm=sw_cre_fdbck_part_mn./normfac;
%% normalized by local mean tsfc diff
%toa_fdbck_lnorm=toa_fdbck_part_mn./normfaclocal;
%olr_fdbck_lnorm=olr_fdbck_part_mn./normfaclocal;
%sw_fdbck_lnorm=sw_fdbck_part_mn./normfaclocal;
%lw_clr_fdbck_lnorm=lw_clr_fdbck_part_mn./normfaclocal;
%sw_clr_fdbck_lnorm=sw_clr_fdbck_part_mn./normfaclocal;
%toa_cre_fdbck_lnorm=toa_cre_fdbck_part_mn./normfaclocal;
%olr_cre_fdbck_lnorm=olr_cre_fdbck_part_mn./normfaclocal;
%sw_cre_fdbck_lnorm=sw_cre_fdbck_part_mn./normfaclocal;
%% normalize the zonal means....
%toa_fdbck_part_zmn_norm=toa_fdbck_part_zmn./norm_tempdiff_zmn;
%olr_fdbck_part_zmn_norm=olr_fdbck_part_zmn./norm_tempdiff_zmn;
%sw_fdbck_part_zmn_norm=sw_fdbck_part_zmn./norm_tempdiff_zmn;
%lw_clr_fdbck_part_zmn_norm=lw_clr_fdbck_part_zmn./norm_tempdiff_zmn;
%sw_clr_fdbck_part_zmn_norm=sw_clr_fdbck_part_zmn./norm_tempdiff_zmn;
%toa_cre_fdbck_part_zmn_norm=toa_cre_fdbck_part_zmn./norm_tempdiff_zmn;
%olr_cre_fdbck_part_zmn_norm=olr_cre_fdbck_part_zmn./norm_tempdiff_zmn;
%sw_cre_fdbck_part_zmn_norm=sw_cre_fdbck_part_zmn./norm_tempdiff_zmn;
%%------------------------------------------------------------------------------------------
% Figures
%------------------------------------------------------------------------------------------
figure;
ppplot(1)=subplot(2,1,1);
contourf(squeeze(toa_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title('TOA fdbck')
ppplot(2)=subplot(2,1,2);
contourf(squeeze(toa_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title('TOA CRE fdbck')
cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
colormap(cmap2(1:8,:))
h=colorbar('SouthOutside');
set(h, 'Position', [.1 .05 .8150 .05]);
for i=1:2
  pos=get(ppplot(i), 'Position');
  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
end;
% try to change colorbar size...
h_bar = findobj(gcf,'Tag','Colorbar');
initpos = get(h_bar,'Position');
initfontsize = get(h_bar,'FontSize');
set(h_bar, ...
   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
         initpos(3)*0.5 initpos(4)*0.5], ...
	    'FontSize',initfontsize*1)
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')

% second
%clear pplot;
%clear h; clear h_bar; clear initpos; clear initfontsize;
% because we want to plot warming of system as positive switch sign of lw_clr
%lw_clr_fdbck_warm=-lw_clr_fdbck_part_mn;
figure;
pp3lot(1)=subplot(2,1,1);
contourf(squeeze(lw_clr_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title('LW clr fdbck')
pp3lot(2)=subplot(2,1,2);
contourf(squeeze(sw_clr_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title('SW clr fdbck')
cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
colormap(cmap2(1:8,:))
h2=colorbar('SouthOutside');
set(h2, 'Position', [.1 .05 .8150 .05]);
for i=1:2
  pos=get(pp3lot(i), 'Position');
  set(pp3lot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
end;
% try to change colorbar size...
h_bar2 = findobj(gcf,'Tag','Colorbar');
initpos2 = get(h_bar2,'Position');
initfontsize2 = get(h_bar2,'FontSize');
set(h_bar2, ...
   'Position',[initpos2(1)+initpos2(3)*0.25 initpos2(2)+initpos2(4)*0.25 ...
         initpos2(3)*0.5 initpos2(4)*0.5], ...
	    'FontSize',initfontsize2*1)
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')

% third
%clear pplot;
%clear h; clear h_bar; clear initpos; clear initfontsize;
% because warming from clouds corresponds to a neg sw_cre switch sign
%sw_cre_warming=-sw_cre_fdbck_part_mn;
figure;
pp4lot(1)=subplot(2,1,1);
contourf(squeeze(olr_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title('LW CRE fdbck')
pp4lot(2)=subplot(2,1,2);
contourf(squeeze(sw_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title('SW CRE fdbck')
cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%cmap2=[.6 .6 1;.9 .9 1;1 .9 .9;1 .7 .7;1 .6 .6;1 .5 .5;1 .4 .4 ;1 .3 .3;1 .1 .1 ;1 0 0 ];
%cmap2=[.6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 .2 .2 ;1 0 0 ];
colormap(cmap2(1:8,:))
h3=colorbar('SouthOutside');
set(h3, 'Position', [.1 .05 .8150 .05]);
for i=1:2
  pos=get(pp4lot(i), 'Position');
  set(pp4lot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
end;
% try to change colorbar size...
h_bar3 = findobj(gcf,'Tag','Colorbar');
initpos3 = get(h_bar3,'Position');
initfontsize3 = get(h_bar3,'FontSize');
set(h_bar3, ...
   'Position',[initpos3(1)+initpos3(3)*0.25 initpos3(2)+initpos3(4)*0.25 ...
         initpos3(3)*0.5 initpos3(4)*0.5], ...
	    'FontSize',initfontsize3*1)
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')

% plot the zonal mean feedback and individual compoenents of feedback
figure; plot(v.lat',toa_fdbck_part_zmn,'k',v.lat',olr_fdbck_part_zmn,'b', ...
v.lat',sw_fdbck_part_zmn,'r',v.lat',lw_clr_fdbck_part_zmn,'b--',v.lat',sw_clr_fdbck_part_zmn,'r--',...
v.lat',toa_cre_fdbck_part_zmn,'k*',v.lat',olr_cre_fdbck_part_zmn,'b*',v.lat',sw_cre_fdbck_part_zmn,'r*');
title('zmn feedbck')
legend('net','olr','sw','lw_{clr}','sw_{clr}','toa_{cre}','olr_{cre}','sw_{cre}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%%------------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------------
% create a new netcdf file
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

toa_gnorm=squeeze(toa_fdbck_gnorm);
cre_gnorm=squeeze(toa_cre_fdbck_gnorm);
lw_clr_gnorm=squeeze(lw_clr_fdbck_gnorm);
sw_clr_gnorm=squeeze(sw_clr_fdbck_gnorm);
sw_cre_gnorm=squeeze(sw_cre_fdbck_gnorm);
lw_cre_gnorm=squeeze(olr_cre_fdbck_gnorm);
nc{'toa_diff'}=ncfloat('lat','lon'); 
nc{'toa_diff'}(:,:)=toa_gnorm(:,:);
nc{'toa_cre_diff'}=ncfloat('lat','lon'); 
nc{'toa_cre_diff'}(:,:)=cre_gnorm(:,:);
nc{'lw_clr_diff'}=ncfloat('lat','lon'); 
nc{'lw_clr_diff'}(:,:)=lw_clr_gnorm(:,:);
nc{'sw_clr_diff'}=ncfloat('lat','lon'); 
nc{'sw_clr_diff'}(:,:)=sw_clr_gnorm(:,:);
nc{'sw_cre_diff'}=ncfloat('lat','lon'); 
nc{'sw_cre_diff'}(:,:)=sw_cre_gnorm(:,:);
nc{'lw_cre_diff'}=ncfloat('lat','lon'); 
nc{'lw_cre_diff'}(:,:)=lw_cre_gnorm(:,:);

nc{'TIME'}.long_name     ='TIME';      
%nc{'TIME'}.climatology   ='climatology_bounds';      
nc{'TIME'}.standard_name ='TIME';
nc{'TIME'}.calendar      ='gregorian';
nc{'TIME'}.units         ='days since 1869-12-1 00:00:00';      
nc{'TIME'}.delta_t       ='0000-00-01 00:00:00';      
nc{'TIME'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'toa_diff'}.long_name     ='toa_net_rad_ch';
nc{'toa_cre_diff'}.long_name ='total_cre_ch';
nc{'lw_clr_diff'}.long_name ='lw_clr_ch';
nc{'sw_clr_diff'}.long_name ='sw_clr_ch';
nc{'lw_cre_diff'}.long_name ='lw_cre_ch';
nc{'sw_cre_diff'}.long_name ='sw_cre_ch';
%nc{'sst'}.standard_name ='sea_surface_temperature';
%nc{'sst'}.units         ='degK';      
%nc{'sst'}.add_offset    = 0.e0;
%nc{'sst'}.scale_factor  = 1.e0;
%nc{'sst'}.FillValue_    =-1.e+30;
%nc{'sst'}.missing_value =-1.e+30;
%nc{'sst'}.description   ='HadIsst 1.1 monthly average sea surface temperature';
%nc{'sst'}.cell_methods  ='TIME: lat: lon: mean within months TIME: mean over years';
%nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';

%nc{'average_T1'}.long_name ='Start TIME for average period';
%nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

%nc{'average_T2'}.long_name ='End TIME for average period';
%nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      
%
%nc{'average_DT'}.long_name ='Length of average period';
%nc{'average_DT'}.units     ='days';      

close(nc); 

'finished first nc file'
% create a new netcdf file
%%------------------------------------------------------------------------------------------
% this is the end

