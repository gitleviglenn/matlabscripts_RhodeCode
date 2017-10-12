%------------------------------------------------------------------------------------------
% trends_write_ncout.m
%
% write output to a netcdf file 
%
% levi silvers                                        may 2017
%------------------------------------------------------------------------------------------

%%------------------------------------------------------------------------------------------
% create a new netcdf file
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

%nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = nmonths; 
%nc{'TIME'}= nmonths;
%nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'} (1:nmonths) = timearray(:); 
nc('lat') = nlat;          nc('lon')     = nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = vlat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = vlon; 


nc{'lcloud_trend'}            =ncfloat('lat','lon'); 
nc{'lcloud_trend'}(:,:)       =lcloud_trend(:,:);
nc{'lcloud_trend'}.long_name  ='trend of low level cloud field';

nc{'hcloud_trend'}            =ncfloat('lat','lon'); 
nc{'hcloud_trend'}(:,:)       =hcloud_trend(:,:);
nc{'hcloud_trend'}.long_name  ='trend of high level cloud field';

nc{'omega500_trend'}            =ncfloat('lat','lon'); 
nc{'omega500_trend'}(:,:)       =omega500_trend(:,:);
nc{'omega500_trend'}.long_name  ='trend of omega 500 field';

nc{'eis_trend'}            =ncfloat('lat','lon'); 
nc{'eis_trend'}(:,:)       =eis_trend(:,:);
nc{'eis_trend'}.long_name  ='trend of eis field';

nc{'lts_trend'}            =ncfloat('lat','lon'); 
nc{'lts_trend'}(:,:)       =lts_trend(:,:);
nc{'lts_trend'}.long_name  ='trend of lts field';

nc{'tsurf_trend'}            =ncfloat('lat','lon'); 
nc{'tsurf_trend'}(:,:)       =tsurf_trend(:,:);
nc{'tsurf_trend'}.long_name  ='trend of tsurf field';

nc{'temp700_trend'}            =ncfloat('lat','lon'); 
nc{'temp700_trend'}(:,:)       =temp700_trend(:,:);
nc{'temp700_trend'}.long_name  ='trend of temp700 field';

nc{'net_rflux_trend'}            =ncfloat('lat','lon'); 
nc{'net_rflux_trend'}(:,:)       =net_rflux_trend(:,:);
nc{'net_rflux_trend'}.long_name  ='trend of net radiative flux';

%nc{'net_clr_rflux_trend'}            =ncfloat('lat','lon'); 
%nc{'net_clr_rflux_trend'}(:,:)       =net_clr_rflux_trend(:,:);
%nc{'net_clr_rflux_trend'}.long_name  ='trend of net_clr_rflux field';

nc{'net_cre_trend'}            =ncfloat('lat','lon'); 
nc{'net_cre_trend'}(:,:)       =net_cre_trend(:,:);
nc{'net_cre_trend'}.long_name  ='trend of net_cre field';

nc{'sw_cre_trend'}            =ncfloat('lat','lon'); 
nc{'sw_cre_trend'}(:,:)       =sw_cre_trend(:,:);
nc{'sw_cre_trend'}.long_name  ='trend of sw cre field';

nc{'lw_cre_trend'}            =ncfloat('lat','lon'); 
nc{'lw_cre_trend'}(:,:)       =lw_cre_trend(:,:);
nc{'lw_cre_trend'}.long_name  ='trend of lw cre field';

nc{'sw_clr_trend'}            =ncfloat('lat','lon'); 
nc{'sw_clr_trend'}(:,:)       =sw_clr_trend(:,:);
nc{'sw_clr_trend'}.long_name  ='trend of sw clr field';

nc{'lw_clr_trend'}            =ncfloat('lat','lon'); 
nc{'lw_clr_trend'}(:,:)       =lw_clr_trend(:,:);
nc{'lw_clr_trend'}.long_name  ='trend of lw clr field';

%
%nc{'TIME'}.long_name     ='TIME';      
%nc{'TIME'}.standard_name ='TIME';
%nc{'TIME'}.calendar      ='gregorian';
%nc{'TIME'}.units         ='days since 1869-12-1 00:00:00';      
%nc{'TIME'}.delta_t       ='0000-00-01 00:00:00';      
%nc{'TIME'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

%nc{'toa_response'}.long_name     ='toa_net_rad_response';
%nc{'toa_cre_response'}.long_name ='total_cre_response';
%nc{'lw_clr_response'}.long_name ='lw_clr_response';
%nc{'sw_clr_response'}.long_name ='sw_clr_response';
%nc{'lw_cre_response'}.long_name ='lw_cre_response';
%nc{'sw_cre_response'}.long_name ='sw_cre_response';

close(nc); 

'finished nc file'
%%------------------------------------------------------------------------------------------
% this is the end
