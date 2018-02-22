%----------------------------------------------------------------------------
% cloud_cov_total.m
%
% read data file with total cloud cover and computes the sum value
%
% this should provide a basic check on the implementation of the COSP 
% simulator.  we need to ensure that the total cloud cover model output is 
% the same as the total cloud cover computed by COSP for the simulators 
%
% levi silvers                                                  july 2016
%----------------------------------------------------------------------------a

ls /archive/Levi.Silvers/awg/ulm_201505/c96L32_am4g9_2000climo_cosp_isccp/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_misr/av/monthly_10yr/atmos_month_misr_am4g9_5yrjan_fldmean.nc
infile='/archive/Levi.Silvers/awg/ulm_201505/c96L32_am4g9_2000climo_cosp_isccp/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_misr/av/monthly_10yr/atmos_month_misr_am4g9_5yrjan_fldmean.nc'
f=netcdf(infile,'nowrite');

% read the data
misr1=f{'misr_1'}(:,:,:,:);
misr2=f{'misr_2'}(:,:,:,:);
misr3=f{'misr_3'}(:,:,:,:);
misr4=f{'misr_4'}(:,:,:,:);
misr5=f{'misr_5'}(:,:,:,:);
misr6=f{'misr_6'}(:,:,:,:);
misr7=f{'misr_7'}(:,:,:,:);
misr8=f{'misr_8'}(:,:,:,:);
misr9=f{'misr_9'}(:,:,:,:);
misr10=f{'misr_10'}(:,:,:,:);
misr11=f{'misr_11'}(:,:,:,:);
misr12=f{'misr_12'}(:,:,:,:);
misr13=f{'misr_13'}(:,:,:,:);
misr14=f{'misr_14'}(:,:,:,:);
misr15=f{'misr_15'}(:,:,:,:);
misr16=f{'misr_16'}(:,:,:,:);

% testsumsum should be the sum of all misr# fields
test=horzcat(misr1,misr2,misr3,misr4,misr5,misr6,misr7,misr8,misr9,misr10,misr11,misr12,misr13,misr14,misr15,misr16);
testsum=sum(test);
testsumsum=sum(testsum);


