%
% driver to run matlab scripts computing the lower tropospheric stability and the 
% estimated inversion strength from different experimental files
%
% the data files used in this script are from experiments with am4 using sst patterns
% derived from cm3 experiments that david paytner performed over 3 different time 
% periods.
%
% for each control and perturbation this script defines a source file and then 
% runs the scripts: 
%   openncfile_new
%   comp_eis_lts
%
% the output from these scripts is stored and then the difference fields are computed
% locally in this script.  zonal means are also computed here.
%
% levi silvers                     dec 2016
%
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ctl_atmos.0002-0011.jas.tmn.nc';
source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ctl_atmos.0002-0011.all.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ctl_p1=lts_f;
eis_ctl_p1=estinvs;

clear source
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ptb_atmos.0002-0011.jas.tmn.nc';
source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ptb_atmos.0002-0011.all.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ptb_p1=lts_f;
eis_ptb_p1=estinvs;

clear source
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ctl_atmos.0002-0011.jas.tmn.nc';
source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ctl_atmos.0002-0011.all.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ctl_p2=lts_f;
eis_ctl_p2=estinvs;

clear source
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ptb_atmos.0002-0011.jas.tmn.nc';
source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p2_ptb_atmos.0002-0011.all.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ptb_p2=lts_f;
eis_ptb_p2=estinvs;

clear source
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ctl_atmos.0002-0011.jas.tmn.nc';
source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ctl_atmos.0002-0011.all.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ctl_p3=lts_f;
eis_ctl_p3=estinvs;

clear source
%source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ptb_atmos.0002-0011.jas.tmn.nc';
source='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ptb_atmos.0002-0011.all.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ptb_p3=lts_f;
eis_ptb_p3=estinvs;

% compute a landmask to apply to the output fields
landm='/Users/silvers/data/c96L32_landmask_atmos.static.nc'
land=ncread(landm,'land_mask');
onlyocean=zeros(size(land));
onlyocean(land>=0.5)=NaN;
onlyocean(land<0.5)=1.;

% compute the differences
%
eis_ptbmctl_p1=eis_ptb_p1-eis_ctl_p1;
lts_ptbmctl_p1=lts_ptb_p1-lts_ctl_p1;
eis_diff_p1_nanland=eis_ptbmctl_p1.*onlyocean;
cont_wcolorbar_eisdiff(eis_diff_p1_nanland','ptb minus ctl P1');
%
eis_ptbmctl_p2=eis_ptb_p2-eis_ctl_p2;
lts_ptbmctl_p2=lts_ptb_p2-lts_ctl_p2;
eis_diff_p2_nanland=eis_ptbmctl_p2.*onlyocean;
cont_wcolorbar_eisdiff(eis_diff_p2_nanland','ptb minus ctl P2');
%
eis_ptbmctl_p3=eis_ptb_p3-eis_ctl_p3;
eis_znm=mean(eis_ptb_p3,1,'omitnan');
lts_ptbmctl_p3=lts_ptb_p3-lts_ctl_p3;
eis_diff_p3_nanland=eis_ptbmctl_p3.*onlyocean;
lts_diff_p3_nanland=lts_ptbmctl_p3.*onlyocean;
cont_wcolorbar_eisdiff(eis_diff_p3_nanland','eis ptb minus ctl P3');
cont_wcolorbar_eisdiff(lts_diff_p3_nanland','lts ptb minus ctl P3');

deleis_p1=mean(eis_diff_p1_nanland,1,'omitnan');
deleis_p2=mean(eis_diff_p2_nanland,1,'omitnan');
deleis_p3=mean(eis_diff_p3_nanland,1,'omitnan');
%dellts_p1=mean(lts_diff_p1_nanland,1,'omitnan');
%dellts_p2=mean(lts_diff_p2_nanland,1,'omitnan');
%dellts_p3=mean(lts_diff_p3_nanland,1,'omitnan');
figure;
%plot(sin((pi/180.)*v.lat),deleis_p1,'r',sin((pi/180.)*v.lat),deleis_p2,'b',sin((pi/180.)*v.lat),deleis_p3,'k')
plot(v.lat,deleis_p1,'r',v.lat,deleis_p2,'b',v.lat,deleis_p3,'k')


