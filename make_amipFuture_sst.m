%-------------------------------------------------------------------------------------------
% make_amipFuture_sst.m
%
% This script opens a file with historical sst data (no ice) used for amip
% This script opens a composite SST warming pattern derived from CMIP3
%
% The two fields are added together and used for an amipFuture4K experiment
% 
% input 1: /archive/Levi.Silvers/input/gmd-2016-70-supplement-version1/gmd-supplement/cfmip2_4k_patterned_sst_forcing.vn1.0.nc
% 
% input 2: amip data
%    /archive/Levi.Silvers/data/PCMDI_sst_cmip6/hadisst_sst.data.nc
%    /archive/Levi.Silvers/data/PCMDI_sst_cmip6/hadisst_ice.data.nc
%
% input 3: climotological amip data
%    /archive/Levi.Silvers/sstpatt/sst.climo.1981-2000.data.nc
%    /archive/Levi.Silvers/sstpatt/ice.climo.1981-2000.data.nc
%
% final product: amipFuture4K_sst.nc
%
% levi silvers                                                                  may 2018
%-------------------------------------------------------------------------------------------

fin_patt_sst='/archive/Levi.Silvers/input/gmd-2016-70-supplement-version1/gmd-supplement/cfmip2_4k_patterned_sst_forcing.vn1.0.360x180.nc'

% climotology data
fin_amip_climo_sst='/archive/Levi.Silvers/sstpatt/sst.climo.1981-2000.data.nc' 
fin_amip_climo_ice='/archive/Levi.Silvers/sstpatt/ice.climo.1981-2000.data.nc' 

%fin_amip_full_sst='/archive/Levi.Silvers/data/PCMDI_sst_cmip6/hadisst_sst.data.amip.nc' 
%fin_amip_full_ice='/archive/Levi.Silvers/data/PCMDI_sst_cmip6/hadisst_ice.data.amip.nc' 
fin_amip_full_sst='/archive/Levi.Silvers/data/PCMDI_sst_cmip6/tmp/hadisst_sst.data.nc' 
fin_amip_full_ice='/archive/Levi.Silvers/data/PCMDI_sst_cmip6/tmp/hadisst_ice.data.nc' 

%read sst
%sst_climo = ncread('sst.nc','SST');
%%sst_co2   = ncread('sst_abrupt4xCO2_C.nc','t_surf');
%sst_co2   = ncread('sst.nc','SST');

sst_climo=ncread(fin_amip_climo_sst,'SST');
%ice_climo=ncread(fin_amip_climo_ice,'ICE');
sst_amip_full=ncread(fin_amip_full_sst,'sst');
sst_fut=ncread(fin_patt_sst,'dt');
sst_future=squeeze(sst_fut);

time=ncread(fin_amip_full_sst,'time');

% grab years after 1979:
% the sst file starts in jan of 1869 so index 1320 should be 
% at jan 1979
% 1788-1320=468 # months between 1979 jan and 2017 dec
% 468/12 = 39 years
sst_amip=sst_amip_full(:,:,1309:1788);
time=time(1309:1788);
% time=time+16; % shift to the middle of the month because of a weird error the model is crashing over

tend=1788-1308;

lat = ncread(fin_amip_full_sst,'lat');
lon = ncread(fin_amip_full_sst,'lon');
lat_bnds = ncread(fin_amip_full_sst,'lat_bnds');
lon_bnds = ncread(fin_amip_full_sst,'lon_bnds');
%lat = ncread('sst.nc','lat');
%lon = ncread('sst.nc','lon');
%lat_bnds = ncread('sst.nc','lat_bnds');
%lon_bnds = ncread('sst.nc','lon_bnds');

%sst_amip = cat(3,sst_climo,sst_co2);
nlon=360;
nlat=180;

for ilon=1:1:nlon
  for ilat=1:1:nlat
    year=0;    
    for tindex=1:12:tend   
      for imonth=0:11;           
        %year=0:35;                                                                         
        mon=tindex-12*imonth;                           
        %mon=tindex-12*imonth;                             
	gl_tindex=tindex+imonth;
        loc_mon=gl_tindex-12*year;
        sst_amip_pfut(ilon,ilat,gl_tindex)=sst_amip(ilon,ilat,gl_tindex)+...
        sst_future(ilon,ilat,loc_mon);
      end         
      mon=0;  
      year=year+1;    
    end 
  end
end

limit=1000.
for ilon=1:1:nlon
  for ilat=1:1:nlat
    for tindex=1:tend
	    magn=sst_amip_pfut(ilon,ilat,tindex);
      if (isnan(magn));% > limit);
	      'magn greater than limit';
        sst_amip_pfut(ilon,ilat,tindex)=sst_amip(ilon,ilat,tindex);
      end
    end
  end
end

% determine which sst field to write out to the netcdf file
clear sst_out;
sst_out=sst_amip_pfut;

% output file name
sstf = 'sst_amip_future_take2.nc';
system(['rm -f ',sstf]);

nccreate(sstf,'sst','Dimensions',{'lon' size(sst_out,1) 'lat' ...
                    size(sst_out,2) 'time' Inf},'Datatype','single');

%create time
nccreate(sstf,'time','Dimensions',{'time' Inf});

%time = zeros(size(sst_out,3),1);
yr=time;
mo=time;
dy=time;

%day = [16,15,16,16,16,16,16,16,16,16,16,16];

%compt=0;
%for yy=1:length(time)/12
%    for mm=1:12
%        compt=compt+1;
%        time(compt) = datenum(yy,mm,day(mm));
%    end
%end

%time=time-datenum(1,1,1);

%create lat/lon
nccreate(sstf,'lat','Dimensions',{'lat' size(sst_out,2)});
nccreate(sstf,'lon','Dimensions',{'lon' size(sst_out,1)});
nccreate(sstf,'lat_bnds','Dimensions',{'bnds' 2 'lat' size(sst_out,2)});
nccreate(sstf,'lon_bnds','Dimensions',{'bnds' 2 'lon' size(sst_out,1)});

ncwrite(sstf,'sst',sst_out);
ncwrite(sstf,'time',time);
ncwrite(sstf,'lat',lat);
ncwrite(sstf,'lon',lon);
ncwrite(sstf,'lat_bnds',lat_bnds);
ncwrite(sstf,'lon_bnds',lon_bnds);

ncwriteatt(sstf,'time','standard_name','time');
ncwriteatt(sstf,'time','long_name','time');
ncwriteatt(sstf,'time','bounds','time_bnds');
%ncwriteatt(sstf,'time','units','days since 1979-1-16 00:00:00');
ncwriteatt(sstf,'time','units','days since 1860-1-1 00:00:00');
ncwriteatt(sstf,'time','axis','T');
ncwriteatt(sstf,'time','calendar','gregorian');

nccreate(sstf,'yr','Dimensions',{'time' length(time)});
nccreate(sstf,'mo','Dimensions',{'time' length(time)});
nccreate(sstf,'dy','Dimensions',{'time' length(time)});

ncwrite(sstf,'yr',yr);
ncwrite(sstf,'mo',mo);
ncwrite(sstf,'dy',dy);

ncwriteatt(sstf,'lat','units','degrees_N')
ncwriteatt(sstf,'lon','units','degrees_E')
ncwriteatt(sstf,'lat_bnds','units','degrees_N')
ncwriteatt(sstf,'lon_bnds','units','degrees_E')

ncwriteatt(sstf,'sst','units','deg_k');
