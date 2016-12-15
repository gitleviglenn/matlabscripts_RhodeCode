%----------------------------------------------------------------
% levi silvers                     dec 2016
%----------------------------------------------------------------
% compute a landmask to apply to the output fields
landm='/Users/silvers/data/c96L32_landmask_atmos.static.nc'
land=ncread(landm,'land_mask');
onlyocean=zeros(size(land));
onlyocean(land>=0.5)=NaN;
onlyocean(land<0.5)=1.;

% period1
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc';
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ctl_atmos.0002-0011.all.tmn.nc';
openncfile_new;
tsurf_ctl_p1=v.tsurf.*onlyocean;
lcloud_ctl_p1=v.lcloud.*onlyocean;
mcloud_ctl_p1=v.mcloud.*onlyocean;
hcloud_ctl_p1=v.hcloud.*onlyocean;

source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_p2K.0002-0021.jas.tmn.nc'; 
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ptb_atmos.0002-0011.all.tmn.nc';
openncfile_new;
tsurf_ptb_p1=v.tsurf.*onlyocean;
lcloud_ptb_p1=v.lcloud.*onlyocean;
mcloud_ptb_p1=v.mcloud.*onlyocean;
hcloud_ptb_p1=v.hcloud.*onlyocean;
%
tsurf_diff_p1=tsurf_ptb_p1-tsurf_ctl_p1;
lcloud_diff_p1=lcloud_ptb_p1-lcloud_ctl_p1;
mcloud_diff_p1=mcloud_ptb_p1-mcloud_ctl_p1;
hcloud_diff_p1=hcloud_ptb_p1-hcloud_ctl_p1;
% figures for p1
cont_wcolorbar_eisdiff(tsurf_diff_p1','tsurf diff p1')
cont_wcolorbar_eisdiff(lcloud_diff_p1','lcloud diff p1')
cont_wcolorbar_eisdiff(mcloud_diff_p1','mcloud diff p1')
cont_wcolorbar_eisdiff(hcloud_diff_p1','hcloud diff p1')

% period2
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc';
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ctl_atmos.0002-0011.all.tmn.nc';
openncfile_new;
tsurf_ctl_p2=v.tsurf.*onlyocean;
lcloud_ctl_p2=v.lcloud.*onlyocean;
mcloud_ctl_p2=v.mcloud.*onlyocean;
hcloud_ctl_p2=v.hcloud.*onlyocean;

source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_1pctco2.0002-0021.jas.tmn.nc'; 
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ptb_atmos.0002-0011.all.tmn.nc';
openncfile_new;
tsurf_ptb_p2=v.tsurf.*onlyocean;
lcloud_ptb_p2=v.lcloud.*onlyocean;
mcloud_ptb_p2=v.mcloud.*onlyocean;
hcloud_ptb_p2=v.hcloud.*onlyocean;
%
tsurf_diff_p2=tsurf_ptb_p2-tsurf_ctl_p2;
lcloud_diff_p2=lcloud_ptb_p2-lcloud_ctl_p2;
mcloud_diff_p2=mcloud_ptb_p2-mcloud_ctl_p2;
hcloud_diff_p2=hcloud_ptb_p2-hcloud_ctl_p2;
% figures for p2
cont_wcolorbar_eisdiff(tsurf_diff_p2','tsurf diff p2')
cont_wcolorbar_eisdiff(lcloud_diff_p2','lcloud diff p2')
cont_wcolorbar_eisdiff(mcloud_diff_p2','mcloud diff p2')
cont_wcolorbar_eisdiff(hcloud_diff_p2','hcloud diff p2')

% period3
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc';
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ctl_atmos.0002-0011.all.tmn.nc';
openncfile_new;
tsurf_ctl_p3=v.tsurf.*onlyocean;
lcloud_ctl_p3=v.lcloud.*onlyocean;
mcloud_ctl_p3=v.mcloud.*onlyocean;
hcloud_ctl_p3=v.hcloud.*onlyocean;

source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_4xCO2.0002-0021.jas.tmn.nc';
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ptb_atmos.0002-0011.all.tmn.nc';
openncfile_new;
tsurf_ptb_p3=v.tsurf.*onlyocean;
lcloud_ptb_p3=v.lcloud.*onlyocean;
mcloud_ptb_p3=v.mcloud.*onlyocean;
hcloud_ptb_p3=v.hcloud.*onlyocean;
%
tsurf_diff_p3=tsurf_ptb_p3-tsurf_ctl_p3;
lcloud_diff_p3=lcloud_ptb_p3-lcloud_ctl_p3;
mcloud_diff_p3=mcloud_ptb_p3-mcloud_ctl_p3;
hcloud_diff_p3=hcloud_ptb_p3-hcloud_ctl_p3;
% figures for p3
cont_wcolorbar_eisdiff(tsurf_diff_p3','tsurf diff p3')
cont_wcolorbar_eisdiff(lcloud_diff_p3','lcloud diff p3')
cont_wcolorbar_eisdiff(mcloud_diff_p3','mcloud diff p3')
cont_wcolorbar_eisdiff(hcloud_diff_p3','hcloud diff p3')
