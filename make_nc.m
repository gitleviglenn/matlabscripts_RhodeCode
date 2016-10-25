%----------------------------------------------------------------------------
% make_nc.m
%
% this script creates a netcdf output files from the fields sst_in and ice_in 
%
% be careful! this is only meant to be used in coordination with another script.
% the data stored in matlab for the v. structure from the last
% executed script will be written as the meta data for sst_in.
%
% to write data from a file to sst_in do the following: 
% fin='data path'
% f =netcdf(fin,'nowrite');
% v.sst =f{'varname'} (:,:,:); 
%
% levi silvers                                        sep 2016
%----------------------------------------------------------------------------
%
fnout_sst='sst_out.nc'
fnout_ice='ice_out.nc'

% 
% it is not clear to me exactly what values need to be used for v.time, v.average etc....
% they probably need to be checked versus the values used in default experiments 
% do the input files have diff values for 1860 and 2000 control exps?
% 1860 and 2000climo experiments use the same input climo_data.
v.time = [47528.5 47559.5 47590 47619.5 47650 47680.5 47711 47741.5 47772.5 47803 47833.5 47864];
v.nt=12;
v.yr=[0 0 0 0 0 0 0 0 0 0 0 0];
v.mo=[1 2 3 4 5 6 7 8 9 10 11 12];
%v.dy=[1 1 1 1 1 1 1 1 1 1 1 1] ;
v.dy=[0 0 0 0 0 0 0 0 0 0 0 0] ;
v.average_T1=[40224.5 40255.5 40285 40314.5 40345 40375.5 40406 40436.5 40467.5 40498 40528.5 40559];
v.average_T2=[47528.5 47559.5 47590 47619.5 47650 47680.5 47711 47741.5 47772.5 47803 47833.5 47864];
v.average_DT=[7300 7300 7300 7300 7300 7300 7300 7300 7300 7300 7300 7300];


%-------------------------------------------------
% create a new netcdf file
nc = netcdf(fnout_sst,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from coupled CM4 run';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; modified by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'sst'}=ncfloat('TIME','lat','lon'); nc{'sst'}(:,:,:)=sst_in(:,:,:);
%nc{'climatology_bounds'} = ncdouble('TIME','nv'); 
%nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('TIME'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('TIME'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('TIME'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'TIME'}.long_name     ='TIME';      
%nc{'TIME'}.climatology   ='climatology_bounds';      
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

nc{'sst'}.long_name     ='Monthly Mean sst';
nc{'sst'}.standard_name ='sea_surface_temperature';
nc{'sst'}.units         ='degK';      
nc{'sst'}.add_offset    = 0.e0;
nc{'sst'}.scale_factor  = 1.e0;
nc{'sst'}.FillValue_    =-1.e+30;
nc{'sst'}.missing_value =-1.e+30;
nc{'sst'}.description   ='climo monthly average sea surface temperature';
nc{'sst'}.cell_methods  ='TIME: lat: lon: mean within months TIME: mean over years';
nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start TIME for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End TIME for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

'finished first nc file'
%%
%%% create a new netcdf file
%%
%nc = netcdf(fnout_ice,'clobber'); 
%if isempty(nc) error('NetCDF File Not Opened.'); end
%nc.Conventions = 'CF-1.0';
%nc.title = 'Modified SST pattern from coupled CM4 run';
%nc.institution = 'GFDL' ;
%nc.source      = 'HadISST';
%nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; modified by Levi Silvers';
%
%nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
%nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
%nc('lat') = v.nlat;          nc('lon')     = v.nlon;
%nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
%nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 
%
%nc{'ice'}=ncfloat('TIME','lat','lon'); nc{'ice'}(:,:,:)=ice_in(:,:,:);
%%nc{'climatology_bounds'} = ncdouble('TIME','nv'); 
%%nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
%nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
%nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
%nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
%nc{'average_T1'} = ncdouble('TIME'); nc{'average_T1'}(:)=v.average_T1;
%nc{'average_T2'} = ncdouble('TIME'); nc{'average_T2'}(:)=v.average_T2;
%nc{'average_DT'} = ncdouble('TIME'); nc{'average_DT'}(:)=v.average_DT;
%nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;
%
%nc{'TIME'}.long_name     ='TIME';      
%%nc{'TIME'}.climatology   ='climatology_bounds';      
%nc{'TIME'}.standard_name ='TIME';
%nc{'TIME'}.calendar      ='gregorian';
%nc{'TIME'}.units         ='days since 1869-12-1 00:00:00';      
%nc{'TIME'}.delta_t       ='0000-00-01 00:00:00';      
%nc{'TIME'}.modulo        =' ';      
%
%nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
%nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;
%
%nc{'yr'}.long_name    ='year';      
%nc{'mo'}.long_name    ='month';      
%nc{'dy'}.long_name    ='day';      
%
%nc{'ice'}.long_name     ='fractional amount of sea ice';
%nc{'ice'}.standard_name ='ice_mask';
%nc{'ice'}.units         ='none';      
%nc{'ice'}.add_offset    = 0.e0;
%nc{'ice'}.scale_factor  = 1.e0;
%nc{'ice'}.FillValue_    =-1.e+20;
%% matlab for some reason doesn't like the notation below...
%%nc{'ice'}.valid_range   =-0.01f, +1.01f;
%nc{'ice'}.missing_value =-1.e+20;
%nc{'sst'}.description   ='climo monthly average sea ice';
%nc{'ice'}.cell_methods  ='TIME: mean';
%nc{'ice'}.time_avg_info ='average_T1,average_T2,average_DT';
%
%nc{'average_T1'}.long_name ='Start TIME for average period';
%nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      
%
%nc{'average_T2'}.long_name ='End TIME for average period';
%nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      
%
%nc{'average_DT'}.long_name ='Length of average period';
%nc{'average_DT'}.units     ='days';      
%
%close(nc); 
%
