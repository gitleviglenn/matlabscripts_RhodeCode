%-------------------------------------------------------------------------------------------
% make_aqua_ozone.m
%
% This script opens a file with CFMIP3 specified climatology ozone and 
% modifies it a bit to make it usable by the AM4 model as input
%
% The initial file has 12 monthly time steps, corresponding to 1 year.
% This needs to be extended to 11 years.  
%
% input: /Users/silvers/data/apeozone_cam3_5_54.nc
%
% final product: aquaplanet_cfmip_o3.nc
%
% levi silvers                                                                  june 2018
%-------------------------------------------------------------------------------------------

fin_cfmip_o3='/Users/silvers/data/apeozone_cam3_5_54.nc'

% this is the time average ozone file that was previously used in
% aquaplanet experiments...  
% it looks like the pfull variable from the prviously used ozone file
% is identical to the lev variable in the cfmip provided file...
fin_o3_short='/Users/silvers/data/ape_ncks.nc'

o3_climo=ncread(fin_cfmip_o3,'OZONE');
o3_tmn=ncread(fin_o3_short,'ozone');
pfull=ncread(fin_o3_short,'pfull');
phalf=ncread(fin_o3_short,'phalf');
% %ice_climo=ncread(fin_amip_climo_ice,'ICE');
% sst_amip_full=ncread(fin_amip_full_sst,'sst');
% sst_fut=ncread(fin_patt_sst,'dt');
% sst_future=squeeze(sst_fut);
% 
%time=ncread(fin_cfmip_o3,'time');
% 
% time=time(1309:1788);
% % time=time+16; % shift to the middle of the month because of a weird error the model is crashing over
% 
lat = ncread(fin_cfmip_o3,'lat');
lon = ncread(fin_cfmip_o3,'lon');
% lat_bnds = ncread(fin_amip_full_sst,'lat_bnds');
% lon_bnds = ncread(fin_amip_full_sst,'lon_bnds');
% 
% %sst_amip = cat(3,sst_climo,sst_co2);
 nlon=128;
 nlat=64;
%
% time is an imaginary reference to days, a difference of
% 30 in 'time' is about a month.
time(1)=0;
%time(2)=16;
for itime=2:133
  time(itime)=time(itime-1)+30;
end

 for itime=1:1:132
     aqua_o3(:,:,:,itime)=o3_climo(:,:,:,1);
 end
       %     year=0;    
%     for tindex=1:12:tend   
%       for imonth=0:11;           
%         %year=0:35;                                                                         
%         mon=tindex-12*imonth;                           
%         %mon=tindex-12*imonth;                             
% 	gl_tindex=tindex+imonth;
%         loc_mon=gl_tindex-12*year;
%         sst_amip_pfut(ilon,ilat,gl_tindex)=sst_amip(ilon,ilat,gl_tindex)+...
%         sst_future(ilon,ilat,loc_mon);
%       end         
%       mon=0;  
%       year=year+1;    
%     end 
%   end
% end
% 
% limit=1000.
% for ilon=1:1:nlon
%   for ilat=1:1:nlat
%     for tindex=1:tend
% 	    magn=sst_amip_pfut(ilon,ilat,tindex);
%       if (isnan(magn));% > limit);
% 	      'magn greater than limit';
%         sst_amip_pfut(ilon,ilat,tindex)=sst_amip(ilon,ilat,tindex);
%       end
%     end
%   end
% end
% 
% % determine which sst field to write out to the netcdf file
% clear sst_out;
% sst_out=sst_amip_pfut;
% 
% output file name
o3f = 'aquaplanet_o3_cfmip_v7.nc';
system(['rm -f ',o3f]);
% 
% 
% %time = zeros(size(sst_out,3),1);
% yr=time;
% mo=time;
% dy=time;
% 
% %day = [16,15,16,16,16,16,16,16,16,16,16,16];
% 
% %compt=0;
% %for yy=1:length(time)/12
% %    for mm=1:12
% %        compt=compt+1;
% %        time(compt) = datenum(yy,mm,day(mm));
% %    end
% %end
% 
nccreate(o3f,'ozone','Dimensions',{'lon' size(aqua_o3,1) 'lat' ...
                     size(aqua_o3,2) 'lev' size(aqua_o3,3) 'time' Inf},'Datatype','single');

nccreate(o3f,'lon','Dimensions',{'lon' size(aqua_o3,1)});
nccreate(o3f,'time','Dimensions',{'time' size(aqua_o3,4)});
nccreate(o3f,'lat','Dimensions',{'lat' size(aqua_o3,2)});
nccreate(o3f,'pfull','Dimensions',{'pfull' size(aqua_o3,3)});
nccreate(o3f,'phalf','Dimensions',{'phalf' 60});
%nccreate(o3f,'lat_bnds','Dimensions',{'bnds' 2 'lat' size(aqua_o3,2)});
%nccreate(o3f,'lon_bnds','Dimensions',{'bnds' 2 'lon' size(aqua_o3,1)});

%nccreate(o3f,'ozone','Dimensions',{'lon' size(aqua_o3,1) 'lat' ...
%                     size(aqua_o3,2) 'lev' size(aqua_o3,3) 'time' Inf},'Datatype','single');
% 
ncwrite(o3f,'lon',lon);
ncwrite(o3f,'lat',lat);
ncwrite(o3f,'pfull',pfull);
ncwrite(o3f,'phalf',phalf);
ncwrite(o3f,'time',time);
ncwrite(o3f,'ozone',aqua_o3);

%ncwrite(o3f,'lat_bnds',lat_bnds);
%ncwrite(o3f,'lon_bnds',lon_bnds);
% 
ncwriteatt(o3f,'time','standard_name','time');
ncwriteatt(o3f,'time','long_name','time');
%ncwriteatt(o3f,'time','bounds','time_bnds');
% %ncwriteatt(sstf,'time','units','days since 1979-1-16 00:00:00');
ncwriteatt(o3f,'time','units','days since 1979-01-01 00:00:00');
ncwriteatt(o3f,'time','axis','T');
ncwriteatt(o3f,'time','calendar','noleap');

ncwriteatt(o3f,'ozone','cell_methods','time:mean (interval: 1 months)');
ncwriteatt(o3f,'ozone','standard_name','ozone');
ncwriteatt(o3f,'ozone','long_name','ozone mass mixing ratio');
ncwriteatt(o3f,'ozone','units','kg/kg');

ncwriteatt(o3f,'lat','standard_name','latitude');
ncwriteatt(o3f,'lat','long_name','Latitude');
ncwriteatt(o3f,'lat','axis','Y');
ncwriteatt(o3f,'lat','units','degrees_north');

ncwriteatt(o3f,'lon','standard_name','longitude');
ncwriteatt(o3f,'lon','long_name','Longitude');
ncwriteatt(o3f,'lat','axis','X');
ncwriteatt(o3f,'lon','units','degrees_east');

ncwriteatt(o3f,'pfull','standard_name','pfull');
ncwriteatt(o3f,'pfull','long_name','layer-mean pressure');
ncwriteatt(o3f,'pfull','units','hPa');
ncwriteatt(o3f,'pfull','positive','down');
ncwriteatt(o3f,'pfull','cartesian_axis','Z');

ncwriteatt(o3f,'phalf','long_name','half pressure level');
ncwriteatt(o3f,'phalf','units','hPa');
ncwriteatt(o3f,'phalf','positive','down');
ncwriteatt(o3f,'phalf','cartesian_axis','Z');

% 
% nccreate(sstf,'yr','Dimensions',{'time' length(time)});
% nccreate(sstf,'mo','Dimensions',{'time' length(time)});
% nccreate(sstf,'dy','Dimensions',{'time' length(time)});
% 
% ncwrite(sstf,'yr',yr);
% ncwrite(sstf,'mo',mo);
% ncwrite(sstf,'dy',dy);
% 
% ncwriteatt(sstf,'lat','units','degrees_N')
% ncwriteatt(sstf,'lon','units','degrees_E')
% ncwriteatt(sstf,'lat_bnds','units','degrees_N')
% ncwriteatt(sstf,'lon_bnds','units','degrees_E')
% 
% ncwriteatt(sstf,'sst','units','deg_k');

ncdisp('aquaplanet_o3_cfmip_v1.nc')
