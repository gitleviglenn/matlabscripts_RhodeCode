%WalkerEnergetics.m

% run this within WalkerCell.m

conv=60*60*24; % convert to Kelvin per day

% kg/m2 s
evap_25km=ncread(source_25km_month,'evap');
evap_2km=ncread(source_2km_month,'evap');

% deg K/s
tdtconv_25km=ncread(source_25km_month,'tdt_conv');
tdtconv_2km=ncread(source_2km_month,'tdt_conv');

tdtconv_25km=conv.*tdtconv_25km;
tdtconv_2km=conv.*tdtconv_2km;
tdtconv_25km_tmn=squeeze(mean(tdtconv_25km,4));
tdtconv_25km_tzmn=squeeze(mean(tdtconv_25km_tmn,2));
tdtconv_2km_tmn=squeeze(mean(tdtconv_2km,4));
tdtconv_2km_tzmn=squeeze(mean(tdtconv_2km_tmn,2));

% deg K/s
tdtls_25km=ncread(source_25km_month,'tdt_ls');
tdtls_2km=ncread(source_2km_month,'tdt_ls');

tdtls_25km=conv.*tdtls_25km;
tdtls_2km=conv.*tdtls_2km;
tdtls_25km_tmn=squeeze(mean(tdtls_25km,4));
tdtls_25km_tzmn=squeeze(mean(tdtls_25km_tmn,2));

tdtls_2km_tmn=squeeze(mean(tdtls_2km,4));
tdtls_2km_tzmn=squeeze(mean(tdtls_2km_tmn,2));

% deg K/s
tdtvdif_25km=ncread(source_25km_month,'tdt_vdif');
tdtvdif_2km=ncread(source_2km_month,'tdt_vdif');

tdtvdif_25km=conv.*tdtvdif_25km;
tdtvdif_2km=conv.*tdtvdif_2km;



% det K/s
tdtlw_25km=ncread(source_25km_month,'tdt_lw');
tdtlw_2km=ncread(source_2km_month,'tdt_lw');
tdtlw_25km=conv.*tdtlw_25km;
tdtlw_2km=conv.*tdtlw_2km;
tdtlw_25_tmn=squeeze(mean(tdtlw_25km,4));
tdtlw_25_tzmn=squeeze(mean(tdtlw_25_tmn,2));
tdtlw_2_tmn=squeeze(mean(tdtlw_2km,4));
tdtlw_2_tzmn=squeeze(mean(tdtlw_2_tmn,2));
% det K/s
tdtsw_25km=ncread(source_25km_month,'tdt_sw');
tdtsw_2km=ncread(source_2km_month,'tdt_sw');
tdtsw_25km=conv.*tdtsw_25km;
tdtsw_2km=conv.*tdtsw_2km;
tdtsw_tmn=squeeze(mean(tdtsw_25km,4));
tdtsw_tzmn=squeeze(mean(tdtsw_tmn,2));

% W/m2  net lw flux (at the surface i think)
lwflx_25km=ncread(source_25km_month,'lwflx');
lwflx_2km=ncread(source_2km_month,'lwflx');

% W/m2  net sh flux 
shflx_25km=ncread(source_25km_month,'shflx');
shflx_2km=ncread(source_2km_month,'shflx');

% W/m2
olr_25km=ncread(source_25km_month,'olr');
olr_2km=ncread(source_2km_month,'olr');
olr_zmn=squeeze(mean(olr_25km,2));
olr_zxmn=squeeze(mean(olr_zmn,1));

swdn_t_25km=ncread(source_25km_month,'swdn_toa');
swdn_t_2km=ncread(source_2km_month,'swdn_toa');
swdn_t_zmn=squeeze(mean(swdn_t_25km,2));
swdn_t_zxmn=squeeze(mean(swdn_t_zmn,1));

swup_t_25km=ncread(source_25km_month,'swup_toa');
swup_t_2km=ncread(source_2km_month,'swup_toa');
swup_t_zmn=squeeze(mean(swup_t_25km,2));
swup_t_zxmn=squeeze(mean(swup_t_zmn,1));

rad_net_toa=-olr_zxmn+swdn_t_zxmn-swup_t_zxmn;

precip_25km=ncread(source_25km_month,'precip');
precip_2km=ncread(source_2km_month,'precip');
precip_zmn=squeeze(mean(precip_25km,2));
precip_zxmn=squeeze(mean(precip_zmn,1));

precip_ts=latheat.*precip_zxmn;

heatrad_25km=ncread(source_25km_month,'heat2d_rad');
heatrad_2km=ncread(source_2km_month,'heat2d_rad');

heatsw_25km=ncread(source_25km_month,'heat2d_sw');
heatsw_2km=ncread(source_2km_month,'heat2d_sw');

figure
subplot(3,2,1)
heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtconv_25km_tzmn',heating_cons);
v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('convective heating K/d')
set(gca,'Ydir','reverse')
colorbar

% figure
% subplot(3,2,2)
% heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
% [C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtconv_2km_tzmn',heating_cons);
% v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
% clabel(C,h,v);
% title('convective heating K/d')
% set(gca,'Ydir','reverse')
% colorbar

subplot(3,2,3)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtls_25km_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('strat cloud heating K/d')
set(gca,'Ydir','reverse') 
colorbar

subplot(3,2,4)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtls_2km_tzmn',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.5,1.0,2.0]; % if labels are desired on contours
%clabel(C,h,v);
title('strat cloud heating K/d')
set(gca,'Ydir','reverse') 
colorbar

subplot(3,2,5)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('lw heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(3,2,6)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtlw_2_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('lw heating K/d')
set(gca,'Ydir','reverse')
colorbar
