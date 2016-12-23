%----------------------------------------------------------------------------
% make_icesst.m
%
% this script opens a file with historical sst data starting at 1860 and 
% uses simple linear regression to compute the change of temperature between 
% 1860 and 2010.  
% this pattern of a potential sst pattern due to warming can then be added
% to a baseline sst from some control experiment
% The same is done for the ice. 
%
% the simple linear regression can be computed as 
% reg=corrcoef*(standard dev of y/standard dev of x)
%
% input: fin
%
% final product: glb_linregs
%
% output files:  mean sst anomaly as a function of grid point and month
%                mean ice anomaly as a function of grid point and month
%
% levi silvers                                        Jan 2016
%----------------------------------------------------------------------------
% the two files below are from the historical run...
fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc'
fin_ice='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.ice_mask.nc'
% the two files below are from the 1860 control run....
fin_sst_ctl='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_surf.nc'
fin_ice_ctl='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.ice_mask.nc'

% the    switch determines if the output sst and ice files will be
% for the control case, or for the control + reg case.
% default: control + reg

% output files
controlpreg=1; % 0: default (ctl + reg), 1: ctl or ctl + 4k
controlp4k=0; % 0: default ctl, 1: ctl + 4k
if (controlpreg > 0 ) 
  if (controlp4k > 0 ) 
    'controlp4k gt 0 so that clt+4k are output to sst '
    'why are you broken?'
    fnout_sst='sst_1860_ctl_p4k.nc'
    fnout_ice='ice_1860_ctl_p4k.nc'
  else
    'default: controlp4k set to 0 so that ctl case is computed'
    'controlpreg gt 0 so that clt sst are output'
    fnout_sst='sst_1860_ctl.nc'
    fnout_ice='ice_1860_ctl.nc'
  end
else
  'default: controlpreg set to 0 so that clt+reg sst are output'
  fnout_sst='newsst_preg.nc'
  fnout_ice='newice_preg.nc'
end

% read input file
f =netcdf(fin,'nowrite');
f_ice =netcdf(fin_ice,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
%-------------------------------------------------
% set up a structure(v) to hold info related to variables
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
% here we read in only the first 10 years
v.sst =f{'t_surf'} (1:120,:,:); 
v.sst_full =f{'t_surf'} (:,:,:); 
v.ice_full =f_ice{'ice_mask'} (:,:,:); 
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
%-------------------------------------------------
close(f);
close(f_ice);
%-------------------------------------------------
% read input file
% this is the control data, used for the baseline which the reg will be added to
f_sst =netcdf(fin_sst_ctl,'nowrite');
f_ice =netcdf(fin_ice_ctl,'nowrite');

v.lon=f_sst{'lon'}(:); v.lat =f_sst{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
tstart=720; % exclude the first 60 years (720)
tend=1679; % 1679-720=960 about 80 years
tint=tend-tstart+1;
v.sst_full_ctl =f_sst{'t_surf'} (tstart:tend,:,:); 
v.ice_full_ctl =f_ice{'ice_mask'} (tstart:tend,:,:); 

close(f_sst);
close(f_ice);

clear monarray;
for ti=1:12;
  monarray=v.sst_full_ctl(ti:12:tint,:,:);
  monarray_ice=v.ice_full_ctl(ti:12:tint,:,:);
  v.sst_mnthlymn(ti,:,:)=mean(monarray,1);
  v.ice_mnthlymn(ti,:,:)=mean(monarray_ice,1);
end
%-------------------------------------------------
%for ti=1:12;
%  monarray=v.sst(ti:12:120,:,:);
%  v.sst_10yrmn(ti,:,:)=mean(monarray,1);
%end
%'10yrmn_sea_surf_temp';
%size(v.sst_10yrmn);

%tempind=0;
%for i=1:nvar    
%    tempind;
%    netcdf.inqVar(ncid,tempind)
%    tempind=tempind+1;
%end

%tsurf=netcdf.getVar(ncid,7);
%'second_sea_surf_temp'
%size(tsurf)
%timearr=netcdf.getVar(ncid,8);
% the reshape command below should group the data by year, as apposed to month
% to get one year t_surf(:,:,:,year);
% to get all occurances of one month: t_surf(:,:,month,:)
% assumes all months are present in tsurf
%t_surf_yr=reshape(tsurf,[288,180,12,150]);

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

%timeslice=v.sst_full(:,lat,lon); % time series at point
%timeslicesqueeze=squeeze(timeslice);

% tm1 values are spaced by 12 to mimic 
% the goal is to grab each instance of each month
% tm1 -> jan
% tm1+1 -> feb etc. 
%tm1=1:12:length(timeslicesqueeze);
tm1=1:150;

% pre allocate needed arrays
months=zeros(12,150);
sigmay=zeros(nlon,nlat,nmon);
sigmay2=zeros(nmon,nlat,nlon);
corrcoeff=zeros(nlon,nlat,nmon);
corrcoeff2=zeros(nmon,nlat,nlon);

% compute the std of 'time'
sigxarr=std(tm1);

%% linregs is computed at a single geographic point
%%-------------------------------------------------
%for i=1:1:12
%    months(i,:)=timeslicesqueeze(i:12:1800);
%    corcof1=corrcoef(tm1,months(i,:));
%    tempcorrs(i)=corcof1(2,1);
%    sigyarr(i)=std(months(i,:));
%    linregs(i)=tempcorrs(i)*sigyarr(i)/sigxarr;
%end
%for i=1:1:12
%    months(i,:)=timeslicesqueeze(i:12:1800);
%    corcof=corrcoef(tm1,months(i,:));
%    tempcorrs(i)=corcof(2,1);
%    sigyarr(i)=std(months(i,:));
%    linregs(i)=tempcorrs(i)*sigyarr(i)/sigxarr;
%end
%month1=timeslicesqueeze(1:12:1800);
%tempcorr=corrcoef(tm1,month1);
%sigy=std(month1);
%sigx=std(tm1);
%corrc=tempcorr(2,1);
%linreg=corrc*sigy/sigx;
%testreg=251.5+linreg.*tm1;
%
%plot(tm1,testreg,tm1,months(1,:),tm1,months(2,:),tm1,months(3,:),tm1,months(4,:),tm1,months(5,:),tm1,months(6,:),tm1,months(7,:),tm1,months(8,:),tm1,months(9,:),tm1,months(10,:),tm1,months(11,:),tm1,months(12,:))
%
%%-------------------------------------------------
%% compute the standard deviation of temp globally, for each month
%% this is needed for the final reg
%% uses reg=corcoef*(std y/std x)
%%-------------------------------------------------
%for ilon=1:1:nlon
%  for ilat=1:1:nlat
%    for imonth=1:1:nmon
%      corcof2=corrcoef(tm1,v.sst_full(imonth:12:1800,ilat,ilon));
%      corrcoeff2(imonth,ilat,ilon)=corcof2(2,1);
%      sigmay2(imonth,ilat,ilon)=std(v.sst_full(imonth:12:1800,ilat,ilon));
%    end
%  end
%end
%% compute the linear regression at each point, for each month.  
%% dims: glb_linregs(nlon,nlat,nmon)
%v.glb_linregs=corrcoeff2.*(sigmay2./sigxarr);
%%v.sst_1860plusreg=4*150*v.glb_linregs+v.sst_10yrmn;
%%-------------------------------------------------
% look at global mean
%v.sst_linreg0=squeeze(mean(v.glb_linregs,1));
%v.glb_linregs0=squeeze(mean(v.glb_linregs,1));
%v.glb_linregs0scale=150*squeeze(mean(v.glb_linregs,1));
%%-------------------------------------------------
%% we also need to rearrange the dimensions to be what the model expects
%%new_glb_linregs=permute(glb_linregs,[3,2,1]);
%%
%%-------------------------------------------------
regarray=zeros(nmon,nlat,nlon);
regarray_ice=zeros(nmon,nlat,nlon);
if (controlp4k > 0 )
'controlp4k gt zero'
else
  for ilon=1:1:nlon
    for ilat=1:1:nlat
      for imonth=1:1:nmon
        p=polyfit(tm1',squeeze(v.sst_full(imonth:12:1800,ilat,ilon)),1);
        p2=polyfit(tm1',squeeze(v.ice_full(imonth:12:1800,ilat,ilon)),1);
        regarray(imonth,ilat,ilon)=p(1);
        regarray_ice(imonth,ilat,ilon)=p2(1);
      end 
    end 
  end 
end 
%part_tsurfyr(:,:)=v.sst_full(144,135,:,:);
%v.sst_1860plusreg=2*150*regarray+v.sst_mnthlymn;
%v.ice_1860plusreg=2*150*regarray_ice+v.ice_mnthlymn;
v.sst_1860plusreg=2*150*regarray+v.sst_mnthlymn;
v.ice_1860plusreg=2*150*regarray_ice+v.ice_mnthlymn;
%v.sst_1860plus4k=v.sst_mnthlymn+4.;
%v.ice_1860plus4k=v.ice_mnthlymn+4.;
if (controlpreg > 0 ) 
  if (controlp4k > 0 ) 
    'controlp4k gt 0 so that clt+4k are output to sst '
    sst_general=v.sst_mnthlymn+4.;
    ice_general=v.ice_mnthlymn+4.;
  else
    'default: controlp4k set to 0 so that ctl case is computed'
    'controlpreg gt 0 so that clt sst are output'
    sst_general=v.sst_mnthlymn;
    ice_general=v.ice_mnthlymn;
  end
else
  'default: controlpreg set to 0 so that clt+reg sst are output'
  regscale=2*150.
  'regscaled by: '
  regscale=2*150.
  sst_general=regscale*regarray+v.sst_mnthlymn;
  ice_general=regscale*regarray+v.ice_mnthlymn;
end
% sanity check, output controlpreg adn controlp4k to check with above mess
'controlpreg: '
controlpreg
'controlp4k: '
controlp4k
%-------------------------------------------------
% check what the global mean value of the regressed pattern is
% compute the global mean with lat weights
% sum(array(:)) returns sum of all elements in A
glblatweight=v.latweight;
for index=1:287;
    glblatweight=horzcat(glblatweight,v.latweight);
end
%v.sst_10yrmn0=squeeze(mean(v.sst_10yrmn,1));
glbsumweight=sum(glblatweight(:));

%glbbasedata=v.sst_10yrmn0.*glblatweight;
%glbregdata=v.sst_linreg0.*glblatweight;
%glbregsum=sum(glbregdata(:));
%globmean1=sum(v.sst_mn0.*A)/glbsumweight
%v.sst_1860ctl=squeeze(mean(v.sst_1860plusreg,1));
'global mean of 1860'
v.sst_1860ctl0=squeeze(mean(v.sst_mnthlymn,1));
glbdatactl=v.sst_1860ctl0.*glblatweight;
glbsumctl=sum(glbdatactl(:));
globmean_ctl=glbsumctl/glbsumweight
'global mean of 1860 plus 150x regression before masaging'
v.sst_1860plusreg0=squeeze(mean(v.sst_1860plusreg,1));
glbdatareg=v.sst_1860plusreg0.*glblatweight;
glbsum=sum(glbdatareg(:));
globmean_ctlpreg=glbsum/glbsumweight
%
%globregmean1=glbregsum/glbsumweight
%-------------------------------------------------
% because t_surf is not sst over land or ice a bit 
% of data masaging is necessary....
% -never allow negative sea ice fractions
% -never allow sst to drop below lowbndsst
% -adjust for cells with partial ice cover
%-------------------------------------------------
%lowbndsst=271.25 % Kelvin low bound for sst
lowbndsst=273.15 % 0 deg C
%zeroc=273.15 % Kelvin
delT=1.9 % app diff btwn 0C & freezing point of sea water
lowbndice=0.0 % low bound for ice (fraction)
% deal with ice problems
for ilon=1:1:nlon
  for ilat=1:1:nlat
    for imonth=1:1:nmon
      %if (controlpreg > 0 ) 
        %if (v.ice_mnthlymn(imonth,ilat,ilon) < lowbndice)
      if (ice_general(imonth,ilat,ilon) < lowbndice)
        ice_general(imonth,ilat,ilon) = lowbndice;
      end
      %else % default case, ctl + reg
        %if (v.ice_1860plusreg(imonth,ilat,ilon) < lowbndice)
        %  v.ice_1860plusreg(imonth,ilat,ilon) = lowbndice;
        %end
      %end
    end
  end	       
end
% account for fractionally ice-covered cells 
%if (controlpreg > 0 ) 
%  v.sst_mnthlymn=v.sst_mnthlymn-delT*v.ice_mnthlymn;
%else
%  v.sst_1860plusreg=v.sst_1860plusreg-delT*v.ice_1860plusreg;
% should this go after or before the sst block? i think after
%sst_general=sst_general-delT*ice_general;
%end
% deal with sst problems
for ilon=1:1:nlon
  for ilat=1:1:nlat
    for imonth=1:1:nmon
      %if (controlpreg > 0 ) 
        %if (v.sst_mnthlymn(imonth,ilat,ilon) < lowbndsst)
        if (sst_general(imonth,ilat,ilon) < lowbndsst)
          %v.sst_mnthlymn(imonth,ilat,ilon) = lowbndsst;
          sst_general(imonth,ilat,ilon) = lowbndsst;
        end
      %else % default case
      %  if (v.sst_1860plusreg(imonth,ilat,ilon) < lowbndsst)
      %    v.sst_1860plusreg(imonth,ilat,ilon) = lowbndsst;
      %  end
      %end
    end
  end	       
end
% should this go after or before the sst block? i think after
sst_general=sst_general-delT*ice_general;

% should the ice be 1860plusreg or ice_mnthlymn?
% below should be a possibility but it seems a bit more artificial
% due to the zeroc term... this seems to matter in regions with 
% regularly fluctuating ice content...
%for ilon=1:1:nlon
%  for ilat=1:1:nlat
%    for imonth=1:1:nmon
%      if (v.ice_1860plusreg(imonth,ilat,ilon) > lowbndice)
%        v.sst_1860plusreg(imonth,ilat,ilon) = zeroc-delT*v.ice_1860plusreg(imonth,ilat,ilon);
%      end
%    end
%  end	       
%end
% compute the diff from the masaging
%sst_diff=v.sst_1860plusregsimple-v.sst_1860plusreg;
%sst_diff0=squeeze(mean(sst_diff,1));
%figure; contourf(v.lon,v.lat,sst_diff0);colorbar
%-------------------------------------------------
'global mean of 1860 plus 150x regression after masaging'
v.sst_1860plusreg0=squeeze(mean(v.sst_1860plusreg,1));
glbdatareg=v.sst_1860plusreg0.*glblatweight;
glbsum=sum(glbdatareg(:));
globmean_ctlpreg=glbsum/glbsumweight
%-------------------------------------------------
'global mean of simple 1860 plus 150x regression after masaging'
v.sst_1860plusregs0=squeeze(mean(v.sst_1860plusreg,1));
glbdataregs=v.sst_1860plusregs0.*glblatweight;
glbsums=sum(glbdataregs(:));
globmean_ctlpregs=glbsums/glbsumweight
%%-------------------------------------------------
%% create a few figures to see what we are doing
%%v.sst_10yrmn0=squeeze(mean(v.sst_10yrmn,1));
%%figure; contourf(v.lon,v.lat,v.sst_10yrmn0);colorbar;
%figure; contourf(v.lon,v.lat,v.sst_1860ctl0);colorbar
%%v.sst_1860plusreg0=squeeze(mean(v.sst_1860plusreg,1));
%figure; contourf(v.lon,v.lat,v.sst_1860plusreg0);colorbar;
%figure; contourf(v.lon,v.lat,v.sst_1860plusregs0);colorbar;
%% look at the spacial pattern of the regression values....
%regarray_ice_janj=regarray_ice(1,:,:);
%regarray_ice_jan=squeeze(regarray_ice_janj);
%figure; contourf(v.lon,v.lat,regarray_ice_jan);colorbar;
%regarray_sst_janj=regarray(1,:,:);
%regarray_sst_jan=squeeze(regarray_sst_janj);
%figure; contourf(v.lon,v.lat,regarray_sst_jan);colorbar;
%-------------------------------------------------
% create a new netcdf file
nc = netcdf(fnout_sst,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

%if (controlp4k .eq. 0 ) 
%  if (controlpreg > 0 ) 
%	'writing 1860 ctl sst to sst variable! '
%    nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=v.sst_mnthlymn(:,:,:);
    nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=sst_general(:,:,:);
%  else
%	'writing 1860 ctl plus regression to sst to sst variable! '
%    nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=v.sst_1860plusreg(:,:,:);
%  end
%else
%	'writing 1860 plus 4k sst to sst variable! '
%  nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=v.sst_1860plus4k(:,:,:);
%end
%nc{'sst'}=ncfloat('time','lat','lon'); nc{'sst'}(:,:,:)=tsurf(:,:,1:12);
%nc{'climatology_bounds'} = ncdouble('time','nv'); 
%nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
%nc{'time'}.climatology   ='climatology_bounds';      
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

% create a new netcdf file

nc = netcdf(fnout_ice,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified ice pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('time')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'time'}  = ncdouble('time'); nc{'time'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

%if (controlp4k .eq. 0 ) 
%  if (controlpreg > 0 ) 
%	'writing 1860 ctl ice to ice variable! '
%    nc{'ice'}=ncfloat('time','lat','lon'); nc{'ice'}(:,:,:)=v.ice_mnthlymn(:,:,:);
    nc{'ice'}=ncfloat('time','lat','lon'); nc{'ice'}(:,:,:)=ice_general(:,:,:);
%  else
%	'writing 1860 plus regression ice to ice variable! '
%    nc{'ice'}=ncfloat('time','lat','lon'); nc{'ice'}(:,:,:)=v.ice_1860plusreg(:,:,:);
%  end
%else
%	'writing 1860 ctl ice to ice variable for p4k exp! '
%  nc{'ice'}=ncfloat('time','lat','lon'); nc{'ice'}(:,:,:)=v.ice_mnthlymn(:,:,:);
%end
%nc{'t_surf'}=ncfloat('time','lat','lon'); nc{'t_surf'}(:,:,:)=tsurf(:,:,1:12);
%nc{'climatology_bounds'} = ncdouble('time','nv'); 
%nc{'climatology_bounds'}(:,:)=v.climatology_bounds(:,:);
nc{'yr'} = ncint('idim'); nc{'yr'}(:)=v.yr;
nc{'mo'} = ncint('idim'); nc{'mo'}(:)=v.mo;
nc{'dy'} = ncint('idim'); nc{'dy'}(:)=v.dy;
nc{'average_T1'} = ncdouble('time'); nc{'average_T1'}(:)=v.average_T1;
nc{'average_T2'} = ncdouble('time'); nc{'average_T2'}(:)=v.average_T2;
nc{'average_DT'} = ncdouble('time'); nc{'average_DT'}(:)=v.average_DT;
nc{'nrecords'} = ncint();  nc{'nrecords'}(:)=12;

nc{'time'}.long_name     ='Time';      
%nc{'time'}.climatology   ='climatology_bounds';      
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

nc{'ice'}.long_name     ='fractional amount of sea ice';
nc{'ice'}.standard_name ='ice_mask';
nc{'ice'}.units         ='none';      
nc{'ice'}.add_offset    = 0.e0;
nc{'ice'}.scale_factor  = 1.e0;
nc{'ice'}.FillValue_    =-1.e+20;
% matlab for some reason doesn't like the notation below...
%nc{'ice'}.valid_range   =-0.01f, +1.01f;
nc{'ice'}.missing_value =-1.e+20;
nc{'ice'}.description   ='HadIice_mask 1.1 monthly average sea surface temperature';
nc{'ice'}.cell_methods  ='time: mean';
nc{'ice'}.time_avg_info ='average_T1,average_T2,average_DT';

nc{'average_T1'}.long_name ='Start time for average period';
nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_T2'}.long_name ='End time for average period';
nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      

nc{'average_DT'}.long_name ='Length of average period';
nc{'average_DT'}.units     ='days';      

close(nc); 

