%WalkerEnergetics.m

% run this within WalkerCell.m

conv=60*60*24; % convert to Kelvin per day

% kg/m2 s
evap_25km=ncread(source_25km_month,'evap');
evap_2km=ncread(source_2km_month,'evap');

% W/m2
sh_25km=ncread(source_25km_month,'shflx');
sh_2km=ncread(source_2km_month,'shflx');

% convert to energy units of W/m2
evap_25km_en=latheat.*evap_25km;
evap_25km_en_zmn=squeeze(mean(evap_25km_en,2));
evap_25km_en_ztmn=squeeze(mean(evap_25km_en_zmn,2));

sh_25km_zmn=squeeze(mean(sh_25km,2));
sh_25km_ztmn=squeeze(mean(sh_25km_zmn,2));

evap_2km_en=latheat.*evap_2km;
evap_2km_en_ztmn=squeeze(mean(evap_2km_en,2));

sh_2km_zmn=squeeze(mean(sh_2km,2));
sh_2km_ztmn=squeeze(mean(sh_2km_zmn,2));

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
tdtlw_25km=conv.*tdtlw_25km(:,:,:,an_t1:an_t2);
tdtlw_25_tmn=squeeze(mean(tdtlw_25km,4));
tdtlw_25_tzmn=squeeze(mean(tdtlw_25_tmn,2));

tdtlw_2km=ncread(source_2km_month,'tdt_lw');
tdtlw_2km=conv.*tdtlw_2km;
tdtlw_2_tmn=squeeze(mean(tdtlw_2km,4));
tdtlw_2_tzmn=squeeze(mean(tdtlw_2_tmn,2));
% det K/s
tdtsw_25km=ncread(source_25km_month,'tdt_sw');
tdtsw_25km=conv.*tdtsw_25km(:,:,:,an_t1:an_t2);
tdtsw_25_tmn=squeeze(mean(tdtsw_25km,4));
tdtsw_25_tzmn=squeeze(mean(tdtsw_25_tmn,2));

tdtsw_2km=ncread(source_2km_month,'tdt_sw');
tdtsw_2km=conv.*tdtsw_2km;
tdtsw_2_tmn=squeeze(mean(tdtsw_2km,4));
tdtsw_2_tzmn=squeeze(mean(tdtsw_2_tmn,2));

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

%compTheta

stst=zeros(160,33);
app_R=zeros(160,33);

for j=2:32
    for i=1:160
        stst(i,j)=(.102/rho_25km(i,j)).*(temp_znm(i,j)/theta_znm(i,j).*((theta_znm(i,j+1)-theta_znm(i,j-1))/(zfull_25km_ztmn(i,j+1)-zfull_25km_ztmn(i,j-1))));
        %stst(i,j)=-(temp_znm(i,j)/theta_znm(i,j).*((theta_znm(i,j+1)-theta_znm(i,j-1))/(pfull_25km(j+1)-pfull_25km(j-1))));
    end 
end

for i=1:160
    %stst(i,1)=-(.1/rho_25km(i,j)).*(temp_znm(i,1)/theta_znm(i,1).*((theta_znm(i,2)-theta_znm(i,1))/(pfull_25km(2)-pfull_25km(1))));
    %stst(i,33)=-(.1/rho_25km(i,j)).*(temp_znm(i,33)/theta_znm(i,33).*((theta_znm(i,33)-theta_znm(i,32))/(pfull_25km(33)-pfull_25km(32))));
    stst(i,1)=(.102/rho_25km(i,1)).*(temp_znm(i,1)/theta_znm(i,1).*((theta_znm(i,2)-theta_znm(i,1))/(zfull_25km_ztmn(i,2)-zfull_25km_ztmn(i,1))));
    stst(i,33)=(.102/rho_25km(i,33)).*(temp_znm(i,33)/theta_znm(i,33).*((theta_znm(i,33)-theta_znm(i,32))/(zfull_25km_ztmn(i,33)-zfull_25km_ztmn(i,32))));
end 

%stst_conv=stst*conv;
%app_R=w_25km_ztmn./stst;
app_R=conv*w_25km_ztmn.*stst;   % units?  should be K/day

rad_heating=tdtlw_25_tzmn+tdtsw_25_tzmn;

%---------------------------------------------------------------
% FIGURES ----------------------------------------------

figure
subplot(3,3,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(3,3,4)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: sw heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(3,3,7)
plot(xgcm(1:xgcm_ngp),evap_25km_en_ztmn,'r','LineWidth',1.5);
hold on;
plot(xgcm(1:xgcm_ngp),sh_25km_ztmn,'r','LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),evap_2km_en_ztmn,'k','LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),sh_2km_ztmn,'k','LineWidth',1.5);
title('Surface Fluxes: W/m2')

%
subplot(3,3,2)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtls_25km_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 
colorbar

subplot(3,3,5)
heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtconv_25km_tzmn',heating_cons);
v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: convective heating K/d')
set(gca,'Ydir','reverse')
colorbar

tdt_total_cloud=tdtconv_25km_tzmn+tdtls_25km_tzmn;

subplot(3,3,8)
heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdt_total_cloud',heating_cons);
v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: conv + ls heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(3,3,9)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtls_2km_tzmn',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 
colorbar

subplot(3,3,6)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtsw_2_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: sw heating K/d')
set(gca,'Ydir','reverse')
colorbar
tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)

subplot(3,3,3)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtlw_2_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: lw heating K/d')
set(gca,'Ydir','reverse')
colorbar

%------------------------

figure
subplot(2,2,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: sw heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(2,2,2)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_tzmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(2,2,3)
heating_cons=[-1.5,-1.25,-1.0,-0.75,-.5,-.25,0.0,0.25,0.5,0.75,1.,1.25,1.5];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,rad_heating',heating_cons);
v=[-1.5,-1.0,-.5,0.0,0.5,1.0,1.5]; % if labels are desired on contours
caxis=([-1.5 1.25]);
clabel(C,h,v);
title('GCM: heating from lw + sw (K/d)')
set(gca,'Ydir','reverse')
colorbar

subplot(2,2,4)
heating_cons=[-1.5,-1.25,-1.0,-0.75,-.5,-.25,0.0,0.25,0.5,0.75,1.,1.25,1.5];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,app_R',heating_cons);
v=[-1.5,-1.0,-.5,0.0,0.5,1.0,1.5]; % if labels are desired on contours
caxis=([-1.5 1.25]);
clabel(C,h,v);
title('GCM: app heating, S*w (K/d)?')
set(gca,'Ydir','reverse')
colorbar

tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)
