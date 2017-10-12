%------------------------------------------------------------------------------------------
% cloud_cover.m
%
% 1. read in variables from input files
% 2. make figures
%         - 3 panel figure of same var from two models and diff 
%
% levi silvers                                        june 2016
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
%exp1name_a='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
exp1name_a='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
%expyrs1_a='atmos.006101-014012.';
expyrs1_a='atmos.000101-014012.';
modelname_a='Model: AM4OM2'
lengthyr_a=80; % length of time series in years
% it is possible to have time series of two different lengths
% depending on how the output from the forced vs control run was saved...
%iend_a=960;
iend_a=1680;
% endt is the end index for the time series that have been computed
% with a running mean of +/- 6 months so it is 13 months shorter
endt_a=947; % needs to be iend -1 year and one month

%% for CM2 model: 
%exp1name_b='CM2.1U-D4_1PctTo2X_I1/ts_all/';
exp1name_b='CM2.1U_Control-1990_E1/ts_all/';
%expyrs1_b='atmos.000101-010012.';
expyrs1_b='atmos.000101-010012.';
modelname_b='Model: CM2'
% for time series 100 years in length:
lengthyr_b=100;
iend_b=1200;
%iend2_b=1200; % istart2=iend2-iend+1; 
% endt is the end index for the time series that have been computed
% with a running mean of +/- 6 months so it is 13 months shorter
endt_b=1187;

% abrupt 4XCO2 forcing
%exp1name='AM4OM2F_c96l32_am4g5r11_1860climo_4xCO2/ts_all/';
%expyrs1='atmos.006101-015012.';

exp1_a=strcat(basedir_a,exp1name_a);
%exp2_a=strcat(basedir_a,exp1name_a);
exp1_b=strcat(basedir_b,exp1name_b);
%exp2_b=strcat(basedir_b,exp1name_b);

%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%fin='/archive/Ming.Zhao/awglg/ulm/c96L32_am4g5r11_2000climo_p2K/ts_all/atmos.000201-001112.t_surf.nc'
base1_a=strcat(exp1_a,expyrs1_a);
%base2_a=strcat(exp2_a,expyrs1_a);
base1_b=strcat(exp1_b,expyrs1_b);
%base2_b=strcat(exp2_b,expyrs1_b);

%compute a time in months: 
timeindex_a=0:0.0833:lengthyr_a-1;
timeindex_b=0:0.0833:lengthyr_b-1;
istart_b=1;
%istart2_b=iend2_b-iend_b+1;
istart_a=1;
%istart2_a=iend2_a-iend_a+1;

%
landm='/archive/Ming.Zhao/awg/ulm/CM2.1U-D4_1PctTo2X_I1/gfdl.ncrc2-intel-prod-openmp/pp/atmos_scalar/atmos_scalar.static.nc'
fland=netcdf(landm,'nowrite');
%------------------------------------------------------------------------------------------

%var1='t_surf.nc';
%var1='high_cld_amt.nc';
var1='low_cld_amt';
var2='mid_cld_amt';
var3='high_cld_amt';
fin=strcat(base1_a,var1,'.nc');
fin_b=strcat(base1_b,var1,'.nc');
fin2=strcat(base1_a,var2,'.nc');
fin2_b=strcat(base1_b,var2,'.nc');
fin3=strcat(base1_a,var3,'.nc');
fin3_b=strcat(base1_b,var3,'.nc');

% read input file
f_a =netcdf(fin,'nowrite');
f2_a =netcdf(fin2,'nowrite');
f3_a =netcdf(fin3,'nowrite');
f_b =netcdf(fin_b,'nowrite');
f2_b =netcdf(fin2_b,'nowrite');
f3_b =netcdf(fin3_b,'nowrite');
%f =netcdf(fin_b,'nowrite');
%f2 =netcdf(fin2_b,'nowrite');
% set up a structure(v) to hold info related to variables
% set up a structure(v) to hold info related to variables
%------------------------------------------------------------------------------------------
v.lon_a=f_a{'lon'}(:); v.lon_b=f_b{'lon'}(:); v.lat_a =f_a{'lat'}(:); v.lat_b =f_b{'lat'}(:);
v.nlon_a=length(v.lon_a); v.nlon_b=length(v.lon_b); v.nlat_b=length(v.lat_b); 
v.nlat_a=length(v.lat_a);
v.latweight_a=cos(pi/180*v.lat_a);
v.latweight_b=cos(pi/180*v.lat_b);
%v.xs0=1; v.xe0=v.nlon;
%v.ys0=1; v.ye0=v.nlat_b;
v.time=f_a{'time'}(:); v.nt=length(v.time);
v.genvar_a =f_a{var1}(istart_a:iend_a,:,:); 
v.genvar2_a =f2_a{var2}(istart_a:iend_a,:,:); 
v.genvar3_a =f3_a{var3}(istart_a:iend_a,:,:); 
v.genvar_b =f_b{var1}(istart_b:iend_b,:,:); 
v.genvar2_b =f2_b{var2}(istart_b:iend_b,:,:); 
v.genvar3_b =f3_b{var3}(istart_b:iend_b,:,:); 
v.landm = fland{'land_mask'}(:,:);
tend_a=iend_a-istart_a;
tend_b=iend_b-istart_b;
v.yr  =f_a{'yr'} (:);
v.mo  =f_a{'mo'} (:);
v.dy  =f_a{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
close(f_a);
close(f2_a);
close(f3_a);
close(f_b);
close(f2_b);
close(f3_b);
%-----------------------------------------------------%
% compute time means
%-----------------------------------------------------%
%scale=86400.
scale=1.
v.genvar_a_tmn=mean(v.genvar_a,1);
v.genvar2_a_tmn=mean(v.genvar2_a,1);
v.genvar3_a_tmn=mean(v.genvar3_a,1);
v.genvar_tot_a=v.genvar_a+v.genvar2_a+v.genvar3_a;
v.genvar_tot_a_tmn=mean(v.genvar_tot_a,1);
v.genvar_a_tmn=scale*v.genvar_a_tmn;
v.genvar2_a_tmn=scale*v.genvar2_a_tmn;
v.genvar3_a_tmn=scale*v.genvar3_a_tmn;
%-----------------------------------------------------%
v.genvar_b_tmn=mean(v.genvar_b,1);
v.genvar2_b_tmn=mean(v.genvar2_b,1);
v.genvar3_b_tmn=mean(v.genvar3_b,1);
v.genvar_tot_b=v.genvar_b+v.genvar2_b+v.genvar3_b;
v.genvar_tot_b_tmn=mean(v.genvar_tot_b,1);
v.genvar_b_tmn=scale*v.genvar_b_tmn;
v.genvar2_b_tmn=scale*v.genvar2_b_tmn;
v.genvar3_b_tmn=scale*v.genvar3_b_tmn;
%-----------------------------------------------------%
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight_b=v.latweight_b;
glblatweight_a=v.latweight_a;
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
%startan=1;
%endan=60;
%
wgt_var=zeros(tend_a,v.nlat_a,v.nlon_a);
for ti=1:tend_a;
  temp_var      = v.genvar_a(ti,:,:);
  temp_var2      = v.genvar2_a(ti,:,:);
  temp_var3      = v.genvar3_a(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  wgt_var3       = squeeze(temp_var3).*glblatweight_a;
  v.genvar_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.genvar_mn_ts2_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
  v.genvar_mn_ts3_a(ti) = sum(wgt_var3(:))/glbsumweight_a;
end
tmean=mean(v.genvar_mn_ts_a);
tmean2=mean(v.genvar_mn_ts2_a);
tmean3=mean(v.genvar_mn_ts3_a);
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.genvar_b(ti,:,:);
  temp_var2      = v.genvar2_b(ti,:,:);
  temp_var3      = v.genvar3_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  wgt_var3       = squeeze(temp_var3).*glblatweight_b;
  v.genvar_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.genvar_mn_ts2_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
  v.genvar_mn_ts3_b(ti) = sum(wgt_var3(:))/glbsumweight_b;
end
tmean_b=mean(v.genvar_mn_ts_b);
tmean2_b=mean(v.genvar_mn_ts2_b);
tmean3_b=mean(v.genvar_mn_ts3_b);
%% compute the anomaly
%v.genvar2_a=v.genvar2_a-mean(v.genvar_mn_ts2_a(startan:endan),2);
%v.genvar_a=v.genvar_a-mean(v.genvar_mn_ts_a(startan:endan),2);
%v.genvar2_b=v.genvar2_b-mean(v.genvar_mn_ts2_b(startan:endan),2);
%v.genvar_b=v.genvar_b-mean(v.genvar_mn_ts_b(startan:endan),2);
%%v.genvar=v.genvar-mean(v.genvar_mn_ts,2);
%%------------------------------------------------------------------------------------------
figure;
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_a, 'EdgeColor', 'none')
ppplot(1)=subplot(2,2,1);
%contourf(squeeze(v.genvar_a(5,:,:)),[-4,-3,-2,-1,0,1,2,3,4]);
contourf(squeeze(v.genvar_a_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
exper='low cld cov';
titlestring=strcat(exper,var1)
%title('forced experiment')
title(titlestring)
ppplot(2)=subplot(2,2,2);
contourf(squeeze(v.genvar2_a_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
title('mid cld cov')
ppplot(3)=subplot(2,2,3);
contourf(squeeze(v.genvar3_a_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
title('high cld cov')
ppplot(3)=subplot(2,2,4);
contourf(squeeze(v.genvar_tot_a_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
title('total cld cov')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_a, 'EdgeColor', 'none')
figure;
annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
nplot(1)=subplot(2,2,1);
contourf(squeeze(v.genvar_b_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
exper='low cld cov';
titlestring=strcat(exper,var1)
title(titlestring)
nplot(2)=subplot(2,2,2);
contourf(squeeze(v.genvar2_b_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
title('mid cld cov')
nplot(3)=subplot(2,2,3);
contourf(squeeze(v.genvar3_b_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
title('high cld cov')
nplot(3)=subplot(2,2,4);
contourf(squeeze(v.genvar_tot_b_tmn),[10,20,30,40,50,60,70,80,90]); colorbar;
caxis([10 90]);
title('total cld cov')
%%------------------------------------------------------------------------------------------
% compute a running mean
incoming_ts=v.genvar_mn_ts_a;
rough_ts=incoming_ts;
tendindex=tend_a;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
genvar_sm_ts_a=output_ts;
%%------------------------------------------------------------------------------------------
% compute a running mean
incoming_ts=v.genvar_mn_ts2_a;
rough_ts=incoming_ts;
tendindex=tend_a;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
genvar_sm_ts2_a=output_ts;
%-----------------------------------------------------------------------------------------
% compute a running mean
incoming_ts=v.genvar_mn_ts_b;
rough_ts=incoming_ts;
tendindex=tend_b;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
genvar_sm_ts_b=output_ts;
%-----------------------------------------------------------------------------------------
% compute a running mean
incoming_ts=v.genvar_mn_ts2_b;
rough_ts=incoming_ts;
tendindex=tend_b;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
genvar_sm_ts2_b=output_ts;
%%-----------------------------------------------------------------------------------------
%%
%%% evolution in time of genvar for experiment a
%figure; plot(timeindex_a(1:endt_a),genvar_sm_ts_a,timeindex_b(1:endt_a),genvar_sm_ts2_a)
%title('Time evolution of genvar for 1% CO2 exp a')
%legend('1% per year CO2','Control','boxoff','Location','northwest')
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_a, 'EdgeColor', 'none')
%%% evolution in time of genvar for experiment b
%figure; plot(timeindex_b(1:endt_b),genvar_sm_ts_b,timeindex_b(1:endt_b),genvar_sm_ts2_b)
%title('Time evolution of genvar for 1% CO2 exp b')
%legend('1% per year CO2','Control','boxoff','Location','northwest')
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
%%
%
%
%
% this is the end
%
