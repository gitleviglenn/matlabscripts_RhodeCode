% this script uses amip data to compute eis and lts
%
% path to Mings amip experiment:
mpath='/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/';
mpath2='/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/monthly_30yr/atmos.1981-2010.01.nc';
years='.198101-201012.';
string1=strcat(mpath,'atmos',years,'t_surf.nc')
string2=strcat(mpath,'atmos',years,'temp.nc')
string3=strcat(mpath,'atmos',years,'rh.nc')
string4=strcat(mpath,'atmos',years,'hght.nc')

%tsurfhandle=netcdf('/archive/Ming.Zhao/awg/verona/c96L32_am4g11r11_SOAv2/ts_all/atmos.198101-201012.t_surf.nc','nowrite');
tsurfhandle=netcdf(string1,'nowrite');
temphandle=netcdf(string2,'nowrite');
levhandle=netcdf(mpath2,'nowrite');
rhhandle=netcdf(string3,'nowrite');
heighthandle=netcdf(string4,'nowrite');

v.tsurf_full =tsurfhandle{'t_surf'}(:,:,:); 
v.tsurf=squeeze(v.tsurf_full(1,:,:));
v.temp_full=temphandle{'temp'}(:,:,:,:); 
v.temp_full(v.temp_full<0)=NaN;
v.temp=squeeze(nanmean(v.temp_full,1));
%v.temp=squeeze(v.temp_full(1,:,:,:));
v.level =levhandle{'level'}(:,:); 
v.level=v.level*100.;
v.rh_full=rhhandle{'rh'}(:,:,:,:);
v.rh_full(v.rh_full<0)=NaN;
v.rh=squeeze(nanmean(v.rh_full,1));
%v.rh=squeeze(v.rh_full(2,:,:,:));
v.hght_full=heighthandle{'hght'}(:,:,:,:);
v.hght_full(v.hght_full<-999)=NaN;
v.hght=squeeze(nanmean(v.hght_full,1));
%v.hght=squeeze(v.hght_full(1,:,:,:));

comp_eis_lts_09
%
lts_amip=lts_f;
eis_amip=estinvs;
diff_term=eis_amip-lts_amip;
%
%cont_wcolorbar_eisdiff(diff_term','EIS - LTS');
