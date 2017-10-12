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

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_CF_Master_psite/gfdl.ncrc3-intel-prod-openmp/history/'
%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_CF_Master_psite_001/gfdl.ncrc3-intel-prod-openmp/history/'

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_psite_001/gfdl.ncrc3-intel-prod-openmp/history/'
%fileincming='00100101.atmos_station_001.tile5.nc'

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_psite_001_b/gfdl.ncrc3-intel-prod-openmp/history/'
%fileincming='00010101.atmos_station_001.tile5.nc'

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_psite_001_c/gfdl.ncrc3-intel-prod-openmp/history/'
%fileincming='00010101.atmos_station_001.tile5.nc'
%path='/archive/Levi.Silvers/awg/warsaw/c96L33_am4p0_cmip6Diag_oldcfsite_nocosp/gfdl.ncrc3-intel-prod-openmp/history/'
path='/archive/Levi.Silvers/awg/warsaw/c96L33_am4p0_cmip6Diag_oldcfsite_nocosp_2sites/gfdl.ncrc3-intel-prod-openmp/history/'
%fileincming='19840101.atmos_station_001.tile5.nc'

fileincming='19800101.atmos_station_001.tile5.nc'
fileincming='19800101.atmos_station_120.tile5.nc'
fileincming='19830101.atmos_station_120.tile5.nc'


source_file=strcat(path,fileincming);
statstring='Station 120';

fin_total=netcdf(source_file,'nowrite');

%for first file/station
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

%cl=fin_total{'cl'}; % cloud area
%clw=fin_total{'clw'}; % liquid amount -- all clouds
%cli=fin_total{'cli'}; % ice amount -- all clouds
%mc=fin_total{'mc'}; % net mass flux from convection
%ta=fin_total{'ta'}; % temperature
%ta=fin_total{'temp'}; % temperature
%ua=fin_total{'ua'}; % zonal wind 
%va=fin_total{'va'}; % meridional wind 
%hus=fin_total{'sphum'}; % specific humidity 
%hur=fin_total{'rh_cmip'}; % relative humidity 
%omega=fin_total{'wap'}; % omega Pa/s
%rsu=fin_total{'rsu'}; % 
%rsd=fin_total{'rsd'}; % 
%rsucs=fin_total{'rsucs'}; 
%rsdcs=fin_total{'rsdcs'}; 


% tendencies are in units of blah blah per second.  Output is every halfhour
conv=1800.;
%timest=1750;
timest=2;

husdiff=hus(timest,:,1,1)-hus(timest-1,:,1,1);
tadiff=ta(timest,:,1,1)-ta(timest-1,:,1,1);
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
%tdtcheck=conv*(tnta(timest,:,1,1)+tntc(timest,:,1,1)+tntls(timest,:,1,1)+tntvdif(timest,:,1,1));
tdtcheck=conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1)+tntc(timest,:,1,1)+tntls(timest,:,1,1)+tnt_vdif(timest,:,1,1)+tnt_topo(timest,:,1,1));
tdtcheck=conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1)+tntc(timest,:,1,1)+tntls(timest,:,1,1)+tnt_vdif(timest,:,1,1));
tdtcheck2=conv*(tnt_phy(timest,:,1,1)+tnt_dyn(timest,:,1,1)+tnt_vdif(timest,:,1,1));
tdtcheck3=conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1)+tntc(timest,:,1,1)+tntls(timest,:,1,1));
tdtcheck4=conv*(tnt_phy(timest,:,1,1)+tnt_dyn(timest,:,1,1));
tdtcheck4_ts=conv*(tnt_phy(timeone:timetwo,vlev,1,1)+tnt_dyn(timeone:timetwo,vlev,1,1));
%tdt_dyn_phy=conv*(tnt_dyn(timest,:,1,1)+tnt_phy(timest,:,1,1));
%tdt_dyn_phy_rad=conv*(tnt_dyn(timest,:,1,1)+tnt_phy(timest,:,1,1)+tnt_rad(timest,:,1,1));
%tdtcheck=conv*6.*(tntrs(timest,:,1,1)+tntrl(timest,:,1,1)+tnta(timest,:,1,1)+tntc(timest,:,1,1)+tntls(timest,:,1,1)+tntvdif(timest,:,1,1)...
%+tntrs(timest+1,:,1,1)+tntrl(timest+1,:,1,1)+tnta(timest+1,:,1,1)+tntc(timest+1,:,1,1)+tntls(timest+1,:,1,1)+tntvdif(timest+1,:,1,1)...
%+tntrs(timest+2,:,1,1)+tntrl(timest+2,:,1,1)+tnta(timest+2,:,1,1)+tntc(timest+2,:,1,1)+tntls(timest+2,:,1,1)+tntvdif(timest+2,:,1,1)...
%+tntrs(timest+3,:,1,1)+tntrl(timest+3,:,1,1)+tnta(timest+3,:,1,1)+tntc(timest+3,:,1,1)+tntls(timest+3,:,1,1)+tntvdif(timest+3,:,1,1)...
%+tntrs(timest+4,:,1,1)+tntrl(timest+4,:,1,1)+tnta(timest+4,:,1,1)+tntc(timest+4,:,1,1)+tntls(timest+4,:,1,1)+tntvdif(timest+4,:,1,1)...
%+tntrs(timest+5,:,1,1)+tntrl(timest+5,:,1,1)+tnta(timest+5,:,1,1)+tntc(timest+5,:,1,1)+tntls(timest+5,:,1,1)+tntvdif(timest+5,:,1,1));

%newvf=pfull(:,-1,:);
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

%figure
%plot(squeeze(husdiff_ts),'k','Linewidth',2)
%hold on
%plot(squeeze(tdtcheck4_ts),'--g')
%title('temperature budget tendency [K per 30 min]')
