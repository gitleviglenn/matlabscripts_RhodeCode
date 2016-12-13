%
% driver to run matlab scripts computing the lower tropospheric stability and the 
% estimated inversion strength from different experimental files
%
% levi silvers                     dec 2016
%
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_ctl=lts_f;
eis_ctl=estinvs;

clear source
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_p2K.0002-0021.jas.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_p2K=lts_f;
eis_p2K=estinvs;

clear source
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_1pctco2.0002-0021.jas.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_1pctCO2=lts_f;
eis_1pctCO2=estinvs;

clear source
source='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_4xCO2.0002-0021.jas.tmn.nc';
openncfile_new;
comp_eis_lts;

lts_4xCO2=lts_f;
eis_4xCO2=estinvs;

% compute a landmask to apply to the output fields
landm='/Users/silvers/data/c96L32_landmask_atmos.static.nc'
land=ncread(landm,'land_mask');
onlyocean=zeros(size(land));
onlyocean(land>=0.5)=NaN;
onlyocean(land<0.5)=1.;

% compute the differences
%
eis_p2Kmctl=eis_p2K-eis_ctl;
lts_p2Kmctl=lts_p2K-lts_ctl;
newsurface=eis_p2Kmctl.*onlyocean;
cont_wcolorbar_eisdiff(newsurface','p2K minus ctl');
%
eis_4xCO2mctl=eis_4xCO2-eis_ctl;
lts_4xCO2mctl=lts_4xCO2-lts_ctl;
newsurface=eis_4xCO2mctl.*onlyocean;
cont_wcolorbar_eisdiff(newsurface','4xCO2 minus ctl');
%
lts_1pctCO2mctl=lts_1pctCO2-lts_ctl;
eis_1pctCO2mctl=eis_1pctCO2-eis_ctl;
newsurface=eis_1pctCO2mctl.*onlyocean;
cont_wcolorbar_eisdiff(newsurface','1pctCO2 minus ctl');




