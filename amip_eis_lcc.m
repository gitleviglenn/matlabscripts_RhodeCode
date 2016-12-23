%
% plot the trend of low cloud amount from am4 model over an amip period
%
flcloud=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.low_cld_amt.nc','nowrite');
tsurfhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.t_surf.nc','nowrite');
%landhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc','nowrite');
%tsurfhandle=netcdf(ftsurf,'nowrite');

lcloud=flcloud{'low_cld_amt'}(:,:,:);
tsurf=tsurfhandle{'t_surf'}(:,:,:);
%land=landhandle{'land_mask'};

% mask out the land
% the land mask is originally has ocean set to zero and land rangning from .gt. zero to 1
%onlyocean=zeros(size(land));
%onlyocean(land>=0.1)=-999.;
%onlyocean(onlyocean==0)=1.;
%onlyocean(onlyocean==-999.)=0.;
%
onlyocean=make_onlyocean;
%
ctl_lcloud=lcloud(1:60,:,:);
ctl_tsurf=tsurf(1:60,:,:);
lcloud_period=lcloud(1:360,:,:);
tsurf_period=tsurf(1:360,:,:);
time=1:360;
mn_clt_lcloud=squeeze(mean(ctl_lcloud,1));
tmlcloud=squeeze(mean(lcloud_period,1));
mn_clt_tsurf=squeeze(mean(ctl_tsurf,1));
tmtsurf=squeeze(mean(tsurf_period,1));

regarray=zeros(size(tmlcloud));
regarray_tsfc=zeros(size(tmlcloud));
%
for ilon=1:1:288
  for ilat=1:1:180
    regval=polyfit(time',lcloud_period(:,ilat,ilon),1);
    regarray(ilat,ilon)=regval(1);
  end
end
trend_reg=360.*regarray;

lcloud_trend=tmlcloud-mn_clt_lcloud;
lcloud_trend_oo=lcloud_trend.*onlyocean;
lcloud_regtrend_oo=trend_reg.*onlyocean;

tsurf_trend=tmtsurf-mn_clt_tsurf;

cont_wcolorbar_eisdiff(lcloud_trend_oo,'AMIP LCC trend 5yr ctl')
cont_wcolorbar_eisdiff(lcloud_regtrend_oo,'AMIP LCC trend reg')

cont_wcolorbar_eisdiff(tsurf_trend,'AMIP tsfc trend reg')

%for ilon=1:1:288
%  for ilat=1:1:180
%    regvaltsfc=polyfit(time',tsurf(:,ilat,ilon),1);
%    regarray_tsfc(ilat,ilon)=regvaltsfc(1);
%  end
%end
%trend_reg_tsfc=360.*regarraytsfc;
%cont_wcolorbar_eisdiff(trend_reg_tsf,'AMIP Tsfc trend')
%
%
