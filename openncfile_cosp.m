%frchive/Levi.Silvers/awg/verona/c96L32_am4g10r8_had_p_1pctco2_climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/annual_5yr/atmos.0007-0011.ann.nc'unction openncfile(stringincoming)
%----------------------------------------------------------------------------
% openncfile.m
%
% this script opens a netcdf file and stores variables in a structure 'v'
%
% concerning modis
% there are several questions to be resolved with modis
%
% 1. what are reff_modis and reff_modis2?  they are old and may not have any 
% clear relation to cosp.
%
% 2. what is the best/appropriate way to normalize?  on the quicklook webpage
% they show [clwmodis*reffclwmodis]/[clwmodis] where [] denote time averages.
% the output from cosp in AM4 for the variable lremodis has already been 
% internally multiplied by CPCT, which is the cloud fraction percent.  so 
% presumably the variable lremodis should be divided by [tclmodis].  
%
% 3.  how well should [lremodis]/[tclmodis] match with the 
%     [clwmodis*reffclwmodis]/[clwmodis] from the Quicklook page?
%
% 4.  The magnitude of [lremodis]/[tclmodis] needs to be checked.  
%
% levi silvers                                        Apr 2016
%----------------------------------------------------------------------------
%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%fin='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/atmos.000101-014012.t_surf.nc'

% paths for am4g10r8
years='.000201-000312.'
yearsav='.0002-0003.'
basedir='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/av/monthly_2yr/'
basedir_ts='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/'

%% paths for am4g11r11
%years='.000701-001112.'
%yearsav='.0007-0011.'
%basedir='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_cosp/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/av/monthly_5yr/'
%basedir_ts='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_cosp/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/5yr/'

basepalltmn=strcat(basedir,'atmos_month_modis',yearsav,'alltmn.nc');
stringincoming=basepalltmn
%stringincoming='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/av/monthly_2yr/atmos_month_modis.0002-0003.alltmn.nc'
basepatm=strcat(basedir,'atmos',yearsav,'alltmn.nc');
stringincoming_atm=basepatm
%stringincoming_atm='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_2yr/atmos.0002-0003.alltmn.nc'
% time series data
baseplclmodis=strcat(basedir_ts,'atmos_month_modis',years,'lclmodis.nc');
stringincoming_lcl=baseplclmodis
%stringincoming_lcl='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/atmos_month_modis.000201-000312.lclmodis.nc'
basepiclmodis=strcat(basedir_ts,'atmos_month_modis',years,'iclmodis.nc');
stringincoming_icl=basepiclmodis
%stringincoming_icl='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/atmos_month_modis.000201-000312.iclmodis.nc'
basepiremodis=strcat(basedir_ts,'atmos_month_modis',years,'iremodis.nc');
stringincoming_ire=basepiremodis
%stringincoming_ire='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/atmos_month_modis.000201-000312.iremodis.nc'
baseplremodis=strcat(basedir_ts,'atmos_month_modis',years,'lremodis.nc');
stringincoming_lre=baseplremodis
%
baseplwpmodis=strcat(basedir_ts,'atmos_month_modis',years,'lwpmodis.nc');
stringincoming_lwp=baseplwpmodis
%stringincoming_lwp='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/atmos_month_modis.000201-000312.lwpmodis.nc'
basepiwpmodis=strcat(basedir_ts,'atmos_month_modis',years,'iwpmodis.nc');
stringincoming_iwp=basepiwpmodis
%stringincoming_iwp='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/atmos_month_modis.000201-000312.iwpmodis.nc'
baseptclmodis=strcat(basedir_ts,'atmos_month_modis',years,'tclmodis.nc');
stringincoming_tcl=baseptclmodis
%stringincoming_tcl='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/ts/monthly/2yr/atmos_month_modis.000201-000312.tclmodis.nc'
% try modis from am4g11r11
%stringincoming_oldmod='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_cosp/gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/5yr/atmos.000701-001112.reff_modis.nc'
%stringincoming_oldmod2='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_cosp/gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/5yr/atmos.000701-001112.reff_modis2.nc'
% try modis from am4g10r8
stringincoming_oldmod='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/2yr/atmos.000201-000312.reff_modis.nc'
stringincoming_oldmod2='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/2yr/atmos.000201-000312.reff_modis2.nc'

% the directory for the cosp run that Ming did is:
% /archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp

% output file
%fnout='testfile.nc'

% read input file
fin =netcdf(stringincoming,'nowrite');
fin_atm =netcdf(stringincoming_atm,'nowrite');
fin_lcl =netcdf(stringincoming_lcl,'nowrite');
fin_icl =netcdf(stringincoming_icl,'nowrite');
fin_ire =netcdf(stringincoming_ire,'nowrite');
fin_lre =netcdf(stringincoming_lre,'nowrite');
fin_lwp =netcdf(stringincoming_lwp,'nowrite');
fin_iwp =netcdf(stringincoming_iwp,'nowrite');
fin_tcl =netcdf(stringincoming_tcl,'nowrite');
fin_reffmod =netcdf(stringincoming_oldmod,'nowrite');
fin_reffmod2 =netcdf(stringincoming_oldmod2,'nowrite');
%ncid=netcdf.open(fin,'NC_NOWRITE');
%[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
% set up a structure(v) to hold info related to variables
%-------------------------------------------------
vin.lon=fin{'lon'}(:); vin.lat =fin{'lat'}(:);
vlon=vin.lon;
vlat=vin.lat;
vin.nlon=length(vin.lon); vin.nlat=length(vin.lat); vin.ngrid=vin.nlat*vin.nlon;
vlon=vin.lon;
vlat=vin.lat;
vin.latweight=cos(pi/180*vin.lat);
vin.xs0=1; vin.xe0=vin.nlon;
vin.ys0=1; vin.ye0=vin.nlat;
vin.time=fin{'time'}(:); vin.nt=length(vin.time);
vin.sst =fin{'t_surf'}(:,:,:); 
%tstart=600;
%tend=1299;
%tint=tend-tstart+1;
%vin.sst_full =f{'SST'} (tstart:tend,:,:); 
vin.yr  =fin{'yr'} (:);
vin.mo  =fin{'mo'} (:);
vin.dy  =fin{'dy'} (:);
vin.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
vin.nt=12;
% 
% read in variables for the MODIS satelite simulator
% lclmodis, iclmodis
% lremodis, iremodis
% lwpmodis, iwpmodis

% compute global lat weighted values
nlongit=length(vlon);
glblatweight=cos(pi/180*vin.lat);
for index=1:nlongit-1;
  glblatweight=horzcat(glblatweight,vin.latweight);
end
%glbsumweight=sum(glblatweight(:));
glbsumweight=nansum(glblatweight(:));

%vin.lclmodis=fin{'lclmodis'}(:,:,:); % time,lat,lon
%vin.iclmodis=fin{'iclmodis'}(:,:,:); % time,lat,lon
%vin.lremodis=fin{'lremodis'}(:,:,:); % time,lat,lon
%vin.iremodis=fin{'iremodis'}(:,:,:); % time,lat,lon
%vin.lwpmodis=fin{'lwpmodis'}(:,:,:); % time,lat,lon
%vin.iwpmodis=fin{'iwpmodis'}(:,:,:); % time,lat,lon
%vin.tclmodis=fin{'tclmodis'}(:,:,:);
%vin.reffmodis=fin_atm{'reff_modis'}(:,:,:);
%vin.reffmodis2=fin_atm{'reff_modis2'}(:,:,:);

%% time series
vin.tclmodis_full=fin_tcl{'tclmodis'}(:,:,:);
vin.lclmodis_full=fin_lcl{'lclmodis'}(:,:,:); % time,lat,lon
vin.iclmodis_full=fin_icl{'iclmodis'}(:,:,:); % time,lat,lon
vin.lremodis_full=fin_lre{'lremodis'}(:,:,:); % time,lat,lon
vin.iremodis_full=fin_ire{'iremodis'}(:,:,:); % time,lat,lon
vin.lwpmodis_full=fin_lwp{'lwpmodis'}(:,:,:); % time,lat,lon
vin.iwpmodis_full=fin_iwp{'iwpmodis'}(:,:,:); % time,lat,lon
vin.reffmodis_full=fin_reffmod{'reff_modis'}(:,:,:); % time,lat,lon
vin.reffmodis2_full=fin_reffmod2{'reff_modis2'}(:,:,:); % time,lat,lon
% if time series are read in than averaging needs to be considered
vin.tclmodis=nanmean(vin.tclmodis_full,1);
vin.lclmodis=nanmean(vin.lclmodis_full,1);
vin.iclmodis=nanmean(vin.iclmodis_full,1);
vin.lremodis=nanmean(vin.lremodis_full,1);
vin.iremodis=nanmean(vin.iremodis_full,1);
vin.lwpmodis=nanmean(vin.lwpmodis_full,1);
vin.iwpmodis=nanmean(vin.iwpmodis_full,1);
reffmodis_mn=mean(vin.reffmodis_full,1);
reffmodis2_mn=mean(vin.reffmodis2_full,1);
vin.tclmodis=squeeze(vin.tclmodis);
vin.lclmodis=squeeze(vin.lclmodis);
vin.iclmodis=squeeze(vin.iclmodis);
vin.lremodis=squeeze(vin.lremodis);
vin.iremodis=squeeze(vin.iremodis);
vin.lwpmodis=squeeze(vin.lwpmodis);
vin.iwpmodis=squeeze(vin.iwpmodis);
reffmodis_mn=squeeze(reffmodis_mn);
reffmodis2_mn=squeeze(reffmodis2_mn);

% cloud fraction variables
vin.hicldmodis=fin{'hicldmodis'};
vin.mdcldmodis=fin{'mdcldmodis'};
vin.locldmodis=fin{'locldmodis'};

% rather than using NaN's the modis output uses -1.0e+30 for missing data.  
% replace this with NaN's
vin.lremodis(vin.lremodis<-1.0e+15)=NaN;

% i don't know what the line below was supposed to do...
%norm_lhe=vin.lremodis.*vin.lclmodis;

%%% attempt at figures 
%figure
%contourf(vin.tclmodis)
%colorbar
%title('total cloud fraction modis')

% reff_modis
% should the time average be before or after the division?
% initially I thought after, but the figures look better 
% when averaged before.  
%
reff_oldmodis=vin.reffmodis_full./vin.reffmodis2_full;
reff_oldmodis_mn=mean(reff_oldmodis,1);
%figure
%contourf(squeeze(reff_oldmodis_mn))
%colorbar
%title('what is reff_oldmodis')

%conts_reff=[2 4 6 8 10 12 14 16 18 20 22];
%conts_reff=[7 8 9 10 11 12 13 14 15 16 17];
conts_reff=[9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14];
caxis_reff=[8 15];
reff_oldmodis_tmn=mean(reff_oldmodis,1);
%cont_map_modis(reff_oldmodis_tmn,vlat,vlon,conts_reff,caxis_reff)
%colorbar
%title('modis reff 5yr mn am4g11r11 2010climo microns')

%%1
%figure
%contourf(vin.lclmodis)
%colorbar
%title('lcl modis')
%%2
%figure
%contourf(vin.iclmodis)
%colorbar
%title('icl modis')
%%3
%figure
%contourf(vin.lremodis)
%colorbar
%title('lre modis')
%%4
%figure
%contourf(vin.iremodis)
%colorbar
%title('ire modis')
%%5
%normlre=vin.lremodis./vin.lclmodis;
normlre=vin.lremodis_full./vin.tclmodis_full;
normlrebylcl=vin.lremodis_full./vin.lclmodis_full;
normlremn=mean(normlre,1);
normlrebylclmn=mean(normlrebylcl,1);
nonormlremn=mean(vin.lremodis_full,1);
lre2=normlre.*vin.lclmodis_full;
lre2mn=mean(lre2,1);
lclmn=mean(vin.lclmodis_full,1);
normlre2mn=lre2mn./lclmn;
%figure
%normlremn_meter=10e6*normlremn;
%contourf(squeeze(normlremn_meter))
%contourf(squeeze(normlre))
%colorbar
%title('norm by tcl lre modis')
%figure
%normlre2mn_meter=10e6*normlre2mn;
%contourf(squeeze(normlre2mn_meter))
%contourf(squeeze(normlre2))
%colorbar
%title('norm by lcl lre modis')
%%?wlre=vin.lremodis.*glblatweight;
%wlre=vin.lremodis;
%wlcl=vin.lclmodis.*glblatweight;
%normlre_weight=wlre./nansum(wlcl(:));
%normlre=vin.lremodis./nansum(vin.lclmodis(:));
%%6
%figure
%normire=vin.iremodis./vin.iclmodis;
normire=vin.iremodis./vin.tclmodis;
%normire=vin.iremodis./nansum(vin.iclmodis(:));
%contourf(normire)
%colorbar
%title('norm ire modis')
%%7
%figure
%contourf(vin.lwpmodis)
%colorbar
%title('lwp modis')
%%8
%figure
%contourf(vin.iwpmodis)
%colorbar
%title('iwp modis')
%%9
%figure
normlwp=vin.lwpmodis./vin.lclmodis;
%contourf(normlwp)
%colorbar
%title('norm lwp modis')
%%10
%figure
normiwp=vin.iwpmodis./vin.iclmodis;
%contourf(normiwp)
%colorbar
%title('norm iwp modis')

%-------------------------------------------------
%close(fin);


