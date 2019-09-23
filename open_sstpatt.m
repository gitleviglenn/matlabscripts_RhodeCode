%----------------------------------------------------------------
% scripts to read and open data from a netcdf file into Matlab
%
% this should work for Matlab 2015 as used on the macbook
%
% levi silvers                     dec 2016
%----------------------------------------------------------------
%source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_av10yr_atmos_subsvar.0002-0011.all.nc'
%source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_atmos.0002-0021.07.nc'
%source_ctl='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc'
%source_ptb='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_p2K.0002-0021.jas.tmn.nc'
%source_ctl='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ctl_atmos.0002-0011.all.tmn.nc';
%source_ptb='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ptb_atmos.0002-0011.all.tmn.nc';
source_ctl='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ctl_atmos.0002-0011.all.tmn.nc';
source_ptb='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ptb_atmos.0002-0011.all.tmn.nc';
ncid=netcdf.open(source_ctl);
[numdims,nvars,natts]=netcdf.inq(ncid);
nvars
%[tcld,xtype,dimids,atts]=netcdf.inqVar(ncid,21);
%v_ctl.rdatatest=ncread(source_ctl,tcld);
v_ctl.lat=ncread(source_ctl,'lat');
v_ctl.lon=ncread(source_ctl,'lon');
v_ctl.level=ncread(source_ctl,'level');
v_ctl.level=100.*v_ctl.level;
v_ctl.temp=ncread(source_ctl,'temp');
v_ctl.tsurf=ncread(source_ctl,'t_surf');
v_ctl.hght=ncread(source_ctl,'hght');
v_ctl.rh=ncread(source_ctl,'rh');
v_ctl.lcloud=ncread(source_ctl,'low_cld_amt');
v_ctl.hcloud=ncread(source_ctl,'high_cld_amt');
v_ctl.mcloud=ncread(source_ctl,'mid_cld_amt');
v_ctl.omega=ncread(source_ctl,'omega');
v_ctl.swdn_toa =ncread(source_ctl,'swdn_toa');
v_ctl.swup_toa =ncread(source_ctl,'swup_toa');
v_ctl.swup_clr =ncread(source_ctl,'swup_toa_clr');
v_ctl.swdn_clr =ncread(source_ctl,'swdn_toa_clr');
v_ctl.olr =ncread(source_ctl,'olr');
v_ctl.olr_clr =ncread(source_ctl,'olr_clr');
v_ctl.precip =ncread(source_ctl,'precip');
v_ctl.ice=ncread(source_ctl,'ice_mask');
v_ctl.wvp=ncread(source_ctl,'WVP');
v_ctl.lwp=ncread(source_ctl,'LWP');
%
v_ptb.level=ncread(source_ptb,'level');
v_ptb.level=100.*v_ptb.level;
v_ptb.temp=ncread(source_ptb,'temp');
v_ptb.tsurf=ncread(source_ptb,'t_surf');
v_ptb.hght=ncread(source_ptb,'hght');
v_ptb.rh=ncread(source_ptb,'rh');
v_ptb.lcloud=ncread(source_ptb,'low_cld_amt');
v_ptb.hcloud=ncread(source_ptb,'high_cld_amt');
v_ptb.mcloud=ncread(source_ptb,'mid_cld_amt');
v_ptb.omega=ncread(source_ptb,'omega');
v_ptb.swdn_toa =ncread(source_ptb,'swdn_toa');
v_ptb.swup_toa =ncread(source_ptb,'swup_toa');
v_ptb.swup_clr =ncread(source_ptb,'swup_toa_clr');
v_ptb.swdn_clr =ncread(source_ptb,'swdn_toa_clr');
v_ptb.olr =ncread(source_ptb,'olr');
v_ptb.olr_clr =ncread(source_ptb,'olr_clr');
v_ptb.precip =ncread(source_ptb,'precip');
v_ptb.ice=ncread(source_ptb,'ice_mask');
v_ptb.wvp=ncread(source_ptb,'WVP');
v_ptb.lwp=ncread(source_ptb,'LWP');
%
