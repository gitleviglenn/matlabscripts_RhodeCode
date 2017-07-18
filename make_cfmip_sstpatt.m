%----------------------------------------------------------------------------
% make_cfmip_sstpatt.m
%
% modified from: make_icesst_norm.m
%
% this script will open a climatological sst file, open an anomalous sst file 
% add the two together, and output a single sst pattern file.  this will be
% in accordance with a cfmip3 experiment that uses a cmip3 multi-model mean
% sst pattern from a 1% per year increase of CO2 concentration
%
% levi silvers                                        july 2017
%----------------------------------------------------------------------------
%

%% the two files below are from a 1% CO2 increase per year run
fin='/archive/Levi.Silvers/input/sst.climo.1981-2014.data.nc'
fin_anom='/archive/Levi.Silvers/input/cfmip2_4k_patterned_sst_forcing.vn1.0.nc'

% output files
fnout_sst='sst_2010_climo_ctl.nc'
fnout_sst_pert='sst_2010_climo_ctlpanom.nc'
	  
%% read input file for control data
f =netcdf(fin,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
%-------------------------------------------------
% set up a structure(v) to hold info related to variables
%-------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
lontarget=v.lon;
lattarget=v.lat;
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
v.sst =f{'sst'} (:,:,:); 
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.average_T1 =f{'average_T1'} (:);
v.average_T2 =f{'average_T2'} (:);
v.average_DT =f{'average_DT'} (:);
v.climatology_bounds = [43845.5 56263.5; 43875 56293; 43904.5 56322.5; 43935 56353; 43965.5 56383.5; 43996 56414; 44026.5 56444.5; 44057.5 56475.5; 44088 56506; 44118.5 56536.5; 44149 56567; 44179.5  56597.5];
v.time = [56263.5 56293 56322.5 56353 56383.5 56414 56444.5 56475.5 56506, 56536.5, 56567, 56597.5] ; 
v.nt=12;
v.yr=[0 0 0 0 0 0 0 0 0 0 0 0];
v.mo=[1 2 3 4 5 6 7 8 9 10 11 12];
v.dy=[16 15 16 16 16 16 16 16 16 16 16 16] ;
v.average_T1 = [43845.5 43875 43904.5 43935 43965.5 43996 44026.5 44057.5 44088 44118.5 44149 44179.5];
v.average_T2 = [56263.5 56293 56322.5 56353 56383.5 56414 56444.5 56475.5 56506 56536.5 56567 56597.5]; 
v.average_DT = [12410 12410 12410 12410 12410 12410 12410 12410 12410 12410 12410 12410];  
%-------------------------------------------------
%-------------------------------------------------

%%-------------------------------------------------
%%% read input file for anomalous sst file 
%%%-------------------------------------------------
f_anom =netcdf(fin_anom,'nowrite');
%
lonbase=f_anom{'longitude'}(:); latbase =f_anom{'latitude'}(:);
%v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
%lonbase=v.lon;
%latbase=v.lat;
%
v.sst_anom =f_anom{'dt'} (:,:,:,:); 
v.sst_anom=squeeze(v.sst_anom);

close(f);
close(f_anom);

% interpolate to the climo grid (360x180)

% switch nan's for -999
v.sst_anomnan=v.sst_anom;
v.sst_anomnan(v.sst_anom==-999.)=NaN;
sst_anom_interp=interp_grid(v.sst_anomnan,lontarget,lattarget,lonbase,latbase,1);
sst_anom_360x180=sst_anom_interp;

% i don't want NaN's over land in the final file
sst_anom_360x180(isnan(sst_anom_360x180))=0.0;

% compute the ctl + anom pattern...
sst_patt_cmip3mm=v.sst+sst_anom_360x180;

figure
contourf(squeeze(sst_patt_cmip3mm(6,:,:)))
title('total sst pattern')
colorbar
figure
contourf(squeeze(v.sst(6,:,:)))
title('ctl sst ')
colorbar
figure
contourf(squeeze(sst_anom_360x180(6,:,:)))
title('anom sst pattern')
colorbar
%%-------------------------------------------------
%for ti=1:12
%  v.sst_ctl_p_pert(ti)=v.sst(ti)-v.sst_anom(ti);
%end
%-------------------------------------------------

% these are the control data
sst_general=v.sst;
%-------------------------------------------------
%-------------------------------------------------

% create a new netcdf file
nc = netcdf(fnout_sst,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = 'created on 07/18/2017 by levi silvers' ;

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=v.sst(:,:,:);
nc{'climatology_bounds'} = ncdouble('time','nv'); 
nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='time';      
%nc{'time'}.climatology   ='climatology_bounds';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1860-01-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'sst'}.long_name     ='Monthly 1 degree resolution sst';
nc{'sst'}.standard_name ='sea_surface_temperature';
nc{'sst'}.units         ='degK';      
nc{'sst'}.add_offset    = 0.e0;
nc{'sst'}.scale_factor  = 1.e0;
nc{'sst'}.FillValue_    =-1.e+30;
nc{'sst'}.missing_value =-1.e+30;
nc{'sst'}.description   ='HadIsst 1.1 monthly average sea surface temperature';
nc{'sst'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1860-01-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1860-01-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

'finished first nc file'

  % create a new netcdf file
  nc = netcdf(fnout_sst_pert,'clobber'); 
  if isempty(nc) error('NetCDF File Not Opened.'); end
  nc.Conventions = 'CF-1.0';
  nc.title = 'regression pattern of warming';
  nc.institution = 'GFDL' ;
  nc.source      = 'HadISST';
  nc.history     = 'created on 07/18/2017' ;
  
  nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
  nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
  nc('lat') = v.nlat;          nc('lon')     = v.nlon;
  nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
  nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 
  
  nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=sst_patt_cmip3mm(:,:,:);
  nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
  nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
  nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
  nc{'climatology_bounds'} = ncdouble('time','nv'); 
  nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
  nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
  nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
  nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
  nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;
  
  nc{'time'}.long_name     ='Time';      
  nc{'time'}.standard_name ='time';
  nc{'time'}.calendar      ='gregorian';
  nc{'time'}.units         ='days since 1860-01-1 00:00:00';      
  nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
  nc{'time'}.modulo        =' ';      
  
  nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
  nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;
  
  nc{'yr'}.long_name    ='year';      
  nc{'mo'}.long_name    ='month';      
  nc{'dy'}.long_name    ='day';      
  
  nc{'sst'}.long_name     ='linear reg values';
  nc{'sst'}.standard_name ='reg';
  nc{'sst'}.units         ='degK per yr';      
  nc{'sst'}.add_offset    = 0.e0;
  nc{'sst'}.scale_factor  = 1.e0;
  nc{'sst'}.FillValue_    =-1.e+30;
  nc{'sst'}.missing_value =-1.e+30;
  nc{'sst'}.description   ='reg pattern from 150 yr historical run';
  nc{'sst'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
  nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';
  
  nc{'average_T1'}.long_name ='Start time for average period';
  nc{'average_T1'}.units     ='days since 1860-01-1 00:00:00';      
  
  nc{'average_T2'}.long_name ='End time for average period';
  nc{'average_T2'}.units     ='days since 1860-01-1 00:00:00';      
  
  nc{'average_DT'}.long_name ='Length of average period';
  nc{'average_DT'}.units     ='days';      
  
  close(nc); 
  
  'finished second nc file'
  

