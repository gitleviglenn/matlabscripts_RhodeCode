% use matlab structures and netcdf functions 
% to open and modify a file.  then create a new file

fin='/net2/Levi.Silvers/data/AM4OM2F_c96l32_am4g6_1860climo_hist0/ts_all/atmos.186101-201012.t_surf.nc';
f=netcdf.open(fin,'nowrite');

v.lon=ncread(fin,'lon');
v.lat=ncread(fin,'lat');
v.nlon=length(v.lon);
v.nlat=length(v.lat);
v.time=ncread(fin,'time');
v.nt=length(v.time);
v.t_surf=ncread(fin,'t_surf');

%v.t_surf(1:100,90:120,:)=278.0;
v.t_surf=v.t_surf+4.0;

newf=netcdf.create('newfile.nc','CLOBBER');

dimidlat=netcdf.defDim(newf,'lat',v.nlat);
latitude_ID=netcdf.defVar(newf,'lat','double',[dimidlat]);
netcdf.putAtt(newf,latitude_ID,'long_name','latitude');
netcdf.putAtt(newf,latitude_ID,'units','degrees_N');
netcdf.putAtt(newf,latitude_ID,'cartesian_axis','Y');
netcdf.putAtt(newf,latitude_ID,'bounds','lat_bnds');

dimidlon=netcdf.defDim(newf,'lon',v.nlon);
longitude_ID=netcdf.defVar(newf,'lon','double',[dimidlon]);
netcdf.putAtt(newf,longitude_ID,'long_name','longitude');
netcdf.putAtt(newf,longitude_ID,'units','degrees_E');
netcdf.putAtt(newf,longitude_ID,'cartesian_axis','X');
netcdf.putAtt(newf,longitude_ID,'bounds','lon_bnds');

dimidt=netcdf.defDim(newf,'time',v.nt);
time_ID=netcdf.defVar(newf,'time','double',[dimidt]);
netcdf.putAtt(newf,time_ID,'long_name','time');
netcdf.putAtt(newf,time_ID,'units','days since 1860-01-01 00:00:00');
netcdf.putAtt(newf,time_ID,'cartesian_axis','T');
netcdf.putAtt(newf,time_ID,'calendar_type','NOLEAP');
netcdf.putAtt(newf,time_ID,'calendar','NOLEAP');
netcdf.putAtt(newf,time_ID,'bounds','time_bounds');

dimidbnds=netcdf.defDim(newf,'bnds',2);

sst_ID=netcdf.defVar(newf,'sst','double',[dimidlon,dimidlat,dimidt]);
netcdf.putAtt(newf,sst_ID,'long_name','surface temperature');
netcdf.putAtt(newf,sst_ID,'units','deg_k');
netcdf.putAtt(newf,sst_ID,'valid_range','100.f, 400.f');
netcdf.putAtt(newf,sst_ID,'missing_value','1.e+20f');
netcdf.putAtt(newf,sst_ID,'FillValue','1.e+20f');
netcdf.putAtt(newf,sst_ID,'cell_methods','time: mean');
netcdf.putAtt(newf,sst_ID,'time_avg_info','average_T1,average_T2,average_DT');
netcdf.putAtt(newf,sst_ID,'interp_method','conserve_order2');



netcdf.endDef(newf);

%Then store the dimension variables in
netcdf.putVar(newf,time_ID,v.time);
netcdf.putVar(newf,latitude_ID,v.lat);
netcdf.putVar(newf,longitude_ID,v.lon);
 
%Then store my main variable
netcdf.putVar(newf,sst_ID,v.t_surf);
 
%We're done, close the netcdf
netcdf.close(newf)