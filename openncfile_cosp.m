%frchive/Levi.Silvers/awg/verona/c96L32_am4g10r8_had_p_1pctco2_climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/annual_5yr/atmos.0007-0011.ann.nc'unction openncfile(stringincoming)
%----------------------------------------------------------------------------
% openncfile.m
%
% this script opens a netcdf file and stores variables in a structure 'v'
%
% input: fin
%
% levi silvers                                        Apr 2016
%----------------------------------------------------------------------------
%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
%fin='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/atmos.000101-014012.t_surf.nc'

%sringincoming='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_modis/av/monthly_2yr/atmos_month_modis.0002-0003.alltmn.nc'

% output file
%fnout='testfile.nc'

% read input file
fin =netcdf(stringincoming,'nowrite');
%ncid=netcdf.open(fin,'NC_NOWRITE');
%[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
% set up a structure(v) to hold info related to variables
%-------------------------------------------------
vin.lon=fin{'lon'}(:); vin.lat =fin{'lat'}(:);
vin.nlon=length(vin.lon); vin.nlat=length(vin.lat); vin.ngrid=vin.nlat*vin.nlon;
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

vin.lclmodis=fin{'lclmodis'}(:,:,:); % time,lat,lon
vin.iclmodis=fin{'iclmodis'}(:,:,:); % time,lat,lon
vin.lremodis=fin{'lremodis'}(:,:,:); % time,lat,lon
vin.iremodis=fin{'iremodis'}(:,:,:); % time,lat,lon
vin.lwpmodis=fin{'lwpmodis'}(:,:,:); % time,lat,lon
vin.iwpmodis=fin{'iwpmodis'}(:,:,:); % time,lat,lon

% cloud fraction variables
vin.tclmodis=fin{'tclmodis'};
vin.hicldmodis=fin{'hicldmodis'};
vin.mdcldmodis=fin{'mdcldmodis'};
vin.locldmodis=fin{'locldmodis'};

% rather than using NaN's the modis output uses -1.0e+30 for missing data.  
% replace this with NaN's
vin.lremodis(vin.lremodis<-1.0e+15)=NaN;
norm_lre=vin.lremodis.*vin.lclmodis;

%% attempt at figures 
figure
contourf(vin.tclmodis)
colorbar
title('total cloud fraction modis')

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
%figure
%normlre=vin.lremodis./vin.lclmodis;
%contourf(normlre)
%colorbar
%title('norm lre modis')
%%6
%figure
%normire=vin.iremodis./vin.iclmodis;
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
%normlwp=vin.lwpmodis./vin.lclmodis;
%contourf(normlwp)
%colorbar
%title('norm lwp modis')
%%10
%figure
%normiwp=vin.iwpmodis./vin.iclmodis;
%contourf(normiwp)
%colorbar
%title('norm iwp modis')

%-------------------------------------------------
%close(fin);


