%------------------------------------------------------------------------------------------
% feedback_zmn.m
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
% levi silvers                                        Apr 2016
%------------------------------------------------------------------------------------------

dirMing_a='/archive/Ming.Zhao/awglg/ulm/';
dirMing_b='/archive/Ming.Zhao/awg/ulm/';
dirLevi='/archive/Levi.Silvers/';
basedir_a=dirMing_a;
basedir_b=dirMing_b;

%% Cess type experiments
%exp1name='c96L32_am4g5r11_2000climo_p2K/';
%exp2name='c96L32_am4g5r11_2000climo/';
%expyrs1='ts_all/atmos.000201-001112.';
%expyrs2='ts_all/atmos.000201-001112.';

%% 1pct increase in CO2 experiment and control
%% for AM4 model: 
exp1name_a='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
exp2name_a='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
expyrs1_a='atmos.006101-014012.';
expyrs2_a='atmos.000101-014012.';
modelname_a='Model: AM4OM2'
lengthyr_a=80; % length of time series in years
% it is possible to have time series of two different lengths
% depending on how the output from the forced vs control run was saved...
iend_a=960;
iend2_a=1680;
% endt is the end index for the time series that have been computed
% with a running mean of +/- 6 months so it is 13 months shorter
endt_a=947; % needs to be iend -1 year and one month

%% for CM2 model: 
exp1name_b='CM2.1U-D4_1PctTo2X_I1/ts_all/';
%exp2name_b='CM2.1U_Control-1990_E1/ts_all/';
exp2name_b='CM2.1U_Control-1860_D4/ts_all/';
expyrs1_b='atmos.000101-010012.';
expyrs2_b='atmos.000101-010012.';
modelname_b='Model: CM2'
% for time series 100 years in length:
lengthyr_b=100;
iend_b=1200;
iend2_b=1200; % istart2=iend2-iend+1; 
% endt is the end index for the time series that have been computed
% with a running mean of +/- 6 months so it is 13 months shorter
endt_b=1187;

% abrupt 4XCO2 forcing
%exp1name='AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/';
%expyrs1='atmos.006101-015012.';

exp1_a=strcat(basedir_a,exp1name_a);
exp2_a=strcat(basedir_a,exp2name_a);
exp1_b=strcat(basedir_b,exp1name_b);
exp2_b=strcat(basedir_b,exp2name_b);

%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.t_surf.nc'
base1_a=strcat(exp1_a,expyrs1_a);
base2_a=strcat(exp2_a,expyrs2_a);
base1_b=strcat(exp1_b,expyrs1_b);
base2_b=strcat(exp2_b,expyrs2_b);

%compute a time in months: 
timeindex_a=0:0.0833:lengthyr_a-1;
timeindex_b=0:0.0833:lengthyr_b-1;
istart_b=1;
istart2_b=iend2_b-iend_b+1;
istart_a=1;
istart2_a=iend2_a-iend_a+1;

%
landm='/archive/Ming.Zhao/awg/ulm/CM2.1U-D4_1PctTo2X_I1/gfdl.ncrc2-intel-prod-openmp/pp/atmos_scalar/atmos_scalar.static.nc'
fland=netcdf(landm,'nowrite');
%------------------------------------------------------------------------------------------

var1='t_surf.nc';
fin=strcat(base1_a,var1);
fin2=strcat(base2_a,var1);
fin_b=strcat(base1_b,var1);
fin2_b=strcat(base2_b,var1);

% read input file
f_a =netcdf(fin,'nowrite');
f2_a =netcdf(fin2,'nowrite');
f =netcdf(fin_b,'nowrite');
f2 =netcdf(fin2_b,'nowrite');
% set up a structure(v) to hold info related to variables
% set up a structure(v) to hold info related to variables
%------------------------------------------------------------------------------------------
v.lon_a=f_a{'lon'}(:); v.lon_b=f{'lon'}(:); v.lat_a =f_a{'lat'}(:); v.lat_b =f{'lat'}(:);
v.nlon_a=length(v.lon_a); v.nlon_b=length(v.lon_b); v.nlat_b=length(v.lat_b); 
v.nlat_a=length(v.lat_a);
v.latweight_a=cos(pi/180*v.lat_a);
v.latweight_b=cos(pi/180*v.lat_b);
%v.xs0=1; v.xe0=v.nlon;
%v.ys0=1; v.ye0=v.nlat_b;
v.time=f{'time'}(:); v.nt=length(v.time);
v.sst_a =f_a{'t_surf'}(istart_a:iend_a,:,:); 
v.sst2_a =f2_a{'t_surf'}(istart2_a:iend2_a,:,:); 
v.sst_b =f{'t_surf'}(istart_b:iend_b,:,:); 
v.sst2_b =f2{'t_surf'}(istart2_b:iend2_b,:,:); 
v.landm = fland{'land_mask'}(:,:);
tend_a=iend_a-istart_a;
tend_b=iend_b-istart_b;
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
close(f);
close(f2);
close(f_a);
close(f2_a);
%-----------------------------------------------------%
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight_b=v.latweight_b;
glblatweight_a=v.latweight_a;
%
%latinc=30;
%sonic=1:30:180;
%sonic=1:15:90;
%tmp_reglatweight=zeros(6,latinc);
%tmp_reglatweight=zeros(6,15);
%for index=1:6;
%  begini=sonic(index);
%  endi=sonic(index)+latinc-1;
%%  endi=sonic(index)+14;
%  tmp_reglatweight(index,:)=v.latweight(begini:endi)';
%end
%testreggarbage=tmp_reglatweight;
%%for ilat=1:6;
%%for ilon=1:v.nlon-1;
%for ilon=1:3;
%    testreggarbage=cat(3,testreggarbage,tmp_reglatweight);
%end
%end
%
for index=1:v.nlon_a-1;
    glblatweight_a=horzcat(glblatweight_a,v.latweight_a);
end
for index=1:v.nlon_b-1;
    glblatweight_b=horzcat(glblatweight_b,v.latweight_b);
end
glbsumweight_a=sum(glblatweight_a(:));
glbsumweight_b=sum(glblatweight_b(:));
%------------------------------------------------------------------------------------------
startan=1;
endan=60;
%
wgt_sst_a=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.sst_a(ti,:,:);
  temp_var2      = v.sst2_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
%  wgt_sst_a()=wgt_var;
  v.sst_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.sst_mn_ts2_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.sst_b(ti,:,:);
  temp_var2      = v.sst2_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.sst_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.sst_mn_ts2_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.sst2_a=v.sst2_a-mean(v.sst_mn_ts2_a(startan:endan),2);
%v.sst_a=v.sst_a-mean(v.sst_mn_ts_a(startan:endan),2);
%v.sst2_b=v.sst2_b-mean(v.sst_mn_ts2_b(startan:endan),2);
%v.sst_b=v.sst_b-mean(v.sst_mn_ts_b(startan:endan),2);
%%v.sst=v.sst-mean(v.sst_mn_ts,2);
%------------------------------------------------------------------------------------------

var2='swdn_toa.nc';
fin_a=strcat(base1_a,var2);
fin2_a=strcat(base2_a,var2);
fin_b=strcat(base1_b,var2);
fin2_b=strcat(base2_b,var2);

% read input file
f_a =netcdf(fin_a,'nowrite');
f2_a =netcdf(fin2_a,'nowrite');
f =netcdf(fin_b,'nowrite');
f2 =netcdf(fin2_b,'nowrite');
v.swdn_toa_a =f_a{'swdn_toa'}(istart_a:iend_a,:,:); 
v.swdn_toa2_a =f2_a{'swdn_toa'}(istart2_a:iend2_a,:,:); 
v.swdn_toa_b =f{'swdn_toa'}(istart_b:iend_b,:,:); 
v.swdn_toa2_b =f2{'swdn_toa'}(istart2_b:iend2_b,:,:); 
close(f);
close(f2);
close(f_a);
close(f2_a);
%
% functional form on code to create a lat weighted glb mn time series
%in_var=v.swdn_toa;
%wgt_var=zeros(tend,v.nlat_b,v.nlon);
%for ti=1:tend;
%  temp_var      = in_var(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_b;
%  out_var(ti) = sum(wgt_var(:))/glbsumweight_b;
%end
%v.swdn_toa_mn_ts=out_var;
%in_var=v.swdn_toa;
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.swdn_toa_a(ti,:,:);
  temp_var2      = v.swdn_toa2_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.swdn_toa_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.swdn_toa2_mn_ts_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.swdn_toa_b(ti,:,:);
  temp_var2      = v.swdn_toa2_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.swdn_toa_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.swdn_toa2_mn_ts_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.swdn_toa2_a=v.swdn_toa2_a-mean(v.swdn_toa2_mn_ts_a(startan:endan),2);
%v.swdn_toa_a=v.swdn_toa_a-mean(v.swdn_toa_mn_ts_a(startan:endan),2);
%v.swdn_toa2_b=v.swdn_toa2_b-mean(v.swdn_toa2_mn_ts_b(startan:endan),2);
%v.swdn_toa_b=v.swdn_toa_b-mean(v.swdn_toa_mn_ts_b(startan:endan),2);
%%v.swdn_toa=v.swdn_toa-mean(v.swdn_toa_mn_ts,2);
%------------------------------------------------------------------------------------------
var3='swup_toa.nc';
fin_a=strcat(base1_a,var3);
fin2_a=strcat(base2_a,var3);
fin_b=strcat(base1_b,var3);
fin2_b=strcat(base2_b,var3);

% read input file
f_a =netcdf(fin_a,'nowrite');
f2_a =netcdf(fin2_a,'nowrite');
f =netcdf(fin_b,'nowrite');
f2 =netcdf(fin2_b,'nowrite');
v.swup_toa_a =f_a{'swup_toa'}(istart_a:iend_a,:,:); 
v.swup_toa2_a =f2_a{'swup_toa'}(istart2_a:iend2_a,:,:); 
v.swup_toa_b =f{'swup_toa'}(istart_b:iend_b,:,:); 
v.swup_toa2_b =f2{'swup_toa'}(istart2_b:iend2_b,:,:); 
close(f_a);
close(f2_a);
close(f);
close(f2);
%
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.swup_toa_a(ti,:,:);
  temp_var2      = v.swup_toa2_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.swup_toa_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.swup_toa2_mn_ts_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.swup_toa_b(ti,:,:);
  temp_var2      = v.swup_toa2_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.swup_toa_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.swup_toa2_mn_ts_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.swup_toa2_a=v.swup_toa2_a-mean(v.swup_toa2_mn_ts_a(startan:endan),2);
%v.swup_toa_a=v.swup_toa_a-mean(v.swup_toa_mn_ts_a(startan:endan),2);
%v.swup_toa2_b=v.swup_toa2_b-mean(v.swup_toa2_mn_ts_b(startan:endan),2);
%v.swup_toa_b=v.swup_toa_b-mean(v.swup_toa_mn_ts_b(startan:endan),2);
%------------------------------------------------------------------------------------------
var4='swup_toa_clr.nc';
fin_a=strcat(base1_a,var4);
fin2_a=strcat(base2_a,var4);
fin_b=strcat(base1_b,var4);
fin2_b=strcat(base2_b,var4);

% read input file
f_a =netcdf(fin_a,'nowrite');
f2_a =netcdf(fin2_a,'nowrite');
f_b =netcdf(fin_b,'nowrite');
f2_b =netcdf(fin2_b,'nowrite');
v.swup_clr_a =f_a{'swup_toa_clr'}(istart_a:iend_a,:,:); 
v.swup2_clr_a =f2_a{'swup_toa_clr'}(istart2_a:iend2_a,:,:); 
v.swup_clr_b =f_b{'swup_toa_clr'}(istart_b:iend_b,:,:); 
v.swup2_clr_b =f2_b{'swup_toa_clr'}(istart2_b:iend2_b,:,:); 
close(f_a);
close(f2_a);
close(f_b);
close(f2_b);
%%
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.swup_clr_a(ti,:,:);
  temp_var2      = v.swup2_clr_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.swup_clr_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.swup_clr2_mn_ts_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.swup_clr_b(ti,:,:);
  temp_var2      = v.swup2_clr_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.swup_clr_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.swup_clr2_mn_ts_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.swup2_clr_a=v.swup2_clr_a-mean(v.swup_clr2_mn_ts_a(startan:endan),2);
%v.swup_clr_a=v.swup_clr_a-mean(v.swup_clr_mn_ts_a(startan:endan),2);
%v.swup2_clr_b=v.swup2_clr_b-mean(v.swup_clr2_mn_ts_b(startan:endan),2);
%v.swup_clr_b=v.swup_clr_b-mean(v.swup_clr_mn_ts_b(startan:endan),2);
%------------------------------------------------------------------------------------------
var5='swdn_toa_clr.nc';
fin_a=strcat(base1_a,var5);
fin2_a=strcat(base2_a,var5);
fin_b=strcat(base1_b,var5);
fin2_b=strcat(base2_b,var5);

% read input file
f_a =netcdf(fin_a,'nowrite');
f2_a =netcdf(fin2_a,'nowrite');
f_b =netcdf(fin_b,'nowrite');
f2_b =netcdf(fin2_b,'nowrite');
v.swdn_clr_a =f_a{'swdn_toa_clr'}(istart_a:iend_a,:,:); 
v.swdn2_clr_a =f2_a{'swdn_toa_clr'}(istart2_a:iend2_a,:,:); 
v.swdn_clr_b =f_b{'swdn_toa_clr'}(istart_b:iend_b,:,:); 
v.swdn2_clr_b =f2_b{'swdn_toa_clr'}(istart2_b:iend2_b,:,:); 
close(f_a);
close(f2_a);
close(f_b);
close(f2_b);
%
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.swdn_clr_a(ti,:,:);
  temp_var2      = v.swdn2_clr_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.swdn_clr_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.swdn_clr2_mn_ts_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.swdn_clr_b(ti,:,:);
  temp_var2      = v.swdn2_clr_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.swdn_clr_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.swdn_clr2_mn_ts_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.swdn2_clr_a=v.swdn2_clr_a-mean(v.swdn_clr2_mn_ts_a(startan:endan),2);
%v.swdn_clr_a=v.swdn_clr_a-mean(v.swdn_clr_mn_ts_a(startan:endan),2);
%v.swdn2_clr_b=v.swdn2_clr_b-mean(v.swdn_clr2_mn_ts_b(startan:endan),2);
%v.swdn_clr_b=v.swdn_clr_b-mean(v.swdn_clr_mn_ts_b(startan:endan),2);
%------------------------------------------------------------------------------------------
var6='olr.nc';
fin_a=strcat(base1_a,var6);
fin2_a=strcat(base2_a,var6);
fin_b=strcat(base1_b,var6);
fin2_b=strcat(base2_b,var6);

% read input file
f_a =netcdf(fin_a,'nowrite');
f2_a =netcdf(fin2_a,'nowrite');
f_b =netcdf(fin_b,'nowrite');
f2_b =netcdf(fin2_b,'nowrite');
v.olr_a =f_a{'olr'}(istart_a:iend_a,:,:); 
v.olr2_a =f2_a{'olr'}(istart2_a:iend2_a,:,:); 
v.olr_b =f_b{'olr'}(istart_b:iend_b,:,:); 
v.olr2_b =f2_b{'olr'}(istart2_b:iend2_b,:,:); 
close(f_a);
close(f2_a);
close(f_b);
close(f2_b);
%
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.olr_a(ti,:,:);
  temp_var2      = v.olr2_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.olr_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.olr2_mn_ts_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.olr_b(ti,:,:);
  temp_var2      = v.olr2_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.olr_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.olr2_mn_ts_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.olr2_a=v.olr2_a-mean(v.olr2_mn_ts_a(startan:endan),2);
%v.olr_a=v.olr_a-mean(v.olr_mn_ts_a(startan:endan),2);
%v.olr2_b=v.olr2_b-mean(v.olr2_mn_ts_b(startan:endan),2);
%v.olr_b=v.olr_b-mean(v.olr_mn_ts_b(startan:endan),2);
%------------------------------------------------------------------------------------------
var7='olr_clr.nc';
fin_a=strcat(base1_a,var7);
fin2_a=strcat(base2_a,var7);
fin_b=strcat(base1_b,var7);
fin2_b=strcat(base2_b,var7);

% read input file
f_a =netcdf(fin_a,'nowrite');
f2_a =netcdf(fin2_a,'nowrite');
f_b =netcdf(fin_b,'nowrite');
f2_b =netcdf(fin2_b,'nowrite');
v.olr_clr_a =f_a{'olr_clr'}(istart_a:iend_a,:,:); 
v.olr2_clr_a =f2_a{'olr_clr'}(istart2_a:iend2_a,:,:); 
v.olr_clr_b =f_b{'olr_clr'}(istart_b:iend_b,:,:); 
v.olr2_clr_b =f2_b{'olr_clr'}(istart2_b:iend2_b,:,:); 
close(f_a);
close(f2_a);
close(f_b);
close(f2_b);
%
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.olr_clr_a(ti,:,:);
  temp_var2      = v.olr2_clr_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.olr_clr_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.olr_clr2_mn_ts_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.olr_clr_b(ti,:,:);
  temp_var2      = v.olr2_clr_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.olr_clr_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.olr_clr2_mn_ts_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%% compute the anomaly
%v.olr2_clr_a=v.olr2_clr_a-mean(v.olr_clr2_mn_ts_a(startan:endan),2);
%v.olr_clr_a=v.olr_clr_a-mean(v.olr_clr_mn_ts_a(startan:endan),2);
%v.olr2_clr_b=v.olr2_clr_b-mean(v.olr_clr2_mn_ts_b(startan:endan),2);
%v.olr_clr_b=v.olr_clr_b-mean(v.olr_clr_mn_ts_b(startan:endan),2);

%------------------------------------------------------------------------------------------
var8='precip.nc';
fin=strcat(base1_a,var8);
fin2=strcat(base2_a,var8);
fin_b=strcat(base1_b,var8);
fin2_b=strcat(base2_b,var8);

% read input file
f =netcdf(fin_b,'nowrite');
f2 =netcdf(fin2_b,'nowrite');
v.precip =f{'precip'}(istart_b:iend_b,:,:); 
v.precip2=f2{'precip'}(istart2_b:iend2_b,:,:); 
close(f);
close(f2);
%-----------------------------------------------------------------------------------------
% compute radiative budget
% feedbacks should be computed with exp1-exp2, and positive values should lead to warming
%-----------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux_b=v.swdn_toa_b-v.olr_b-v.swup_toa_b;
v.radflux2_b=v.swdn_toa2_b-v.olr2_b-v.swup_toa2_b;
v.radflux_tmn_b=mean(v.radflux_b,1);

toa_net_fdbck_b=v.radflux_b-v.radflux2_b;
olr_fdbck_b=v.olr_b-v.olr2_b;
sw_fdbck_b=v.swdn_toa_b-v.swup_toa_b-v.swdn_toa2_b+v.swup_toa2_b;

v.radflux_a=v.swdn_toa_a-v.olr_a-v.swup_toa_a;
v.radflux2_a=v.swdn_toa2_a-v.olr2_a-v.swup_toa2_a;
v.radflux_tmn_a=mean(v.radflux_a,1);

toa_net_fdbck_a=v.radflux_a-v.radflux2_a;
olr_fdbck_a=v.olr_a-v.olr2_a;
sw_fdbck_a=v.swdn_toa_a-v.swup_toa_a-v.swdn_toa2_a+v.swup_toa2_a;

in_var=v.radflux_a;  
in_var2=v.radflux2_a;  
%tend_short=pend-pstart;
for ti=1:959;
  temp_var      = in_var(ti,:,:);
  temp_var2      = in_var2(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  out_var(ti) = sum(wgt_var(:))/glbsumweight_a;
  out_var2(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
glb_mn_radflux_a=out_var;
glb_mn_radflux2_a=out_var2;

% clear sky
lw_clr_fdbck_a=v.olr_clr_a-v.olr2_clr_a;
% the sign should be flipped here because larger olr values correspond to cooling
lw_clr_fdbck_a=-lw_clr_fdbck_a;
% swdn_clr=swdn, should swdn_clr be part of the computation for 
sw_clr_fdbck_a=v.swdn_clr_a-v.swup_clr_a-v.swdn2_clr_a+v.swup2_clr_a;

lw_clr_fdbck_b=v.olr_clr_b-v.olr2_clr_b;
lw_clr_fdbck_b=-lw_clr_fdbck_b;
sw_clr_fdbck_b=v.swdn_clr_b-v.swup_clr_b-v.swdn2_clr_b+v.swup2_clr_b;

% cloud radiative effects: clear sky - all sky  
olr_cre1_a=v.olr_clr_a-v.olr_a; % pos means clouds warm
olr_cre2_a=v.olr2_clr_a-v.olr2_a;
sw_cre1_a=v.swup_clr_a-v.swup_toa_a; % pos means clouds cool, so we plot -sw_cre
sw_cre2_a=v.swup2_clr_a-v.swup_toa2_a;
tot_cre1_a=olr_cre1_a-sw_cre1_a; % pos means clouds warm
tot_cre2_a=olr_cre2_a-sw_cre2_a;
%
olr_cre1_b=v.olr_clr_b-v.olr_b; % pos means clouds warm
olr_cre2_b=v.olr2_clr_b-v.olr2_b;
sw_cre1_b=v.swup_clr_b-v.swup_toa_b; % pos means clouds cool, so we plot -sw_cre
sw_cre2_b=v.swup2_clr_b-v.swup_toa2_b;
tot_cre1_b=olr_cre1_b-sw_cre1_b; % pos means clouds warm
tot_cre2_b=olr_cre2_b-sw_cre2_b;
% CRE = lw_cre - sw_cre; positive values correspond to warming from clouds
%olr_cre_fdbck=lw_clr_fdbck - olr_fdbck;
%sw_cre_fdbck=sw_clr_fdbck - sw_fdbck;
%toa_cre_fdbck=sw_cre_fdbck+olr_cre_fdbck;
olr_cre_fdbck_a=olr_cre1_a-olr_cre2_a;
sw_cre_fdbck_a=sw_cre1_a-sw_cre2_a;
toa_cre_fdbck_a=olr_cre_fdbck_a+sw_cre_fdbck_a;
%
olr_cre_fdbck_b=olr_cre1_b-olr_cre2_b;
sw_cre_fdbck_b=sw_cre1_b-sw_cre2_b;
toa_cre_fdbck_b=olr_cre_fdbck_b+sw_cre_fdbck_b;
%toa_cre_fdbck_test=tot_cre1-tot_cre2;

tempdiff_full_a=v.sst_a-v.sst2_a;  % forced minus control
tempdiff=mean(tempdiff_full_a,1); % take the time mean
tempdiff_zmn_a=mean(tempdiff,3); % take the zonal mean

tempdiff_fulla = mean(tempdiff_full_a(1:240,:,:),1);
tempdiffa_zmn_a=mean(tempdiff_fulla,3); % take the zonal mean
tempdiff_fullb = mean(tempdiff_full_a(240:480,:,:),1);
tempdiffb_zmn_a=mean(tempdiff_fullb,3); % take the zonal mean
tempdiff_fullc = mean(tempdiff_full_a(480:720,:,:),1);
tempdiffc_zmn_a=mean(tempdiff_fullc,3); % take the zonal mean
tempdiff_fulld = mean(tempdiff_full_a(720:960,:,:),1);
tempdiffd_zmn_a=mean(tempdiff_fulld,3); % take the zonal mean
%%
tempdiff_full_b=v.sst_b-v.sst2_b;  % forced minus control
tempdiff=mean(tempdiff_full_b,1); % take the time mean
tempdiff_zmn_b=mean(tempdiff,3); % take the zonal mean
%
tempdiff_fulla = mean(tempdiff_full_b(1:240,:,:),1);
tempdiffa_zmn_b=mean(tempdiff_fulla,3); % take the zonal mean
tempdiff_fullb = mean(tempdiff_full_b(240:480,:,:),1);
tempdiffb_zmn_b=mean(tempdiff_fullb,3); % take the zonal mean
tempdiff_fullc = mean(tempdiff_full_b(480:720,:,:),1);
tempdiffc_zmn_b=mean(tempdiff_fullc,3); % take the zonal mean
tempdiff_fulld = mean(tempdiff_full_b(720:960,:,:),1);
tempdiffd_zmn_b=mean(tempdiff_fulld,3); % take the zonal mean
%
%tempdiff_first10_a = mean(tempdiff_full_a(1:120,:,:),1);
%tempdiff_60t70_a = mean(tempdiff_full_a(720:840,:,:),1);
%tempdiff_first10_b = mean(tempdiff_full_b(1:120,:,:),1);
%tempdiff_60t70_b = mean(tempdiff_full_b(720:840,:,:),1);
%%-----------------------------------------------------%
%% compute global mean temp diff: first the difference 
%% between forced and cntl is taken, then the glb mean
%% is computed
%%-----------------------------------------------------%
%in_var=tempdiff_full_b; % in  : v.sst 
%% out : out_var
%wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
%for ti=1:tend_b;
%  temp_var      = in_var(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_b;
%  out_var(ti) = sum(wgt_var(:))/glbsumweight_b;
%end
%% save global mean time series in v
%%-----------------------------------------------------%
%glb_mn_delt_b=out_var;
%%
%wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
%for ti=1:tend_a;
%  temp_var      = tempdiff_full_a(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_a;
%  out_var(ti) = sum(wgt_var(:))/glbsumweight_a;
%end
%glb_mn_delt_a=out_var;
%%
% defne the time period over which fdbck is computed
pstart=720; % 840 months is 70 years
pend=960; % 80 years
%
toa_f_part_a=toa_net_fdbck_a(pstart:pend,:,:);
toa_fdbck_part_mn_a=mean(toa_f_part_a,1); %compute time mean
toa_fdbck_part_zmn_a=mean(toa_fdbck_part_mn_a,3); % compute zonal mean
%
olr_f_part_a=olr_fdbck_a(pstart:pend,:,:);
olr_fdbck_part_mn_a=mean(olr_f_part_a,1);
olr_fdbck_part_zmn_a=mean(olr_fdbck_part_mn_a,3);
%
sw_f_part_a=sw_fdbck_a(pstart:pend,:,:);
sw_fdbck_part_mn_a=mean(sw_f_part_a,1);
sw_fdbck_part_zmn_a=mean(sw_fdbck_part_mn_a,3);
%
lw_clr_f_part_a=lw_clr_fdbck_a(pstart:pend,:,:);
lw_clr_fdbck_part_mn_a=mean(lw_clr_f_part_a,1);
lw_clr_fdbck_part_zmn_a=mean(lw_clr_fdbck_part_mn_a,3);
%
sw_clr_f_part_a=sw_clr_fdbck_a(pstart:pend,:,:);
sw_clr_fdbck_part_mn_a=mean(sw_clr_f_part_a,1);
sw_clr_fdbck_part_zmn_a=mean(sw_clr_fdbck_part_mn_a,3);
%
toa_cre_f_part_a=toa_cre_fdbck_a(pstart:pend,:,:);
toa_cre_fdbck_part_mn_a=mean(toa_cre_f_part_a,1);
toa_cre_fdbck_part_zmn_a=mean(toa_cre_fdbck_part_mn_a,3);
%
olr_cre_f_part_a=olr_cre_fdbck_a(pstart:pend,:,:);
olr_cre_fdbck_part_mn_a=mean(olr_cre_f_part_a,1);
olr_cre_fdbck_part_zmn_a=mean(olr_cre_fdbck_part_mn_a,3);
%
sw_cre_f_part_a=sw_cre_fdbck_a(pstart:pend,:,:);
sw_cre_fdbck_part_mn_a=mean(sw_cre_f_part_a,1);
sw_cre_fdbck_part_zmn_a=mean(sw_cre_fdbck_part_mn_a,3);
%%%%
%
toa_f_part_b=toa_net_fdbck_b(pstart:pend,:,:);
toa_fdbck_part_mn_b=mean(toa_f_part_b,1);
toa_fdbck_part_zmn_b=mean(toa_fdbck_part_mn_b,3);
%
olr_f_part_b=olr_fdbck_b(pstart:pend,:,:);
olr_fdbck_part_mn_b=mean(olr_f_part_b,1);
olr_fdbck_part_zmn_b=mean(olr_fdbck_part_mn_b,3);
%
sw_f_part_b=sw_fdbck_b(pstart:pend,:,:);
sw_fdbck_part_mn_b=mean(sw_f_part_b,1);
sw_fdbck_part_zmn_b=mean(sw_fdbck_part_mn_b,3);
%
lw_clr_f_part_b=lw_clr_fdbck_b(pstart:pend,:,:);
lw_clr_fdbck_part_mn_b=mean(lw_clr_f_part_b,1);
lw_clr_fdbck_part_zmn_b=mean(lw_clr_fdbck_part_mn_b,3);
%
sw_clr_f_part_b=sw_clr_fdbck_b(pstart:pend,:,:);
sw_clr_fdbck_part_mn_b=mean(sw_clr_f_part_b,1);
sw_clr_fdbck_part_zmn_b=mean(sw_clr_fdbck_part_mn_b,3);
%
toa_cre_f_part_b=toa_cre_fdbck_b(pstart:pend,:,:);
toa_cre_fdbck_part_mn_b=mean(toa_cre_f_part_b,1);
toa_cre_fdbck_part_zmn_b=mean(toa_cre_fdbck_part_mn_b,3);
%
olr_cre_f_part_b=olr_cre_fdbck_b(pstart:pend,:,:);
olr_cre_fdbck_part_mn_b=mean(olr_cre_f_part_b,1);
olr_cre_fdbck_part_zmn_b=mean(olr_cre_fdbck_part_mn_b,3);
%
sw_cre_f_part_b=sw_cre_fdbck_b(pstart:pend,:,:);
sw_cre_fdbck_part_mn_b=mean(sw_cre_f_part_b,1);
sw_cre_fdbck_part_zmn_b=mean(sw_cre_fdbck_part_mn_b,3);
%%------------------------------------------------------------------------------------------
%
%Normalize the feedbacks...
%
%for ti=1:tend_a;
%  temp_var      = v.sst_a(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_a;
%  out_var(ti) = sum(wgt_var(:))/glbsumweight_a;
%  temp_var      = v.sst2_a(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_a;
%  out_var2(ti) = sum(wgt_var(:))/glbsumweight_a;
%end
%v.sst_a_ts=out_var;
%v.sst2_a_ts=out_var2;
%tempdiff_a_end=v.sst_a_ts(pstart:pend-1)-v.sst2_a_ts(pstart:pend-1);
tempdiff_a_end=v.sst_mn_ts_a(pstart:pend-1)-v.sst_mn_ts2_a(pstart:pend-1);
mn_sfc_temp_ch_a=mean(tempdiff_a_end);
%for ti=1:tend_b;
%  temp_var      = v.sst_b(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_b;
%  out_var(ti) = sum(wgt_var(:))/glbsumweight_b;
%  temp_var      = v.sst2_b(ti,:,:);
%  wgt_var       = squeeze(temp_var).*glblatweight_b;
%  out_var2(ti) = sum(wgt_var(:))/glbsumweight_b;
%end
%v.sst_b_ts=out_var;
%v.sst2_b_ts=out_var2;
%tempdiff_b_end=v.sst_b_ts(pstart:pend-1)-v.sst2_b_ts(pstart:pend-1);
tempdiff_b_end=v.sst_mn_ts_b(pstart:pend-1)-v.sst_mn_ts2_b(pstart:pend-1);
mn_sfc_temp_ch_b=mean(tempdiff_b_end);
%
% below is the old way of normalizing....
%global_tempdiff_a=tempdiff_60t70_a-tempdiff_first10_a;
%wgt_var       = squeeze(global_tempdiff_a).*glblatweight_a;
%mn_sfc_temp_ch_a   = sum(wgt_var(:))/glbsumweight_a;
%global_tempdiff_b=tempdiff_60t70_b-tempdiff_first10_b;
%wgt_var       = squeeze(global_tempdiff_b).*glblatweight_b;
%mn_sfc_temp_ch_b   = sum(wgt_var(:))/glbsumweight_b;
%
%wgt_var       = squeeze(global_tempdiff_a).*glblatweight_a;
%wgt_var       = squeeze(global_tempdiff_a).*glblatweight_a;
%mn_sfc_temp_ch_a   = sum(wgt_var(:))/glbsumweight_a;
%global_tempdiff_b=tempdiff_60t70_b-tempdiff_first10_b;
%wgt_var       = squeeze(global_tempdiff_b).*glblatweight_b;
%mn_sfc_temp_ch_b   = sum(wgt_var(:))/glbsumweight_b;
%
% plot one map normalized by mn_sfc_temp_ch and one normalized
% with the sfc_temp change at every grid point
%
%normfac_b=mean(tempdiff_full(pstart:pend,:,:),1);
%normfac_a=mn_sfc_temp_ch_a;
%normfac_alocal=global_tempdiff_a;
%norm_tempdiff_zmn_a=mean(global_tempdiff_a,3);
%normfac_b=mn_sfc_temp_ch_b;
%normfac_blocal=global_tempdiff_b;
%norm_tempdiff_zmn_b=mean(global_tempdiff_b,3);
%
%% normalized by global mean tsfc diff
%toa_fdbck_gnorm_a=toa_fdbck_part_mn_a./normfac_a;
%olr_fdbck_gnorm_a=olr_fdbck_part_mn_a./normfac_a;
%sw_fdbck_gnorm_a=sw_fdbck_part_mn_a./normfac_a;
%lw_clr_fdbck_gnorm_a=lw_clr_fdbck_part_mn_a./normfac_a;
%sw_clr_fdbck_gnorm_a=sw_clr_fdbck_part_mn_a./normfac_a;
%toa_cre_fdbck_gnorm_a=toa_cre_fdbck_part_mn_a./normfac_a;
%olr_cre_fdbck_gnorm_a=olr_cre_fdbck_part_mn_a./normfac_a;
%sw_cre_fdbck_gnorm_a=sw_cre_fdbck_part_mn_a./normfac_a;
%% normalized by local mean tsfc diff
%toa_fdbck_lnorm_a=toa_fdbck_part_mn_a./normfac_alocal;
%olr_fdbck_lnorm_a=olr_fdbck_part_mn_a./normfac_alocal;
%sw_fdbck_lnorm_a=sw_fdbck_part_mn_a./normfac_alocal;
%lw_clr_fdbck_lnorm_a=lw_clr_fdbck_part_mn_a./normfac_alocal;
%sw_clr_fdbck_lnorm_a=sw_clr_fdbck_part_mn_a./normfac_alocal;
%toa_cre_fdbck_lnorm_a=toa_cre_fdbck_part_mn_a./normfac_alocal;
%olr_cre_fdbck_lnorm_a=olr_cre_fdbck_part_mn_a./normfac_alocal;
%sw_cre_fdbck_lnorm_a=sw_cre_fdbck_part_mn_a./normfac_alocal;
%% normalize the zonal means....
%toa_fdbck_part_zmn_norm_a=toa_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%olr_fdbck_part_zmn_norm_a=olr_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%sw_fdbck_part_zmn_norm_a=sw_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%lw_clr_fdbck_part_zmn_norm_a=lw_clr_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%sw_clr_fdbck_part_zmn_norm_a=sw_clr_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%toa_cre_fdbck_part_zmn_norm_a=toa_cre_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%olr_cre_fdbck_part_zmn_norm_a=olr_cre_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%sw_cre_fdbck_part_zmn_norm_a=sw_cre_fdbck_part_zmn_a./norm_tempdiff_zmn_a;
%% normalized by global mean tsfc diff
%toa_fdbck_gnorm_b=toa_fdbck_part_mn_b./normfac_b;
%olr_fdbck_gnorm_b=olr_fdbck_part_mn_b./normfac_b;
%sw_fdbck_gnorm_b=sw_fdbck_part_mn_b./normfac_b;
%lw_clr_fdbck_gnorm_b=lw_clr_fdbck_part_mn_b./normfac_b;
%sw_clr_fdbck_gnorm_b=sw_clr_fdbck_part_mn_b./normfac_b;
%toa_cre_fdbck_gnorm_b=toa_cre_fdbck_part_mn_b./normfac_b;
%olr_cre_fdbck_gnorm_b=olr_cre_fdbck_part_mn_b./normfac_b;
%sw_cre_fdbck_gnorm_b=sw_cre_fdbck_part_mn_b./normfac_b;
%% normalized by local mean tsfc diff
%toa_fdbck_lnorm_b=toa_fdbck_part_mn_b./normfac_blocal;
%olr_fdbck_lnorm_b=olr_fdbck_part_mn_b./normfac_blocal;
%sw_fdbck_lnorm_b=sw_fdbck_part_mn_b./normfac_blocal;
%lw_clr_fdbck_lnorm_b=lw_clr_fdbck_part_mn_b./normfac_blocal;
%sw_clr_fdbck_lnorm_b=sw_clr_fdbck_part_mn_b./normfac_blocal;
%toa_cre_fdbck_lnorm_b=toa_cre_fdbck_part_mn_b./normfac_blocal;
%olr_cre_fdbck_lnorm_b=olr_cre_fdbck_part_mn_b./normfac_blocal;
%sw_cre_fdbck_lnorm_b=sw_cre_fdbck_part_mn_b./normfac_blocal;
%% normalize the zonal means....
%toa_fdbck_part_zmn_norm_b=toa_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%olr_fdbck_part_zmn_norm_b=olr_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%sw_fdbck_part_zmn_norm_b=sw_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%lw_clr_fdbck_part_zmn_norm_b=lw_clr_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%sw_clr_fdbck_part_zmn_norm_b=sw_clr_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%toa_cre_fdbck_part_zmn_norm_b=toa_cre_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%olr_cre_fdbck_part_zmn_norm_b=olr_cre_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%sw_cre_fdbck_part_zmn_norm_b=sw_cre_fdbck_part_zmn_b./norm_tempdiff_zmn_b;
%%------------------------------------------------------------------------------------------
% Figures
%------------------------------------------------------------------------------------------
NameArray={'Marker','MarkerSize','LineStyle','LineWidth'};
ValueArray={'.',.1,'-',2;'.',.1,'-',2;'.',.1,'-',2;'v',5,'-',1;'v',5,'-',1;'*',5,'-',1;'*',5,'-',1;'*',5,'-',1};
%figure; plot(sin(pi*v.lat'/180.),fdbck_lat);
%figure; plot(v.lat',toa_feedback_zmn);
%title('zmn toa feedbck')
figure; plot(v.lat_b',tempdiff_zmn_b,v.lat_b',tempdiffa_zmn_b,v.lat_b',tempdiffb_zmn_b,v.lat_b',tempdiffc_zmn_b,v.lat_b',tempdiffd_zmn_b);
title('tempdiff_b zonal mean')
legend('time mean','years 0-20','years 20-40','years 40-60','years 60-80','boxoff','Location','northwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
% comparison between cm2 adn cm4
%norm_b=mn_sfc_temp_ch_b*v.latweight_b;
%tdiff_zmn_b=tempdiffd_zmn_b./norm_b;
%tdiff_zmn_b=tempdiffd_zmn_b/mn_sfc_temp_ch_b;
%tdiff_zmn_a=tempdiffd_zmn_a/mn_sfc_temp_ch_a;
tdiff_zmn_b=tempdiffd_zmn_b-mn_sfc_temp_ch_b;
tdiff_zmn_a=tempdiffd_zmn_a-mn_sfc_temp_ch_a;
figure; polamp=plot(v.lat_b',tdiff_zmn_b,v.lat_a',tdiff_zmn_a);
title('Normalized Polar Amplification of last 20 years')
legend('CM2.1','CM4','boxoff','Location','northwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')


% plot the zonal mean feedback and individual compoenents of feedback
figure; znm_a=plot(v.lat_a',toa_fdbck_part_zmn_a,'k',v.lat_a',olr_fdbck_part_zmn_a,'b',...
v.lat_a',sw_fdbck_part_zmn_a,'r',v.lat_a',lw_clr_fdbck_part_zmn_a,'b+',v.lat_a',sw_clr_fdbck_part_zmn_a,'r+',...
v.lat_a',toa_cre_fdbck_part_zmn_a,'k*',v.lat_a',olr_cre_fdbck_part_zmn_a,'b*',v.lat_a',sw_cre_fdbck_part_zmn_a,'r*');
title('zmn feedbck a')
legend('net','olr','sw','lw_{clr}','sw_{clr}','toa_{cre}','olr_{cre}','sw_{cre}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_a, 'EdgeColor', 'none')
set(znm_a,NameArray,ValueArray)
%
figure; znm_b=plot(v.lat_b',toa_fdbck_part_zmn_b,'k',v.lat_b',olr_fdbck_part_zmn_b,'b', ...
v.lat_b',sw_fdbck_part_zmn_b,'r',v.lat_b',lw_clr_fdbck_part_zmn_b,'b+',v.lat_b',sw_clr_fdbck_part_zmn_b,'r+',...
v.lat_b',toa_cre_fdbck_part_zmn_b,'k*',v.lat_b',olr_cre_fdbck_part_zmn_b,'b*',v.lat_b',sw_cre_fdbck_part_zmn_b,'r*');
title('zmn feedbck b')
legend('net','olr','sw','lw_{clr}','sw_{clr}','toa_{cre}','olr_{cre}','sw_{cre}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none');
set(znm_b,NameArray,ValueArray)
%
% plot cre's from both models together
figure; znm_cre=plot(v.lat_a',toa_cre_fdbck_part_zmn_a/mn_sfc_temp_ch_a,'k',v.lat_a',olr_cre_fdbck_part_zmn_a/mn_sfc_temp_ch_a,'b',v.lat_a',sw_cre_fdbck_part_zmn_a/mn_sfc_temp_ch_a,'r',v.lat_b',toa_cre_fdbck_part_zmn_b/mn_sfc_temp_ch_b,'k--',v.lat_b',olr_cre_fdbck_part_zmn_b/mn_sfc_temp_ch_b,'b--',v.lat_b',sw_cre_fdbck_part_zmn_b/mn_sfc_temp_ch_b,'r--');
title('zmn change of CRE div by glb mn tsurf');
legend('net_{cre_a}','olr_{cre_a}','sw_{cre_a}','net_{cre_b}','olr_{cre_b}','sw_{cre_b}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
% compute the global mean cre radiative responses...
glb_net_cre_toa_fdbck_a=sum(toa_cre_fdbck_part_zmn_a.*v.latweight_a')/sum(v.latweight_a)/mn_sfc_temp_ch_a
glb_net_cre_olr_fdbck_a=sum(olr_cre_fdbck_part_zmn_a.*v.latweight_a')/sum(v.latweight_a)/mn_sfc_temp_ch_a
glb_net_cre_sw_fdbck_a=sum(sw_cre_fdbck_part_zmn_a.*v.latweight_a')/sum(v.latweight_a)/mn_sfc_temp_ch_a
glb_net_cre_toa_fdbck_b=sum(toa_cre_fdbck_part_zmn_b.*v.latweight_b')/sum(v.latweight_b)/mn_sfc_temp_ch_b
glb_net_cre_olr_fdbck_b=sum(olr_cre_fdbck_part_zmn_b.*v.latweight_b')/sum(v.latweight_b)/mn_sfc_temp_ch_b
glb_net_cre_sw_fdbck_b=sum(sw_cre_fdbck_part_zmn_b.*v.latweight_b')/sum(v.latweight_b)/mn_sfc_temp_ch_b

% compute the global mean radiative responses...
glb_net_toa_fdbck_a=sum(toa_fdbck_part_zmn_a.*v.latweight_a')/sum(v.latweight_a)/mn_sfc_temp_ch_a
glb_net_olr_fdbck_a=sum(olr_fdbck_part_zmn_a.*v.latweight_a')/sum(v.latweight_a)/mn_sfc_temp_ch_a
glb_net_sw_fdbck_a=sum(sw_fdbck_part_zmn_a.*v.latweight_a')/sum(v.latweight_a)/mn_sfc_temp_ch_a
glb_net_toa_fdbck_b=sum(toa_fdbck_part_zmn_b.*v.latweight_b')/sum(v.latweight_b)/mn_sfc_temp_ch_b
glb_net_olr_fdbck_b=sum(olr_fdbck_part_zmn_b.*v.latweight_b')/sum(v.latweight_b)/mn_sfc_temp_ch_b
glb_net_sw_fdbck_b=sum(sw_fdbck_part_zmn_b.*v.latweight_b')/sum(v.latweight_b)/mn_sfc_temp_ch_b

% plot tot rad fluxes from both models together
figure; znm_rad=plot(v.lat_a',toa_fdbck_part_zmn_a,'k',v.lat_a',olr_fdbck_part_zmn_a,'b',v.lat_a',sw_fdbck_part_zmn_a,'r',v.lat_b',toa_fdbck_part_zmn_b,'k--',v.lat_b',olr_fdbck_part_zmn_b,'b--',v.lat_b',sw_fdbck_part_zmn_b,'r--');
title('zmn rad change');
legend('net_{a}','olr_{a}','sw_{a}','net_{b}','olr_{b}','sw_{b}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
% plot normalized tot rad fluxes from both models together
figure; znm_rad=plot(v.lat_a',toa_fdbck_part_zmn_a/mn_sfc_temp_ch_a,'k',v.lat_a',olr_fdbck_part_zmn_a/mn_sfc_temp_ch_a,'b',v.lat_a',sw_fdbck_part_zmn_a/mn_sfc_temp_ch_a,'r',v.lat_b',toa_fdbck_part_zmn_b/mn_sfc_temp_ch_b,'k--',v.lat_b',olr_fdbck_part_zmn_b/mn_sfc_temp_ch_b,'b--',v.lat_b',sw_fdbck_part_zmn_b/mn_sfc_temp_ch_b,'r--');
title('norm zmn rad change');
legend('net_{a}','olr_{a}','sw_{a}','net_{b}','olr_{b}','sw_{b}','boxoff','Location','southwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
%-----------------------------------------------------%
%% subtract off the mean of the global mean ts
%v.sst_mn_ts2_a=v.sst_mn_ts2_a-mean(v.sst_mn_ts2_a(startan:endan),2);
%v.sst_mn_ts_a=v.sst_mn_ts_a-mean(v.sst_mn_ts_a(startan:endan),2);
%v.sst_mn_ts2_b=v.sst_mn_ts2_b-mean(v.sst_mn_ts2_b(startan:endan),2);
%v.sst_mn_ts_b=v.sst_mn_ts_b-mean(v.sst_mn_ts_b(startan:endan),2);
%%-----------------------------------------------------%
%-----------------------------------------------------------------------------------------
incoming_ts=v.sst_mn_ts_a;
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend_a;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%-----------------------------------------------------------------------------------------
sfc_t_sm_ts_a=output_ts;
%
%-----------------------------------------------------------------------------------------
incoming_ts=v.sst_mn_ts_b;
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend_b;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%-----------------------------------------------------------------------------------------
sfc_t_sm_ts_b=output_ts;
%
%-----------------------------------------------------------------------------------------
incoming_ts=v.sst_mn_ts2_a;
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend_a;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%-----------------------------------------------------------------------------------------
sfc_t_sm_ts2_a=output_ts;
%
%-----------------------------------------------------------------------------------------
incoming_ts=v.sst_mn_ts2_b;
% compute a running mean
rough_ts=incoming_ts;
tendindex=tend_b;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%-----------------------------------------------------------------------------------------
sfc_t_sm_ts2_b=output_ts;
%% evolution of surface temperature
figure; plot(timeindex_a(1:endt_a),sfc_t_sm_ts_a,timeindex_a(1:endt_a),sfc_t_sm_ts2_a)
title('Time evolution of T_{sfc} for 1% CO2 exp a')
legend('1% per year CO2','Control','boxoff','Location','northwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_a, 'EdgeColor', 'none')
%
sfc_t_sm_ts2_b=output_ts;
%% evolution of surface temperature
figure; plot(timeindex_b(1:endt_b),sfc_t_sm_ts_b,timeindex_b(1:endt_b),sfc_t_sm_ts2_b)
title('Time evolution of T_{sfc} for 1% CO2 exp b')
legend('1% per year CO2','Control','boxoff','Location','northwest')
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
%-----------------------------------------------------------------------------------------
% this is the end

