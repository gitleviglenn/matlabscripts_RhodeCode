%------------------------------------------------------------------------------------------
% feedback_generalvar.m
%
% 1. read in variables from input files
% 2. make figures
%         - 3 panel figure of same var from two models and diff 
%
% levi silvers                                        june 2016
%------------------------------------------------------------------------------------------
% name of output file
fnout_genvar='general_varout_a.nc'
fnout_genvar_b='general_varout_b.nc'

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

%var1='t_surf.nc';
var1='low_cld_amt.nc';
variable='low_cld_amt';
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
v.genvar_a =f_a{variable}(istart_a:iend_a,:,:); 
v.genvar2_a =f2_a{variable}(istart2_a:iend2_a,:,:); 
v.genvar_b =f{variable}(istart_b:iend_b,:,:); 
v.genvar2_b =f2{variable}(istart2_b:iend2_b,:,:); 
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
% compute time means
pstart=720;
pend=960;
%-----------------------------------------------------%
%scale=86400.
scale=1.
v.genvar_a_tmn=mean(v.genvar_a,1);
boo_a=v.genvar_a(pstart:pend,:,:);
v.genvar_a_tmn_end=mean(boo_a,1);
v.genvar2_a_tmn=mean(v.genvar2_a,1);
boo2_a=v.genvar2_a(pstart:pend,:,:);
v.genvar2_a_tmn_end=mean(boo2_a,1);
v.genvar_a_tmn=scale*v.genvar_a_tmn;
v.genvar_a_tmn_end=scale*v.genvar_a_tmn_end;
v.genvar2_a_tmn=scale*v.genvar2_a_tmn;
v.genvar2_a_tmn_end=scale*v.genvar2_a_tmn_end;
v.genvar_a_diff=v.genvar_a_tmn-v.genvar2_a_tmn;
v.genvar_a_diff_end=v.genvar_a_tmn_end-v.genvar2_a_tmn_end;
%v.genvar_a_diff=scale*v.genvar_a_diff;
%-----------------------------------------------------%
v.genvar_b_tmn=mean(v.genvar_b,1);
v.genvar2_b_tmn=mean(v.genvar2_b,1);
v.genvar_b_tmn=scale*v.genvar_b_tmn;
v.genvar2_b_tmn=scale*v.genvar2_b_tmn;
v.genvar_b_diff=v.genvar_b_tmn-v.genvar2_b_tmn;
%
boo_b=v.genvar_b(pstart:pend,:,:);
v.genvar_b_tmn_end=mean(boo_b,1);
boo2_b=v.genvar2_b(pstart:pend,:,:);
v.genvar2_b_tmn_end=mean(boo2_b,1);
v.genvar_b_tmn_end=scale*v.genvar_b_tmn_end;
v.genvar2_b_tmn_end=scale*v.genvar2_b_tmn_end;
v.genvar_b_diff_end=v.genvar_b_tmn_end-v.genvar2_b_tmn_end;
%v.genvar_b_diff=scale*v.genvar_b_diff;
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
  wgt_var       = squeeze(temp_var).*glblatweight_a;
  wgt_var2       = squeeze(temp_var2).*glblatweight_a;
  v.genvar_mn_ts_a(ti) = sum(wgt_var(:))/glbsumweight_a;
  v.genvar_mn_ts2_a(ti) = sum(wgt_var2(:))/glbsumweight_a;
end
wgt_var=zeros(tend_b,v.nlat_b,v.nlon_b);
for ti=1:tend_b;
  temp_var      = v.genvar_b(ti,:,:);
  temp_var2      = v.genvar2_b(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight_b;
  wgt_var2       = squeeze(temp_var2).*glblatweight_b;
  v.genvar_mn_ts_b(ti) = sum(wgt_var(:))/glbsumweight_b;
  v.genvar_mn_ts2_b(ti) = sum(wgt_var2(:))/glbsumweight_b;
end
%-----------------------------------------------------------------------------------------
scalef=1.
normfac=1.9
figure;
ppplot(1)=subplot(3,1,1);
%contourf(squeeze(v.genvar_a(5,:,:)),[-4,-3,-2,-1,0,1,2,3,4]);
genvar_a_2d=scalef*squeeze(v.genvar_a_tmn_end);
contourf(genvar_a_2d); colorbar;
exper='forced experiment a: ';
titlestring=strcat(exper,variable)
%title('forced experiment')
title(titlestring)
ppplot(2)=subplot(3,1,2);
genvar2_a_2d=scalef*squeeze(v.genvar2_a_tmn_end);
contourf(genvar2_a_2d); colorbar;
title('control experiment a: ')
ppplot(3)=subplot(3,1,3);
%contourf(squeeze(v.genvar_a_diff),[-4,-3.5,-3.0,-2.5,-2.0,-1.5,-1.,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]); colorbar;
%contourf(squeeze(v.genvar_a_diff_end),[-4,-3.0,-2.0,-1.,0,1,2,3,4]); colorbar;
genvar_a_diff_2d=(genvar_a_2d-genvar2_a_2d)/normfac;
contourf(genvar_a_diff_2d,[-5,-4,-3.0,-2.0,-1.,0,1,2,3,4,5]); colorbar;
caxis([-5 5]);
%contourf(squeeze(v.genvar_a_diff_end),[0,1,2,3,4,5,6,7,8]); colorbar;
%caxis([0 8]);
%contourf(squeeze(v.genvar_a_diff_end),[-2,-1.5,-1.0,-0.5,0,0.5,1,1.5,2]); colorbar;
%caxis([-2 2]);
diff_title=strcat(variable,'Response');
title(diff_title)
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
%%------------------------------------------------------------------------------------------
normfac=1.3
figure;
ppplot(1)=subplot(3,1,1);
%contourf(squeeze(v.genvar_a(5,:,:)),[-4,-3,-2,-1,0,1,2,3,4]);
genvar_b_2d=scalef*squeeze(v.genvar_b_tmn_end);
contourf(genvar_b_2d); colorbar;
exper='forced experiment b: ';
titlestring=strcat(exper,variable)
%title('forced experiment')
title(titlestring)
ppplot(2)=subplot(3,1,2);
genvar2_b_2d=scalef*squeeze(v.genvar2_b_tmn_end);
contourf(genvar2_b_2d); colorbar;
title('control experiment b: ')
ppplot(3)=subplot(3,1,3);
%contourf(squeeze(v.genvar_b_diff),[-4,-3.5,-3.0,-2.5,-2.0,-1.5,-1.,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4]); colorbar;
%contourf(squeeze(v.genvar_b_diff_end),[-4,-3.0,-2.0,-1.,0,1,2,3,4]); colorbar;
genvar_b_diff_2d=(genvar_b_2d-genvar2_b_2d)/normfac;
contourf(genvar_b_diff_2d,[-5,-4,-3.0,-2.0,-1.,0,1,2,3,4,5]); colorbar;
caxis([-5 5]);
%contourf(squeeze(v.genvar_b_diff_end),[0,1,2,3,4,5,6,7,8]); colorbar;
%caxis([0 8]);
%contourf(squeeze(v.genvar_b_diff_end),[-2,-1.5,-1.0,-0.5,0,0.5,1,1.5,2]); colorbar;
exp1_a=strcat(basedir_a,exp1name_a);
%caxis([-2 2]);
diff_title=strcat(variable,'Response');
title(diff_title)
%%%------------------------------------------------------------------------------------------
%% compute a running mean
%incoming_ts=v.genvar_mn_ts_a;
%rough_ts=incoming_ts;
%tendindex=tend_a;
%for ti=7:tendindex-6
%  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
%end
%output_ts=ts_smooth;
%clear rough_ts; clear ts_smooth;
%genvar_sm_ts_a=output_ts;
%%%------------------------------------------------------------------------------------------
%% compute a running mean
%incoming_ts=v.genvar_mn_ts2_a;
%rough_ts=incoming_ts;
%tendindex=tend_a;
%for ti=7:tendindex-6
%  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
%end
%output_ts=ts_smooth;
%clear rough_ts; clear ts_smooth;
%genvar_sm_ts2_a=output_ts;
%%-----------------------------------------------------------------------------------------
%% compute a running mean
%incoming_ts=v.genvar_mn_ts_b;
%rough_ts=incoming_ts;
%tendindex=tend_b;
%for ti=7:tendindex-6
%  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
%end
%output_ts=ts_smooth;
%clear rough_ts; clear ts_smooth;
%genvar_sm_ts_b=output_ts;
%%-----------------------------------------------------------------------------------------
%% compute a running mean
%incoming_ts=v.genvar_mn_ts2_b;
%rough_ts=incoming_ts;
%tendindex=tend_b;
%for ti=7:tendindex-6
%  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
%end
%output_ts=ts_smooth;
%clear rough_ts; clear ts_smooth;
%genvar_sm_ts2_b=output_ts;
%%-----------------------------------------------------------------------------------------
%%
%%% evolution in time of genvar for experiment a
%figure; plot(timeindex_a(1:endt_a),genvar_sm_ts_a,timeindex_b(1:endt_a),genvar_sm_ts2_a)
%bosh='Time evolution of genvar for 1% CO2 exp a: ';
%newtitle=strcat(bosh,variable);
%title(newtitle)
%legend('1% per year CO2','Control','boxoff','Location','northwest')
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_a, 'EdgeColor', 'none')
%%% evolution in time of genvar for experiment b
%figure; plot(timeindex_b(1:endt_b),genvar_sm_ts_b,timeindex_b(1:endt_b),genvar_sm_ts2_b)
%boshface='Time evolution of genvar for 1% CO2 exp b: ';
%newtitle=strcat(boshface,variable);
%title(newtitle)
%legend('1% per year CO2','Control','boxoff','Location','northwest')
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname_b, 'EdgeColor', 'none')
%%
%%
%%
%%-----------------------------------------------------------------------------------------
% create a new netcdf file
nc = netcdf(fnout_genvar,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'general variable output from matlab';
nc.institution = 'GFDL' ;
nc.source      = 'levi silvers';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat_a;          nc('lon')     = v.nlon_a;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat_a; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon_a; 

toa_gnorm=genvar_a_diff_2d;
nc{'genvar_a'}=ncfloat('lat','lon'); 
nc{'genvar_a'}(:,:)=toa_gnorm(:,:);

nc{'TIME'}.long_name     ='TIME';      
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

%nc{'toa_diff_am4g6'}.long_name     ='toa_net_rad_ch';
%nc{'toa_cre_diff_am4g6'}.long_name ='total_cre_ch';
%nc{'lw_clr_diff_am4g6'}.long_name ='lw_clr_ch';
%nc{'sw_clr_diff_am4g6'}.long_name ='sw_clr_ch';
%nc{'lw_cre_diff_am4g6'}.long_name ='lw_cre_ch';
%nc{'sw_cre_diff_am4g6'}.long_name ='sw_cre_ch';

close(nc); 

'finished first nc file'

nc = netcdf(fnout_genvar_b,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'general variable output from matlab';
nc.institution = 'GFDL' ;
nc.source      = 'levi silvers';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat_b;          nc('lon')     = v.nlon_b;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat_b; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon_b; 

toa_gnorm=genvar_b_diff_2d;
nc{'genvar_b'}=ncfloat('lat','lon'); 
nc{'genvar_b'}(:,:)=toa_gnorm(:,:);

nc{'TIME'}.long_name     ='TIME';      
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

%nc{'toa_diff_am4g6'}.long_name     ='toa_net_rad_ch';
%nc{'toa_cre_diff_am4g6'}.long_name ='total_cre_ch';
%nc{'lw_clr_diff_am4g6'}.long_name ='lw_clr_ch';
%nc{'sw_clr_diff_am4g6'}.long_name ='sw_clr_ch';
%nc{'lw_cre_diff_am4g6'}.long_name ='lw_cre_ch';
%nc{'sw_cre_diff_am4g6'}.long_name ='sw_cre_ch';

close(nc); 

'finished first nc file'
%
% this is the end
%
