%------------------------------------------------------------------------------------------
% ensmn_ncout.m
%
% write output to a netcdf file 
%
% levi silvers                                        may 2017
%------------------------------------------------------------------------------------------

%%------------------------------------------------------------------------------------------
starti=1;
endi=127;
firstyr=1875;
timearr=firstyr:firstyr+126;
nyearsalpha=127;

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
%nc('lat') = nlat;          nc('lon')     = nlon;
%nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = vlat; 
%nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = vlon; 

nc{'am2_applcc_smooth'}             =ncfloat('TIME'); 
nc{'am2_applcc_smooth'}(:)          =new_ts_am2_smooth(:);
nc{'am2_applcc_smooth'}.long_name   ='app am2 lcc smoothed by 9 yr rmn';

nc{'am3_applcc_smooth'}             =ncfloat('TIME'); 
nc{'am3_applcc_smooth'}(:)          =new_ts_am3_smooth(:);
nc{'am3_applcc_smooth'}.long_name   ='app am3 lcc smoothed by 9 yr rmn';

nc{'am4_applcc_smooth'}             =ncfloat('TIME'); 
nc{'am4_applcc_smooth'}(:)          =new_ts_am4_smooth(:);
nc{'am4_applcc_smooth'}.long_name   ='app am4 lcc smoothed by 9 yr rmn';

nc{'am2_lcc_smooth'}             =ncfloat('TIME'); 
nc{'am2_lcc_smooth'}(:)          =lcc_am2_smooth(:);
nc{'am2_lcc_smooth'}.long_name   ='app am2 lcc smoothed by 9 yr rmn';

nc{'am3_lcc_smooth'}             =ncfloat('TIME'); 
nc{'am3_lcc_smooth'}(:)          =lcc_am3_smooth(:);
nc{'am3_lcc_smooth'}.long_name   ='app am3 lcc smoothed by 9 yr rmn';

nc{'am4_lcc_smooth'}             =ncfloat('TIME'); 
nc{'am4_lcc_smooth'}(:)          =lcc_am4_smooth(:);
nc{'am4_lcc_smooth'}.long_name   ='am4 lcc smoothed by 9 yr rmn';

nc{'am2_sst_scaled'}             =ncfloat('TIME'); 
nc{'am2_sst_scaled'}(:)          =new_sst2_scaled(:);
nc{'am2_sst_scaled'}.long_name   ='app am2 lcc smoothed by 9 yr rmn';

nc{'am3_sst_scaled'}             =ncfloat('TIME'); 
nc{'am3_sst_scaled'}(:)          =new_sst3_scaled(:);
nc{'am3_sst_scaled'}.long_name   ='app am3 lcc smoothed by 9 yr rmn';

nc{'am4_sst_scaled'}             =ncfloat('TIME'); 
nc{'am4_sst_scaled'}(:)          =new_sst4_scaled(:);
nc{'am4_sst_scaled'}.long_name   ='am4 lcc smoothed by 9 yr rmn';

%nc{'alpha_window_am3'}              =ncfloat('TIME','ensnum','wnum'); 
%nc{'alpha_window_am3'}(:,:,:)       =alpha_wind_am3_newd(:,:,:);
%nc{'alpha_window_am3'}.long_name    ='alpha window array am3';
%
%nc{'alpha_window_am4'}              =ncfloat('TIME','ensnum','wnum'); 
%nc{'alpha_window_am4'}(:,:,:)       =alpha_wind_am4_newd(:,:,:);
%nc{'alpha_window_am4'}.long_name    ='alpha window array am4';
%
%nc{'alpha_lcc_window_am2'}              =ncfloat('TIME','ensnum','wnum'); 
%nc{'alpha_lcc_window_am2'}(:,:,:)       =alpha_lcc_wind_am2_newd(:,:,:);
%nc{'alpha_lcc_window_am2'}.long_name    ='alpha window array am2';
%
%nc{'alpha_lcc_window_am3'}              =ncfloat('TIME','ensnum','wnum'); 
%nc{'alpha_lcc_window_am3'}(:,:,:)       =alpha_lcc_wind_am3_newd(:,:,:);
%nc{'alpha_lcc_window_am3'}.long_name    ='alpha window array am3';
%
%nc{'alpha_lcc_window_am4'}              =ncfloat('TIME','ensnum','wnum'); 
%nc{'alpha_lcc_window_am4'}(:,:,:)       =alpha_lcc_wind_am4_newd(:,:,:);
%nc{'alpha_lcc_window_am4'}.long_name    ='alpha window array am4';


nc{'TIME'}.long_name     ='TIME';      
nc{'TIME'}.standard_name ='TIME';
nc{'TIME'}.calendar      ='gregorian';
nc{'TIME'}.units         ='days since 1869-12-1 00:00:00';      
nc{'TIME'}.delta_t       ='0000-00-01 00:00:00';      
nc{'TIME'}.modulo        =' ';      

%nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
%nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      


close(nc); 

'finished nc file'
%%------------------------------------------------------------------------------------------
% this is the end
