%---------------------------------------------------------------------------------------
% budget_1cfsite.m
%---------------------------------------------------------------------------------------
% purpose:   quick look at data from a particular grid point.
%
%            the data and location of the station are based on
%            the cfSites component from cfmip3
%
%            check the moisture and temperature budgets
%
%            quality control and check the varaibles from the cf diag_table
%
% levi silvers                                                    sep 2017
%---------------------------------------------------------------------------------------

path='/archive/Levi.Silvers/awg/warsaw/c96L33_am4p0_cmip6Diag_oldcfsite_nocosp_2sites/gfdl.ncrc3-intel-prod-openmp/history/'
%%fileincming='19840101.atmos_station_001.tile5.nc'
%
fileincming='19800101.atmos_station_001.tile5.nc'
%fileincming='19800101.atmos_station_120.tile5.nc'
%fileincming='19830101.atmos_station_120.tile5.nc'

statstring='Station 001';

source_file=strcat(path,fileincming);

fin_total=netcdf(source_file,'nowrite');

pfull=fin_total{'pfull'};
phalf=fin_total{'phalf'};
ta=fin_total{'temp'}; % temperature
hus=fin_total{'sphum'}; % specific humidity 
hur=fin_total{'rh_cmip'}; % relative humidity 
% temp tends
tnt_dyn=fin_total{'tdt_dyn'}; % K/s from dynamics?  does this include advection or dissipation?
tnt_vdif=fin_total{'tdt_vdif'}; % K/s temp tend from vert diff 
tntc=fin_total{'tdt_conv'}; % temp tend from conv deg/s
tntls=fin_total{'tdt_ls'}; % K/s temp tend from strat cloud deg/s
tnt_topo=fin_total{'tdt_diss_topo'};
tnt_rad=fin_total{'allradp'}; % K/s temp tend from sw+lw radiation
tnt_phy=fin_total{'tdt_phys'}; % K/s temp tend from physics deg/s

% specific hum tends
qdt_vdif=fin_total{'qdt_vdif'}; % kg/kg/s spec hum from vert diff
qdt_ls=fin_total{'qdt_ls'}; % kg/kg/s  spec hum tend from strat clouds
qdt_dyn=fin_total{'qdt_dyn'}; % kg/kg/s spec hum tend from 
qdt_conv=fin_total{'qdt_conv'}; % kg/kg/s spec hum tend from convection


% tendencies are in units of blah blah per second.  Output is every halfhour
conv=1800.;
%timest=1750;
timest=2;

% these correspond to the actual profiles, that should be matched by adding tendencies
husdiff=hus(timest,:,1,1)-hus(timest-1,:,1,1);
tadiff=ta(timest,:,1,1)-ta(timest-1,:,1,1);

% compute time series
vlev=5;
timeone=20;
timetwo=100;
for timei=1:200;
  tadiff_fullts(timei)=ta(timei,vlev,1,1)-ta(timei-1,vlev,1,1);
  husdiff_fullts(timei)=hus(timei,vlev,1,1)-hus(timei-1,vlev,1,1);
end
tadiff_ts=squeeze(tadiff_fullts(timeone:timetwo));
husdiff_ts=squeeze(husdiff_fullts(timeone:timetwo));

% specific humidity tendency terms
qdtcheck=conv*(qdt_ls(timest,:,1,1)+qdt_dyn(timest,:,1,1)+qdt_conv(timest,:,1,1)+qdt_vdif(timest,:,1,1));
qdtcheck_ts=conv*(qdt_ls(timeone:timetwo,vlev,1,1)+qdt_dyn(timeone:timetwo,vlev,1,1)+qdt_conv(timeone:timetwo,vlev,1,1)+qdt_vdif(timeone:timetwo,vlev,1,1));

% temperature tendency terms
% dyn 
% rad + c + ls + vdif + topo
%tdtcheck= conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1) ...
%               +tntc(timest,:,1,1)   +tntls(timest,:,1,1)   ...
%               +tnt_vdif(timest,:,1,1)+tnt_topo(timest,:,1,1));
% dyn 
% rad + c + ls + vdif
tdtcheck= conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1) ...
               +tntc(timest,:,1,1)+tntls(timest,:,1,1) ...
	       +tnt_vdif(timest,:,1,1));
% dyn 
% phy + vdif
tdtcheck2=conv*(tnt_phy(timest,:,1,1)+tnt_dyn(timest,:,1,1) ...
               +tnt_vdif(timest,:,1,1));
% dyn 
% rad + c + ls 
tdtcheck3=conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1) ...
               +tntc(timest,:,1,1)+tntls(timest,:,1,1));
% dyn 
% phy  
tdtcheck4=conv*(tnt_phy(timest,:,1,1)+tnt_dyn(timest,:,1,1));

% time series...
tdtcheck4_ts=conv*(tnt_phy(timeone:timetwo,vlev,1,1)+tnt_dyn(timeone:timetwo,vlev,1,1));

newvf=pfull(:,1,:);

figure
plot(squeeze(husdiff),newvf,'k','Linewidth',2)
set(gca,'Ydir','reverse')
hold on
plot(squeeze(qdtcheck),newvf,'--g')
titlestr=strcat(statstring,': moisture budget tendency [kg/kg per 30 min]')
title(titlestr)

figure
plot(squeeze(tadiff),newvf,'k','Linewidth',2)
set(gca,'Ydir','reverse')
hold on
plot(squeeze(tdtcheck4),newvf,'--g')
plot(squeeze(tdtcheck),newvf,'--r')
titlestr=strcat(statstring,': temp budget tendency [K per 30 min]');
title(titlestr)

figure
plot(squeeze(tadiff_ts),'k','Linewidth',2)
hold on
plot(squeeze(tdtcheck4_ts),'--g')
titlestr=strcat(statstring,': temp budget tendency [K per 30 min]');
title(titlestr)

hold off
