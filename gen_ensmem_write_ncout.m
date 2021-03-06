%------------------------------------------------------------------------------------------
% ensmn_ncout.m
%
% write output to a netcdf file 
%
% levi silvers                                        may 2017
%------------------------------------------------------------------------------------------

%%------------------------------------------------------------------------------------------
starti=1;
endi=104;
firstyr=1886;
timearr=firstyr:firstyr+104;

% create a new netcdf file
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = nyearsalpha; 
%nc{'TIME'}= nmonths;
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'} (1:nyearsalpha) = timearr(:); 
nc('lat') = nlat;          nc('lon')     = nlon;
nc('ensnum') = 5;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = vlat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = vlon; 

nc{'alpha_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_ensmbr_am2'}(:,:)       =alpha_array(:,:);
nc{'alpha_ensmbr_am2'}.long_name  ='alpha ensembles';

nc{'alpha_ensmn_am2'}            =ncfloat('TIME'); 
nc{'alpha_ensmn_am2'}(:)         =mean_alpha(:);
nc{'alpha_ensmn_am2'}.long_name  ='alpha ensemble mn';

nc{'alpha_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_ensmbr_am3'}(:,:)       =alpha_array_am3(:,:);
nc{'alpha_ensmbr_am3'}.long_name  ='alpha ensembles';

nc{'alpha_ensmn_am3'}            =ncfloat('TIME'); 
nc{'alpha_ensmn_am3'}(:)         =mean_alpha_am3(:);
nc{'alpha_ensmn_am3'}.long_name  ='alpha ensemble mn';

nc{'alpha_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_ensmbr_am4'}(:,:)       =alpha_array_am4(:,:);
nc{'alpha_ensmbr_am4'}.long_name  ='alpha ensembles';

nc{'alpha_ensmn_am4'}            =ncfloat('TIME'); 
nc{'alpha_ensmn_am4'}(:)         =mean_alpha_am4(:);
nc{'alpha_ensmn_am4'}.long_name  ='alpha ensemble mn';

nc{'alpha_cre_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_cre_ensmbr_am2'}(:,:)       =alpha_cre_array(:,:);
nc{'alpha_cre_ensmbr_am2'}.long_name  ='alpha ensembles';

nc{'alpha_clr_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_clr_ensmbr_am2'}(:,:)       =alpha_clr_array(:,:);
nc{'alpha_clr_ensmbr_am2'}.long_name  ='alpha clr ensembles';

nc{'alpha_cre_ensmn_am2'}              =ncfloat('TIME'); 
nc{'alpha_cre_ensmn_am2'}(:)           =mean_alpha_cre(:);
nc{'alpha_cre_ensmn_am2'}.long_name    ='alpha ensemble mn';

nc{'alpha_clr_ensmn_am2'}              =ncfloat('TIME'); 
nc{'alpha_clr_ensmn_am2'}(:)           =mean_alpha_clr(:);
nc{'alpha_clr_ensmn_am2'}.long_name    ='alpha ensemble mn';

nc{'alpha_lwcre_ensmbr_am2'}           =ncfloat('TIME','ensnum'); 
nc{'alpha_lwcre_ensmbr_am2'}(:,:)      =alpha_lwcre_array(:,:);
nc{'alpha_lwcre_ensmbr_am2'}.long_name ='alpha lwcre ensembles';

nc{'alpha_lwcre_ensmn_am2'}            =ncfloat('TIME'); 
nc{'alpha_lwcre_ensmn_am2'}(:)         =mean_alpha_lwcre(:);
nc{'alpha_lwcre_ensmn_am2'}.long_name  ='alpha lwcre ensemble mn';

nc{'alpha_swcre_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_swcre_ensmbr_am2'}(:,:)       =alpha_swcre_array(:,:);
nc{'alpha_swcre_ensmbr_am2'}.long_name  ='alpha swcre ensembles';

nc{'alpha_swcre_ensmn_am2'}            =ncfloat('TIME'); 
nc{'alpha_swcre_ensmn_am2'}(:)         =mean_alpha_swcre(:);
nc{'alpha_swcre_ensmn_am2'}.long_name  ='alpha swcre ensemble mn';

nc{'alpha_cre_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_cre_ensmbr_am3'}(:,:)       =alpha_cre_array_am3(:,:);
nc{'alpha_cre_ensmbr_am3'}.long_name  ='alpha cre ensembles';

nc{'alpha_clr_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_clr_ensmbr_am3'}(:,:)       =alpha_clr_array_am3(:,:);
nc{'alpha_clr_ensmbr_am3'}.long_name  ='alpha ensembles';

nc{'alpha_clr_ensmn_am3'}            =ncfloat('TIME'); 
nc{'alpha_clr_ensmn_am3'}(:)         =mean_alpha_clr_am3(:);
nc{'alpha_clr_ensmn_am3'}.long_name  ='alpha clr ensemble mn';

nc{'alpha_cre_ensmn_am3'}            =ncfloat('TIME'); 
nc{'alpha_cre_ensmn_am3'}(:)         =mean_alpha_cre_am3(:);
nc{'alpha_cre_ensmn_am3'}.long_name  ='alpha ensemble mn';

nc{'alpha_lwcre_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_lwcre_ensmbr_am3'}(:,:)       =alpha_lwcre_array_am3(:,:);
nc{'alpha_lwcre_ensmbr_am3'}.long_name  ='alpha lwcre ensembles';

nc{'alpha_lwcre_ensmn_am3'}            =ncfloat('TIME'); 
nc{'alpha_lwcre_ensmn_am3'}(:)         =mean_alpha_lwcre_am3(:);
nc{'alpha_lwcre_ensmn_am3'}.long_name  ='alpha lwcre ensemble mn';

nc{'alpha_swcre_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_swcre_ensmbr_am3'}(:,:)       =alpha_swcre_array_am3(:,:);
nc{'alpha_swcre_ensmbr_am3'}.long_name  ='alpha swcre ensembles';

nc{'alpha_swcre_ensmn_am3'}            =ncfloat('TIME'); 
nc{'alpha_swcre_ensmn_am3'}(:)         =mean_alpha_swcre_am3(:);
nc{'alpha_swcre_ensmn_am3'}.long_name  ='alpha swcre ensemble mn';

nc{'alpha_cre_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_cre_ensmbr_am4'}(:,:)       =alpha_cre_array_am4(:,:);
nc{'alpha_cre_ensmbr_am4'}.long_name  ='alpha ensembles';

nc{'alpha_clr_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_clr_ensmbr_am4'}(:,:)       =alpha_clr_array_am4(:,:);
nc{'alpha_clr_ensmbr_am4'}.long_name  ='alpha clr ensembles';

nc{'alpha_cre_ensmn_am4'}            =ncfloat('TIME'); 
nc{'alpha_cre_ensmn_am4'}(:)         =mean_alpha_cre_am4(:);
nc{'alpha_cre_ensmn_am4'}.long_name  ='alpha ensemble mn';

nc{'alpha_clr_ensmn_am4'}            =ncfloat('TIME'); 
nc{'alpha_clr_ensmn_am4'}(:)         =mean_alpha_clr_am4(:);
nc{'alpha_clr_ensmn_am4'}.long_name  ='alpha clr ensemble mn';

nc{'alpha_lwcre_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_lwcre_ensmbr_am4'}(:,:)       =alpha_lwcre_array_am4(:,:);
nc{'alpha_lwcre_ensmbr_am4'}.long_name  ='alpha lwcre ensembles';

nc{'alpha_lwcre_ensmn_am4'}            =ncfloat('TIME'); 
nc{'alpha_lwcre_ensmn_am4'}(:)         =mean_alpha_lwcre_am4(:);
nc{'alpha_lwcre_ensmn_am4'}.long_name  ='alpha lwcre ensemble mn';

nc{'alpha_swcre_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_swcre_ensmbr_am4'}(:,:)       =alpha_swcre_array_am4(:,:);
nc{'alpha_swcre_ensmbr_am4'}.long_name  ='alpha swcre ensembles';

nc{'alpha_swcre_ensmn_am4'}            =ncfloat('TIME'); 
nc{'alpha_swcre_ensmn_am4'}(:)         =mean_alpha_swcre_am4(:);
nc{'alpha_swcre_ensmn_am4'}.long_name  ='alpha swcre ensemble mn';

nc{'alpha_lcc_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_lcc_ensmbr_am2'}(:,:)       =alpha_lcc_array(:,:);
nc{'alpha_lcc_ensmbr_am2'}.long_name  ='alpha lcc ensembles';

nc{'alpha_lcc_ensmn_am2'}            =ncfloat('TIME'); 
nc{'alpha_lcc_ensmn_am2'}(:)         =mean_alpha_lcc(:);
nc{'alpha_lcc_ensmn_am2'}.long_name  ='alpha lcc ensemble mn';

nc{'alpha_lcc_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_lcc_ensmbr_am3'}(:,:)       =alpha_lcc_array_am3(:,:);
nc{'alpha_lcc_ensmbr_am3'}.long_name  ='alpha lcc ensembles';

nc{'alpha_lcc_ensmn_am3'}            =ncfloat('TIME'); 
nc{'alpha_lcc_ensmn_am3'}(:)         =mean_alpha_lcc_am3(:);
nc{'alpha_lcc_ensmn_am3'}.long_name  ='alpha lcc ensemble mn';

nc{'alpha_lcc_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
nc{'alpha_lcc_ensmbr_am4'}(:,:)       =alpha_lcc_array_am4(:,:);
nc{'alpha_lcc_ensmbr_am4'}.long_name  ='alpha lcc ensembles';

nc{'alpha_lcc_ensmn_am4'}            =ncfloat('TIME'); 
nc{'alpha_lcc_ensmn_am4'}(:)         =mean_alpha_lcc_am4(:);
nc{'alpha_lcc_ensmn_am4'}.long_name  ='alpha lcc ensemble mn';

%%nc{'toa_clr_rflux'}        =ncfloat('TIME','lat','lon'); 
%%nc{'toa_clr_rflux'}(:,:,:) =net_clr_rflux_out(:,:,:);
%%nc{'toa_clr_rflux'}.long_name      ='toa net clear sky radiative flux';
%
%nc{'toa_cre'}              =ncfloat('TIME','lat','lon'); 
%nc{'toa_cre'}(:,:,:)       =net_cre_out(:,:,:);
%nc{'toa_cre'}.long_name            ='toa net cloud radiative effect';
%
%%nc{'toa_lw_out'}              =ncfloat('TIME','lat','lon'); 
%%nc{'toa_lw_out'}(:,:,:)       =lw_out(:,:,:);
%%nc{'toa_lw_out'}.long_name         ='toa lw outgoing';
%
%nc{'toa_lw_clr_out'}              =ncfloat('TIME','lat','lon'); 
%nc{'toa_lw_clr_out'}(:,:,:)       =lw_clr_out(:,:,:);
%nc{'toa_lw_clr_out'}.long_name     ='toa lw clear sky outgoing';
%
%nc{'toa_lw_cre_out'}              =ncfloat('TIME','lat','lon'); 
%nc{'toa_lw_cre_out'}(:,:,:)       =lw_cre_out(:,:,:);
%nc{'toa_lw_cre_out'}.long_name     ='toa lw cloud radiative effect';
%
%%nc{'toa_sw_out'}                  =ncfloat('TIME','lat','lon'); 
%%nc{'toa_sw_out'}(:,:,:)           =sw_out(:,:,:);
%%nc{'toa_sw_out'}.long_name         ='toa sw outgoing';
%
%nc{'toa_sw_clr_out'}              =ncfloat('TIME','lat','lon'); 
%nc{'toa_sw_clr_out'}(:,:,:)       =sw_clr_out(:,:,:);
%nc{'toa_sw_clr_out'}.long_name     ='toa sw clear sky outgoing';
%
%nc{'toa_sw_cre_out'}              =ncfloat('TIME','lat','lon'); 
%nc{'toa_sw_cre_out'}(:,:,:)       =sw_cre_out(:,:,:);
%nc{'toa_sw_cre_out'}.long_name     ='toa sw cloud radiative effect';
%
%%nc{'eis'}              =ncfloat('TIME','lat','lon'); 
%%nc{'eis'}(:,:,:)       =eis_out(:,:,:);
%%nc{'eis'}.long_name     ='estimated inversion strength';
%%
%%nc{'lts'}              =ncfloat('TIME','lat','lon'); 
%%nc{'lts'}(:,:,:)       =lts_out(:,:,:);
%%nc{'lts'}.long_name    ='lower tropospheric stability';
%
%nc{'temp_sfc'}              =ncfloat('TIME','lat','lon'); 
%nc{'temp_sfc'}(:,:,:)       =temp_sfc_out(:,:,:);
%nc{'temp_sfc'}.long_name    ='surface temperature';
%
%%nc{'temp700'}              =ncfloat('TIME','lat','lon'); 
%%nc{'temp700'}(:,:,:)       =temp700_out(:,:,:);
%%nc{'temp700'}.long_name    ='temperature on 700hPa';
%%
%%nc{'omega500'}              =ncfloat('TIME','lat','lon'); 
%%nc{'omega500'}(:,:,:)       =omega500_out(:,:,:);
%%nc{'omega500'}.long_name    ='omega on 500hPa';
%
%%nc{'lcloud'}              =ncfloat('TIME','lat','lon'); 
%%nc{'lcloud'}(:,:,:)       =lcloud_out(:,:,:);
%%nc{'lcloud'}.long_name    ='low level cloud';
%%
%%nc{'hcloud'}              =ncfloat('TIME','lat','lon'); 
%%nc{'hcloud'}(:,:,:)       =hcloud_out(:,:,:);
%%nc{'hcloud'}.long_name    ='high level cloud';

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
