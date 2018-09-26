path_base='/Users/silvers/data/WalkerCell/'
%tit_st=' cos sq ';
%tit_st=' gaussian ';
%path_25km=path;

path=strcat(path_base,'gauss_d/');
%path=path_base;

%path_25km='/Users/silvers/data/WalkerCell/gauss_d/'
%init_st_fname='19790101';
%init_st_fname=strcat(path,'c96L33_8x80_nh.19790101');

%exptype: 0: default; 2: p4K; 3: lwoff
if (experi < 2) 
    estr='ent0p5'
    estr2='ent0p5'
    if (exptype > 2)
        estr2='ent0p5_p4K'
    elseif (exptype > 1)
        estr2='ent0p5_lwoff'
    end
    %estr2='ent0p5_p4K'
    ind=1
    % initialize several matrices to hold the ensemble of gcm experiments
    %psi_mat       = zeros(5,160,33);
    p_mat         = zeros(5,160,2920);
    prec_mn_mat   = zeros(6,1);
    radh_mn_mat   = zeros(6,1);
    rh_mat        = zeros(5,160,33);
    cl_mat        = zeros(5,160,33);
    tdtlw_mat     = zeros(5,160,33);
    tdtsw_mat     = zeros(5,160,33);
    tdtconv_mat   = zeros(5,160,33);
    tdt_totcl_mat = zeros(5,160,33);
    rad_heat_mat  = zeros(5,33);
    lts_mat       = zeros(5,160);
elseif (experi < 3)
estr='ent0p7'
estr2='ent0p7'
if (exptype > 2)
  estr2='ent0p7_p4K'
elseif (exptype > 1)
  estr2='ent0p7_lwoff'
end
ind=2
elseif (experi < 4)
estr='ent0p9'
estr2='ent0p9'
if (exptype > 2)
  estr2='ent0p9_p4K'
elseif (exptype > 1)
  estr2='ent0p9_lwoff'
end
%estr2='b' % this is only necessary because of the stupid experiment names i chose
ind=3
elseif (experi < 5)
estr='ent1p1'
estr2='ent1p1'
if (exptype > 2)
  estr2='ent1p1_p4K'
elseif (exptype > 1)
  estr2='ent1p1_lwoff'
end
ind=4
elseif (experi < 6)
estr='ent1p3'
estr2='ent1p3'
if (exptype > 2)
  estr2='ent1p3_p4K'
elseif (exptype > 1)
  estr2='ent1p3_lwoff'
end
ind=5
end 

%tit_st='4K ent1p1';
tit_st=strcat('4K ',estr2);

% timing variables for gcm 
an_t1=4; % for months
an_t2=12;

an_t1_d=120;
an_t2_d=365;

% timing variables for crm [days]
%t_end=181; % was 59 original
%t_mid=91; % was 30 originally
t_mid=3;
t_end=6;

yearstr_100km='/1980th1983';
yearstr='/19790101';

% at least for now, our control is wlkr_4K_b
%path_25km=strcat(path,'c96L33_am4p0_8x160_nh_25km_wlkr_4K_',estr2,'/19790101');
path_25km=strcat(path,'c8x160L33_am4p0_25km_wlkr_',estr2,yearstr);
path_100km=strcat(path,'c8x160L33_am4p0_100km_wlkr_',estr2,yearstr);
%path_2km=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','19790401');
%path_2km=strcat(path,'c50x2000L33_am4p0_2km_wlkr_4K/');
%path_1km=strcat(path,'c96L33_am4p0_10x4000_nh_1km_wlkr_4K/');
path_1km=strcat(path,'c10x4000L33_am4p0_1km_wlkr_4K/');
% path_2km=strcat(path,'am4p0_50x2000_4K/','19790301');

source_25km=strcat(path_25km,'.atmos_daily.nc');
%source_2km=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','1979_6mn.atmos_daily.nc');
%source_2km=strcat(path_2km,'.atmos_daily.nc');

source_25km_month=strcat(path_25km,'.atmos_month.nc');
%source_100km_month=strcat(path_100km,'.atmos_month_tmn.nc');
source_100km_month=strcat(path_100km,'.atmos_month.nc');
% source_2km_month=strcat(path,'c96L33_am4p0_50x2000_nh_2km_wlkr_4K/','1979_6mn.atmos_month.nc');
source_2km_month=strcat(path,'c50x2000L33_am4p0_2km_wlkr_4K/','1979_6mn.atmos_month.nc');
source_2km_dprecp=strcat(path,'c50x2000L33_am4p0_2km_wlkr_4K/','1979_6mn.atmos_daily_precp.nc');
source_1km_month=strcat(path,'c10x4000L33_am4p0_1km_wlkr_4K/','1979_6mn.atmos_month.nc');
%source_1km_month=strcat(path_1km,'19790301.atmos_month_psivars.nc');
%source_1km_month=strcat(path_1km,'1979.mn3456.atmos_month_psivars.tmn.nc');
source_1km_liq_month=strcat(path_1km,'1979.040506.atmos_month.liqvars.3months.nc');
%source_2km_month=strcat(path_2km,'.atmos_month.nc');

source_25km_8xday=strcat(path_25km,'.atmos_8xdaily.nc');
%source_2km_8xday=strcat(path_2km,'.atmos_8xdaily.nc');

% pfull_2km=ncread(source_2km_month,'pfull');
% 

% domain related parameters:
xgcm=0:25:4000; % size of gcm domain in km
xgcm_ngp=160; % gcm number of grid points in x
xcrm=0:2:4000; % size of crm domain in km
xcrm_ngp=2000; % crm number of grid points in x
xcrm_1km=0:1:4000;
xcrm_1km_ngp=4000;

% latent heat of vaporization
latheat=2.26e6 % J/kg

% scaling factors
% precip can be converted into mm/day (scale1) 
% or energy units of W/m2 (scale2)
scale1=86400.; % s m^2 mm / kg day
%scale2=2.265e6; % J/kg why the difference with the value below?
scale2=2.501e6;
scale=scale1;
cltscale=100. % convert to percentage of cloud fraction

% read variables from input files

% precipitation
precip_25km=ncread(source_25km,'precip');
precip_2km=ncread(source_2km_month,'precip');
precip_1km=ncread(source_1km_month,'precip');
precip_25km_8x=ncread(source_25km_8xday,'precip');
%precip_2km_8x=ncread(source_2km_8xday,'precip');
p_cv_25km=ncread(source_25km,'prec_conv'); %kg(h2o)/m2/2
p_ls_25km=ncread(source_25km,'prec_ls');
p_cv_2km=ncread(source_2km_month,'prec_conv'); %kg(h2o)/m2/2
p_ls_2km=ncread(source_2km_month,'prec_ls');

precip_25km_znm=mean(precip_25km,2);
precip_2km_znm=mean(precip_2km,2);
precip_1km_znm=mean(precip_1km,2);
precip_25km_8x_znm=mean(precip_25km_8x,2);
%precip_2km_8x_znm=mean(precip_2km_8x,2);

%p_contours=[10.,20.,30.,40.,50.,60.,70.,80.,90.,100.];
%p_contours=[5.,20.,35.,50.,65.,80.,95.,110.,125.,140.];

%precip_25km_znm=mean(precip_25km,2);
%precip_25km_8x=precip_25km_8x(:,:,4800:2920);
%precip_25km_8x_znm=mean(precip_25km_8x,2);
%precip_2km_znm=mean(precip_2km,2);
%precip_2km_8x_znm=mean(precip_2km_8x,2);
p_2km_znm=scale.*(squeeze(precip_2km_znm));
p_1km_znm=scale.*(squeeze(precip_1km_znm));
%p_2km_8x_znm=scale.*(squeeze(precip_2km_8x_znm));
p_25km_znm=scale.*(squeeze(precip_25km_znm));
p_25km_8x_znm=scale.*(squeeze(precip_25km_8x_znm));

% time mean precip
p_25km_8x_znm_equil=p_25km_8x_znm(:,960:2920);
p_25km_tmean=mean(p_25km_8x_znm_equil,2);
p_2km_tmean=mean(p_2km_znm,2);
p_1km_tmean=mean(p_1km_znm,2);

% surface temperature
tsurf_fulltime=ncread(source_25km,'t_surf');
tsfc=tsurf_fulltime(:,:,32:365);
tsfc_mn=mean(tsfc,3);

% surface pressure
p_sfc_fulltime=ncread(source_25km,'ps');
psurf=mean(p_sfc_fulltime,3);
psurf_zmn=squeeze(mean(psurf,2));

% vertical velocity
w_25km=ncread(source_25km,'w');
w_2km=ncread(source_2km_month,'w');
w500_25km=ncread(source_25km,'w500');
w500_2km=ncread(source_2km_dprecp,'w500');

clt_2km=ncread(source_2km_month,'cld_amt');
clt_1km=ncread(source_1km_month,'cld_amt');
clt_25km=ncread(source_25km,'cld_amt');

liq_1km=ncread(source_1km_month,'tot_liq_amt');
liq_2km=ncread(source_2km_month,'tot_liq_amt');
liq_25km=ncread(source_25km_month,'tot_liq_amt');

ice_1km=ncread(source_1km_month,'tot_ice_amt');
ice_2km=ncread(source_2km_month,'tot_ice_amt');
ice_25km=ncread(source_25km_month,'tot_ice_amt');

hur_1km=ncread(source_1km_month,'rh');
hur_2km=ncread(source_2km_month,'rh');
hur_25km=ncread(source_25km_month,'rh');

pfull_2km=ncread(source_2km_month,'pfull');
pfull_25km=ncread(source_2km_month,'pfull');
pfull_25km=100.*pfull_25km; % convert to Pa
pfull_2km=100.*pfull_2km; % convert to Pa


%tsurf=ncread(source_25km,'t_surf');
temp_25km=ncread(source_25km_month,'temp');

zfull_25km=ncread(source_2km_month,'z_full');
zfull_25km_zmn=squeeze(mean(zfull_25km,2));
zfull_25km_ztmn=squeeze(mean(zfull_25km_zmn,3));

liq_1km_tot=liq_1km+ice_1km;
liq_1km_zmn=squeeze(mean(liq_1km_tot,2));
liq_1km_zmn=liq_1km_zmn(:,:,t_mid:t_end);
liq_1km_zmn=squeeze(mean(liq_1km_zmn,3));

liq_2km_tot=liq_2km+ice_2km;
liq_2km_zmn=squeeze(mean(liq_2km_tot,2));
% if using last 3 months of crm data:
liq_2km_zmn=liq_2km_zmn(:,:,t_mid:t_end);
liq_2km_zmn=squeeze(mean(liq_2km_zmn,3));

liq_25km_tot=liq_25km+ice_25km;
liq_25km_zmn=squeeze(mean(liq_25km_tot,2));
liq_25km_zmn_last10m=liq_25km_zmn(:,:,an_t1:an_t2);
liq_25km_zmn_9m=squeeze(mean(liq_25km_zmn_last10m,3));

% relative humidity
% for the 2km runs, the time dimension is often not present becuase it is 1

hur_2km_zmn=squeeze(mean(hur_2km,2));
hur_1km_zmn=squeeze(mean(hur_1km,2));
hur_25km_zmn=squeeze(mean(hur_25km,2));
%hur_2km_zmn_tmn=hur_2km_zmn;

% if using last 3 months of crm data:
hur_2km_zmn=hur_2km_zmn(:,:,t_mid:t_end);
hur_2km_zmn=squeeze(mean(hur_2km_zmn,3));
hur_2km_zmn_tmn=hur_2km_zmn;

hur_1km_zmn=hur_1km_zmn(:,:,t_mid:t_end);
hur_1km_zmn=squeeze(mean(hur_1km_zmn,3));
hur_1km_zmn_tmn=hur_1km_zmn;

hur_25km_zmn_last10m=hur_25km_zmn(:,:,an_t1:an_t2);
hur_25km_zmn_tmn=squeeze(mean(hur_25km_zmn_last10m,3));


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

tsurf1=squeeze(tsurf_fulltime(:,4,300)); % indices shouldn't matter here...

clt_25km_znm=cltscale.*squeeze(mean(clt_25km,2));
%clt_25km_znm_2m=clt_25km_znm(:,:,61:90);
clt_25km_znm_2m=clt_25km_znm(:,:,an_t1_d:an_t2_d);
clt_25km_znm_2mtmn=squeeze(mean(clt_25km_znm_2m,3));
clt_25km_znm_tmn=mean(clt_25km_znm,3); % this is over a full year...

clt_2km_znm=cltscale.*squeeze(mean(clt_2km,2));
clt_2km_znm_end=clt_2km_znm(:,:,t_mid:t_end);
clt_2km_znm_start=clt_2km_znm(:,:,1:t_mid);
clt_2km_znm_eq=clt_2km_znm(:,:,t_mid:t_end);

clt_2km_znm_st_tmn=mean(clt_2km_znm_start,3);
clt_2km_znm_end_tmn=mean(clt_2km_znm_end,3);
clt_2km_znm_eq_tmn=mean(clt_2km_znm_eq,3);

clt_1km_znm=cltscale.*squeeze(mean(clt_1km,2));
clt_1km_znm_eq=clt_1km_znm(:,:,t_mid:t_end);
clt_1km_znm_eq_tmn=mean(clt_1km_znm_eq,3);


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

% call script
compTheta % compute the potential temperature
%StreamFun % compute the streamfunction
% call psi_driver to compute the streamfunction
WalkerEnergetics % compute several of the radiative flux fields

%psi_mat(ind,:,:)=psi_3(:,:);
p_mat(ind,:,:)=p_25km_8x_znm(:,:);
rh_mat(ind,:,:)=hur_25km_zmn_tmn(:,:);
cl_mat(ind,:,:)=clt_25km_znm_tmn(:,:);
tdtlw_mat(ind,:,:)=tdtlw_25_tzmn(:,:);
tdtsw_mat(ind,:,:)=tdtsw_25_tzmn(:,:);
tdtls_mat(ind,:,:)=tdtls_25km_tzmn(:,:);
tdtconv_mat(ind,:,:)=tdtconv_25km_tzmn(:,:);
lts_mat(ind,:)=lts(:); % computed in compTheta.m
 
tdt_total_cloud=tdtconv_25km_tzmn+tdtls_25km_tzmn;
tdt_totcl_mat(ind,:,:)=tdt_total_cloud(:,:);

tdtlw_dmn=squeeze(mean(tdtlw_25_tzmn,1));
tdtsw_dmn=squeeze(mean(tdtsw_25_tzmn,1));
temprad=tdtlw_dmn+tdtsw_dmn;
rad_heat_mat(ind,:)=temprad;

MeanPrecip_25km=mean(p_25km_tmean,1)
MeanPrecip_2km=mean(p_2km_tmean,1)
MeanPrecip_1km=mean(p_1km_tmean,1)

prec_mn_mat(6)=MeanPrecip_2km;
prec_mn_mat(ind)=MeanPrecip_25km;

radh_mn_mat(6)=MeanRadH_2km;
radh_mn_mat(ind)=MeanRadH_25km;

 
%-----------------------------------------------------------------------
% figures

% points at which to plot profiles
gcm_ris=xgcm_ngp/2;
gcm_sub=xgcm_ngp-4;
crm_ris=xcrm_ngp/2;
crm_sub=xcrm_ngp-100;

stop

figure
%clt_contours=[1.,3.,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.,55.,60.,65.,70.,75.,80.,85.,90.,95.];
clt_contours=[1,3,5,10,15,20,25,30,35,40,45,50,55,60];
subplot(1,2,1)
%caxis=([1 25]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,clt_2km_znm_end_tmn',clt_contours,'EdgeColor','None');
v=[5,10,20,30,40,50,60];
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

% the figure below is bet run after the matrix has been filled
figure
plot(squeeze(rad_heat_mat(1,:)),pfull_2km);
set(gca,'Ydir','reverse')
hold on
plot(squeeze(rad_heat_mat(2,:)),pfull_2km);
plot(squeeze(rad_heat_mat(3,:)),pfull_2km);
plot(squeeze(rad_heat_mat(4,:)),pfull_2km);
plot(squeeze(rad_heat_mat(5,:)),pfull_2km);
plot(rad_heat_prof_2,pfull_2km,'k','LineWidth',2);

% figure
% plot(lts_mat(1,:),'LineWidth',1);
% hold on
% title('Lower Tropospheric Stability');
% ylabel('K','FontSize',15)
% plot(lts_mat(2,:),'LineWidth',1.5);
% plot(lts_mat(3,:),'k','LineWidth',2);
% plot(lts_mat(4,:),'LineWidth',2.5);
% plot(lts_mat(5,:),'LineWidth',3);

% figure
% plot(rad_heat_prof_2,pfull_2km);
% set(gca,'Ydir','reverse')
% hold on
% plot(rad_heat_prof_25,pfull_2km);

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
set(gca,'XScale','log')
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
tit_e=strcat('Precip GCM:',num2str(MeanPrecip_25km),' CRM:',num2str(MeanPrecip_2km));
title(tit_e); 
suptitle(tit_st)


figure
liq_1km_zmn_scale=liq_1km_zmn*1000.;
liq_2km_zmn_scale=liq_2km_zmn*1000.;
liq_25km_zmn_scale=liq_25km_zmn_9m*1000.;
q_contours=[0.4,0.1,0.06,0.04,0.03,0.02,0.01,0.001,0.0001,0.0001];
q_contours=[0.4,0.1,0.06,0.04,0.03,0.02];
subplot(1,3,1)
caxis=([0.0001 0.4]);
[C,h]=contourf(1:xcrm_1km_ngp,pfull_2km,liq_1km_zmn_scale',q_contours,'EdgeColor','None');
v=[0.4,0.1,0.06,0.04,0.03,0.02,0.01,0.001,0.0001,0.0001];
clabel(C,h,v);
tit_a=strcat('liq+ice water 1km');
title(tit_a);
set(gca,'Ydir','reverse')
%colorbar
subplot(1,3,2)
%caxis=([0.00001 0.03]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
%v=[0.03,0.01,0.001,0.0001,0.00001];
clabel(C,h,v);
tit_a=strcat('liq+ice water 2km');
title(tit_a);
set(gca,'Ydir','reverse')
%colorbar
subplot(1,3,3)
%caxis=([0.00001 0.03]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,liq_25km_zmn_scale',q_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('liq+ice 25km');
title(tit_b);
set(gca,'Ydir','reverse')
%colorbar
tit_liq=strcat('liq: ',tit_st);
suptitle(tit_liq)

figure
rh_contours=[5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85];
subplot(1,2,1)
caxis=([10 80]);
[C,h]=contourf(1:xcrm_ngp,pfull_2km,hur_2km_zmn_tmn',rh_contours,'EdgeColor','None');
v=[10,20,30,50,70];
clabel(C,h,v);
tit_a=strcat('relative humidity 2km');
title(tit_a);
%set(gca,'Ydir','reverse')
%colorbar
%hold on
%contour(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
set(gca,'Ydir','reverse')
colorbar

subplot(1,2,2)
caxis=([10 80]);
[C,h]=contourf(1:xgcm_ngp,pfull_2km,hur_25km_zmn_tmn',rh_contours,'EdgeColor','None');
clabel(C,h,v);
tit_b=strcat('relative humidity 25km');
title(tit_b);
set(gca,'Ydir','reverse')
colorbar
tit_rh=strcat('RH: ',tit_st);
suptitle(tit_rh)

% the code below only works if all fize ensemble members have been run...
% and stored in the matrices cl_mat and rh_mat

% plot the domain mean cloud fractions...
figure
blab_cla=squeeze(mean(cl_mat,2));
plot(blab_cla(1,:),pfull_2km,'k','LineWidth',1);
set(gca,'YLim',[10000 100000]);
set(gca,'XLim',[0 100]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
hold on
plot(blab_cla(2,:),pfull_2km,'k','LineWidth',1);
plot(blab_cla(3,:),pfull_2km,'k','LineWidth',1);
plot(blab_cla(4,:),pfull_2km,'k','LineWidth',1);
plot(blab_cla(5,:),pfull_2km,'k','LineWidth',1);
clt_crm=mean(clt_2km_znm_end_tmn,1);
clt_crm_1km=mean(clt_1km_znm_eq_tmn,1);
plot(clt_crm(:),pfull_2km,'--k','LineWidth',2);
plot(clt_crm_1km(:),pfull_2km,'-.k','LineWidth',2);

% plot the domain mean relative humidity
blab_rh=squeeze(mean(rh_mat,2));
plot(blab_rh(1,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(2,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(3,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(4,:),pfull_2km,'b','LineWidth',1);
plot(blab_rh(5,:),pfull_2km,'b','LineWidth',1);
hur_crm=mean(hur_2km_zmn_tmn,1);
hur_crm_1km=mean(hur_1km_zmn_tmn,1);
plot(hur_crm(:),pfull_2km,'--b','LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'-.b','LineWidth',2);
title('Mean Cloud and RH')

% plot the maximum value at each level
max_cl_mat=max(cl_mat,[],2);
max_cl_mat=squeeze(max_cl_mat);
max_cl_crm=max(clt_2km_znm_end_tmn,[],1);
max_cl_crm_1km=max(clt_1km_znm_eq_tmn,[],1);
max_cl_crm=squeeze(max_cl_crm);
max_cl_crm_1km=squeeze(max_cl_crm_1km);
figure
plot(max_cl_mat(1,:),pfull_2km,'k','LineWidth',1);
set(gca,'YLim',[10000 100000]);
set(gca,'XLim',[0 100]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
hold on
plot(max_cl_mat(2,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_mat(3,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_mat(4,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_mat(5,:),pfull_2km,'k','LineWidth',1);
plot(max_cl_crm(:),pfull_2km,'--k','LineWidth',2);
plot(max_cl_crm_1km(:),pfull_2km,'-.k','LineWidth',2);


max_rh_mat=max(rh_mat,[],2);
max_rh_mat=squeeze(max_rh_mat);
max_rh_crm=max(hur_2km_zmn_tmn,[],1);
max_rh_crm_1km=max(hur_1km_zmn_tmn,[],1);
max_rh_crm=squeeze(max_rh_crm);
max_rh_crm_1km=squeeze(max_rh_crm_1km);
plot(max_rh_mat(1,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(2,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(3,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(4,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_mat(5,:),pfull_2km,'b','LineWidth',1);
plot(max_rh_crm(:),pfull_2km,'--b','LineWidth',2);
plot(max_rh_crm_1km(:),pfull_2km,'-.b','LineWidth',2);
title('Maximum Cloud and RH')

% plot the minimum value at each level
min_cl_mat=min(cl_mat,[],2);
min_cl_mat=squeeze(min_cl_mat);
min_cl_crm=min(clt_2km_znm_end_tmn,[],1);
min_cl_crm_1km=min(clt_1km_znm_eq_tmn,[],1);
min_cl_crm=squeeze(min_cl_crm);
min_cl_crm_1km=squeeze(min_cl_crm_1km);
figure
plot(min_cl_mat(1,:),pfull_2km,'k','LineWidth',1);
set(gca,'YLim',[10000 100000]);
set(gca,'XLim',[0 100]);
set(gca,'YScale','log')
set(gca,'Ydir','reverse')
hold on
plot(min_cl_mat(2,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_mat(3,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_mat(4,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_mat(5,:),pfull_2km,'k','LineWidth',1);
plot(min_cl_crm(:),pfull_2km,'--k','LineWidth',2);
plot(min_cl_crm_1km(:),pfull_2km,'-.k','LineWidth',2);


min_rh_mat=min(rh_mat,[],2);
min_rh_mat=squeeze(min_rh_mat);
min_rh_crm=min(hur_2km_zmn_tmn,[],1);
min_rh_crm_1km=min(hur_1km_zmn_tmn,[],1);
min_rh_crm=squeeze(min_rh_crm);
min_rh_crm_1km=squeeze(min_rh_crm_1km);
plot(min_rh_mat(1,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(2,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(3,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(4,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_mat(5,:),pfull_2km,'b','LineWidth',1);
plot(min_rh_crm(:),pfull_2km,'--b','LineWidth',2);
plot(min_rh_crm_1km(:),pfull_2km,'-.b','LineWidth',2);
title('Minimum Cloud and RH')
