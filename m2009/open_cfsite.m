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
% levi silvers                                                    apr 2017
%---------------------------------------------------------------------------------------

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_CF_Master_psite/gfdl.ncrc3-intel-prod-openmp/history/'
%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_CF_Master_psite_001/gfdl.ncrc3-intel-prod-openmp/history/'

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_psite_001/gfdl.ncrc3-intel-prod-openmp/history/'
%fileincming='00100101.atmos_station_001.tile5.nc'

%path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_psite_001_b/gfdl.ncrc3-intel-prod-openmp/history/'
%fileincming='00010101.atmos_station_001.tile5.nc'

path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_psite_001_c/gfdl.ncrc3-intel-prod-openmp/history/'
fileincming='00010101.atmos_station_001.tile5.nc'

source_file=strcat(path,fileincming);
sitenum='station 1';

fin_total=netcdf(source_file,'nowrite');

pfull=fin_total{'pfull'};
phalf=fin_total{'phalf'};

cl=fin_total{'cl'}; % cloud area
clw=fin_total{'clw'}; % liquid amount -- all clouds
cli=fin_total{'cli'}; % ice amount -- all clouds
mc=fin_total{'mc'}; % net mass flux from convection
ta=fin_total{'ta'}; % temperature
ua=fin_total{'ua'}; % zonal wind 
va=fin_total{'va'}; % meridional wind 
hus=fin_total{'hus'}; % specific humidity 
hur=fin_total{'hur'}; % relative humidity 
omega=fin_total{'wap'}; % omega Pa/s
rsu=fin_total{'rsu'}; % 
rsd=fin_total{'rsd'}; % 
rsucs=fin_total{'rsucs'}; 
rsdcs=fin_total{'rsdcs'}; 

% temp tends
tnta=fin_total{'tnta'}; 
tntc=fin_total{'tdt_conv'}; 
tntls=fin_total{'tdt_ls'}; 
tntvdif=fin_total{'tdt_vdif'}; 
%tntmp=fin_total{'tntmp'}; 
%tntr=fin_total{'tntr'}; 
%tntc=fin_total{'tntc'}; 

% specific hum tends
qdt_vdif=fin_total{'qdt_vdif'}; 
qdt_ls=fin_total{'qdt_ls'};
qdt_dyn=fin_total{'tnhusa'}; % qdt_dyn
qdt_conv=fin_total{'qdt_conv'}; % qdt_dyn

tntrs=fin_total{'tntrs'};

% tendencies are in units of blah blah per second.  Output is every halfhour
conv=1800.;
timest=1750;

husdiff=hus(timest,:,1,1)-hus(timest-1,:,1,1);
tadiff=ta(timest,:,1,1)-ta(timest-1,:,1,1);

qdtcheck=conv*(qdt_ls(timest,:,1,1)+qdt_dyn(timest,:,1,1)+qdt_conv(timest,:,1,1)+qdt_vdif(timest,:,1,1));
tdtcheck=conv*(tnta(timest,:,1,1)+tntc(timest,:,1,1)+tntls(timest,:,1,1)+tntvdif(timest,:,1,1));

newvf=pfull(:,-1,:);

figure
plot(squeeze(qdtcheck),newvf,'g')
set(gca,'Ydir','reverse')
hold on
plot(squeeze(husdiff),newvf,'k')
title('moisture budget tendency [kg/kg per 30 min]')

figure
plot(squeeze(tdtcheck),newvf,'g')
set(gca,'Ydir','reverse')
hold on
plot(squeeze(tadiff),newvf,'k')
title('temperature budget tendency [K per 30 min]')

%size(cl)
%size(clw)
%size(cli)
%size(mc)
%size(ta)
%size(ua)
%size(va)
%size(hus)
%size(hur)
%size(omega)
