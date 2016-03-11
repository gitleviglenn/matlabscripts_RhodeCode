%----------------------------------------------------------------------------
% plot_temp.m
%
% read in data from a historical and control run.  plot several manifistations
% of the data.  
% 
% compute a simple linear regression of the data
%
% compute a running mean
%
% there are two ways of computing the temperature trend via regression.
% one way results in a reg coeff in [K/yr]
% another way results in a reg coeff in [K/K]
%
% it is not clear to me which should be used
%
% we want to generate T_i, del(T_i), bar(T), and del(bar(T))
% where i is the geographic location, bar is a global mean, and del is the 
% difference in time.
%
% levi silvers                                        Feb 2016
%----------------------------------------------------------------------------
% the two files below are from the historical run...
%fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc'
fin_tref='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_ref.nc'
%fin_ice='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.ice_mask.nc'
%% the two files below are from the 1860 control run....
%fin_sst_ctl='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_surf.nc'
%fin_ice_ctl='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.ice_mask.nc'
fin='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.t_surf.nc'
fin_ice='/archive/Ming.Zhao/awgom2/ulm_201505/AM4OM2F_c96l32_am4g6_1860climo/ts_all/atmos.000101-014012.ice_mask.nc'

% read input file
% note the historical file has 1800 time steps, the ctl has 1680
f =netcdf(fin,'nowrite');
f_tref =netcdf(fin_tref,'nowrite');
f_ice =netcdf(fin_ice,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
%-------------------------------------------------
% set up a structure(v) to hold info related to variables
tend=1800;
nmon=12;
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
% here we read in only the first 10 years
%v.sst =f{'t_surf'} (1:120,:,:); 
v.sst_full =f{'t_surf'} (:,:,:); 
v.tref_full =f_tref{'t_ref'} (:,:,:); % this is the 2m temp
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
close(f_tref);
%-------------------------------------------------
%% read input file
%% this is the control data, used for the baseline which the reg will be added to
%f_sst =netcdf(fin_sst_ctl,'nowrite');
%f_ice =netcdf(fin_ice_ctl,'nowrite');
%
%v.lon=f_sst{'lon'}(:); v.lat =f_sst{'lat'}(:);
%v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
%tstart=720; % exclude the first 60 years (720)
%tend=1679; % 1679-720=960 about 80 years
%tint=tend-tstart+1;
%v.sst_full_ctl =f_sst{'t_surf'} (tstart:tend,:,:); 
%v.ice_full_ctl =f_ice{'ice_mask'} (tstart:tend,:,:); 
%
%close(f_sst);
%close(f_ice);

%clear monarray;
%% reorganize data 
%for ti=1:12;
%  monarray=v.sst_full_ctl(ti:12:tint,:,:);
%  monarray_ice=v.ice_full_ctl(ti:12:tint,:,:);
%  v.sst_mnthlymn(ti,:,:)=mean(monarray,1);
%  v.ice_mnthlymn(ti,:,:)=mean(monarray_ice,1);
%end
%-------------------------------------------------
% check what the global mean value of the regressed pattern is
% compute the global mean with lat weights
% sum(array(:)) returns sum of all elements in A
glblatweight=v.latweight;
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
%v.sst_10yrmn0=squeeze(mean(v.sst_10yrmn,1));
glbsumweight=sum(glblatweight(:));

%%glbbasedata=v.sst_10yrmn0.*glblatweight;
%%glbregdata=v.sst_linreg0.*glblatweight;
%%glbregsum=sum(glbregdata(:));
%%globmean1=sum(v.sst_mn0.*A)/glbsumweight
%%v.sst_1860ctl=squeeze(mean(v.sst_1860plusreg,1));
%'global mean of 1860'
%v.sst_1860ctl0=squeeze(mean(v.sst_mnthlymn,1));
%glbdatactl=v.sst_1860ctl0.*glblatweight;
%glbsumctl=sum(glbdatactl(:));
%globmean_ctl=glbsumctl/glbsumweight
%%globregmean1=glbregsum/glbsumweight
%-------------------------------------------------
% generate a time series of global mean mnthly values
sst_ts_wgt=zeros(tend,v.nlat,v.nlon);
v.sst_prime=zeros(tend,v.nlat,v.nlon);
sst_ts=zeros(tend,1);
for ti=1:tend;
  sst_temp=v.sst_full(ti,:,:);
  sst_ts_wgt2 = squeeze(sst_temp).*glblatweight;
  mn_sst_ts(ti)=sum(sst_ts_wgt2(:))/glbsumweight;
  tref_temp=v.tref_full(ti,:,:);
  tref_ts_wgt = squeeze(tref_temp).*glblatweight;
  mn_tref_ts(ti)=sum(tref_ts_wgt(:))/glbsumweight;
end
% save global mean time series in v
v.tref_mn_ts=mn_tref_ts;
v.sst_mn_ts=mn_sst_ts;
%-------------------------------------------------
% generate a time series of ref temp at one location
onelat=90;
onelat=144;
tref_location_ts=v.tref_full(:,onelat,onelat);
v.tref_location=tref_location_ts;
%%-------------------------------------------------
% compute T'
% compute temperature perturbations at each point
% from global mean temper
for ilon=1:1:v.nlon
  for ilat=1:1:v.nlat
    for ti=1:tend
      v.sst_prime(ti,ilat,ilon)=v.sst_full(ti,ilat,ilon)-v.sst_mn_ts(ti);
    end
  end 
end
%%-------------------------------------------------
% compute del(bar(T))
% I am not sure what this is good for... 
for ti=2:tend
  v.del_sst_mn_ts(ti)=v.sst_mn_ts(ti)-v.sst_mn_ts(ti-1);
end
%%-------------------------------------------------
% compute regression
% I think that somehow the seasonal cycle is messing this up...
regarray=zeros(v.nlat,v.nlon);
for ilon=1:1:v.nlon
  for ilat=1:1:v.nlat
    %p3=polyfit(v.del_sst_mn_ts',squeeze(v.del_sst_full(:,ilat,ilon)),1);
    p3=polyfit(v.sst_mn_ts',squeeze(v.sst_prime(:,ilat,ilon)),1);
    regarray(ilat,ilon)=p3(1); %[K/K]
  end
end
%%-------------------------------------------------
regarray_mn=zeros(nmon,v.nlat,v.nlon);
for ilon=1:1:v.nlon
  for ilat=1:1:v.nlat
    for imonth=1:1:nmon
      %p4=polyfit(v.del_sst_mn_ts(imonth:12:1800)',squeeze(v.sst_full(imonth:12:1800,ilat,ilon)),1);
      p4=polyfit(v.sst_mn_ts(imonth:12:tend)',squeeze(v.sst_prime(imonth:12:tend,ilat,ilon)),1);
      regarray_mn(imonth,ilat,ilon)=p4(1); %[K/K]
    end 
  end 
end 
yrmn=squeeze(mean(regarray_mn,1));
figure; contourf(yrmn,[-1,0,1,2,3,4]); colorbar;
% possible predifined colormaps: copper, summer, jet(default)
% to create a custom colormap
cmap=[1 1 1 ; .8 .8 1 ; .6 .6 1 ; .4 .4 1 ; .2 .2 1 ; 0 0 1];
colormap(cmap(1:5,:))
%%-------------------------------------------------
% compute the global mean of yrmn
regweight=yrmn.*glblatweight;
globalmeanreg=sum(regweight(:))/glbsumweight
%%-------------------------------------------------
%% generate a time series of global mean yearly values
%sst_full_yr=reshape(v.sst_full,[180,288,12,150]);
%tref_full_yr=reshape(v.tref_full,[180,288,12,150]);
%% compute yearly mean
%sst_full_yrmn=squeeze(mean(sst_full_yr,3));
%tref_full_yrmn=squeeze(mean(tref_full_yr,3));
%% compute global mean of yearly mean data
%for ti=1:150 % something doesn't look right in the result
%  sst_temp=sst_full_yrmn(:,:,ti);
%  sst_glb_wgt = squeeze(sst_temp).*glblatweight;
%  sst_yr_ts(ti)=sum(sst_glb_wgt(:))/glbsumweight;
%  tref_temp=tref_full_yrmn(:,:,ti);
%  tref_glb_wgt = squeeze(tref_temp).*glblatweight;
%  tref_yr_ts(ti)=sum(tref_glb_wgt(:))/glbsumweight;
%end
%%-------------------------------------------------
% print out some info
min_glbtemp=min(mn_sst_ts)
max_glbtemp=max(mn_sst_ts)
min_early_period_glbtemp=min(mn_sst_ts(1:120))
min_late_period_glbtemp=min(mn_sst_ts(1668:1788))
diff_glbtemp=min_late_period_glbtemp-min_early_period_glbtemp
% as computed here the regression is in units of K/K and corresponds
% the temperature response to a global mean warming of 1K.  To show 
% actual theoretical response we need to multiply this rate by the 
% amount of warminmean which we have over the given period.  
total_response=v.sst_mn_ts*diff_glbtemp;
%%-------------------------------------------------
% compute a running mean
tendindex=tend;
rough_ts=mn_tref_ts;
%for ti=3:tendindex-2
%  ts_smooth(ti-2)=(rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2))/5.;
%end
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
sm_tref_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
rough_ts=mn_sst_ts;
for ti=7:tendindex-6
  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
end
sm_sst_ts=ts_smooth;
%%-------------------------------------------------
% convert to celcius for comparison: 
sm_sst_ts=sm_sst_ts-273.15;
sm_tref_ts=sm_tref_ts-273.15;
%%-------------------------------------------------
p1=plot(sm_tref_ts)
ylabel('glb mn 2m temp')
set(p1,'Color','black','Linewidth',1)
hold all
p2=plot(sm_sst_ts)
ylabel('glb mn sst')
set(p2,'Color','red','Linewidth',1)
%%----------------------------------
% plot a contour figur of the regression pattern
figure; contourf(v.lon,v.lat,squeeze(regarray_mn(10,:,:)));colorbar;
