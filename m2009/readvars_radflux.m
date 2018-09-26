%----------------------------------------------------------------
% scripts to read and open data from a netcdf files 
%
% this script is designed to open data that will be processed and written 
% to a netcdf file for timothy andrews
%
% the data is from 5 ensemble members of long amip runs with am4p0
%
% pathbase, path, and years2 vars to be predefined
%
% e.g.
%pathbase='/net2/Levi.Silvers/data/amip_long/';
%path='AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A1/';
%years2='atmos.187001-200412'; % 1620 months
%
% this should work for Matlab 2009 
%
% levi silvers                     june 2017
%----------------------------------------------------------------

piece=strcat(pathbase,path,years2);

%source_swdn_ts     = strcat(piece,'.swdn_toa.nc')
%source_swup_ts     = strcat(piece,'.swup_toa.nc')
%source_swup_clr_ts = strcat(piece,'.swup_toa_clr.nc')
%source_olr_ts      = strcat(piece,'.olr.nc')
%source_olr_clr_ts  = strcat(piece,'.olr_clr.nc')
%source_tref_ts     = strcat(piece,'.t_ref.nc')
rsdt='swdn_toa'
rsut='swup_toa'
rsutcs='swup_toa_clr'
rlutcs='olr'
rlut='olr_clr'
tas='tas'

if (cmip_format=='true') 
  rsdt='rsdt'
  rsut='rsut'
  rsutcs='rsutcs'
  rlutcs='rlutcs'
  rlut='rlut'
  tas='tas'
end

source_swdn_ts     = strcat(piece,'.',rsdt,'.nc')
source_swup_ts     = strcat(piece,'.',rsut,'.nc')
source_swup_clr_ts = strcat(piece,'.',rsutcs,'.nc')
source_olr_ts      = strcat(piece,'.',rlut,'.nc')
source_olr_clr_ts  = strcat(piece,'.',rlutcs,'.nc')
source_tref_ts     = strcat(piece,'.',tas,'.nc')

filein=zeros(6);

fin_swdn      = netcdf(source_swdn_ts,'nowrite');
fileid(1)=fopen(source_swdn_ts);
fin_swup      = netcdf(source_swup_ts,'nowrite');
fileid(2)=fopen(source_swup_ts);
fin_swup_clr  = netcdf(source_swup_clr_ts,'nowrite');
fileid(3)=fopen(source_swup_clr_ts);
fin_olr       = netcdf(source_olr_ts,'nowrite');
fileid(4)=fopen(source_olr_ts);
fin_olr_clr   = netcdf(source_olr_clr_ts,'nowrite');
fileid(5)=fopen(source_olr_clr_ts);
fin_tref      = netcdf(source_tref_ts,'nowrite');
fileid(6)=fopen(source_tref_ts);

%% grab time series over a specified period:
vlon               = fin_olr{'lon'}(:); 
vlat               = fin_olr{'lat'}(:);
vlevel             = fin_olr{'level'}(:);
v.lon              = fin_olr{'lon'}(:); 
v.lat              = fin_olr{'lat'}(:);
tref_ts            = fin_tref{tas}(timest:timeend,:,:); 
swdn_ts            = fin_swdn{rsdt}(timest:timeend,:,:,:);
swup_ts            = fin_swup{rsut}(timest:timeend,:,:,:);
%swup_ts            = -1.*swup_ts;  % data request defines swup as + up
swup_clr_ts        = fin_swup_clr{rsutcs}(timest:timeend,:,:,:);
%swup_clr_ts        = -1.*swup_clr_ts;
olr_ts             = fin_olr{rlut}(timest:timeend,:,:,:);
%olr_ts             = -1.*olr_ts;  % data request defines olr as +up
olr_clr_ts         = fin_olr_clr{rlutcs}(timest:timeend,:,:,:);
%olr_clr_ts         = -1.*olr_clr_ts;

for i=1:6
  fclose(fileid(i));
end

nlat=size(vlat,1);
nlon=size(vlon,1);
v.nlat=size(vlat,1);
v.nlon=size(vlon,1);
