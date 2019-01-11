%WalkerEnergetics.m

% calls the function rho_2d_gen()

% run this within WalkerCell.m

conv=60*60*24; % convert to Kelvin per day

source_100km_month=strcat(path_100km,yearstr,'.atmos_month_tmn.nc');

% kg/m2 s
evap_25km=ncread(source_gcm_month,'evap');
evap_2km=ncread(source_2km_month,'evap');

% W/m2
sh_25km=ncread(source_gcm_month,'shflx');
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
tdtconv_25km=ncread(source_gcm_month,'tdt_conv');
tdtconv_100km=ncread(source_100km_month,'tdt_conv');
%tdtconv_2km=ncread(source_2km_month,'tdt_conv');

tdtconv_25km=conv.*tdtconv_25km;
tdtconv_25km_tmn=squeeze(mean(tdtconv_25km,4));
tdtconv_25km_ztmn=squeeze(mean(tdtconv_25km_tmn,2));
tdtconv_25km_prof=squeeze(mean(tdtconv_25km_ztmn,1));

tdtconv_100km=conv.*tdtconv_100km;
tdtconv_100km_tmn=squeeze(mean(tdtconv_100km,4));
tdtconv_100km_ztmn=squeeze(mean(tdtconv_100km_tmn,2));
tdtconv_100km_prof=squeeze(mean(tdtconv_100km_ztmn,1));


% deg K/s
tdtls_100km=ncread(source_100km_month,'tdt_ls');
tdtls_25km=ncread(source_gcm_month,'tdt_ls');
tdtls_2km=ncread(source_2km_month,'tdt_ls');
tdtls_1km=ncread(source_1km_month,'tdt_ls');

tdtls_100km=conv.*tdtls_100km;
tdtls_100km_tmn=squeeze(mean(tdtls_100km,4));
tdtls_100km_ztmn=squeeze(mean(tdtls_100km_tmn,2));
tdtls_100km_prof=squeeze(mean(tdtls_100km_ztmn,1));

tdtls_25km=conv.*tdtls_25km;
tdtls_25km_tmn=squeeze(mean(tdtls_25km,4));
tdtls_25km_ztmn=squeeze(mean(tdtls_25km_tmn,2));
tdtls_25km_prof=squeeze(mean(tdtls_25km_ztmn,1));

tdtls_2=conv.*tdtls_2km(:,:,:,t_mid:t_end);
tdtls_2_tmn=squeeze(mean(tdtls_2,4));
tdtls_2_ztmn=squeeze(mean(tdtls_2_tmn,2));
tdtls_2km_prof=squeeze(mean(tdtls_2_ztmn,1));

tdtls_1=conv.*tdtls_1km(:,:,:,t_mid:t_end);
tdtls_1_tmn=squeeze(mean(tdtls_1,4));
tdtls_1_ztmn=squeeze(mean(tdtls_1_tmn,2));
tdtls_1km_prof=squeeze(mean(tdtls_1_ztmn,1));

% deg K/s
tdtvdif_25km=ncread(source_gcm_month,'tdt_vdif');
tdtvdif_25km=conv.*tdtvdif_25km;

tdtvdif_2km=ncread(source_2km_month,'tdt_vdif');
tdtvdif_2km=conv.*tdtvdif_2km;


% det K/s
tdtlw_25km=ncread(source_gcm_month,'tdt_lw');
tdtlw_25km=conv.*tdtlw_25km(:,:,:,an_t1:an_t2);
tdtlw_25_tmn=squeeze(mean(tdtlw_25km,4));
tdtlw_25_ztmn=squeeze(mean(tdtlw_25_tmn,2));

tdtlw_100km=ncread(source_100km_month,'tdt_lw');
tdtlw_100km=conv.*tdtlw_100km(:,:,:,1:4);
tdtlw_100_tmn=squeeze(mean(tdtlw_100km,4));
tdtlw_100_ztmn=squeeze(mean(tdtlw_100_tmn,2));

tdtlw_2km=ncread(source_2km_month,'tdt_lw');
tdtlw_2km=conv.*tdtlw_2km(:,:,:,t_mid:t_end);
tdtlw_2_tmn=squeeze(mean(tdtlw_2km,4));
tdtlw_2_ztmn=squeeze(mean(tdtlw_2_tmn,2));

tdtlw_1km=ncread(source_1km_month,'tdt_lw');
tdtlw_1km=conv.*tdtlw_1km(:,:,:,t_mid:t_end);
tdtlw_1_tmn=squeeze(mean(tdtlw_1km,4));
tdtlw_1_ztmn=squeeze(mean(tdtlw_1_tmn,2));
% det K/s
tdtsw_100km=ncread(source_100km_month,'tdt_sw');
tdtsw_100km=conv.*tdtsw_100km(:,:,:,1:4);
tdtsw_100_tmn=squeeze(mean(tdtsw_100km,4));
tdtsw_100_ztmn=squeeze(mean(tdtsw_100_tmn,2));

tdtsw_25km=ncread(source_gcm_month,'tdt_sw');
tdtsw_25km=conv.*tdtsw_25km(:,:,:,an_t1:an_t2);
tdtsw_25_tmn=squeeze(mean(tdtsw_25km,4));
tdtsw_25_ztmn=squeeze(mean(tdtsw_25_tmn,2));

tdtsw_2km=ncread(source_2km_month,'tdt_sw');
tdtsw_2km=conv.*tdtsw_2km(:,:,:,4:6);
tdtsw_2_tmn=squeeze(mean(tdtsw_2km,4));
tdtsw_2_ztmn=squeeze(mean(tdtsw_2_tmn,2));

tdtsw_1km=ncread(source_1km_month,'tdt_sw');
tdtsw_1km=conv.*tdtsw_1km(:,:,:,4:6);
tdtsw_1_tmn=squeeze(mean(tdtsw_1km,4));
tdtsw_1_ztmn=squeeze(mean(tdtsw_1_tmn,2));

% W/m2  net lw flux (at the surface i think)
lwflx_25km=ncread(source_gcm_month,'lwflx');
lwflx_2km=ncread(source_2km_month,'lwflx');

% W/m2  net sh flux 
shflx_25km=ncread(source_gcm_month,'shflx');
shflx_2km=ncread(source_2km_month,'shflx');

% W/m2
olr_25km=ncread(source_gcm_month,'olr');
olr_2km=ncread(source_2km_month,'olr');
olr_zmn=squeeze(mean(olr_25km,2));
olr_zxmn=squeeze(mean(olr_zmn,1));

swdn_t_25km=ncread(source_gcm_month,'swdn_toa');
swdn_t_2km=ncread(source_2km_month,'swdn_toa');
swdn_t_zmn=squeeze(mean(swdn_t_25km,2));
swdn_t_zxmn=squeeze(mean(swdn_t_zmn,1));

swup_t_25km=ncread(source_gcm_month,'swup_toa');
swup_t_2km=ncread(source_2km_month,'swup_toa');
swup_t_zmn=squeeze(mean(swup_t_25km,2));
swup_t_zxmn=squeeze(mean(swup_t_zmn,1));

rad_net_toa=-olr_zxmn+swdn_t_zxmn-swup_t_zxmn;

precip_100km=ncread(source_100km_month,'precip');
precip_25km=ncread(source_gcm_month,'precip');
precip_2km=ncread(source_2km_month,'precip');
precip_1km=ncread(source_1km_month,'precip');

precip_100_zmn=squeeze(mean(precip_100km,2));
precip_100_zxmn=squeeze(mean(precip_100_zmn,1));
precip_100_tmn=squeeze(mean(precip_100_zxmn,2));
precip_100km_en=scale2*precip_100_tmn

precip_25_zmn=squeeze(mean(precip_25km,2));
precip_25_zxmn=squeeze(mean(precip_25_zmn,1));
precip_25_tmn=squeeze(mean(precip_25_zxmn,2));
precip_25km_en=scale2*precip_25_tmn

precip_2_zmn=squeeze(mean(precip_2km,2));
precip_2_zxmn=squeeze(mean(precip_2_zmn,1));
precip_2_tmn=squeeze(mean(precip_2_zxmn,2));
precip_2km_en=scale2*precip_2_tmn

precip_1_zmn=squeeze(mean(precip_1km,2));
precip_1_zxmn=squeeze(mean(precip_1_zmn,1));
precip_1_tmn=squeeze(mean(precip_1_zxmn,2));
precip_1km_en=scale2*precip_1_tmn

%precip_ts=latheat.*precip_zxmn;

heatrad_100km=ncread(source_100km_month,'heat2d_rad');
heatrad_25km=ncread(source_gcm_month,'heat2d_rad');
heatrad_2km=ncread(source_2km_month,'heat2d_rad');
heatrad_1km=ncread(source_1km_month,'heat2d_rad');

heatsw_25km=ncread(source_gcm_month,'heat2d_sw');
heatsw_2km=ncread(source_2km_month,'heat2d_sw');

heatr_100km_1=squeeze(mean(heatrad_100km,1));
heatr_100km_2=squeeze(mean(heatr_100km_1,1));
heatr_100km_dmn=squeeze(mean(heatr_100km_2,2));

MeanRadH_100km=heatr_100km_dmn

heatr_25km_1=squeeze(mean(heatrad_25km,1));
heatr_25km_2=squeeze(mean(heatr_25km_1,1));
heatr_25km_dmn=squeeze(mean(heatr_25km_2,2));

MeanRadH_25km=heatr_25km_dmn

heatr_2km_1=squeeze(mean(heatrad_2km,1));
heatr_2km_2=squeeze(mean(heatr_2km_1,1));
heatr_2km_dmn=squeeze(mean(heatr_2km_2,2));

MeanRadH_2km=heatr_2km_dmn

heatr_1km_1=squeeze(mean(heatrad_1km,1));
heatr_1km_2=squeeze(mean(heatr_1km_1,1));
heatr_1km_dmn=squeeze(mean(heatr_1km_2,2));

MeanRadH_1km=heatr_1km_dmn

MeanRadPrec=[MeanRadH_1km MeanRadH_2km MeanRadH_25km MeanRadH_100km; precip_1km_en precip_2km_en precip_25km_en precip_100km_en]
%MeanPrecip_25km=mean(p_25km_tmean,1)
%MeanPrecip_2km=mean(p_2km_tmean,1)

%compTheta

stst=zeros(160,33);
app_R=zeros(160,33);

%Tv_25km=temp_25km_ztmn.*(1+sphum_25km_ztmn./epsilon)./(1+sphum_25km_ztmn);
%Tv_2km=temp_crm_ztmn.*(1+sphum_2km_ztmn./epsilon)./(1+sphum_2km_ztmn);
Tv_25km=temp_25km_ztmn.*(1+q_25km_ztmn./epsilon)./(1+q_25km_ztmn);
Tv_2km=temp_crm_ztmn.*(1+q_2km_ztmn./epsilon)./(1+q_2km_ztmn);

clear rho_25km;
clear rho_2km;

rho_25km=rho_2d_gen(temp_25km_ztmn,q_25km_ztmn,pfull_25km,160);
rho_2km=rho_2d_gen(temp_crm_ztmn,q_2km_ztmn,pfull_2km,2000);

%for j=33:-1:1
%    for i=1:160
%        rho_25km(i,j)=pfull_25km(j)/(r_dry*Tv_25km(i,j));
%        %rho_25km(i,j)=pfull_25km(j)./(r_dry*temp_25km_ztmn(i,j));
%    end
%end
%for j=33:-1:1
%    for i=1:2000
%        rho_2km(i,j)=pfull_2km(j)/(r_dry*Tv_2km(i,j));
%    end
%end

for j=2:32
    for i=1:160
        stst(i,j)=(.102/rho_25km(i,j)).*(temp_25km_ztmn(i,j)/theta_znm(i,j).*((theta_znm(i,j+1)-theta_znm(i,j-1))/(zfull_25km_ztmn(i,j+1)-zfull_25km_ztmn(i,j-1))));
        %stst(i,j)=-(temp_znm(i,j)/theta_znm(i,j).*((theta_znm(i,j+1)-theta_znm(i,j-1))/(pfull_25km(j+1)-pfull_25km(j-1))));
    end 
end

for i=1:160
    %stst(i,1)=-(.1/rho_25km(i,j)).*(temp_znm(i,1)/theta_znm(i,1).*((theta_znm(i,2)-theta_znm(i,1))/(pfull_25km(2)-pfull_25km(1))));
    %stst(i,33)=-(.1/rho_25km(i,j)).*(temp_znm(i,33)/theta_znm(i,33).*((theta_znm(i,33)-theta_znm(i,32))/(pfull_25km(33)-pfull_25km(32))));
    stst(i,1)=(.102/rho_25km(i,1)).*(temp_25km_ztmn(i,1)/theta_znm(i,1).*((theta_znm(i,2)-theta_znm(i,1))/(zfull_25km_ztmn(i,2)-zfull_25km_ztmn(i,1))));
    stst(i,33)=(.102/rho_25km(i,33)).*(temp_25km_ztmn(i,33)/theta_znm(i,33).*((theta_znm(i,33)-theta_znm(i,32))/(zfull_25km_ztmn(i,33)-zfull_25km_ztmn(i,32))));
end 

%stst_conv=stst*conv;
%app_R=w_25km_ztmn./stst;
app_R=conv*w_25km_ztmn.*stst;   % units?  should be K/day

rad_heating_100=tdtlw_100_ztmn+tdtsw_100_ztmn;
rad_heat_prof_100=mean(rad_heating_100,1);

rad_heating_25=tdtlw_25_ztmn+tdtsw_25_ztmn;
rad_heat_prof_25=mean(rad_heating_25,1);

rad_heating_1=tdtlw_1_ztmn+tdtsw_1_ztmn;
rad_heat_prof_1=mean(rad_heating_1,1);

rad_heating_2=tdtlw_2_ztmn+tdtsw_2_ztmn;
rad_heat_prof_2=mean(rad_heating_2,1);

figure_prof=figure
axes2 = axes('Parent',figure_prof,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
%set(gca,'Ydir','reverse')
plot(rad_heat_prof_25,pfull_2km,'-.k','LineWidth',2.0);
hold on
plot(rad_heat_prof_100,pfull_2km,':k','LineWidth',2.0);
plot(rad_heat_prof_2,pfull_2km,'k','LineWidth',1.5);
plot(rad_heat_prof_1,pfull_2km,'--k','LineWidth',1.5);

figure
plot(tdtls_100km_prof,pfull_2km,'-.b');
set(gca,'Ydir','reverse')
hold on
plot(tdtconv_100km_prof,pfull_2km,'--b');
plot(tdtconv_100km_prof+tdtls_100km_prof,pfull_2km,'b','LineWidth',2);
plot(tdtls_25km_prof,pfull_2km,'-.r');
plot(tdtconv_25km_prof,pfull_2km,'--r');
plot(tdtconv_25km_prof+tdtls_25km_prof,pfull_2km,'r','LineWidth',2);
plot(tdtls_2km_prof,pfull_2km,'k','LineWidth',2);
plot(tdtls_1km_prof,pfull_2km,'g','LineWidth',2);

figure
plot(rad_heat_prof_25,pfull_2km,'-.k','LineWidth',2);
set(gca,'Ydir','reverse')
hold on
plot(tdtconv_25km_prof+tdtls_25km_prof,pfull_2km,'-.k','LineWidth',2);
plot(rad_heat_prof_100,pfull_2km,':k','LineWidth',2);
plot(tdtconv_100km_prof+tdtls_100km_prof,pfull_2km,':k','LineWidth',2);
plot(rad_heat_prof_2,pfull_2km,'--k','LineWidth',2);
plot(tdtls_2km_prof,pfull_2km,'--k','LineWidth',2);
plot(rad_heat_prof_1,pfull_2km,'-k','LineWidth',2);
plot(tdtls_1km_prof,pfull_2km,'-k','LineWidth',2);

tdt_total_cloud=tdtconv_25km_ztmn+tdtls_25km_ztmn;

%---------------------------------------------------------------
% % FIGURES ----------------------------------------------
% 
figure
subplot(3,3,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')
colorbar

subplot(3,3,4)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_ztmn',heating_cons);
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
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtls_25km_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 
colorbar

subplot(3,3,5)
heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtconv_25km_ztmn',heating_cons);
v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: convective heating K/d')
set(gca,'Ydir','reverse')
colorbar



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
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtls_2_ztmn',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 
colorbar

subplot(3,3,6)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtsw_2_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: sw heating K/d')
set(gca,'Ydir','reverse')
colorbar
tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)

subplot(3,3,3)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtlw_2_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: lw heating K/d')
set(gca,'Ydir','reverse')
colorbar

% %------------------------
% 
% figure
% subplot(2,2,1)
% heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_ztmn',heating_cons);
% v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
% clabel(C,h,v);
% title('GCM: sw heating K/d')
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(2,2,2)
% heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_ztmn',heating_cons);
% v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
% clabel(C,h,v);
% title('GCM: lw heating K/d')
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(2,2,3)
% heating_cons=[-1.5,-1.25,-1.0,-0.75,-.5,-.25,0.0,0.25,0.5,0.75,1.,1.25,1.5];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,rad_heating',heating_cons);
% v=[-1.5,-1.0,-.5,0.0,0.5,1.0,1.5]; % if labels are desired on contours
% caxis=([-1.5 1.25]);
% clabel(C,h,v);
% title('GCM: heating from lw + sw (K/d)')
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(2,2,4)
% heating_cons=[-1.5,-1.25,-1.0,-0.75,-.5,-.25,0.0,0.25,0.5,0.75,1.,1.25,1.5];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,app_R',heating_cons);
% v=[-1.5,-1.0,-.5,0.0,0.5,1.0,1.5]; % if labels are desired on contours
% caxis=([-1.5 1.25]);
% clabel(C,h,v);
% title('GCM: app heating, S*w (K/d)?')
% set(gca,'Ydir','reverse')
% colorbar
% 
% tit_en=strcat('Energetics: ',tit_st);
% suptitle(tit_en)
