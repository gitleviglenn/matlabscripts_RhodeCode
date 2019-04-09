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

% figure with lwcre
lwoff = true;

% for the lwoff switch to work the model needs to be run with the lwoff path names
% which are set in the WalkerCell script.  Then the resulting data needs to be 
% saved to the appropriate arrays to be plotted as lwoff, as below.  Then the paths
% must be changed back to the control experiment and rerun. 

%evap_25km_ztmn_lwoff=evap_25km_ztmn;
%evap_2km_ztmn_lwoff=evap_2km_ztmn;
%evap_1km_ztmn_lwoff=evap_1km_ztmn;
%q_25km_ztmn_lwoff=q_25km_ztmn;
%q_2km_ztmn_lwoff=q_2km_ztmn;
%q_1km_ztmn_lwoff=q_1km_ztmn;
%u_25km_ztmn_lwoff=u_25km_ztmn;
%u_2km_ztmn_lwoff=u_2km_ztmn;
%u_1km_ztmn_lwoff=u_1km_ztmn;
%theta_e_gcm_lwoff=theta_e_gcm;
%theta_e_crm2_lwoff=theta_e_crm2;
%theta_e_crm1_lwoff=theta_e_crm1;
%temp_eq_ztmn_lwoff=temp_eq_ztmn;
%temp_crm1_ztmn_lwoff=temp_crm1_ztmn;
%temp_crm_ztmn_lwoff=temp_crm_ztmn;
%Tv_1km_lwoff=Tv_1km;
%Tv_2km_lwoff=Tv_2km;
%Tv_25km_lwoff=Tv_25km;
%u_1km_dmn_lwoff=u_1km_dmn;
%u_2km_dmn_lwoff=u_2km_dmn;
%u_25km_dmn_lwoff=u_25km_dmn;

%evap_25km_ztmn_noconvlwoff=evap_25km_ztmn;
%theta_e_gcm_noconvlwoff=theta_e_gcm;
%q_25km_ztmn_noconvlwoff=q_25km_ztmn;
%u_25km_ztmn_noconvlwoff=u_25km_ztmn;
%temp_eq_ztmn_noconvlwoff=temp_eq_ztmn;
%Tv_25km_noconvlwoff=Tv_25km;
%u_25km_dmn_noconvlwoff=u_25km_dmn;

if lwoff 
  figure
  subplot(2,3,1)
  plot(xcrm_2to1,evap_2km_ztmn,'Color',colblu)
  hold on
  plot(xcrm_2to1,evap_2km_ztmn_lwoff,'--','Color',colblu)
  plot(evap_1km_ztmn,'Color',colgrn)
  plot(evap_1km_ztmn_lwoff,'--','Color',colgrn)
  plot(xaxis_gcm2crm,evap_25km_ztmn,'Color',colyel)
  plot(xaxis_gcm2crm,evap_25km_ztmn_lwoff,'--','Color',colyel)
  plot(xaxis_gcm2crm,evap_25km_ztmn_noconvlwoff,'-.','Color',colyel)
  title('evaporation')
  
  subplot(2,3,2)
  plot(xcrm_2to1,theta_e_crm2(:,33),'Color',colblu)
  hold on
  plot(xcrm_2to1,theta_e_crm2_lwoff(:,33),'--','Color',colblu)
  plot(theta_e_crm1(:,33),'Color',colgrn)
  plot(theta_e_crm1_lwoff(:,33),'--','Color',colgrn)
  plot(xaxis_gcm2crm,theta_e_gcm(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,theta_e_gcm_lwoff(:,33),'--','Color',colyel)
  plot(xaxis_gcm2crm,theta_e_gcm_noconvlwoff(:,33),'-.','Color',colyel)
  title('equivalent theta')
  
  subplot(2,3,3)
  plot(q_1km_ztmn(:,33),'Color',colgrn)
  hold on
  title('q at 33, lowest atm level')
  plot(q_1km_ztmn_lwoff(:,33),'--','Color',colgrn)
  plot(xcrm_2to1,q_2km_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,q_2km_ztmn_lwoff(:,33),'--','Color',colblu)
  plot(xaxis_gcm2crm,q_25km_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,q_25km_ztmn_lwoff(:,33),'--','Color',colyel)
  plot(xaxis_gcm2crm,q_25km_ztmn_noconvlwoff(:,33),'-.','Color',colyel)
  
  subplot(2,3,4)
  plot(u_1km_ztmn(:,33),'Color',colgrn)
  hold on
  plot(-u_1km_ztmn(:,33),'Color',colgrn)
  plot(u_1km_ztmn_lwoff(:,33),'--','Color',colgrn)
  plot(-u_1km_ztmn_lwoff(:,33),'--','Color',colgrn)
  title('u wind at 33, lowest atm level')
  plot(xcrm_2to1,u_2km_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,u_2km_ztmn_lwoff(:,33),'--','Color',colblu)
  plot(xcrm_2to1,-u_2km_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,-u_2km_ztmn_lwoff(:,33),'--','Color',colblu)
  plot(xaxis_gcm2crm,u_25km_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,u_25km_ztmn_lwoff(:,33),'--','Color',colyel)
  plot(xaxis_gcm2crm,u_25km_ztmn_noconvlwoff(:,33),'-.','Color',colyel)
  plot(xaxis_gcm2crm,-u_25km_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,-u_25km_ztmn_lwoff(:,33),'--','Color',colyel)
  plot(xaxis_gcm2crm,-u_25km_ztmn_noconvlwoff(:,33),'-.','Color',colyel)
  
  subplot(2,3,5)
  plot(tsurf_crm1_ztmn,'k','LineWidth',2)
  hold on
  plot(temp_crm1_ztmn(:,33),'Color',colgrn)
  plot(temp_crm1_ztmn_lwoff(:,33),'--','Color',colgrn)
  plot(xcrm_2to1,temp_crm_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,temp_crm_ztmn_lwoff(:,33),'--','Color',colblu)
  plot(xaxis_gcm2crm,temp_eq_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,temp_eq_ztmn_lwoff(:,33),'--','Color',colyel)
  plot(xaxis_gcm2crm,temp_eq_ztmn_noconvlwoff(:,33),'-.','Color',colyel)
  plot(Tv_1km(:,33),'Color',colgrn,'LineWidth',2) 
  plot(Tv_1km_lwoff(:,33),'--','Color',colgrn,'LineWidth',2) 
  plot(xcrm_2to1,Tv_2km(:,33),'Color',colblu,'LineWidth',2) 
  plot(xcrm_2to1,Tv_2km_lwoff(:,33),'--','Color',colblu,'LineWidth',2) 
  plot(xaxis_gcm2crm,Tv_25km(:,33),'Color',colyel,'LineWidth',2) 
  plot(xaxis_gcm2crm,Tv_25km_lwoff(:,33),'--','Color',colyel,'LineWidth',2) 
  plot(xaxis_gcm2crm,Tv_25km_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',2) 
  title('surf temp and temp and lowest atm level')
  
  subplot(2,3,6)
  plot(u_1km_dmn(10:33),zzfull(10:33),'Color',colgrn)
  hold on
  plot(u_1km_dmn_lwoff(10:33),zzfull(10:33),'--','Color',colgrn)
  plot(u_2km_dmn(10:33),zzfull(10:33),'Color',colblu)
  plot(u_2km_dmn_lwoff(10:33),zzfull(10:33),'--','Color',colblu)
  plot(u_25km_dmn(10:33),zzfull(10:33),'Color',colyel)
  plot(u_25km_dmn_lwoff(10:33),zzfull(10:33),'--','Color',colyel)
  plot(u_25km_dmn_noconvlwoff(10:33),zzfull(10:33),'-.','Color',colyel)
  title('domain mean u wind')
  ylim([0 15000])
else
  figure
  subplot(2,3,1)
  plot(xcrm_2to1,evap_2km_ztmn,'Color',colblu)
  hold on
  plot(evap_1km_ztmn,'Color',colgrn)
  plot(xaxis_gcm2crm,evap_25km_ztmn,'Color',colyel)
  title('evaporation')
  
  subplot(2,3,2)
  plot(xcrm_2to1,theta_e_crm2(:,33),'Color',colblu)
  hold on
  plot(theta_e_crm1(:,33),'Color',colgrn)
  plot(xaxis_gcm2crm,theta_e_gcm(:,33),'Color',colyel)
  title('equivalent theta')
  
  subplot(2,3,3)
  plot(q_1km_ztmn(:,33),'Color',colgrn)
  hold on
  title('q at 33, lowest atm level')
  plot(xcrm_2to1,q_2km_ztmn(:,33),'Color',colblu)
  plot(xaxis_gcm2crm,q_25km_ztmn(:,33),'Color',colyel)
  
  subplot(2,3,4)
  plot(u_1km_ztmn(:,33),'Color',colgrn)
  hold on
  plot(-u_1km_ztmn(:,33),'Color',colgrn)
  title('u wind at 33, lowest atm level')
  plot(xcrm_2to1,u_2km_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,-u_2km_ztmn(:,33),'Color',colblu)
  plot(xaxis_gcm2crm,u_25km_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,-u_25km_ztmn(:,33),'Color',colyel)
  
  subplot(2,3,5)
  plot(tsurf_crm1_ztmn,'k','LineWidth',2)
  hold on
  plot(temp_crm1_ztmn(:,33),'Color',colgrn)
  plot(Tv_1km(:,33),'Color',colgrn,'LineWidth',1.5)
  plot(xcrm_2to1,temp_crm_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,Tv_2km(:,33),'Color',colblu,'LineWidth',1.5)
  plot(xaxis_gcm2crm,temp_eq_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,Tv_25km(:,33),'Color',colyel,'LineWidth',1.5)
  title('surf temp, T and Tv lowest atm level')
  
  subplot(2,3,6)
  plot(u_1km_dmn(10:33),zzfull(10:33),'Color',colgrn)
  hold on
  plot(u_2km_dmn(10:33),zzfull(10:33),'Color',colblu)
  plot(u_25km_dmn(10:33),zzfull(10:33),'Color',colyel)
  title('domain mean u wind')
  ylim([0 15000])
end

% figures from compTheta.m

% Figures -----------------------------------------

figure
subplot(2,3,1)
% the 0.01 factor converts to 100hPa/day
% I think, that vvel_d should be computed in units of Pa/day
vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,0.01.*vvel_d_25km',vvel_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
v=vvel_cons;
clabel(C,h,v);
set(h,'EdgeColor','none')
ylim([20000 100000])
title('GCM: diab vert velocity [hPa/d]')
set(gca,'Ydir','reverse')

subplot(2,3,2)
[C,h]=contourf(1:xcrm_ngp,pfull_2km,0.01.*vvel_d_2km',vvel_cons);
v=vvel_cons;
clabel(C,h,v);
set(h,'EdgeColor','none')
ylim([20000 100000])
title('CRM 2km: diab vert velocity [hPa/d]')
set(gca,'Ydir','reverse')

subplot(2,3,3)
[C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,0.01.*vvel_d_1km',vvel_cons);
v=vvel_cons;
clabel(C,h,v);
set(h,'EdgeColor','none')
ylim([20000 100000])
title('CRM 1km: diab vert velocity [hPa/d]')
set(gca,'Ydir','reverse')

%figure
plotOmega=true;

% if desired, the difference between the two vertical motion fields
% can be plotted.  the vvel_cons needs to be changed for the difference...
diff_omega_25km=864.*omega_25km_ztmn-0.01.*vvel_d_25km;
diff_omega_2km=864.*omega_2km_ztmn-0.01.*vvel_d_2km;
diff_omega_1km=864.*omega_1km_ztmn-0.01.*vvel_d_1km;

%diff_omega_25km=omega_25km_ztmn;
%diff_omega_2km=omega_2km_ztmn;
%diff_omega_1km=omega_1km_ztmn;

if plotOmega 
  %vvel_conl=[0.0,5,15,25,50];
  vvel_conl=[0.0];
  subplot(2,3,4)
  vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
  %vvel_cons=[-6,-4,-2,0.0,2,4,6];
  [C,h]=contourf(1:xgcm_ngp,pfull_2km,864.*omega_25km_ztmn',vvel_cons);
%  [C,h]=contourf(1:xgcm_ngp,pfull_2km,diff_omega_25km',vvel_cons);
  %v=[-50.,-25.,-5.,0.0,5,25,50];
  v=vvel_conl;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('GCM 25km: omega [hPa/d]')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,5)
  [C,h]=contourf(1:xcrm_ngp,pfull_2km,864.*omega_2km_ztmn',vvel_cons);
  %[C,h]=contourf(1:xcrm_ngp,pfull_2km,diff_omega_2km',vvel_cons);
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 2km: omega [hPa/d]')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,6)
  [C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,864.*omega_1km_ztmn',vvel_cons);
  %[C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,diff_omega_1km',vvel_cons);
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 1km: omega [hPa/d]')
  set(gca,'Ydir','reverse')
else
  subplot(2,3,4)
  div_cons=[-.45,-.4,-.35,-.3,-.25,-.2,-0.15,-0.1,-0.05,-0.01,0.0,0.01,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45];
  div_cons_lab=[-.3,-0.1,0.0,0.1,0.3];
  [C,h]=contourf(1:xgcm_ngp,pfull_2km,div_d_25km',div_cons);
  v=div_cons;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('GCM: diabatic divergence')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,5)
  [C,h]=contourf(1:xcrm_ngp,pfull_2km,div_d_2km',div_cons);
  v=div_cons_lab;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 2km: diabatic divergence')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,6)
  [C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,div_d_1km',div_cons);
  v=div_cons_lab;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 1km: diabatic divergence')
  set(gca,'Ydir','reverse')
end


stop

figure
plot(temp_crm_ztmn(1000,top_2plot:33),zzfull(top_2plot:33),'k')
hold on
plot(temp_crm_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'k','LineWidth',2)
plot(temp_crm_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--k')
plot(temp_crm1_ztmn(2000,top_2plot:33),zzfull(top_2plot:33),'g')
plot(temp_crm1_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'g','LineWidth',2)
plot(temp_crm1_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--g')
plot(temp_eq_ztmn(80,top_2plot:33),zzfull(top_2plot:33),'c')
plot(temp_eq_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'c','LineWidth',2)
plot(temp_eq_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--c')
title('Temperature')

figure
plot(temp_crm_ztmn(1000,top_2plot:33),pfull_gen(top_2plot:33),'k')
hold on
plot(temp_crm_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'k','LineWidth',2)
plot(temp_crm_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--k')
plot(temp_crm1_ztmn(2000,top_2plot:33),pfull_gen(top_2plot:33),'g')
plot(temp_crm1_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'g','LineWidth',2)
plot(temp_crm1_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--g')
plot(temp_eq_ztmn(80,top_2plot:33),pfull_gen(top_2plot:33),'c')
plot(temp_eq_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'c','LineWidth',2)
plot(temp_eq_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--c')
plot(fr_line(top_2plot:33),pfull_gen(top_2plot:33))
title('Temperature')
set(gca,'Ydir','reverse')

% plot the lapse rate
figure
plot(-1000.*gamma(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
plot(-1000.*gamma(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(-1000.*gamma(3,10:33),zzfull(10:33),'-o','Color',colgrn)
plot(1000.*gamma_m(1,10:33),zzfull(10:33),'-o','Color',colyel)
plot(1000.*gamma_m(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(1000.*gamma_m(3,10:33),zzfull(10:33),'-o','Color',colgrn)
xlim([0 10])
title('Lapse Rate (K/km)')

figure_plev=figure
axes2 = axes('Parent',figure_plev,'BoxStyle','full','YMinorTick','on',...
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
plot(-1000.*gamma(1,:),pfull_2km,'-o','Color',colyel)
hold on
plot(-1000.*gamma(2,:),pfull_2km,'-o','Color',colblu)
plot(-1000.*gamma(3,:),pfull_2km,'-o','Color',colgrn)
plot(1000.*gamma_m(3,:),pfull_2km,'-o','Color',colgrn)
plot(1000.*gamma_m(2,:),pfull_2km,'-o','Color',colblu)
plot(1000.*gamma_m(1,:),pfull_2km,'-o','Color',colyel)
xlim([0 10])
title('Lapse Rate (K/km)')


figure
gamma_crm_2d=gamma_2d_cen';
gamma_cons=[0,1,2,3,4,5,6];
v=gamma_cons;
[C,h]=contourf(750:1250,zzfull,-1000.*gamma_crm_2d)
clabel(C,h,v);
ylim([0 16000])
colorbar
title('Lapse Rate (K/km) center')

figure
gamma_crm_2d=gamma_2d_edg';
gamma_cons=[0,1,2,3,4,5,6];
v=gamma_cons;
[C,h]=contourf(0:500,zzfull,-1000.*gamma_crm_2d)
label(C,h,v);
ylim([0 16000])
colorbar
title('Lapse Rate (K/km) edge')


figure % convert from K/Pa to K/100hPa to compare with Mapes
plot(10000*stastapar(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
% the second index is for 2km, the third for 1km
plot(10000*stastapar(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(10000*stastapar(3,10:33),zzfull(10:33),'-o','Color',colgrn)
xlim([-10 0])
ylim([0 15000])
title('Static Stability Par (K/100hPa)')

figure_stasta_prof=figure
axes2 = axes('Parent',figure_stasta_prof,'BoxStyle','full','YMinorTick','on',...
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
plot(10000*stastapar(1,:),pfull_2km,'-o','Color',colyel)
plot(10000*stastapar(2,:),pfull_2km,'-o','Color',colblu)
plot(10000*stastapar(3,:),pfull_2km,'-o','Color',colgrn)
xlim([-10 0])
title('Static Stability Par (K/100hPa)')


figure
plot(theta_e_gcm_mid,pfull_2km,'Color',colyel)
hold on
%plot(theta_e_gcm(80,:),pfull_2km,'Color',colyel)
plot(theta_gcm(100,:),pfull_2km,'Color',colyel)
plot(theta_e_crm2_mid,pfull_2km,'Color',colblu)
plot(theta_crm2(1000,:),pfull_2km,'Color',colblu)
%plot(theta_e_crm2(1000,:),pfull_2km,'Color',colblu)
plot(theta_e_crm1_mid,pfull_2km,'Color',colgrn)
plot(theta_crm1(2000,:),pfull_2km,'Color',colgrn)
%plot(theta_e_crm1(2000),pfull_2km,'Color',colgrn)
set(gca,'Ydir','reverse')
title('equivalent pot temp')
ylim([20000 100000])
xlim([295 345])

figure
thetae_cons=[0.0,290,295,300,305,310,315,320,325.,330,335.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,theta_e_crm2',thetae_cons);
set(gca,'Ydir','reverse')
colorbar
clabel(C,h,thetae_cons);

% contour figures of the energetics

% for the crm's
tdtlw=tdtlw_2_ztmn;
tdtsw=tdtsw_2_ztmn;
tdtls=tdtls_2_ztmn;
xaxis=xcrm_ngp;

tdtlw=tdtlw_25_ztmn;
tdtsw=tdtsw_25_ztmn;
tdtls=tdtls_25km_ztmn;
xaxis=cgcm_ngp;

tit_st='2km Conv Exp';

figure
subplot(3,1,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xaxis,pfull_2km,tdtlw',heating_cons);
v=[-3.0,-2.0,-1.0,-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,1,2)
%heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xaxis,pfull_2km,tdtsw',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: sw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,1,3)
%heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xaxis,pfull_2km,tdtls',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: strat cloud heating K/d')
set(gca,'Ydir','reverse')

tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)

% create profile figures of domain mean relative humidity

%rh_25km_control=squeeze(mean(rh_mat,2));
%blab_rh=squeeze(mean(rh_mat,2));
rh_25km_tmp=squeeze(mean(rh_mat,2));
rh_25km_current=squeese(rh_25km_tmp(3,:));

rh_25km_noconv_2d=rh_25km_current;

figure1=figure
axes2 = axes('Parent',figure1,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
xlim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'on');
%rh_25km_control=blab_rh(3,:);
plot(rh_25km_control,pfull_2km,'--','Color',colyel,'LineWidth',1);
plot(rh_25km_noconv_2d,pfull_2km,'Color',colyel,'LineWidth',2);
hold on
plot(rh_25km_nolwcre,pfull_2km,'-.','Color',colyel,'LineWidth',1);
hur_crm=mean(hur_2km_ztmn,1);
hur_crm_1km=mean(hur_1km_ztmn,1);
plot(hur_crm_ctl(:),pfull_2km,'Color',colblu,'LineWidth',2);
plot(hur_crm_nolw(:),pfull_2km,'-.','Color',colblu,'LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);
title('Mean Cloud and RH')






