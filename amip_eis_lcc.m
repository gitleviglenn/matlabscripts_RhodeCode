%
% plot the trend of low cloud amount from am4 model over an amip period
%
flcloud=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.low_cld_amt.nc','nowrite');
landpath='/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc'
lcloud=flcloud{'low_cld_amt'}(:,:,:);
fland=netcdf(landpath,'nowrite');
land=fland{'land_mask'};
onlyocean=zeros(size(land));
regarray=zeros(size(land));
%onlyocean(land~=0)=-999.;
% the land mask is originally has ocean set to zero and land rangning from .gt. zero to 1
onlyocean(land>=0.1)=-999.;
onlyocean(onlyocean==0)=1.;
onlyocean(onlyocean==-999.)=0.;

ctl_lcloud=lcloud(1:60,:,:);
lcloud_period=lcloud(1:360,:,:);
time=1:360;
mn_clt_lcloud=squeeze(mean(ctl_lcloud,1));
tmlcloud=squeeze(mean(lcloud_period,1));

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

cont_wcolorbar_eisdiff(lcloud_trend_oo,'AMIP LCC trend 5yr ctl')
cont_wcolorbar_eisdiff(lcloud_regtrend_oo,'AMIP LCC trend reg')
