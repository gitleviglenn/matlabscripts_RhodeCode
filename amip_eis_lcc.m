%
% plot the trend of low cloud amount from am4 model over an amip period
%
% files for AM4 g11r11 run
%
% the difference in the trend of low-level clouds between g11r11 and g12r04 is 
% interesting, although i don't know if it is significant...
%
%flcloud=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.low_cld_amt.nc','nowrite');
%tsurfhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.t_surf.nc','nowrite');

% files for AM4 g12r04 run
modeltitle='AM4 g12r04 AMIP LCC trend reg 1981-2010';
flcloud_g12r04=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp/ts_all/atmos.198101-201012.low_cld_amt.nc','nowrite');
tsurfhandle_g12r04=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp/ts_all/atmos.198101-201012.t_surf.nc','nowrite');

flcloud=flcloud_g12r04;
tsurfhandle=tsurfhandle_g12r04;

fmcloud=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp/ts_all/atmos.198101-201012.mid_cld_amt.nc','nowrite');
fhcloud=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp/ts_all/atmos.198101-201012.high_cld_amt.nc','nowrite');
fswdn_toa=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp/ts_all/atmos.198101-201012.swdn_toa.nc','nowrite');
fswdn_toa_clr=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g12r04_cosp/ts_all/atmos.198101-201012.swdn_toa_clr.nc','nowrite');

nlat=180;
nlon=288;

%landhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/gfdl.ncrc3-intel-prod-openmp/pp/atmos/atmos.static.nc','nowrite');
%tsurfhandle=netcdf(ftsurf,'nowrite');

% files for AM2 run
%modeltitle='AM2.1 AMIP LCC trend reg 1980-2005';
%flcloud=netcdf('/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/atmos.187001-200412.low_cld_amt.nc','nowrite');
%tsurfhandle=netcdf('/archive/fjz/AM2.1_1870-2004/AM2.1_1870-2004-HGlob-SST-ICE-1860RAD_A10/pp/atmos/ts/monthly/135yr/atmos.187001-200412.t_surf.nc','nowrite');

%%% files for AM3 run
%modeltitle='AM3 AMIP LCC trend reg 1980-2005';
%flcloud=netcdf('/archive/lwh/fms/riga_201104/c48L48_am3p9_1860_ext/gfdl.intel-prod/pp/atmos/ts/monthly/136yr/atmos.187001-200512.low_cld_amt.nc','nowrite');
%tsurfhandle=netcdf('/archive/lwh/fms/riga_201104/c48L48_am3p9_1860_ext/gfdl.intel-prod/pp/atmos/ts/monthly/136yr/atmos.187001-200512.t_surf.nc');
%%
%nlat=90;
%nlon=144;

lcloud=flcloud{'low_cld_amt'}(:,:,:);
latit=flcloud{'lat'}(:);
longit=flcloud{'lon'}(:);
tsurf=tsurfhandle{'t_surf'}(:,:,:);
%lcloud_g12r04=flcloud_g12r04{'low_cld_amt'}(:,:,:);
%tsurf_g12r04=tsurfhandle_g12r04{'t_surf'}(:,:,:);

%clear lcloud;
%clear tsurf;
%
%lcloud=lcloud_g12r04;
%tsurf=tsurf_g12r04;

%tref=trefhandle{'t_ref'}(:,:,:);
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
%stime=1320;
%endtime=1620; % months
stime=1;
endtime=360; % months
tlength=endtime-stime+1;
%
%ctl_lcloud=lcloud(1:60,:,:);
%ctl_tsurf=tsurf(1:60,:,:);
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
%AM2.1_1870-2004
%cont_wcolorbar_eisdiff(lcloud_regtrend_oo,'AM2.1 AMIP LCC trend reg 1980-2005')
%cont_wcolorbar_eisdiff(lcloud_regtrend_oo,'AM3 AMIP LCC trend reg 1980-2005')
%cont_wcolorbar_eisdiff(lcloud_regtrend_oo,'AM4 g12r04 AMIP LCC trend reg 1981-2010')
cont_wcolorbar_eisdiff(lcloud_regtrend_oo,modeltitle)

contsin=[-5,-4,-3,-2,-1,0,1,2,3,4,5];
caxisin=[-5 5];
cont_map_modis(lcloud_regtrend_oo,latit,longit,contsin,caxisin)
colorbar
title(modeltitle)

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
