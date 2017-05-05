%------------------------------------------------------------------------------------------
% amip_eiscltrends_ncout.m
%
% write output to a netcdf file for use in ncl
% this netcdf file doesn't have to work as input for gfdl model
%
% levi silvers                                        Jan 2017
%------------------------------------------------------------------------------------------

% name the output nc files
%fnout_cm4_diff='AM4OM2F_c96l32_am4g5r11_2000climo_1pct_response.nc'
%file_out='testout.nc'
%fnout_cm2_1_diff='CM2.1U-D4_1PctTo2X_response.nc'

%%%------------------------------------------------------------------------------------------
%% Figures
%%------------------------------------------------------------------------------------------
% create a new netcdf file
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

%%
nc{'lcloud_trend'}=ncfloat('lat','lon'); 
nc{'lcloud_trend'}(:,:)=lcloud_trend(:,:);
nc{'hcloud_trend'}=ncfloat('lat','lon'); 
nc{'hcloud_trend'}(:,:)=hcloud_trend(:,:);
nc{'omega_trend'}=ncfloat('lat','lon'); 
nc{'omega_trend'}(:,:)=omega500_trend(:,:);
nc{'eis_trend'}=ncfloat('lat','lon'); 
nc{'eis_trend'}(:,:)=eis_trend(:,:);
nc{'lts_trend'}=ncfloat('lat','lon'); 
nc{'lts_trend'}(:,:)=lts_trend(:,:);
nc{'tsfc_trend'}=ncfloat('lat','lon'); 
nc{'tsfc_trend'}(:,:)=tsurf_trend(:,:);
nc{'lwp_trend'}=ncfloat('lat','lon'); 
nc{'lwp_trend'}(:,:)=lwp_trend(:,:);
nc{'temp700_trend'}=ncfloat('lat','lon'); 
nc{'temp700_trend'}(:,:)=temp700_trend(:,:);

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

nc{'lcloud_trend'}.long_name     ='lcloud long amip trend ';
nc{'hcloud_trend'}.long_name ='hcloud long amip trend';
nc{'omega_trend'}.long_name ='omega long amip trend';
nc{'eis_trend'}.long_name ='eis long amip trend';
nc{'lts_trend'}.long_name ='lts long amip trend';
nc{'lwp_trend'}.long_name ='lwp_trend';
nc{'temp700_trend'}.long_name ='temp on 700 hPa trend';
nc{'tsfc_trend'}.long_name ='tsfc or tref trend';

close(nc); 

'finished nc file'
%%------------------------------------------------------------------------------------------
% this is the end
