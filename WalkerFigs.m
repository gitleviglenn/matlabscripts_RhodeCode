%----------------------------------------------------------------------------
% basically a driver script that relies on fields computed in WalkerCell.m to 
% create a variety of figures
%
% levi silvers                               jan 2019
%----------------------------------------------------------------------------

colyel=[0.9290,0.6940,0.1250];  % used for 25km runs
colblu=[0.3010,0.7450,0.9330];  % 2 km runs
colgrn=[0.4660,0.6740,0.1880];  % 1 km runs

xcrm_2to1=0:2:3998;
xaxis_gcm2crm=0:25:3975;

figure
subplot(2,3,1)
plot(xcrm_2to1,evap_2km_ztmn,'Color',colblu)
hold on
plot(evap_1km_ztmn,'Color',colgrn)
plot(xaxis_gcm2crm,evap_25km_ztmn,'Color',colyel)
plot(xaxis_gcm2crm,evap_25km_ztmn_lwcre,'--','Color',colyel)
title('evaporation')

%figure
subplot(2,3,2)
plot(xcrm_2to1,theta_e_crm2(:,33),'Color',colblu)
hold on
plot(theta_e_crm1(:,33),'Color',colgrn)
plot(xaxis_gcm2crm,theta_e_gcm(:,33),'Color',colyel)
plot(xaxis_gcm2crm,theta_e_gcm_lwcre(:,33),'--','Color',colyel)
title('equivalent theta')

%figure
subplot(2,3,3)
plot(q_1km_ztmn(:,33),'Color',colgrn)
hold on
title('q at 33, lowest atm level')
plot(xcrm_2to1,q_2km_ztmn(:,33),'Color',colblu)
plot(xaxis_gcm2crm,q_25km_ztmn(:,33),'Color',colyel)
plot(xaxis_gcm2crm,q_25km_ztmn_lwcre(:,33),'--','Color',colyel)

%figure
subplot(2,3,4)
plot(u_1km_ztmn(:,33),'Color',colgrn)
hold on
plot(-u_1km_ztmn(:,33),'Color',colgrn)
title('u wind at 33, lowest atm level')
plot(xcrm_2to1,u_2km_ztmn(:,33),'Color',colblu)
plot(xcrm_2to1,-u_2km_ztmn(:,33),'Color',colblu)
plot(xaxis_gcm2crm,u_25km_ztmn(:,33),'Color',colyel)
plot(xaxis_gcm2crm,u_25km_ztmn_lwcre(:,33),'--','Color',colyel)
plot(xaxis_gcm2crm,-u_25km_ztmn(:,33),'Color',colyel)
plot(xaxis_gcm2crm,-u_25km_ztmn_lwcre(:,33),'--','Color',colyel)
%ylim([0 4])

%figure
subplot(2,3,5)
plot(tsurf_crm1_ztmn,'k','LineWidth',2)
hold on
plot(temp_crm1_ztmn(:,33),'Color',colgrn)
plot(xcrm_2to1,temp_crm_ztmn(:,33),'Color',colblu)
plot(xaxis_gcm2crm,temp_eq_ztmn(:,33),'Color',colyel)
plot(xaxis_gcm2crm,temp_eq_ztmn_lwcre(:,33),'--','Color',colyel)
title('surf temp and temp and lowest atm level')

%figure
subplot(2,3,6)
plot(u_1km_dmn(10:33),zzfull(10:33),'Color',colgrn)
hold on
plot(u_2km_dmn(10:33),zzfull(10:33),'Color',colblu)
plot(u_25km_dmn(10:33),zzfull(10:33),'Color',colyel)
plot(u_25km_dmn_lwcre(10:33),zzfull(10:33),'--','Color',colyel)
title('domain mean u wind')
ylim([0 15000])
