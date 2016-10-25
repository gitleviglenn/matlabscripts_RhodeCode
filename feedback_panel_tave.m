%------------------------------------------------------------------------------------------
% feedback_panel_tave.m
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
%
% levi silvers                                        Sept 2016
%------------------------------------------------------------------------------------------

%%
basedir='/archive/Levi.Silvers/awg/verona/'
%%
%% p2k  base: hadley center ice and sst
modelname='Model: c96L32_am4g10r8_2000climo_p2K'
expname='am4p2k'
x1name='c96L32_am4g10r8_2000climo_p2K';
%%
% sst pattern from mmm cmip3, from Appendix in Webb et al. 2016
modelname='Model: c96L32_am4g10r8_had_p_cmip3sstanom'
expname='am4 cmip3 anom'
x1name='c96L32_am4g10r8_had_p_cmip3sstanom';
%%
%% 2000climo: hadley center ice and sst, ice thickness reduced from 2m to 1m
%modelname='Model: c96L32_am4g10r8_2000climo_1mice'
%expname='am4_p2K_1mice'
%x1name='c96L32_am4g10r8_2000climo_p2K_1mice/';
%%
%modelname='Model: c96L32_am4g10r8_2000climo_1mice'
%expname='am4_1mice'
%x1name='c96L32_am4g10r8_2000climo_1mice/';
%
%modelname='Model: c96L32_am4g10r8_qobs_2000climo'
%expname='am4_qobs'
%x1name='c96L32_am4g10r8_qobs_2000climo_p2K/';
%%
%%% sst: hadley center base+1%co2 patter      ice: hadley center
%modelname='Model: c96L32_am4g10r8_haddsstp1pctco2_climo'
%expname='am4co2sst1pct'
%x1name='c96L32_am4g10r8_hadsstp1pctco2_climo/';
%
%%% sst: hadley center base+1%co2 patern      ice: hadley center base + 1%co2 patern
%modelname='Model: c96L32_am4g10r8_haddicesstp1pctco2_climo'
%x1name='c96L32_am4g10r8_hadsstp1pctco2_AM4OM2ice_climo/';
%expname='am4co2icesst1pct'
%
% the ice and sst patterns where first derived as means from the last 20years of
% the coupled run and then added to the hadley center data.
%modelname='Model: c96L32_am4g10r8_1pctco2_climo'
%x1name='c96L32_am4g10r8_1pctco2_climo';
%expname='am4co21pct_lst20yr'

% alternate, and probably correct, attempt on the 1pct pattern:
% ice field has not changed from control
%modelname='Model: c96L32_am4g10r8_had_p_1pctco2_climo'
%x1name='c96L32_am4g10r8_had_p_1pctco2_climo';
%expname='am4co21pct'
%
% ice field has not changed from control
%modelname='Model: c96L32_am4g10r8_had_p_4xCO2_climo'
%x1name='c96L32_am4g10r8_had_p_4xCO2_climo';
%expname='am4_4xCO2'
%%
%x2name='c96L32_am4g10r8_2000climo_p2K/';
x2name='c96L32_am4g10r8_2000climo';
%x2name='c96L32_am4g10r8_qobs_2000climo/';
%addpath='/ts_all/';
addpath='/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_20yr/';
%%%% use below for reg + pattern experiments
%%%%% pstart and pend define the period over which the feedbacks are computed
%years='0002-0011.';
%lengthyr=5; % length of time series in years
%iend=60;
%iend2=60;
%pstart=1;
%pend=59;
%iarr=[1 10 30 40 50 60];
%%%% endt is the end index for the time series that have been computed
%%%% with a running mean of +/- 6 months so it is 13 months shorter
%%endt=107; % needs to be iend -1 year and one month
%%%%
%%% below is needed both for my experiments and for Ming's cess experiment
%atm='atmos.';
%expyrs1=strcat(atm,years); 
%expyrs2=strcat(atm,years); 
%%%
%exp1name=strcat(x1name,addpath,expyrs1);
%exp2name=strcat(x2name,addpath,expyrs2);
%exp1=strcat(basedir,x1name,addpath);
%exp2=strcat(basedir,x2name,addpath);
exp1=strcat(basedir,x1name,addpath);
exp2=strcat(basedir,x2name,addpath);
filename1=strcat(exp1,'atmos_subsvar3d.0002-0021.all.nc');
filename2=strcat(exp2,'atmos_subsvar3d.0002-0021.all.nc');
%%
%------------------------------------------------------------------------------------------
%%%

% read input file
f =netcdf(filename1,'nowrite');
f2 =netcdf(filename2,'nowrite');
%------------------------------------------------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.time=f{'time'}(:); v.nt=length(v.time);
v.sst =f{'t_surf'}(:,:,:); 
v.sst2 =f2{'t_surf'}(:,:,:); 
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;

% variables other than t_surf:
v.swdn_toa =f{'swdn_toa'}(:,:,:); 
v.swdn_toa2 =f2{'swdn_toa'}(:,:,:); 
v.swup_toa =f{'swup_toa'}(:,:,:); 
v.swup_toa2 =f2{'swup_toa'}(:,:,:); 
v.swup_clr =f{'swup_toa_clr'}(:,:,:); 
v.swup2_clr =f2{'swup_toa_clr'}(:,:,:); 
v.swdn_clr =f{'swdn_toa_clr'}(:,:,:); 
v.swdn2_clr =f2{'swdn_toa_clr'}(:,:,:); 
v.olr =f{'olr'}(:,:,:); 
v.olr2 =f2{'olr'}(:,:,:); 
v.olr_clr =f{'olr_clr'}(:,:,:); 
v.olr2_clr =f2{'olr_clr'}(:,:,:); 
v.precip =f{'precip'}(:,:,:); 
v.precip2=f2{'precip'}(:,:,:); 
v.ice=f{'ice_mask'}(:,:,:);
v.ice2=f2{'ice_mask'}(:,:,:);
v.wvp=f{'WVP'}(:,:,:);
v.wvp2=f2{'WVP'}(:,:,:);
v.lwp=f{'LWP'}(:,:,:);
v.lwp2=f2{'LWP'}(:,:,:);

v.hcld=f{'high_cld_amt'}(:,:,:);
v.hcld2=f2{'high_cld_amt'}(:,:,:);
v.lcld=f{'low_cld_amt'}(:,:,:);
v.lcld2=f2{'low_cld_amt'}(:,:,:);
v.mcld=f{'mid_cld_amt'}(:,:,:);
v.mcld2=f2{'mid_cld_amt'}(:,:,:);
v.tot_cld=f{'tot_cld_amt'}(:,:,:);
v.tot_cld2=f2{'tot_cld_amt'}(:,:,:);
v.wp_allcld=f{'WP_all_clouds'}(:,:,:);
v.wp_allcld2=f2{'WP_all_clouds'}(:,:,:);

%-----------------------------------------------------------------------------------------
% compute responses/feedbacks
% feedbacks should be computed with exp1-exp2, and positive values should lead to warming
%-----------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux=v.swdn_toa-v.olr-v.swup_toa;
v.radflux2=v.swdn_toa2-v.olr2-v.swup_toa2;
toa_net_fdbck=v.radflux-v.radflux2;
olr_fdbck=v.olr-v.olr2;
lw_clr_fdbck=v.olr_clr-v.olr2_clr;
sw_fdbck=v.swdn_toa-v.swup_toa-v.swdn_toa2+v.swup_toa2;
% the sign should be flipped here because larger olr values correspond to cooling
lw_clr_fdbck=-lw_clr_fdbck;
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

precip_fdbck=v.precip-v.precip2;
wvp_fdbck=v.wvp-v.wvp2;
lwp_fdbck=v.lwp-v.lwp2;
wp_allcld_fdbck=v.wp_allcld-v.wp_allcld2;
tot_cld_fdbck=v.tot_cld-v.tot_cld2;
midcld_fdbck=v.mcld-v.mcld2;
lowcld_fdbck=v.lcld-v.lcld2;
highcld_fdbck=v.hcld-v.hcld2;
%t_ref_fdbck=v.t_ref-v.t_ref2;
%swup_sfc_clr_fdbck=v.swup_sfc_clr-v.swup_sfc_clr2;
%lwup_sfc_clr_fdbck=v.lwup_sfc_clr-v.lwup_sfc_clr2;

% time mean response fields
toa_fdbck_mn=mean(toa_net_fdbck,1);
olr_fdbck_mn=mean(olr_fdbck,1);
sw_fdbck_mn=mean(sw_fdbck,1);
lw_clr_fdbck_mn=mean(lw_clr_fdbck,1);
sw_clr_fdbck_mn=mean(sw_clr_fdbck,1);
olr_cre_fdbck_mn=mean(olr_cre_fdbck,1);
sw_cre_fdbck_mn=mean(sw_cre_fdbck,1);
toa_cre_fdbck_mn=olr_cre_fdbck_mn+sw_cre_fdbck_mn;

precip_fdbck_mn=mean(precip_fdbck,1);
wvp_fdbck_mn=mean(wvp_fdbck,1);
lwp_fdbck_mn=mean(lwp_fdbck,1);
wp_allcld_fdbck_mn=mean(wp_allcld_fdbck,1);
tot_cld_fdbck_mn=mean(tot_cld_fdbck,1);
midcld_fdbck_mn=mean(midcld_fdbck,1);
lowcld_fdbck_mn=mean(lowcld_fdbck,1);
highcld_fdbck_mn=mean(highcld_fdbck,1);
%t_ref_fdbck_mn=mean(t_ref_fdbck,1);
%-----------------------------------------------------%
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight=v.latweight;
%
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));
wgt_sst=squeeze(mean(v.sst,1)).*glblatweight;
wgt_sst2=squeeze(mean(v.sst2,1)).*glblatweight;
wgt_radflux=squeeze(mean(v.radflux,1)).*glblatweight;
wgt_radflux2=squeeze(mean(v.radflux2,1)).*glblatweight;
mnsst=sum(wgt_sst(:))/glbsumweight;
mnsst2=sum(wgt_sst2(:))/glbsumweight;
mnradflux=sum(wgt_radflux(:))/glbsumweight;
mnradflux2=sum(wgt_radflux2(:))/glbsumweight;
% global mean time mean responses
toa_fdbck_gtmn=mnradflux-mnradflux2
normfac=mnsst-mnsst2
glbmean_radimb=toa_fdbck_gtmn/normfac
%------------------------------------------------------------------------------------------
% normalized by global mean tsfc diff
% these should be time mean fields (1xlatxlon) normalized by the global sfc temp change
toa_fdbck_gnorm=toa_fdbck_mn./normfac;
olr_fdbck_gnorm=olr_fdbck_mn./normfac;
sw_fdbck_gnorm=sw_fdbck_mn./normfac;
lw_clr_fdbck_gnorm=lw_clr_fdbck_mn./normfac;
sw_clr_fdbck_gnorm=sw_clr_fdbck_mn./normfac;
toa_cre_fdbck_gnorm=toa_cre_fdbck_mn./normfac;
olr_cre_fdbck_gnorm=olr_cre_fdbck_mn./normfac;
sw_cre_fdbck_gnorm=sw_cre_fdbck_mn./normfac;
%
precip_fdbck_gnorm=precip_fdbck_mn./normfac;
wvp_fdbck_gnorm=wvp_fdbck_mn./normfac;
lwp_fdbck_gnorm=lwp_fdbck_mn./normfac;
wp_allcld_fdbck_gnorm_mn=wp_allcld_fdbck_mn./normfac;
tot_cld_fdbck_gnorm_mn=tot_cld_fdbck_mn./normfac;
midcld_fdbck_gnorm_mn=midcld_fdbck_mn./normfac;
lowcld_fdbck_gnorm_mn=lowcld_fdbck_mn./normfac;
highcld_fdbck_gnorm_mn=highcld_fdbck_mn./normfac;
%t_ref_fdbck_gnorm=t_ref_fdbck_mn./normfac;
%------------------------------------------------------------------------------------------
