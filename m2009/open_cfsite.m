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

path='/archive/Levi.Silvers/awg/verona/c96L32_am4g11r11_2010climo_CF_Master_psite/gfdl.ncrc3-intel-prod-openmp/history/'
fileincming='00100101.atmos_station_001.tile5.nc'
source_file=strcat(path,fileincming);
sitenum='station 1';

fin_total=netcdf(source_file,'nowrite');

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
