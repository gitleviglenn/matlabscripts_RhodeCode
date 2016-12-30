
basedir='/archive/Levi.Silvers/awg/verona/'
expname='c96L32_am4g10r8_2000climo/ts_all/';
expname2='c96L32_am4g10r8_2000climo_p2K/ts_all/';
expname3='c96L32_am4g10r8_hadsstp1pctco2_climo/ts_all/';
base1=strcat(basedir,expname);
base2=strcat(basedir,expname2);
base3=strcat(basedir,expname3);
var1='atmos.000201-001112.t_surf.nc';
fin=strcat(base1,var1);
fin2=strcat(base2,var1);
fin3=strcat(base3,var1);
% read input file
f =netcdf(fin,'nowrite');
f2 =netcdf(fin2,'nowrite');
f3 =netcdf(fin3,'nowrite');
v.sst =f{'t_surf'}(:,:,:); 
v.sst_p2k =f2{'t_surf'}(:,:,:); 
v.sst_hadp1pct =f3{'t_surf'}(:,:,:); 
