%----------------------------------------------------------------------------
% plot_temp.m
%
% read in data from a historical and control run.  plot several manifistations
% of the data.  
%
% we want to generate T_i, del(T_i), bar(T), and del(bar(T))
% where i is the geographic location, bar is a global mean, and del is the 
% difference in time.
%
% levi silvers                                        Feb 2016
%----------------------------------------------------------------------------
% the two files below are from the historical run...
fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc'
fin_tref='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_ref.nc'
fin_ice='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.ice_mask.nc'

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
%-------------------------------------------------
close(f);
close(f_ice);
close(f_tref);
%-------------------------------------------------
% check what the global mean value of the regressed pattern is
% compute the global mean with lat weights
% sum(array(:)) returns sum of all elements in A
glblatweight=v.latweight;
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));

%-------------------------------------------------
% generate a time series of global mean mnthly values
sst_ts_wgt=zeros(tend,v.nlat,v.nlon);
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
% compute del(T)
for ilon=1:1:v.nlon
  for ilat=1:1:v.nlat
    for ti=2:tend
      v.del_sst_full(ti,ilat,ilon)=v.sst_full(ti,ilat,ilon)-v.sst_full(ti-1,ilat,ilon);
    end
  end 
end
%%-------------------------------------------------
% compute del(bar(T))
for ti=2:tend
  v.del_sst_mn_ts(ti)=v.sst_mn_ts(ti)-v.sst_mn_ts(ti-1);
end
%%-------------------------------------------------
% compute regression
regarray=zeros(v.nlat,v.nlon);
for ilon=1:1:v.nlon
  for ilat=1:1:v.nlat
    p3=polyfit(v.del_sst_mn_ts',squeeze(v.del_sst_full(:,ilat,ilon)),1);
    regarray(ilat,ilon)=p3(1);
  end
end
%%-------------------------------------------------
%figure; contourf(yrmn,[-1,0,1,2,3,4]); colorbar;
%% possible predifined colormaps: copper, summer, jet(default)
%% to create a custom colormap
%cmap=[1 1 1 ; .8 .8 1 ; .6 .6 1 ; .4 .4 1 ; .2 .2 1 ; 0 0 1];
%colormap(cmap(1:5,:))
%%-------------------------------------------------
% compute a running mean
rough_ts=mn_tref_ts;
tendindex=tend;
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
