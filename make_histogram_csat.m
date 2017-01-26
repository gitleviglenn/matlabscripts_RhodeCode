stringincoming='/archive/Levi.Silvers/awg/verona/c96L32_am4g10r8_2000climo_cosp_bigout/gfdl.ncrc3-intel-prod-openmp/pp/atmos_month_cospx/av/monthly_2yr/atmos_cloudsatcalipso.0002-0003.allt2.nc'
fin=netcdf(stringincoming,'nowrite');

csat=zeros(15,40);
calip=zeros(15,40);
%var={'csatcfad_1','csatcfad_2','csatcfad_3','csatcfad_4','csatcfad_5','csatcfad_6','csatcfad_7','csatcfad_8','csatcfad_9','csatcfad_10','csatcfad_11','csatcfad_12','csatcfad_13','csatcfad_14','csatcfad_15'};
%for index=1:15;
%  %csat2=fin{var(index)}(:,:,:,:);
%  %blah(index,:)=fin{var(index)}(:,:,:,:);
%  varin=var(index)
%  blahblah=fin{varin}(:,:,:,:);
%end

  csatindex=fin{'csatindx'}(:);
  latit=fin{'lat'}(:);

  % cloudsat
  csat(1,:)=fin{'csatcfad_1'}(:,:,:,:);
  csat(2,:)=fin{'csatcfad_2'}(:,:,:,:);
  csat(3,:)=fin{'csatcfad_3'}(:,:,:,:);
  csat(4,:)=fin{'csatcfad_4'}(:,:,:,:);
  csat(5,:)=fin{'csatcfad_5'}(:,:,:,:);
  csat(6,:)=fin{'csatcfad_6'}(:,:,:,:);
  csat(7,:)=fin{'csatcfad_7'}(:,:,:,:);
  csat(8,:)=fin{'csatcfad_8'}(:,:,:,:);
  csat(9,:)=fin{'csatcfad_9'}(:,:,:,:);
  csat(10,:)=fin{'csatcfad_10'}(:,:,:,:);
  csat(11,:)=fin{'csatcfad_11'}(:,:,:,:);
  csat(12,:)=fin{'csatcfad_12'}(:,:,:,:);
  csat(13,:)=fin{'csatcfad_13'}(:,:,:,:);
  csat(14,:)=fin{'csatcfad_14'}(:,:,:,:);
  csat(15,:)=fin{'csatcfad_15'}(:,:,:,:);

  % calipso
  calip(1,:)=fin{'srcfad_1'}(:,:,:,:);
  calip(2,:)=fin{'srcfad_2'}(:,:,:,:);
  calip(3,:)=fin{'srcfad_3'}(:,:,:,:);
  calip(4,:)=fin{'srcfad_4'}(:,:,:,:);
  calip(5,:)=fin{'srcfad_5'}(:,:,:,:);
  calip(6,:)=fin{'srcfad_6'}(:,:,:,:);
  calip(7,:)=fin{'srcfad_7'}(:,:,:,:);
  calip(8,:)=fin{'srcfad_8'}(:,:,:,:);
  calip(9,:)=fin{'srcfad_9'}(:,:,:,:);
  calip(10,:)=fin{'srcfad_10'}(:,:,:,:);
  calip(11,:)=fin{'srcfad_11'}(:,:,:,:);
  calip(12,:)=fin{'srcfad_12'}(:,:,:,:);
  calip(13,:)=fin{'srcfad_13'}(:,:,:,:);
  calip(14,:)=fin{'srcfad_14'}(:,:,:,:);
  calip(15,:)=fin{'srcfad_15'}(:,:,:,:);
