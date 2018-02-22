%------------------------------------------------------------------------------------------
% am4p0_swcorr_write_ncout.m
%
% write output to a netcdf file 
%
% levi silvers                                        june 2017
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

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = nmonths; 
%nc{'TIME'}= nmonths;
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'} (1:nmonths) = timearray(:); 
nc('lat') = nlat;          nc('lon')     = nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = vlat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = vlon; 

nc{'am4_swcrealphacc_a'}            =ncfloat('lat','lon'); 
nc{'am4_swcrealphacc_a'}(:,:)     =global_swcor_18851999(:,:);
nc{'am4_swcrealphacc_a'}.long_name  ='corr coeff of swcre and alpha ts';

nc{'am4_swcrealphacc_b'}            =ncfloat('lat','lon'); 
nc{'am4_swcrealphacc_b'}(:,:)     =global_swcor_19741999(:,:);
nc{'am4_swcrealphacc_b'}.long_name  ='corr coeff of swcre and alpha ts';

nc{'am4_swcrealphacc_c'}            =ncfloat('lat','lon'); 
nc{'am4_swcrealphacc_c'}(:,:)     =global_swcor_19251955(:,:);
nc{'am4_swcrealphacc_c'}.long_name  ='corr coeff of swcre and alpha ts';

nc{'am4_swcrealphacc_d'}            =ncfloat('lat','lon'); 
nc{'am4_swcrealphacc_d'}(:,:)     =global_swcor_19401999(:,:);
nc{'am4_swcrealphacc_d'}.long_name  ='corr coeff of swcre and alpha ts';

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
