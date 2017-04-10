%----------------------------------------------------------------------------
% openncfile_cosp_av.m
%
% this script opens one or more  netcdf file and stores variables in a structure 'v'
%
% the assumption is that the incoming files will be averaged over time already
%
% the averaged files will likely still be separated by months and need to be combined
% and averaged into yearly mean values.  Then the time dimension will need to be 
% squeezed.
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
% levi silvers                                                      Feb 2016
%----------------------------------------------------------------------------

% define path related variables

% years
yearsav='.0002-0011.'

% base paths
% paths for am4g10r8
%realbase='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/'
%realbase='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/'
%stringincoming_oldmod='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/2yr/atmos.000201-000312.reff_modis.nc'
%stringincoming_oldmod2='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos/ts/monthly/2yr/atmos.000201-000312.reff_modis2.nc'

% paths for cosp runs in Ming's directories are:
% /archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp
%realbase='/archive/Ming.Zhao/awg/verona/c96L32_am4G12r16_2010climo_new_cosp/gfdl.ncrc3-intel-prod-openmp/pp/'
%realbase='/archive/Levi.Silvers/data/c96L32_am4G12r16_2010climo_new_cosp/'
%realbase='/archive/Ming.Zhao/awg/verona/c96L32_am4G12r17_2010climo_A_cosp/gfdl.ncrc3-intel-prod-openmp/pp/'
realbase='/archive/Levi.Silvers/data/c96L32_am4G12r17_2010climo_A_cosp/'
%realbase='/archive/Ming.Zhao/awg/verona/c96L32_am4G12r18_2010climo_A_cosp/gfdl.ncrc3-intel-prod-openmp/pp/'
%realbase='/archive/Levi.Silvers/data/c96L32_am4G12r18_2010climo_A_cosp/'

% concatinate and create necessary path strings
basedir=strcat(realbase,'atmos/');
basedirmod=strcat(realbase,'atmos_month_modis/');
basedirmis=strcat(realbase,'atmos_month_misr/');
basedircal=strcat(realbase,'atmos_month_cospx/');
basedirisccp=strcat(realbase,'atmos_month_cospx/');


%basepat=strcat(basedir,'atmos_month_modis',yearsav,'alltmn.nc');
basepat=strcat(basedir,'atmos',yearsav,'alltmn.nc');
stringincoming_atm=basepat

%basepatmod=strcat(basedirmod,'atmos',yearsav,'alltmn.nc');
basepatmod=strcat(basedirmod,'atmos_month_modis',yearsav,'alltmn.nc');
stringincoming_mod=basepatmod
%
basepatmis=strcat(basedirmis,'atmos_month_misr',yearsav,'alltmn.nc');
stringincoming_mis=basepatmis
%
basepatcal=strcat(basedircal,'atmos_month_cospx',yearsav,'alltmn.nc');
stringincoming_cal=basepatcal
%
basepatisccp=strcat(basedirisccp,'atmos_month_cospx',yearsav,'alltmn.nc');
stringincoming_isccp=basepatisccp
%

% read input file
fin_atm =netcdf(stringincoming_atm,'nowrite');
% for MODIS
fin_mod =netcdf(stringincoming_mod,'nowrite');
% for CALIPSO
fin_calip =netcdf(stringincoming_cal,'nowrite');
% for MISR
fin_misr =netcdf(stringincoming_mis,'nowrite');
% for ISCCP
fin_isccp =netcdf(stringincoming_isccp,'nowrite');

%fin_atm =netcdf(stringincoming_atm,'nowrite');
%fin_lcl =netcdf(stringincoming_lcl,'nowrite');
%fin_modLWP =netcdf(stringincoming_mLWP,'nowrite');
%fin_icl =netcdf(stringincoming_icl,'nowrite');
%fin_ire =netcdf(stringincoming_ire,'nowrite');
%fin_lre =netcdf(stringincoming_lre,'nowrite');
%fin_lwp =netcdf(stringincoming_lwp,'nowrite');
%fin_iwp =netcdf(stringincoming_iwp,'nowrite');
%fin_tcl =netcdf(stringincoming_tcl,'nowrite');
%fin_ttau =netcdf(stringincoming_ttau,'nowrite');

%fin_reffmod =netcdf(stringincoming_atm,'nowrite');
%fin_reffmod2 =netcdf(stringincoming_atm,'nowrite');


% set up a structure(v) to hold info related to variables
%-------------------------------------------------
vin.lon=fin_atm{'lon'}(:); vin.lat =fin_atm{'lat'}(:);
vlon=vin.lon;
vlat=vin.lat;
vin.nlon=length(vin.lon); vin.nlat=length(vin.lat); vin.ngrid=vin.nlat*vin.nlon;
vlon=vin.lon;
vlat=vin.lat;
vin.latweight=cos(pi/180*vin.lat);
vin.xs0=1; vin.xe0=vin.nlon;
vin.ys0=1; vin.ye0=vin.nlat;
vin.time=fin_atm{'time'}(:); vin.nt=length(vin.time);
vin.sst =fin_atm{'t_surf'}(:,:,:); 
vin.yr  =fin_atm{'yr'} (:);
vin.mo  =fin_atm{'mo'} (:);
vin.dy  =fin_atm{'dy'} (:);
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

% from MODIS input
% do we still have to squeeze?
vin.lclmodis=fin_mod{'lclmodis'}(:,:,:); % time,lat,lon
vin.iclmodis=fin_mod{'iclmodis'}(:,:,:); % time,lat,lon
vin.lremodis=fin_mod{'lremodis'}(:,:,:); % time,lat,lon
vin.iremodis=fin_mod{'iremodis'}(:,:,:); % time,lat,lon
vin.lwpmodis=fin_mod{'lwpmodis'}(:,:,:); % time,lat,lon
vin.iwpmodis=fin_mod{'iwpmodis'}(:,:,:); % time,lat,lon
vin.tclmodis=fin_mod{'tclmodis'}(:,:,:);
vin.hicldmodis=fin_mod{'hicldmodis'}(:,:,:);
vin.mdcldmodis=fin_mod{'mdcldmodis'}(:,:,:);
vin.locldmodis=fin_mod{'locldmodis'}(:,:,:);

% rather than using NaN's the modis output uses -1.0e+30 for missing data.  
% replace this with NaN's
vin.lremodis(vin.lremodis<-1.0e+15)=NaN;

% from CALIPSO
vin.cllcalipso=fin_calip{'clhcalipso'}(:,:,:);
vin.clmcalipso=fin_calip{'clhcalipso'}(:,:,:);
vin.clhcalipso=fin_calip{'clhcalipso'}(:,:,:);

% from ISCCP
vin.tauisccp=fin_isccp{'tauisccp'}(:,:,:);

% from atmos component
vin.reffmodis=fin_atm{'reff_modis'}(:,:,:);
vin.reffmodis2=fin_atm{'reff_modis2'}(:,:,:);
vin.lwp=fin_atm{'LWP'}(:,:,:);
lre_yim=vin.reffmodis./vin.reffmodis2;
%%---------------------------------------------------------------------------------
%%%% attempt at figures 
%
%% reff_modis
%% should the time average be before or after the division?
%% initially I thought after, but the figures look better 
%% when averaged before.  
%%
%reff_oldmodis=vin.reffmodis_full./vin.reffmodis2_full;
%reff_oldmodis_mn=mean(reff_oldmodis,1);
%%figure
%%contourf(squeeze(reff_oldmodis_mn))
%%colorbar
%%title('what is reff_oldmodis')
%
%%conts_reff=[2 4 6 8 10 12 14 16 18 20 22];
%%conts_reff=[7 8 9 10 11 12 13 14 15 16 17];
%conts_reff=[9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14];
%caxis_reff=[8 15];
%reff_oldmodis_tmn=mean(reff_oldmodis,1);
%%cont_map_modis(reff_oldmodis_tmn,vlat,vlon,conts_reff,caxis_reff)
%%colorbar
%%title('modis reff 5yr mn am4g11r11 2010climo microns')
%
%normlremn=vin.lremodis./vin.lclmodis;
lre_norm_lcl=vin.lremodis./vin.lclmodis;
normlremn=vin.lremodis./vin.tclmodis;
lre_norm_tcl=vin.lremodis./vin.tclmodis;
%normlre=vin.lremodis_full./vin.tclmodis_full;
%normlrebylcl=vin.lremodis_full./vin.lclmodis_full;
%normlremn=mean(normlre,1);
%normlrebylclmn=mean(normlrebylcl,1);
%nonormlremn=mean(vin.lremodis_full,1);
%lre2=normlre.*vin.lclmodis_full;
%lre2mn=mean(lre2,1);
%lclmn=mean(vin.lclmodis_full,1);
%normlre2mn=lre2mn./lclmn;
%%figure
%%normlremn_meter=10e6*normlremn;
%%contourf(squeeze(normlremn_meter))
%%contourf(squeeze(normlre))
%%colorbar
%%title('norm by tcl lre modis')
%%figure
%%normlre2mn_meter=10e6*normlre2mn;
%%contourf(squeeze(normlre2mn_meter))
%%contourf(squeeze(normlre2))
%%colorbar
%%title('norm by lcl lre modis')
%%%?wlre=vin.lremodis.*glblatweight;
%%wlre=vin.lremodis;
%%wlcl=vin.lclmodis.*glblatweight;
%%normlre_weight=wlre./nansum(wlcl(:));
%%normlre=vin.lremodis./nansum(vin.lclmodis(:));
%%%6
%%figure
normiremn=vin.iremodis./vin.iclmodis;
%normire=vin.iremodis./vin.tclmodis;
%%normire=vin.iremodis./nansum(vin.iclmodis(:));
%%contourf(normire)
%%colorbar
%%title('norm ire modis')
%%%7
%%figure
%%contourf(vin.lwpmodis)
%%colorbar
%%title('lwp modis')
%%%8
%%figure
%%contourf(vin.iwpmodis)
%%colorbar
%%title('iwp modis')
%%%9
%%figure
%lwp_norm_lcl=vin.lwpmodis./vin.lclmodis;
lwp_norm_tcl=vin.lwpmodis./vin.tclmodis;
%%contourf(normlwp)
%%colorbar
%%title('norm lwp modis')
%%figure
%normiwp=vin.iwpmodis./vin.iclmodis;
%%contourf(normiwp)
%%colorbar
%%title('norm iwp modis')
%
%%-------------------------------------------------
%close(fin_atm);


