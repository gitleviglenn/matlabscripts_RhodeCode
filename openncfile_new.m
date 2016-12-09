%----------------------------------------------------------------
% scripts to read and open data from a netcdf file into Matlab
%
% this should work for Matlab 2015 as used on the macbook
%
% levi silvers                     dec 2016
%----------------------------------------------------------------
%source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_av10yr_atmos_subsvar.0002-0011.all.nc'
source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_atmos.0002-0021.07.nc'
ncid=netcdf.open(source);
[numdims,nvars,natts]=netcdf.inq(ncid);
nvars
%[tcld,xtype,dimids,atts]=netcdf.inqVar(ncid,21);
%vardatatest=ncread(source,tcld);
v.lat=ncread(source,'lat');
v.lon=ncread(source,'lon');
v.level=ncread(source,'level');
v.level=100.*v.level;
v.temp=ncread(source,'temp');
v.tsurf=ncread(source,'t_surf');
v.hght=ncread(source,'hght');
