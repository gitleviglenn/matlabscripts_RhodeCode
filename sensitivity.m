%------------------------------------------------------------------------------------------
% sensitivity.m
%
% 1. read in variables from input files
% 2. compute cosine weighted global mean values
% 3. compute radiative flux at toa and temp diff pattern
% 4. compute feedbacks between two experiments
% 5. compute yearly mean values in preparation for Gregory plot
% 6. compute running means
% 7. make figures
%         - zonal mean temp change
%         - 4 panel plot of global temp change during 20 increments
%         - time evolution of glb mean surface temp for forced and cntl exps
%
% the Cess sensitivity is computed as the ratio of the (toa rad imb)/(diff T_surf)
%
% attempt to create a Gregory plot... doesn't work yet
%
% levi silvers                                        Apr 2016
%------------------------------------------------------------------------------------------

%dirMing='/archive/Ming.Zhao/awglg/ulm/';
dirMing='/archive/Ming.Zhao/awg/ulm/';
dirLevi='/archive/Levi.Silvers/';
basedir=dirMing;

% Cess type experiments
%exp1name='c96L32_am4g5r11_2000climo_p2K/';
%exp2name='c96L32_am4g5r11_2000climo/';
%expyrs='ts_all/atmos.000201-001112.';

%% 1pct increase in CO2 experiment and control
%exp1name='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
%exp2name='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
%expyrs1='atmos.006101-014012.';
%expyrs2='atmos.000101-014012.';
%modelname='am4om2'
% for time series 80 years in length:
%lengthyr=80;
%endt=948;

%% for CM2 model:
exp1name='CM2.1U-D4_1PctTo2X_I1/ts_all/';
exp2name='CM2.1U_Control-1990_E1/ts_all/';
expyrs1='atmos.000101-010012.';
expyrs2='atmos.000101-010012.';
modelname='cm2'
% for time series 100 years in length:
lengthyr=100;
endt=1188;

%compute a time in months: 
timeindex=0:0.0833:lengthyr-1;

exp1=strcat(basedir,exp1name);
exp2=strcat(basedir,exp2name);

%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.t_surf.nc'
base1=strcat(exp1,expyrs1);
base2=strcat(exp2,expyrs2);

%------------------------------------------------------------------------------------------

var1='t_surf.nc';
fin=strcat(base1,var1);
fin2=strcat(base2,var1);

% read input file
f =netcdf(fin,'nowrite');
%f2 =netcdf(fin2,'nowrite');
f2=netcdf('/archive/Ming.Zhao/awg/ulm/CM2.1U_Control-1990_E1/gfdl.ncrc2-intel-prod-openmp/pp/atmos/ts/monthly/100yr/atmos.010101-020012.t_surf.nc','nowrite');
%ncid=netcdf.open(fin,'NC_NOWRITE');
% set up a structure(v) to hold info related to variables
%------------------------------------------------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
istart=1;
%iend=960;
%iend2=1680;
iend=1200;
iend2=1200;
istart2=iend2-iend+1;
v.sst =f{'t_surf'}(istart:iend,:,:); 
v.sst2 =f2{'t_surf'}(istart2:iend2,:,:); 
%tstart=600;
%tend=1299;
%tint=tend-tstart+1;
%v.sst_full =f{'SST'} (tstart:tend,:,:); 
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
close(f);
close(f2);
%------------------------------------------------------------------------------------------

var2='swdn_toa.nc';
fin=strcat(base1,var2);
fin2=strcat(base2,var2);

%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.swdn_toa.nc'
%fin=strcat(exp1,'ts_all/atmos.000201-001112.swdn_toa.nc')
%in2=strcat(exp2,'ts_all/atmos.000201-001112.swdn_toa.nc')

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swdn_toa =f{'swdn_toa'}(:,:,:); 
v.swdn_toa2 =f2{'swdn_toa'}(:,:,:); 
close(f);
close(f2);
%------------------------------------------------------------------------------------------
var3='swup_toa.nc';
fin=strcat(base1,var3);
fin2=strcat(base2,var3);
%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.swup_toa.nc'
%fin=strcat(exp1,'ts_all/atmos.000201-001112.swup_toa.nc')
%fin2=strcat(exp2,'ts_all/atmos.000201-001112.swup_toa.nc')

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.swup_toa =f{'swup_toa'}(:,:,:); 
v.swup_toa2 =f2{'swup_toa'}(:,:,:); 
close(f);
close(f2);
%------------------------------------------------------------------------------------------
var4='olr.nc';
fin=strcat(base1,var4);
fin2=strcat(base2,var4);
%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.olr.nc'
%fin=strcat(exp1,'ts_all/atmos.000201-001112.olr.nc')
%fin2=strcat(exp2,'ts_all/atmos.000201-001112.olr.nc')

% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
v.olr =f{'olr'}(:,:,:); 
v.olr2 =f2{'olr'}(:,:,:); 
close(f);
close(f2);

%------------------------------------------------------------------------------------------
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight=v.latweight;
%
%sonic=1:30:180;
sonic=1:15:90;
tmp_reglatweight=zeros(6,15);
for index=1:6;
  begini=sonic(index);
  %endi=sonic(index)+29;
  endi=sonic(index)+14;
  tmp_reglatweight(index,:)=v.latweight(begini:endi)';
end
testreggarbage=tmp_reglatweight;
%for ilat=1:6;
%for ilon=1:v.nlon-1;
for ilon=1:3;
    testreggarbage=cat(3,testreggarbage,tmp_reglatweight);
end
%end
%
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));
% generate a time series of global mean mnthly values
tend=iend;

%------------------------------------------------------------------------------------------
% for experiment one
%------------------------------------------------------------------------------------------
in_var=v.sst;
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.sst_mn_ts=out_var;
in_var=v.olr;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.olr_mn_ts=out_var;
in_var=v.swup_toa;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.swup_toa_mn_ts=out_var;
in_var=v.swdn_toa;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.swdn_toa_mn_ts=out_var;

%------------------------------------------------------------------------------------------
% for experiment two
%------------------------------------------------------------------------------------------
in_var=v.sst2;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.sst_mn_ts2=out_var;
sst_mn_ts2_mean=mean(v.sst_mn_ts2,2);
v.sst_mn_ts2prime=v.sst_mn_ts2-sst_mn_ts2_mean;
in_var=v.olr2;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.olr_mn_ts2=out_var;
in_var=v.swup_toa2;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.swup_toa_mn_ts2=out_var;
in_var=v.swdn_toa2;
%-----------------------------------------------------%
% compute global mean
%-----------------------------------------------------%
% in  : v.sst 
% out : out_var
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
% save global mean time series in v
%-----------------------------------------------------%
v.swdn_toa_mn_ts2=out_var;

%------------------------------------------------------------------------------------------
% compute radiative budget
%------------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux=v.swdn_toa-v.olr-v.swup_toa;
v.radflux2=v.swdn_toa2-v.olr2-v.swup_toa2;
v.radflux_tmn=mean(v.radflux,1);
v.radflux2_tmn=mean(v.radflux2,1);

% compute warming pattern
tempdiff_full=v.sst-v.sst2; 
tempdiff_ts=v.sst_mn_ts-v.sst_mn_ts2;
tempdiff=mean(tempdiff_full,1); % take the time mean
tempdiff_zmn=mean(tempdiff,3); % take the zonal mean

tempdiff_fulla = mean(tempdiff_full(1:240,:,:),1);
tempdiffa_zmn=mean(tempdiff_fulla,3); % take the zonal mean
tempdiff_fullb = mean(tempdiff_full(240:480,:,:),1);
tempdiffb_zmn=mean(tempdiff_fullb,3); % take the zonal mean
tempdiff_fullc = mean(tempdiff_full(480:720,:,:),1);
tempdiffc_zmn=mean(tempdiff_fullc,3); % take the zonal mean
tempdiff_fulld = mean(tempdiff_full(720:960,:,:),1);
tempdiffd_zmn=mean(tempdiff_fulld,3); % take the zonal mean

%what=fdbck_lat.*tempdiff_lat;

toa_feedback=(v.radflux_tmn-v.radflux2_tmn)/2.;
toa_feedback_zmn=mean(toa_feedback,3);

v.swnet_toa=v.swdn_toa_mn_ts-v.swup_toa_mn_ts;
v.swnet_toa2=v.swdn_toa_mn_ts2-v.swup_toa_mn_ts2;
v.radflux_mn_ts=v.swdn_toa_mn_ts-v.olr_mn_ts-v.swup_toa_mn_ts;
v.radflux_mn_ts2=v.swdn_toa_mn_ts2-v.olr_mn_ts2-v.swup_toa_mn_ts2;

rflux_imb_ts=v.radflux_mn_ts-v.radflux_mn_ts2;

%------------------------------------------------------------------------------------------
clear yrarray_t;
clear yrarray_r;

yrindex=1;
% organize time series into yearly data array(year,month)
for ti=1:12:tend; 
  yrarray_t(yrindex,1:12)=tempdiff_ts(ti:ti+11); 
  yrarray_r(yrindex,1:12)=rflux_imb_ts(ti:ti+11); 
  yrarray_olr(yrindex,1:12)=v.olr_mn_ts(ti:ti+11); 
  yrarray_olr2(yrindex,1:12)=v.olr_mn_ts2(ti:ti+11); 
  yrarray_sw_toa(yrindex,1:12)=v.swnet_toa(ti:ti+11); 
  yrarray_sw_toa2(yrindex,1:12)=v.swnet_toa2(ti:ti+11); 
  yrindex=yrindex+1; 
end

% compute yearly mean time series
rad_imb_gltmn=mean(yrarray_r,2);
tsfc_diff_gltmn=mean(yrarray_t,2);
yrarray_olr_gltmn=mean(yrarray_olr,2);
yrarray_olr2_gltmn=mean(yrarray_olr2,2);
yrarray_sw_gltmn=mean(yrarray_sw_toa,2);
yrarray_sw2_gltmn=mean(yrarray_sw_toa2,2);

%------------------------------------------------------------------------------------------
% running means....
%------------------------------------------------------------------------------------------
incoming_ts=v.olr_mn_ts2;
%------------------------------------------------------------------------------------------
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%------------------------------------------------------------------------------------------
v.olr_sm_ts2=output_ts;
%------------------------------------------------------------------------------------------
incoming_ts=v.sst_mn_ts;
%------------------------------------------------------------------------------------------
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%------------------------------------------------------------------------------------------
sfc_t_sm_ts=output_ts;
incoming_ts=v.sst_mn_ts2;
%------------------------------------------------------------------------------------------
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%------------------------------------------------------------------------------------------
sfc_t_sm_ts2=output_ts;
%------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------
% Figures
%------------------------------------------------------------------------------------------
%figure; plot(sin(pi*v.lat'/180.),fdbck_lat);
figure; plot(v.lat',toa_feedback_zmn);
title('zmn toa feedbck')
figure; plot(tempdiff_zmn);
title('tempdiff zonal mean')
figure; plot(v.lat',tempdiff_zmn,v.lat',tempdiffa_zmn,v.lat',tempdiffb_zmn,v.lat',tempdiffc_zmn,v.lat',tempdiffd_zmn);
title('tempdiff zonal mean')
legend('time mean','years 0-20','years 20-40','years 40-60','years 60-80','boxoff','Location','northwest')
%figure; contourf(yrmn,[-1,0,1,2,3,4]); colorbar;
figure; contourf(squeeze(v.radflux_tmn(1,:,:))); colorbar;
% define the periods of interest
figure;
periods=[1 20 30 40];
% create a panneled plot of for different stages of the tmp evolution
pplot(1)=subplot(2,2,1);
contourf(squeeze(tempdiff_fulla),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
title('years 0-20')
pplot(2)=subplot(2,2,2);
contourf(squeeze(tempdiff_fullb),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
title('years 20-40')
pplot(3)=subplot(2,2,3);
contourf(squeeze(tempdiff_fullc),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
title('years 40-60')
pplot(4)=subplot(2,2,4);
contourf(squeeze(tempdiff_fulld),[-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]);
title('years 60-80')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
cmap2=[.6 .6 1;.9 .9 1;1 .9 .9;1 .7 .7;1 .6 .6;1 .5 .5;1 .4 .4 ;1 .3 .3;1 .1 .1 ;1 0 0 ];
%cmap2=[.6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 .2 .2 ;1 0 0 ];
colormap(cmap2(1:10,:))

h=colorbar('SouthOutside');
set(h, 'Position', [.1 .05 .8150 .05]);
for i=1:4
  pos=get(pplot(i), 'Position');
  set(pplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
end;
% try to change colorbar size...
h_bar = findobj(gcf,'Tag','Colorbar');
initpos = get(h_bar,'Position');
initfontsize = get(h_bar,'FontSize');
set(h_bar, ...
   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
         initpos(3)*0.5 initpos(4)*0.5], ...
	    'FontSize',initfontsize*1)

% scatter plot for Gregory attempt
figure; scatter(tsfc_diff_gltmn,rad_imb_gltmn);
title('Regression of N vs T_{sfc} for 1% CO2 exp')

% evolution of surface temperature
figure; plot(timeindex(1:endt),sfc_t_sm_ts,timeindex(1:endt),sfc_t_sm_ts2)
title('Time evolution of T_{sfc} for 1% CO2 exp')
legend('1% per year CO2','Control','boxoff','Location','northwest')

% evolution of rad fluxes
time=1:lengthyr;
figure; plot(time,yrarray_sw_gltmn,time,yrarray_olr_gltmn)
title('Time evolution of TOA Rad Fluxes 1% per year CO2')
legend('sw','lw','boxoff','Location','northwest')

	    % possible predifined colormaps: copper, summer, jet(default)
% to create a custom colormap
%cmap=[1 1 1 ; .8 .8 1 ; .6 .6 1 ; .4 .4 1 ; .2 .2 1 ; 0 0 1];
%colormap(cmap(1:5,:))
% blue: 0 0 1
% red : 1 0 0
% white: 1 1 1
%cmap2=[1 1 1 ; .9 .9 1 ; .8 .8 1 ; .6 .6 1 ; .4 .4 1 ; .2 .2 1 ; .1 .1 1 ; 0 0 1];
%cmap2=[1 1 1 ; 1 .9 .9 ; 1 .8 .8 ;1 .6 .6 ;1 .4 .4 ;1 .1 .1 ;1 .2 .2 ;1 0 0 ];
% cmap2 is a color map ranging from reds to blues.
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%------------------------------------------------------------------------------------------
% this is the end

