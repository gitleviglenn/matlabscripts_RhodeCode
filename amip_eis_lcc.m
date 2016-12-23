%
% plot the trend of low cloud amount from am4 model over an amip period
%
% files for AM4 run
%flcloud=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.low_cld_amt.nc','nowrite');
%tsurfhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.t_surf.nc','nowrite');

%landhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc','nowrite');
%tsurfhandle=netcdf(ftsurf,'nowrite');

% files for AM2 run
%flcloud=netcdf('/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/atmos.187001-200412.low_cld_amt.nc','nowrite');
%tsurfhandle=netcdf('/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/atmos.187001-200412.t_surf.nc','nowrite');

% files for AM3 run
flcloud=netcdf('/archive/lwh/fms/riga_201104/c48L48_am3p9_1860_ext/gfdl.intel-prod/pp/atmos/ts/monthly/136yr/atmos.187001-200512.low_cld_amt.nc','nowrite');
tsurfhandle=netcdf('/archive/lwh/fms/riga_201104/c48L48_am3p9_1860_ext/gfdl.intel-prod/pp/atmos/ts/monthly/136yr/atmos.187001-200512.t_surf.nc');

nlat=90;
nlon=144;

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
stime=1320;
endtime=1620; % months
tlength=endtime-stime+1;
%
ctl_lcloud=lcloud(1:60,:,:);
ctl_tsurf=tsurf(1:60,:,:);
lcloud_period=lcloud(stime:endtime,:,:);
tsurf_period=tsurf(stime:endtime,:,:);
time=stime:endtime;
mn_clt_lcloud=squeeze(mean(ctl_lcloud,1));
tmlcloud=squeeze(mean(lcloud_period,1));
mn_clt_tsurf=squeeze(mean(ctl_tsurf,1));
tmtsurf=squeeze(mean(tsurf_period,1));

regarray=zeros(size(tmlcloud));
regarray_tsfc=zeros(size(tmlcloud));
%
for ilon=1:1:nlon
  for ilat=1:1:nlat
    regval=polyfit(time',lcloud_period(:,ilat,ilon),1);
    regarray(ilat,ilon)=regval(1);
  end
end
trend_reg=tlength.*regarray;

lcloud_trend=tmlcloud-mn_clt_lcloud;
lcloud_trend_oo=lcloud_trend.*onlyocean;
lcloud_regtrend_oo=trend_reg.*onlyocean;

%cont_wcolorbar_eisdiff(lcloud_trend_oo,'AMIP LCC trend 5yr ctl')
cont_wcolorbar_eisdiff(lcloud_regtrend_oo,'AM3 AMIP LCC trend reg 1980-2005')

%tsurf_trend=tmtsurf-mn_clt_tsurf;
%cont_wcolorbar_eisdiff(tsurf_trend,'AMIP tsfc trend reg')

%for ilon=1:1:nlon
%  for ilat=1:1:nlat
%    regvaltsfc=polyfit(time',tsurf_period(:,ilat,ilon),1);
%    regarray_tsfc(ilat,ilon)=regvaltsfc(1);
%  end
%end
%trend_reg_tsfc=tlength.*regarray_tsfc;
%tsfc_regtrend_oo=trend_reg_tsfc.*onlyocean;
%cont_wcolorbar_eisdiff(tsfc_regtrend_oo,'AMIP Tsfc trend')
%
%
