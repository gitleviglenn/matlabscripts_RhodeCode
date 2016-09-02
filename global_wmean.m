function global_wmean(fieldin,file1in,file2in,output_mn_ts)

% computes the cosine weighted global mean of an incoming variable
% the final product should be a time series of global mean values

% fieldin : variable to be averaged
% file1in : path for first file containing fieldin
% file2in : path for second file containing fieldin

% local parameters
istart=1;
iend=960;
tend=iend-istart;

var1='t_surf.nc';
%basedir='/archive/Ming.Zhao/awglg/ulm/';
%exp1name='AM4OM2F_c96l32_am4g5r11_2000climo_1pct/ts_all/';
%exp2name='AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/';
%exp1=strcat(basedir,exp1name);
%exp2=strcat(basedir,exp2name);
%expyrs1='atmos.006101-014012.';
%expyrs2='atmos.000101-014012.';
%base1=strcat(exp1,expyrs1);
%base2=strcat(exp2,expyrs2);
%fin=strcat(base1,var1);
%fin2=strcat(base2,var1);

% read input file
ff1 =netcdf(file1in,'nowrite');
ff2 =netcdf(file2in,'nowrite');

v.lon=ff1{'lon'}(:); v.lat =ff1{'lat'}(:);
% compute the weights
v.latweight=cos(pi/180*v.lat);
glblatweight=cos(pi/180*v.lat);
for index=1:v.nlon-1;
  glblatweight=horzcat(glblatweight,v.latweight);
end
glbsumweight=sum(glblatweight(:));

in_var=fieldin;
wgt_var=zeros(tend,v.nlat,v.nlon);
for ti=1:tend;
  temp_var      = in_var(ti,:,:);
  wgt_var       = squeeze(temp_var).*glblatweight;
  out_var(ti) = sum(wgt_var(:))/glbsumweight;
end
output_mn_ts=out_var;
