%----------------------------------------------------------------
% scripts to read and open data from a netcdf file into Matlab
%
% this should work for Matlab 2015 as used on the macbook
%
% levi silvers                     dec 2016
%----------------------------------------------------------------
%source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_av10yr_atmos_subsvar.0002-0011.all.nc'
%source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/c96L32_am4g10r8_2000climo_atmos.0002-0021.07.nc'
%source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc'
%source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_p2K.0002-0021.jas.tmn.nc'
%source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_4xCO2.0002-0021.jas.tmn.nc'
%source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_1pctco2.0002-0021.jas.tmn.nc'
%ncid=netcdf.open(source);
%[numdims,nvars,natts]=netcdf.inq(ncid);
%nvars
%[tcld,xtype,dimids,atts]=netcdf.inqVar(ncid,21);
%vardatatest=ncread(source,tcld);
%v.lat=ncread(source,'lat');
%v.lon=ncread(source,'lon');
%v.level=ncread(source,'level');
%v.level=100.*v.level;
%v.temp=ncread(source,'temp');
%v.tsurf=ncread(source,'t_surf');
%v.tref=ncread(source,'t_ref');
%v.lcloud=ncread(source,'low_cld_amt');
%v.mcloud=ncread(source,'mid_cld_amt');
%v.hcloud=ncread(source,'high_cld_amt');
%v.hght=ncread(source,'hght');
%v.rh=ncread(source,'rh');

source='/Users/silvers/data/amip_long/c48L48_am3p9_1860_ext/';
source_tsurf=strcat(source,'atmos.187001-200512.t_surf.nc');
v.tsurf=ncread(source_tsurf,'t_surf');
%source_level=strcat(source,'atmos.187001-200512.level.nc');
%v.level=ncread(source_tsurf,'level');
source_tref=strcat(source,'atmos.187001-200512.t_ref.nc');
v.tref=ncread(source_tref,'t_ref');
source_temp=strcat(source,'atmos.187001-200512.temp.nc');
v.temp=ncread(source_temp,'temp');
source_rh=strcat(source,'atmos.187001-200512.rh.nc');
v.rh=ncread(source_rh,'rh');
source_hght=strcat(source,'atmos.187001-200512.hght.nc');
v.hght=ncread(source_hght,'hght');






