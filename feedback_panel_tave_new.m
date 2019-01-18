%----------------------------------------------------------------
% scripts to read and open data from a netcdf file into Matlab
%
% this should work for Matlab 2015 as used on the macbook
%
% computes radiative and cloud responses between the two files
%
% levi silvers                     dec 2016
%----------------------------------------------------------------
%source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_av10yr_atmos_subsvar.0002-0011.all.nc'
%source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_atmos.0002-0021.07.nc'
%source_ctl='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos.0002-0021.jas.tmn.nc'
%source_ptb='/Users/silvers/data/cre_sstpatt/am4_warmpatt/atmos_p2K.0002-0021.jas.tmn.nc'
%source_ctl='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ctl_atmos.0002-0011.all.tmn.nc';
%source_ptb='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_ptb_atmos.0002-0011.all.tmn.nc';
source_ctl='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ctl_atmos.0002-0011.all.tmn.nc';
source_ptb='/Users/silvers/data/cre_sstpatt/am4_sst_from_cm3/am4g10r8_cm3sst_p3_ptb_atmos.0002-0011.all.tmn.nc';
ncid=netcdf.open(source_ctl);
[numdims,nvars,natts]=netcdf.inq(ncid);
nvars
%[tcld,xtype,dimids,atts]=netcdf.inqVar(ncid,21);
%v.rdatatest=ncread(source_ctl,tcld);
v.lat=ncread(source_ctl,'lat');
v.latweight=cos(pi/180*v.lat);
v.lon=ncread(source_ctl,'lon');
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.level=ncread(source_ctl,'level');
v.level=100.*v.level;
v.temp2=ncread(source_ctl,'temp');
v.tsurf2=ncread(source_ctl,'t_surf');
v.hght2=ncread(source_ctl,'hght');
v.rh2=ncread(source_ctl,'rh');
v.lcloud2=ncread(source_ctl,'low_cld_amt');
v.hcloud2=ncread(source_ctl,'high_cld_amt');
v.mcloud2=ncread(source_ctl,'mid_cld_amt');
v.omega2=ncread(source_ctl,'omega');
v.swdn_toa2 =ncread(source_ctl,'swdn_toa');
v.swup_toa2 =ncread(source_ctl,'swup_toa');
v.swup_clr2 =ncread(source_ctl,'swup_toa_clr');
v.swdn_clr2 =ncread(source_ctl,'swdn_toa_clr');
v.olr2 =ncread(source_ctl,'olr');
v.olr_clr2 =ncread(source_ctl,'olr_clr');
v.precip2 =ncread(source_ctl,'precip');
v.ice2=ncread(source_ctl,'ice_mask');
v.wvp2=ncread(source_ctl,'WVP');
v.lwp2=ncread(source_ctl,'LWP');
%
%v.level=ncread(source_ptb,'level');
%v.level=100.*v_ptb.level;
v.temp=ncread(source_ptb,'temp');
v.tsurf=ncread(source_ptb,'t_surf');
v.hght=ncread(source_ptb,'hght');
v.rh=ncread(source_ptb,'rh');
v.lcloud=ncread(source_ptb,'low_cld_amt');
v.hcloud=ncread(source_ptb,'high_cld_amt');
v.mcloud=ncread(source_ptb,'mid_cld_amt');
v.omega=ncread(source_ptb,'omega');
v.swdn_toa =ncread(source_ptb,'swdn_toa');
v.swup_toa =ncread(source_ptb,'swup_toa');
v.swup_clr =ncread(source_ptb,'swup_toa_clr');
v.swdn_clr =ncread(source_ptb,'swdn_toa_clr');
v.olr =ncread(source_ptb,'olr');
v.olr_clr =ncread(source_ptb,'olr_clr');
v.precip =ncread(source_ptb,'precip');
v.ice=ncread(source_ptb,'ice_mask');
v.wvp=ncread(source_ptb,'WVP');
v.lwp=ncread(source_ptb,'LWP');
%
v.hcld2=ncread(source_ctl,'high_cld_amt');
v.hcld=ncread(source_ptb,'high_cld_amt');
v.lcld2=ncread(source_ctl,'low_cld_amt');
v.lcld=ncread(source_ptb,'low_cld_amt');
v.mcld2=ncread(source_ctl,'mid_cld_amt');
v.mcld=ncread(source_ptb,'mid_cld_amt');
v.tot_cld2=ncread(source_ctl,'tot_cld_amt');
v.tot_cld=ncread(source_ptb,'tot_cld_amt');
v.wp_allcld2=ncread(source_ctl,'WP_all_clouds');
v.wp_allcld=ncread(source_ptb,'WP_all_clouds');

%
%-----------------------------------------------------------------------------------------
% compute responses/feedbacks
% feedbacks should be computed with exp1-exp2, and positive values should lead to warming
%-----------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux=v.swdn_toa-v.olr-v.swup_toa;
v.radflux2=v.swdn_toa2-v.olr2-v.swup_toa2;
toa_net_fdbck=v.radflux-v.radflux2;
%-----------------------------------------------------------------------------------------
% compute responses/feedbacks
% feedbacks should be computed with exp1-exp2, and positive values should lead to warming
%-----------------------------------------------------------------------------------------
% all three of these variables are defined as positive
v.radflux=v.swdn_toa-v.olr-v.swup_toa;
v.radflux2=v.swdn_toa2-v.olr2-v.swup_toa2;
toa_net_fdbck=v.radflux-v.radflux2;
olr_fdbck=v.olr-v.olr2;
lw_clr_fdbck=v.olr_clr-v.olr_clr2;
sw_fdbck=v.swdn_toa-v.swup_toa-v.swdn_toa2+v.swup_toa2;
% the sign should be flipped here because larger olr values correspond to cooling
lw_clr_fdbck=-lw_clr_fdbck;
sw_clr_fdbck=v.swdn_clr-v.swup_clr-v.swdn_clr2+v.swup_clr2;
% cloud radiative effects: clear sky - all sky  
olr_cre1=v.olr_clr-v.olr; % pos means clouds warm
olr_cre2=v.olr_clr2-v.olr2;
sw_cre1=v.swup_clr-v.swup_toa; % pos means clouds cool, so we plot -sw_cre
sw_cre2=v.swup_clr2-v.swup_toa2;
tot_cre1=olr_cre1-sw_cre1; % pos means clouds warm
tot_cre2=olr_cre2-sw_cre2;
% CRE = lw_cre - sw_cre; positive values correspond to warming from clouds
%olr_cre_fdbck=lw_clr_fdbck - olr_fdbck;
%sw_cre_fdbck=sw_clr_fdbck - sw_fdbck;
%toa_cre_fdbck=sw_cre_fdbck+olr_cre_fdbck;
olr_cre_fdbck=olr_cre1-olr_cre2;
sw_cre_fdbck=sw_cre1-sw_cre2;
toa_cre_fdbck=olr_cre_fdbck+sw_cre_fdbck;
%toa_cre_fdbck_test=tot_cre1-tot_cre2;

precip_fdbck=v.precip-v.precip2;
wvp_fdbck=v.wvp-v.wvp2;
lwp_fdbck=v.lwp-v.lwp2;
wp_allcld_fdbck=v.wp_allcld-v.wp_allcld2;
tot_cld_fdbck=v.tot_cld-v.tot_cld2;
midcld_fdbck=v.mcld-v.mcld2;
lowcld_fdbck=v.lcld-v.lcld2;
highcld_fdbck=v.hcld-v.hcld2;
%t_ref_fdbck=v.t_ref-v.t_ref2;
%swup_sfc_clr_fdbck=v.swup_sfc_clr-v.swup_sfc_clr2;
%lwup_sfc_clr_fdbck=v.lwup_sfc_clr-v.lwup_sfc_clr2;

%% time mean response fields
%toa_fdbck_mn=mean(toa_net_fdbck,1);
%olr_fdbck_mn=mean(olr_fdbck,1);
%sw_fdbck_mn=mean(sw_fdbck,1);
%lw_clr_fdbck_mn=mean(lw_clr_fdbck,1);
%sw_clr_fdbck_mn=mean(sw_clr_fdbck,1);
%olr_cre_fdbck_mn=mean(olr_cre_fdbck,1);
%sw_cre_fdbck_mn=mean(sw_cre_fdbck,1);
%toa_cre_fdbck_mn=olr_cre_fdbck_mn+sw_cre_fdbck_mn;
%
%precip_fdbck_mn=mean(precip_fdbck,1);
%wvp_fdbck_mn=mean(wvp_fdbck,1);
%lwp_fdbck_mn=mean(lwp_fdbck,1);
%wp_allcld_fdbck_mn=mean(wp_allcld_fdbck,1);
%tot_cld_fdbck_mn=mean(tot_cld_fdbck,1);
%midcld_fdbck_mn=mean(midcld_fdbck,1);
%lowcld_fdbck_mn=mean(lowcld_fdbck,1);
%highcld_fdbck_mn=mean(highcld_fdbck,1);
%%t_ref_fdbck_mn=mean(t_ref_fdbck,1);
%-----------------------------------------------------%
% compute global means using the cosine weighted latitude
%------------------------------------------------------------------------------------------

glblatweight=v.latweight;
%
for index=1:v.nlon-1;
    glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));
wgt_sst=v.tsurf.*glblatweight';
wgt_sst2=v.tsurf2.*glblatweight';
wgt_radflux=v.radflux.*glblatweight';
wgt_radflux2=v.radflux2.*glblatweight';
mnsst=sum(wgt_sst(:))/glbsumweight;
mnsst2=sum(wgt_sst2(:))/glbsumweight;
mnradflux=sum(wgt_radflux(:))/glbsumweight;
mnradflux2=sum(wgt_radflux2(:))/glbsumweight;
% global mean time mean responses
toa_fdbck_gtmn=mnradflux-mnradflux2
normfac=mnsst-mnsst2
glbmean_radimb=toa_fdbck_gtmn/normfac
%------------------------------------------------------------------------------------------
% normalized by global mean tsfc diff
% these should be time mean fields (1xlatxlon) normalized by the global sfc temp change
toa_fdbck_gnorm=toa_net_fdbck./normfac;
olr_fdbck_gnorm=olr_fdbck./normfac;
sw_fdbck_gnorm=sw_fdbck./normfac;
lw_clr_fdbck_gnorm=lw_clr_fdbck./normfac;
sw_clr_fdbck_gnorm=sw_clr_fdbck./normfac;
toa_cre_fdbck_gnorm=toa_cre_fdbck./normfac;
olr_cre_fdbck_gnorm=olr_cre_fdbck./normfac;
sw_cre_fdbck_gnorm=sw_cre_fdbck./normfac;
%
precip_fdbck_gnorm=precip_fdbck./normfac;
wvp_fdbck_gnorm=wvp_fdbck./normfac;
lwp_fdbck_gnorm=lwp_fdbck./normfac;
wp_allcld_fdbck_gnorm_mn=wp_allcld_fdbck./normfac;
tot_cld_fdbck_gnorm_mn=tot_cld_fdbck./normfac;
midcld_fdbck_gnorm_mn=midcld_fdbck./normfac;
lowcld_fdbck_gnorm_mn=lowcld_fdbck./normfac;
highcld_fdbck_gnorm_mn=highcld_fdbck./normfac;
%t_ref_fdbck_gnorm=t_ref_fdbck_mn./normfac;
