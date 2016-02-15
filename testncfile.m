%----------------------------------------------------------------------------
% make_sst_1860ctl.m
%
% this script opens a file with sst data from a control 1860 coupled exp. The
% control 1860 run extends for 140 years.  We skip the first 50 years to 
% eliminate fluctuations due to spinup.
%
% a mean sst pattern to use as a control experiment is derived from this sst.
%
% input: fin
%
% output files:  mean sst as a function of grid point and month
%
% at the moment average_T1, average_T2, and average_Dt are junk...
%
% levi silvers                                        Jan 2016
%----------------------------------------------------------------------------
%fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc'
%fin_sst='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_surf.nc'
fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'

% output file
fnout='testfile.nc'

% read input file
f =netcdf(fin_sst,'nowrite');
ncid=netcdf.open(fin_sst,'NC_NOWRITE');
[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
% set up a structure(v) to hold info related to variables
%-------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
v.climatology_bounds =f{'climatology_bounds'}(:,:);
% here we read in only the first 10 years
v.sst =f{'SST'}(:,:,:); 
%tstart=600;
%tend=1299;
%tint=tend-tstart+1;
%v.sst_full =f{'SST'} (tstart:tend,:,:); 
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.average_T1 =f{'average_T1'} (:);
v.average_T2 =f{'average_T2'} (:);
v.average_DT =f{'average_DT'} (:);
v.climatology_bounds= [...
  40223 49354;...
  40254 49385;...
  40282 49413;...
  40313 49444;...
  40343 49474;...
  40374 49505;...
  40404 49535;...
  40435 49566;...
  40466 49597;...
  40496 49627;...
  40527 49658;...
  40557 49688] ;
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
v.yr=[0 0 0 0 0 0 0 0 0 0 0 0];
v.mo=[1 2 3 4 5 6 7 8 9 10 11 12];
v.dy=[1 1 1 1 1 1 1 1 1 1 1 1] ;
v.average_T1=[40223 40254 40282 40313 40343 40374 ...
	     40404 40435 40466 40496 40527 40557];
v.average_T2=[49354 49385 49413 49444 49474 49505 ...
	     49535 49566 49597 49627 49658 49688];
v.average_DT=[9125 9125 9125 9125 9125 9125 9125 9125 9125 9125 9125 9125];
%-------------------------------------------------
close(f);

% define lat/lon which will be used for the timeslice
latfull=1:1:180;
lonfull=1:1:288;
lat=90.;
lon=100.;
% indexing end points
nlon=288;
nlat=180;
nyr=150;
nmon=12;

%-------------------------------------------------
nc = netcdf(fnout,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Monthly version of HadISST sea surface temperature component';
nc.institution = 'Met Office, Hadley Centre for Climate Research' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy';

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

nc{'time'}.long_name     ='Time';      
nc{'time'}.climatology   ='climatology_bounds';      
nc{'time'}.standard_name ='time';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'sst'}.long_name     ='Monthly 1 degree resolution SST';
nc{'sst'}.standard_name ='sea_surface_temperature';
nc{'sst'}.units         ='degK';      
nc{'sst'}.add_offset    = 0.e0;
nc{'sst'}.scale_factor  = 1.e0;
nc{'sst'}.FillValue_    =-1.e+30;
nc{'sst'}.missing_value =-1.e+30;
nc{'sst'}.description   ='HadISST 1.1 monthly average sea surface temperature';
nc{'sst'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc);
