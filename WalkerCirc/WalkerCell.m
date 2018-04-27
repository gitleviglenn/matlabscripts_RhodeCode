path_base='/Users/silvers/data/WalkerCell/'
%tit_st=' cos sq ';
%tit_st=' gaussian ';
%path_25km=path;

path=strcat(path_base,'gauss_d/');
%path=path_base;

%path_25km='/Users/silvers/data/WalkerCell/gauss_d/'
%init_st_fname='19790101';
%init_st_fname=strcat(path,'c96L33_8x80_nh.19790101');

% original paths
tit_st='4K ent1p1';

% timing variables for gcm 
an_t1=4; % for months
an_t2=12;

an_t1_d=120;
an_t2_d=365;

% timing variables for crm [days]
t_end=28; % was 59 original
t_mid=1; % was 30 originally

% at least for now, our control is wlkr_4K_b
path_25km=strcat(path,'c96L33_am4p0_8x160_nh_25km_wlkr_4K_ent1p1/','19790101');
path_2km=strcat(path,'am4p0_50x2000_4K/','19790301');

source_25km=strcat(path_25km,'.atmos_daily.nc');
source_2km=strcat(path_2km,'.atmos_daily.nc');

source_25km_month=strcat(path_25km,'.atmos_month.nc');
source_2km_month=strcat(path_2km,'.atmos_month.nc');

source_25km_8xday=strcat(path_25km,'.atmos_8xdaily.nc');
source_2km_8xday=strcat(path_2km,'.atmos_8xdaily.nc');

% domain related parameters:
xgcm=0:25:4000; % size of gcm domain in km
xgcm_ngp=160; % gcm number of grid points in x
xcrm=0:2:4000; % size of crm domain in km
xcrm_ngp=2000; % crm number of grid points in x

% latent heat of vaporization
latheat=2.26e6 % J/kg

% scaling factors
% precip can be converted into mm/day (scale1) 
% or energy units of W/m2 (scale2)
scale1=86400.; % s m^2 mm / kg day
scale2=2.265e-6; % J/kg
scale=scale1;
cltscale=100. % convert to percentage of cloud fraction

% read variables from input files

% precipitation
precip_25km=ncread(source_25km,'precip');
precip_2km=ncread(source_2km,'precip');
precip_25km_8x=ncread(source_25km_8xday,'precip');
precip_2km_8x=ncread(source_2km_8xday,'precip');
p_cv_25km=ncread(source_25km,'prec_conv'); %kg(h2o)/m2/2
p_ls_25km=ncread(source_25km,'prec_ls');
p_cv_2km=ncread(source_2km,'prec_conv'); %kg(h2o)/m2/2
p_ls_2km=ncread(source_2km,'prec_ls');

precip_25km_znm=mean(precip_25km,2);
precip_2km_znm=mean(precip_2km,2);
precip_25km_8x_znm=mean(precip_25km_8x,2);
precip_2km_8x_znm=mean(precip_2km_8x,2);

%p_contours=[10.,20.,30.,40.,50.,60.,70.,80.,90.,100.];
%p_contours=[5.,20.,35.,50.,65.,80.,95.,110.,125.,140.];

%precip_25km_znm=mean(precip_25km,2);
%precip_25km_8x=precip_25km_8x(:,:,4800:2920);
%precip_25km_8x_znm=mean(precip_25km_8x,2);
%precip_2km_znm=mean(precip_2km,2);
%precip_2km_8x_znm=mean(precip_2km_8x,2);
p_2km_znm=scale.*(squeeze(precip_2km_znm));
p_2km_8x_znm=scale.*(squeeze(precip_2km_8x_znm));
p_25km_znm=scale.*(squeeze(precip_25km_znm));
p_25km_8x_znm=scale.*(squeeze(precip_25km_8x_znm));

% time mean precip
p_25km_8x_znm_equil=p_25km_8x_znm(:,960:2920);
p_25km_tmean=mean(p_25km_8x_znm_equil,2);
p_2km_tmean=mean(p_2km_8x_znm,2);

% vertical velocity
w_25km=ncread(source_25km,'w');
w_2km=ncread(source_2km,'w');
w500_25km=ncread(source_25km,'w500');
w500_2km=ncread(source_2km,'w500');

clt_2km=ncread(source_2km,'cld_amt');
clt_25km=ncread(source_25km,'cld_amt');

liq_2km=ncread(source_2km_month,'tot_liq_amt');
liq_25km=ncread(source_25km_month,'tot_liq_amt');

ice_2km=ncread(source_2km_month,'tot_ice_amt');
ice_25km=ncread(source_25km_month,'tot_ice_amt');

hur_2km=ncread(source_2km_month,'rh');
hur_25km=ncread(source_25km_month,'rh');

pfull_2km=ncread(source_2km,'pfull');
pfull_25km=ncread(source_2km_month,'pfull');

tsurf=ncread(source_25km,'t_surf');
temp_25km=ncread(source_25km_month,'temp');

zfull_25km=ncread(source_2km_month,'z_full');
zfull_25km_zmn=squeeze(mean(zfull_25km,2));
zfull_25km_ztmn=squeeze(mean(zfull_25km_zmn,3));

liq_2km_tot=liq_2km+ice_2km;
liq_2km_zmn=squeeze(mean(liq_2km_tot,2));

liq_25km_tot=liq_25km+ice_25km;
liq_25km_zmn=squeeze(mean(liq_25km_tot,2));
liq_25km_zmn_last10m=liq_25km_zmn(:,:,an_t1:an_t2);
liq_25km_zmn_1m=squeeze(mean(liq_25km_zmn_last10m,3));

% relative humidity
% for the 2km runs, the time dimension is often not present becuase it is 1

hur_2km_zmn=squeeze(mean(hur_2km,2));
hur_25km_zmn=squeeze(mean(hur_25km,2));

hur_2km_zmn_1m=hur_2km_zmn;
hur_25km_zmn_last10m=hur_25km_zmn(:,:,an_t1:an_t2);
hur_25km_zmn_1m=squeeze(mean(hur_25km_zmn_last10m,3));


q_25km=ncread(source_25km_month,'sphum');
q_25km_zmn=squeeze(mean(q_25km,2));
q_25km_zmn_end=q_25km_zmn(:,:,an_t1:an_t2);
%q_25km_zmn_end=q_25km_zmn(:,:,2);
q_25km_zmntmn=mean(q_25km_zmn_end,3);

q_2km=ncread(source_2km_month,'sphum');
q_2km_zmn=squeeze(mean(q_2km,2));
%q_2km_zmn_end=q_2km_zmn(:,:,2);
%q_2km_zmntmn=mean(q_2km_zmn_end,3);

q_2km_zmntmn=squeeze(q_2km_zmn(:,:,1));

tsurf1=squeeze(tsurf(:,4,300)); % indices shouldn't matter here...

clt_25km_znm=cltscale.*squeeze(mean(clt_25km,2));
%clt_25km_znm_2m=clt_25km_znm(:,:,61:90);
clt_25km_znm_2m=clt_25km_znm(:,:,an_t1_d:an_t2_d);

clt_2km_znm=cltscale.*squeeze(mean(clt_2km,2));
clt_2km_znm_end=clt_2km_znm(:,:,t_mid:t_end);
clt_2km_znm_start=clt_2km_znm(:,:,1:t_mid);

clt_25km_znm_2mtmn=squeeze(mean(clt_25km_znm_2m,3));

clt_2km_znm_st_tmn=mean(clt_2km_znm_start,3);
clt_2km_znm_end_tmn=mean(clt_2km_znm_end,3);
clt_25km_znm_tmn=mean(clt_25km_znm,3); % this is over a full year...

% grab w at or near 500 mb
w_25km_532=squeeze(w_25km(:,:,18,:)); % grab 532 level
w_25km_532_zmn=squeeze(mean(w_25km_532,2));
w_25km_532_zmn_tm=mean(w_25km_532_zmn,2);
w500_25km_zmn=squeeze(mean(w500_25km,2)); % output on the 500mb level
w500_25km_zmn_tm=mean(w500_25km_zmn,2);

w_2km_532=squeeze(w_2km(:,:,18,t_mid:t_end));
w_2km_532_zmn=squeeze(mean(w_2km_532,2));
w_2km_532_zmn_tm=mean(w_2km_532_zmn,2);
w500_2km_zmn=squeeze(mean(w500_2km,2)); % output on the 500mb level
w500_2km_zmn_tm=mean(w500_2km_zmn,2);

% w at all levels
w_25km_zmn=squeeze(mean(w_25km,2));
w_25km_zmn_tmn_last8=squeeze(w_25km_zmn(:,:,an_t1_d:an_t2_d));
w_25km_zmn_tm=squeeze(mean(w_25km_zmn_tmn_last8,3));
w_2km_zmn=squeeze(mean(w_2km,2));
w_2km_zmn_tm=mean(w_2km_zmn(:,:,t_mid:t_end),3); 

q25=q_25km_zmntmn';
q2=q_2km_zmntmn';

% compute the potential temperature
compTheta

StreamFun

% psi_mat=zeros(5,160,33);
% WalkerCell
% StreamFun
% psi_mat(3,:,:)=psi_3(:,:);
% WalkerCell
% StreamFun
% psi_mat(4,:,:)=psi_3(:,:);
% etc....

% p_mat=zeros(5,160,2920);
% WalkerCell
% p_mat(1,:,:)=p_25km_8x_znm(:,:);
% WalkerCell
% p_mat(2,:,:)=p_25km_8x_znm(:,:);
% WalkerCell
% p_mat(3,:,:)=p_25km_8x_znm(:,:);
% WalkerCell
% p_mat(4,:,:)=p_25km_8x_znm(:,:);
% WalkerCell
% p_mat(5,:,:)=p_25km_8x_znm(:,:);

%-----------------------------------------------------------------------
% figures

% points at which to plot profiles
gcm_ris=xgcm_ngp/2;
gcm_sub=xgcm_ngp-4;
crm_ris=xcrm_ngp/2;
crm_sub=xcrm_ngp-100;

figure
%clt_contours=[1.,3.,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.,55.,60.,65.,70.,75.,80.,85.,90.,95.];
clt_contours=[1,3,5,10,15,20,25,30];
subplot(1,2,1)
%caxis=([1 25]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,clt_2km_znm_end_tmn',clt_contours,'EdgeColor','None');
v=[5,10,20,30,50,70];
clabel(C,h,v);
tit_a=strcat('cloud fraction 2km')
title(tit_a)
set(gca,'Ydir','reverse')
colorbar
subplot(1,2,2)
%caxis=([1 25]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,clt_25km_znm_tmn',clt_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('cloud fraction 25km')
title(tit_b)
set(gca,'Ydir','reverse')
colorbar
suptitle(tit_st)


figure
plot(q25(:,gcm_ris),pfull_2km,'--r','LineWidth',2);
set(gca,'Ydir','reverse')
hold on
plot(q25(:,gcm_sub),pfull_2km,'r','LineWidth',2);
plot(q2(:,crm_ris),pfull_2km,'--k','LineWidth',2);
plot(q2(:,crm_sub),pfull_2km,'k','LineWidth',2);
ylabel('Pressure','FontSize',20)
xlabel('kg/kg','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
tit_c=strcat('Specific Humidity',tit_st);
title(tit_c)

% figure
% plot(xgcm(1:xgcm_ngp),tsurf1,'k','LineWidth',2);
% ylabel('Kelvin','FontSize',20)
% xlabel('km','FontSize',20)
% yt=get(gca,'YTick');
% set(gca,'FontSize',16)
% tit_d=strcat('Surface Temperature',tit_st);
% title(tit_d)

figure
wlev=18;
subplot(1,2,1)
plot(xcrm(1:xcrm_ngp),w_2km_zmn_tm(:,wlev),'k','LineWidth',2);
%plot(xcrm(1:xcrm_ngp),w500_2km_zmn_tm(:),'k','LineWidth',2);
hold on
plot(xgcm(1:xgcm_ngp),w_25km_zmn_tm(:,wlev),'r','LineWidth',2);
%plot(xgcm(1:xgcm_ngp),w500_25km_zmn_tm(:),'r','LineWidth',2);
ylabel('w (m/s)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
tit_e=strcat('Vertical Velocity');
title(tit_e)

subplot(1,2,2)
% plot precip time mean
plot(xcrm(1:xcrm_ngp),p_2km_tmean(:),'k','LineWidth',2);
hold on
plot(xgcm(1:xgcm_ngp),p_25km_tmean(:),'r','LineWidth',2);
ylabel('Precip (mm/d)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
MeanPrecip_25km=mean(p_25km_tmean,1)
MeanPrecip_2km=mean(p_2km_tmean,1)
tit_e=strcat('Precip GCM:',num2str(MeanPrecip_25km),' CRM:',num2str(MeanPrecip_2km));
title(tit_e); 
suptitle(tit_st)


figure
liq_2km_zmn_scale=liq_2km_zmn*1000.;
liq_25km_zmn_scale=liq_25km_zmn_1m*1000.;
q_contours=[0.03,0.01,0.001,0.0001,0.00001];
subplot(1,2,1)
caxis=([0.00001 0.03]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
v=[0.03,0.01,0.001,0.0001,0.00001];
clabel(C,h,v);
tit_a=strcat('liq+ice water 2km');
title(tit_a);
set(gca,'Ydir','reverse')
colorbar
subplot(1,2,2)
caxis=([0.00001 0.03]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,liq_25km_zmn_scale',q_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('liq+ice 25km');
title(tit_b);
set(gca,'Ydir','reverse')
colorbar
tit_liq=strcat('liq: ',tit_st);
suptitle(tit_liq)

figure
rh_contours=[5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85];
subplot(1,2,1)
caxis=([10 80]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,hur_2km_zmn_1m',rh_contours,'EdgeColor','None');
v=[10,20,30,50,70];
clabel(C,h,v);
tit_a=strcat('relative humidity 2km');
title(tit_a);
%set(gca,'Ydir','reverse')
%colorbar
hold on
contour(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
set(gca,'Ydir','reverse')
colorbar

subplot(1,2,2)
caxis=([10 80]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,hur_25km_zmn_1m',rh_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('relative humidity 25km');
title(tit_b);
set(gca,'Ydir','reverse')
colorbar
tit_rh=strcat('RH: ',tit_st);
suptitle(tit_rh)

%StreamFun
%WalkerEnergetics