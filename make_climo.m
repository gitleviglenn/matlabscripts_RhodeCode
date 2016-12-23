%----------------------------------------------------------------------------
% make_climo.m
%
% this script creates a climatology data set for sst and ice.  this means that
% the output should have 12 time steps, one for each month.  
%
% file(s) are read with sst and ice data over some range of times.  The desired 
% range is selected, and the climatological mean values are then computed for 
% each month.  
%
% levi silvers                                        july 2016
%----------------------------------------------------------------------------
%
% the two files below are from the 2000 control run....
% for am4g5r11
%fin_sst_ctl='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/atmos.000101-014012.t_surf.nc'
%fin_ice_ctl='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/atmos.000101-014012.ice_mask.nc'
% remapped versions of above files
fin_sst_ctl='/archive/Levi.Silvers/sstpatt/fromMing/AM4OM2F_c96l32_am4g5r11_2000climo_atmos.000101-014012.t_surf_r360x180.nc'
fin_ice_ctl='/archive/Levi.Silvers/sstpatt/fromMing/AM4OM2F_c96l32_am4g5r11_2000climo_atmos.000101-014012.ice_mask_r360x180.nc'

%% the two files below are from a 1% CO2 increase per year run
fin='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/atmos.006101-014012.t_surf.nc'
fin_ice='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/atmos.006101-014012.ice_mask.nc'
% remapped versions of above files
%fin='/archive/Levi.Silvers/sstpatt/fromMing/AM4OM2F_c96l32_am4g5r11_2000climo_1pct_atmos.006101-014012.t_surf_r360x180.nc'
%fin_ice='/archive/Levi.Silvers/sstpatt/fromMing/AM4OM2F_c96l32_am4g5r11_2000climo_1pct_atmos.006101-014012.ice_mask_r360x180.nc'
%lengthmon=960;

fin_had_sst='/archive/Levi.Silvers/input/sst.climo.1981-2000.data.nc'
fin_had_ice='/archive/Levi.Silvers/input/ice.climo.1981-2000.data.nc'

% we also may need the land sea mask...
fstatic='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/atmos.static.nc'

  % read input files
f =netcdf(fin,'nowrite');
f_ice =netcdf(fin_ice,'nowrite');
f_static =netcdf(fstatic,'nowrite');
  % data from hadley center
f_had_sst=netcdf(fin_had_sst,'nowrite');
f_had_ice=netcdf(fin_had_ice,'nowrite');
had_sst =f_had_sst{'SST'} (:,:,:); 
had_ice =f_had_ice{'ICE'} (:,:,:); 
%-------------------------------------------------
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
sst_forced_alltime=f{'t_surf'} (:,:,:);
tstart=721; 
tend=960; 
lengthmon=tend-tstart;
tint=tend-tstart+1;
v.sst_forced =f{'t_surf'} (tstart:tend,:,:); 
v.ice_forced =f_ice{'ice_mask'} (tstart:tend,:,:); 
v.landmask =f_static{'land_mask'} (:,:);
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.average_T1 =f{'average_T1'} (:);
v.average_T2 =f{'average_T2'} (:);
v.average_DT =f{'average_DT'} (:);
v.time = [47528.5 47559.5 47590 47619.5 47650 47680.5 47711 47741.5 47772.5 47803 47833.5 47864];
v.nt=12;
v.yr=[0 0 0 0 0 0 0 0 0 0 0 0];
v.mo=[1 2 3 4 5 6 7 8 9 10 11 12];
v.dy=[0 0 0 0 0 0 0 0 0 0 0 0] ;
v.average_T1=[40224.5 40255.5 40285 40314.5 40345 40375.5 40406 40436.5 40467.5 40498 40528.5 40559];
v.average_T2=[47528.5 47559.5 47590 47619.5 47650 47680.5 47711 47741.5 47772.5 47803 47833.5 47864];
v.average_DT=[7300 7300 7300 7300 7300 7300 7300 7300 7300 7300 7300 7300];
%-------------------------------------------------
%-------------------------------------------------
clear monarray;
clear monarray_ice;
for ti=1:12; % this should create the climatology data
  monarray=v.sst_forced(ti:12:tint,:,:);
  monarray_ice=v.ice_forced(ti:12:tint,:,:);
  v.sst_mnthlymn(ti,:,:)=mean(monarray,1);
  v.ice_mnthlymn(ti,:,:)=mean(monarray_ice,1);
end
% the final ice concentration needs to be a percentage
v.ice_mnthlymn=100.0*v.ice_mnthlymn;

sst_forced=v.sst_mnthlymn;
ice_forced=v.ice_mnthlymn;

%%-------------------------------------------------
%% read input file for control data
%%-------------------------------------------------
%% this is the control data, used for the baseline which the reg 
f_sst_ctl =netcdf(fin_sst_ctl,'nowrite');
f_ice_ctl =netcdf(fin_ice_ctl,'nowrite');

v.lon=f_sst_ctl{'lon'}(:); v.lat =f_sst_ctl{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;

close(f);
close(f_ice);
tstart=1441; 
tend=1680; 
tint=tend-tstart+1;
sst_ctl_alltime=f_sst_ctl{'t_surf'} (:,:,:);
v.sst_full_ctl =f_sst_ctl{'t_surf'} (tstart:tend,:,:); 
v.ice_full_ctl =f_ice_ctl{'ice_mask'} (tstart:tend,:,:); 

close(f_sst_ctl);
close(f_ice_ctl);

clear monarray;
clear monarray_ice;
for ti=1:12; % this should create the climatology data
  monarray=v.sst_full_ctl(ti:12:tint,:,:);
  monarray_ice=v.ice_full_ctl(ti:12:tint,:,:);
  v.sst_ctl_mnthlymn(ti,:,:)=mean(monarray,1);
  v.ice_ctl_mnthlymn(ti,:,:)=mean(monarray_ice,1);
end
% the final ice concentration needs to be a percentage
v.ice_ctl_mnthlymn=100.0*v.ice_ctl_mnthlymn;

% these are the control data
sst_ctl=v.sst_ctl_mnthlymn;
ice_ctl=v.ice_ctl_mnthlymn;
%-------------------------------------------------
%-------------------------------------------------

%% the reshape command below should group the data by year, as apposed to month
%% to get one year t_surf(:,:,:,year);
%% to get all occurances of one month: t_surf(:,:,month,:)
%% assumes all months are present in tsurf
%%t_surf_yr=reshape(tsurf,[288,180,12,150]);
%
%% define lat/lon which will be used for the timeslice
%latfull=1:1:180;
%lonfull=1:1:288;
%lat=90.;
%lon=100.;
%% indexing end points
%nlon=288;
%nlat=180;
%nyr=150;
%nmon=12;
%
%% pre allocate needed arrays
%months=zeros(12,150);
%
%%-------------------------------------------------
%% compute lat weights for the global mean 
%%-------------------------------------------------
%% sum(array(:)) returns sum of all elements in A
%glblatweight=v.latweight;
%for index=1:287;
%    glblatweight=horzcat(glblatweight,v.latweight);
%end
%glbsumweight=sum(glblatweight(:));
%
%% generate a time series of global mean mnthly values
%sst_ts_wgt=zeros(lengthmon,v.nlat,v.nlon);
%v.sst_prime=zeros(lengthmon,v.nlat,v.nlon);
%sst_ts=zeros(lengthmon,1);
%for ti=1:lengthmon;
%  sst_temp=v.sst_full(ti,:,:);
%  sst_ts_wgt2 = squeeze(sst_temp).*glblatweight;
%  mn_sst_ts(ti)=sum(sst_ts_wgt2(:))/glbsumweight;
%end
%% save global mean time series in v
%v.sst_mn_ts=mn_sst_ts;
%v.sst_mn_t=sum(mn_sst_ts(:))/lengthmon;
%% compute temperature perturbations at each point
%% from global mean temper
%for ilon=1:1:v.nlon
%  for ilat=1:1:v.nlat
%    for ti=1:lengthmon
%      v.sst_prime(ti,ilat,ilon)=v.sst_full(ti,ilat,ilon)-v.sst_mn_ts(ti);
%      v.sst_prime2(ti,ilat,ilon)=v.sst_full(ti,ilat,ilon)-v.sst_mn_t;
%    end
%  end 
%end
%%-------------------------------------------------
%%-------------------------------------------------

