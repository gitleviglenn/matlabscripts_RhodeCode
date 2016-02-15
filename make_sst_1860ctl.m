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
%
% output files:  mean sst as a function of grid point and month
%
% at the moment average_T1, average_T2, and average_Dt are junk...
%
% levi silvers                                        Jan 2016
%----------------------------------------------------------------------------
%fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc'
fin_sst='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_surf.nc'
fin_ice='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.ice_mask.nc'
fin_reft='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_ref.nc'
%ncid=netcdf.open(fin,'NC_NOWRITE');
%[ndim,nvar,natt,unlim]=netcdf.inq(fin);

% output file
fnout='sst_1860ctl.nc'
fnoutice='ice_1860ctl.nc'

% read input file
f =netcdf(fin_sst,'nowrite');
fice =netcdf(fin_ice,'nowrite');
fref = netcdf(fin_reft,'nowrite');
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
% here we read in only the first 10 years
v.sst =f{'t_surf'} (1:120,:,:); 
tstart=720;
tend=1679;
tint=tend-tstart+1;
v.sst_full =f{'t_surf'} (tstart:tend,:,:); 
v.ice_full =fice{'ice_mask'} (tstart:tend,:,:); 
v.t_ref =fref{'t_ref'} (tstart:tend,:,:); 
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.average_T1 =f{'average_T1'} (:);
v.average_T2 =f{'average_T2'} (:);
v.average_DT =f{'average_DT'} (:);
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
% this can be used if the length of T1,T2, and DT need to be other than 12
%v.nt=tint;
%v.average_T1=1:tint;
%v.average_T2=1:tint;
%v.average_DT=1:tint;
%-------------------------------------------------
close(f);
close(fice);
close(fref);

% arrange the sst array in terms of months
clear monarray;
for ti=1:12;
  monarray=v.sst_full(ti:12:tint,:,:);
  monarray2=v.t_ref(ti:12:tint,:,:);
  monarray3=v.ice_full(ti:12:tint,:,:);
  v.sst_mnthlymn(ti,:,:)=mean(monarray,1);
  v.t_refmnthlymn(ti,:,:)=mean(monarray2,1);
  v.ice_mnthlymn(ti,:,:)=mean(monarray3,1);
end
clear monarray;
for ti=1:12;
  monarray=v.sst(ti:12:120,:,:);
  v.sst_10yrmn(ti,:,:)=mean(monarray,1);
end
%'10yrmn_sea_surf_temp';
size(v.sst_10yrmn);

%
%tsurf=netcdf.getVar(ncid,7);
%'second_sea_surf_temp'
%size(tsurf)
%timearr=netcdf.getVar(ncid,8);
%% the reshape command below should group the data by year, as apposed to month
%% to get one year t_surf(:,:,:,year);
%% to get one all occurances of one month: t_surf(:,:,month,:)
%% assumes all months are present in tsurf
%%t_surf_yr=reshape(tsurf,[288,180,12,150]);

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

%
%-------------------------------------------------
% check what the global mean value of the regressed pattern is
glblatweight=v.latweight;
for index=1:287;
    glblatweight=horzcat(glblatweight,v.latweight);
end
v.sst_10yrmn0=squeeze(mean(v.sst_10yrmn,1));
v.sst_fullyrmn0=squeeze(mean(v.sst_mnthlymn,1));
v.t_reffullyrmn0=squeeze(mean(v.t_refmnthlymn,1));
glbsumweight=sum(glblatweight(:));
%
% create a full global array of the lat weights, for every time
glblatweightwack=repmat(glblatweight,[1,1,tint]);
glblatweightfull=permute(glblatweightwack,[3,1,2]);
latweightsst=glblatweightfull.*v.sst_full;
testmean=mean(v.sst_full,2);
fullmean=mean(testmean,3);
%glbmeansst=fullmean/glbsumweight;
glbmeansst=fullmean;
%plot(glbmeansst)
%
%
glbbasedata=v.sst_10yrmn0.*glblatweight;
glbbasedata_full=v.sst_fullyrmn0.*glblatweight;
glbbasedata_tref=v.t_reffullyrmn0.*glblatweight;
glbsum_basesst=sum(glbbasedata(:));
glbsum_basesstfull=sum(glbbasedata_full(:));
glbsum_basesstref=sum(glbbasedata_tref(:));
%
'jan global mean of first 10 years'
globmean=glbsum_basesst/glbsumweight
'jan global mean over averaging period'
globmean=glbsum_basesstfull/glbsumweight
'jan global mean 2m temperature'
globmean=glbsum_basesstref/glbsumweight
%'global mean of 1860 plus 150x regression'
globalmeantot=zeros(22);
glbsum_basetotsst=zeros(22);
for tindex=1:22;
  v.sst_glbmn=squeeze(mean(v.sst_full,tindex));
  glbsumweight=sum(glblatweight(:));
  glbbasedatatime=v.sst_glbmn.*glbsumweight;
  glbsum_basetotsst(tindex)=sum(glbbasedatatime(:));
  globmeantot(tindex)=glbsum_basetotsst(tindex)/glbsumweight;
end
%-------------------------------------------------
lowbnd=271.21 % lower bound for sst
for ilon=1:1:nlon
  for ilat=1:1:nlat
    for imonth=1:1:nmon
      if (v.sst_mnthlymn(imonth,ilat,ilon) < lowbnd)
        v.sst_mnthlymn(imonth,ilat,ilon) = lowbnd;
      end
    end
  end	       
end
% create a few figures to see what we are doing
%figure; contourf(v.lon,v.lat,v.sst_10yrmn0);colorbar;
%figure; contourf(v.lon,v.lat,v.sst_fullyrmn0);colorbar;
%-------------------------------------------------
% create a new netcdf file
nc = netcdf(fnout,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
%nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(tstart:tend); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=v.sst_mnthlymn(:,:,:);
%nc{'t_surf'}=ncfloat('time','lat','lon'); nc{'t_surf'}(:,:,:)=tsurf(:,:,1:12);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); 
nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
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
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

% now create the output nc file with the mean ice mask
nc = netcdf(fnoutice,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'mean ice pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

nc{'ice'}=ncfloat('time','lat','lon'); nc{'ice'}(:,:,:)=v.ice_mnthlymn(:,:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); 
nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
nc{'time'}.standard_name ='time';
nc{'time'}.calendar      ='gregorian';
nc{'time'}.units         ='days since 1869-12-1 00:00:00';      
nc{'time'}.delta_t       ='0000-00-01 00:00:00';      
nc{'time'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'ice'}.long_name     ='Mean Monthly 1 degree resolution ice';
nc{'ice'}.standard_name ='ice';
nc{'ice'}.units         ='degK';      
nc{'ice'}.add_offset    = 0.e0;
nc{'ice'}.scale_factor  = 1.e0;
nc{'ice'}.FillValue_    =-1.e+30;
nc{'ice'}.missing_value =-1.e+30;
nc{'ice'}.description   ='HadIice 1.1 monthly average sea surface temperature';
nc{'ice'}.cell_methods  ='time: lat: lon: mean within months time: mean over years';
nc{'ice'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 


