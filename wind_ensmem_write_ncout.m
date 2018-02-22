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
nc('wnum') = 37;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = vlat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = vlon; 

nc{'alpha_window_am2'}              =ncfloat('TIME','ensnum','wnum'); 
nc{'alpha_window_am2'}(:,:,:)       =alpha_wind_am2_newd(:,:,:);
nc{'alpha_window_am2'}.long_name    ='alpha window array am2';

nc{'alpha_window_am3'}              =ncfloat('TIME','ensnum','wnum'); 
nc{'alpha_window_am3'}(:,:,:)       =alpha_wind_am3_newd(:,:,:);
nc{'alpha_window_am3'}.long_name    ='alpha window array am3';

nc{'alpha_window_am4'}              =ncfloat('TIME','ensnum','wnum'); 
nc{'alpha_window_am4'}(:,:,:)       =alpha_wind_am4_newd(:,:,:);
nc{'alpha_window_am4'}.long_name    ='alpha window array am4';

nc{'alpha_lcc_window_am2'}              =ncfloat('TIME','ensnum','wnum'); 
nc{'alpha_lcc_window_am2'}(:,:,:)       =alpha_lcc_wind_am2_newd(:,:,:);
nc{'alpha_lcc_window_am2'}.long_name    ='alpha window array am2';

nc{'alpha_lcc_window_am3'}              =ncfloat('TIME','ensnum','wnum'); 
nc{'alpha_lcc_window_am3'}(:,:,:)       =alpha_lcc_wind_am3_newd(:,:,:);
nc{'alpha_lcc_window_am3'}.long_name    ='alpha window array am3';

nc{'alpha_lcc_window_am4'}              =ncfloat('TIME','ensnum','wnum'); 
nc{'alpha_lcc_window_am4'}(:,:,:)       =alpha_lcc_wind_am4_newd(:,:,:);
nc{'alpha_lcc_window_am4'}.long_name    ='alpha window array am4';

%
%nc{'alpha_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_ensmbr_am3'}(:,:)       =alpha_array_am3(:,:);
%nc{'alpha_ensmbr_am3'}.long_name  ='alpha ensembles';
%
%nc{'alpha_ensmn_am3'}            =ncfloat('TIME'); 
%nc{'alpha_ensmn_am3'}(:)         =mean_alpha_am3(:);
%nc{'alpha_ensmn_am3'}.long_name  ='alpha ensemble mn';
%
%nc{'alpha_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_ensmbr_am4'}(:,:)       =alpha_array_am4(:,:);
%nc{'alpha_ensmbr_am4'}.long_name  ='alpha ensembles';
%
%nc{'alpha_ensmn_am4'}            =ncfloat('TIME'); 
%nc{'alpha_ensmn_am4'}(:)         =mean_alpha_am4(:);
%nc{'alpha_ensmn_am4'}.long_name  ='alpha ensemble mn';
%
%nc{'alpha_cre_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_cre_ensmbr_am2'}(:,:)       =alpha_cre_array(:,:);
%nc{'alpha_cre_ensmbr_am2'}.long_name  ='alpha ensembles';
%
%nc{'alpha_cre_ensmn_am2'}            =ncfloat('TIME'); 
%nc{'alpha_cre_ensmn_am2'}(:)         =mean_alpha_cre(:);
%nc{'alpha_cre_ensmn_am2'}.long_name  ='alpha ensemble mn';
%
%nc{'alpha_cre_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_cre_ensmbr_am3'}(:,:)       =alpha_cre_array_am3(:,:);
%nc{'alpha_cre_ensmbr_am3'}.long_name  ='alpha ensembles';
%
%nc{'alpha_cre_ensmn_am3'}            =ncfloat('TIME'); 
%nc{'alpha_cre_ensmn_am3'}(:)         =mean_alpha_cre_am3(:);
%nc{'alpha_cre_ensmn_am3'}.long_name  ='alpha ensemble mn';
%
%nc{'alpha_cre_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_cre_ensmbr_am4'}(:,:)       =alpha_cre_array_am4(:,:);
%nc{'alpha_cre_ensmbr_am4'}.long_name  ='alpha ensembles';
%
%nc{'alpha_cre_ensmn_am4'}            =ncfloat('TIME'); 
%nc{'alpha_cre_ensmn_am4'}(:)         =mean_alpha_cre_am4(:);
%nc{'alpha_cre_ensmn_am4'}.long_name  ='alpha ensemble mn';
%
%nc{'alpha_lcc_ensmbr_am2'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_lcc_ensmbr_am2'}(:,:)       =alpha_lcc_array(:,:);
%nc{'alpha_lcc_ensmbr_am2'}.long_name  ='alpha lcc ensembles';
%
%nc{'alpha_lcc_ensmn_am2'}            =ncfloat('TIME'); 
%nc{'alpha_lcc_ensmn_am2'}(:)         =mean_alpha_lcc(:);
%nc{'alpha_lcc_ensmn_am2'}.long_name  ='alpha lcc ensemble mn';
%
%nc{'alpha_lcc_ensmbr_am3'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_lcc_ensmbr_am3'}(:,:)       =alpha_lcc_array_am3(:,:);
%nc{'alpha_lcc_ensmbr_am3'}.long_name  ='alpha lcc ensembles';
%
%nc{'alpha_lcc_ensmn_am3'}            =ncfloat('TIME'); 
%nc{'alpha_lcc_ensmn_am3'}(:)         =mean_alpha_lcc_am3(:);
%nc{'alpha_lcc_ensmn_am3'}.long_name  ='alpha lcc ensemble mn';
%
%nc{'alpha_lcc_ensmbr_am4'}            =ncfloat('TIME','ensnum'); 
%nc{'alpha_lcc_ensmbr_am4'}(:,:)       =alpha_lcc_array_am4(:,:);
%nc{'alpha_lcc_ensmbr_am4'}.long_name  ='alpha lcc ensembles';
%
%nc{'alpha_lcc_ensmn_am4'}            =ncfloat('TIME'); 
%nc{'alpha_lcc_ensmn_am4'}(:)         =mean_alpha_lcc_am4(:);
%nc{'alpha_lcc_ensmn_am4'}.long_name  ='alpha lcc ensemble mn';


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


close(nc); 

'finished nc file'
%%------------------------------------------------------------------------------------------
% this is the end
