path='/Users/silvers/data/WalkerCell/'
tit_st=' cos sq ';
path_25km=path
%path_25km='/Users/silvers/data/WalkerCell/gauss_d/'
%init_st_fname='19790101';
init_st_fname='c96L33_8x80_nh.19790101';
source_25km=strcat(path_25km,init_st_fname,'.atmos_daily.nc');
source_2km=strcat(path,'c96L33_100x1000_nh_crm.19790101.atmos_daily.nc');

source_25km_month=strcat(path_25km,init_st_fname,'.atmos_month.nc');
source_2km_month=strcat(path,'c96L33_100x1000_nh_crm.19790101.atmos_month.nc');

source_25km_8xday=strcat(path_25km,init_st_fname,'.atmos_8xdaily.nc');
source_2km_8xday=strcat(path,'c96L33_100x1000_nh_crm.19790101.atmos_8xdaily.nc');

% read variables
precip_25km=ncread(source_25km,'precip');
precip_2km=ncread(source_2km,'precip');
precip_25km_8x=ncread(source_25km_8xday,'precip');
precip_2km_8x=ncread(source_2km_8xday,'precip');
w_25km=ncread(source_25km,'w');
w_2km=ncread(source_2km,'w');
clt_2km=ncread(source_2km,'cld_amt');
clt_25km=ncread(source_25km,'cld_amt');
pfull_2km=ncread(source_2km,'pfull');
tsurf=ncread(source_25km,'t_surf');

q_25km=ncread(source_25km_month,'sphum');
q_25km_zmn=squeeze(mean(q_25km,2));
%q_25km_zmn_end=q_25km_zmn(:,:,3:12);
q_25km_zmn_end=q_25km_zmn(:,:,2);
q_25km_zmntmn=mean(q_25km_zmn_end,3);

q_2km=ncread(source_2km_month,'sphum');
q_2km_zmn=squeeze(mean(q_2km,2));
q_2km_zmn_end=q_2km_zmn(:,:,2);
q_2km_zmntmn=mean(q_2km_zmn_end,3);

% begin to process variables

precip_25km_znm=mean(precip_25km,2);
precip_2km_znm=mean(precip_2km,2);
precip_25km_8x_znm=mean(precip_25km_8x,2);
precip_2km_8x_znm=mean(precip_2km_8x,2);

tsurf1=squeeze(tsurf(:,4,300)); % indices shouldn't matter here...

% precip can be converted into mm/day (scale1) 
% or energy units of W/m2 (scale2)
scale1=86400.; % s m^2 mm / kg day
scale2=2.265e-6; % J/kg
scale=scale1;

p_contours=[10.,20.,30.,40.,50.,60.,70.,80.,90.,100.];
p_contours=[5.,20.,35.,50.,65.,80.,95.,110.,125.,140.];

precip_25km_znm=mean(precip_25km,2);
precip_25km_8x_znm=mean(precip_25km_8x,2);
precip_2km_znm=mean(precip_2km,2);
precip_2km_8x_znm=mean(precip_2km_8x,2);
p_2km_znm=scale.*(squeeze(precip_2km_znm));
p_2km_8x_znm=scale.*(squeeze(precip_2km_8x_znm));
p_25km_znm=scale.*(squeeze(precip_25km_znm));
p_25km_8x_znm=scale.*(squeeze(precip_25km_8x_znm));


clt_contours=[1.,3.,5.,10.,15.,20.,25.,30.,35.,40.,45.,50.,55.,60.,65.,70.,75.,80.,85.,90.,95.];

cltscale=100. % convert to percentage of cloud fraction

clt_25km_znm=cltscale.*squeeze(mean(clt_25km,2));
clt_25km_znm_2m=clt_25km_znm(:,:,1:59);

clt_2km_znm=cltscale.*squeeze(mean(clt_2km,2));
clt_2km_znm_end=clt_2km_znm(:,:,30:59);
clt_2km_znm_start=clt_2km_znm(:,:,1:30);

clt_25km_znm_2mtmn=squeeze(mean(clt_25km_znm_2m,3));

clt_2km_znm_st_tmn=mean(clt_2km_znm_start,3);
clt_2km_znm_end_tmn=mean(clt_2km_znm_end,3);
clt_25km_znm_tmn=mean(clt_25km_znm,3); % this is over a full year...


w_25km_532=squeeze(w_25km(:,:,18,:)); % grab 532 level
w_25km_532_zmn=mean(w_25km_532,2);
w_25km_zmn=squeeze(mean(w_25km,2));
w_25km_zmn_tm=mean(w_25km_zmn(:,:,21:364),3);

w_2km_532=squeeze(w_2km(:,:,18,21:59));
w_2km_532_zmn=mean(w_2km_532,2);
w_2km_zmn=squeeze(mean(w_2km,2));
w_2km_zmn_tm=mean(w_2km_zmn(:,:,21:59),3);

w_2km_532_zmn=squeeze(w_2km_532_zmn);
w_2km_532_zmn_tm=mean(w_2km_532_zmn,2);


w_25km_532_zmn=squeeze(w_25km_532_zmn);
w_25km_532_zmn_tm=mean(w_25km_532_zmn,2);



% figures
blah=1:1000;
x80=0:25:2000;
x1000=0:2:2000;

figure
subplot(1,2,1)
[C,h]=contourf(blah,pfull_2km,clt_2km_znm_end_tmn',clt_contours,'EdgeColor','None')
v=[10,20,30,50,70];
clabel(C,h,v);
tit_a=strcat('cloud fraction 2km',tit_st)
title(tit_a)
set(gca,'Ydir','reverse')
colorbar
subplot(1,2,2)
[C,h]=contourf(1:80,pfull_2km,clt_25km_znm_tmn',clt_contours,'EdgeColor','None')
clabel(C,h,h);
tit_b=strcat('cloud fraction 25km',tit_st)
title(tit_b)
set(gca,'Ydir','reverse')
colorbar

% figure
% subplot(2,2,1)
% contourf(p_2km_znm',p_contours,'EdgeColor','None')
% subplot(2,2,2)
% contourf(p_25km_znm',p_contours,'EdgeColor','None')
% colorbar
% subplot(2,2,3)
% contourf(p_25km_znm(:,1:59)',p_contours,'EdgeColor','None')
% title('Precipitation Hovmuller Plots')
% subplot(2,2,4)
% plot(tsurf1)

% figure
% subplot(2,1,1)
% contourf(p_2km_8x_znm',p_contours,'EdgeColor','None')
% subplot(2,1,2)
% contourf(p_25km_8x_znm(:,1:480)',p_contours,'EdgeColor','None')

% figure
% subplot(1,2,1)
% plot(w_25km_532_zmn_tm)
% axis([0 80 -0.02 0.05])
% title('vertical velocity at 532 for 25km')
% subplot(1,2,2)
% plot(w_2km_532_zmn_tm)
% axis([0 1000 -0.02 0.05])
% title('vertical velocity at 532 for 2km')

% wlev=18;
% figure
% subplot(1,2,1)
% plot(w_25km_zmn_tm(:,wlev))
% axis([0 80 -0.02 0.05])
% title('vertical velocity 25km')
% subplot(1,2,2)
% plot(w_2km_zmn_tm(:,wlev))
% axis([0 1000 -0.02 0.05])
% title('vertical velocity 2km')

q25=q_25km_zmntmn';
q2=q_2km_zmntmn';

figure
plot(q25(:,40),pfull_2km,'--r','LineWidth',2)
set(gca,'Ydir','reverse')
hold on
plot(q25(:,70),pfull_2km,'r','LineWidth',2)
plot(q2(:,500),pfull_2km,'--k','LineWidth',2)
plot(q2(:,875),pfull_2km,'k','LineWidth',2)
ylabel('Pressure','FontSize',20)
xlabel('kg/kg','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
tit_c=strcat('Specific Humidity',tit_st);
title(tit_c)

figure
plot(x80(1:80),tsurf1,'k','LineWidth',2)
ylabel('Kelvin','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
tit_d=strcat('Surface Temperature',tit_st);
title(tit_d)

figure
wlev=18;

plot(x80(1:80),w_25km_zmn_tm(:,wlev),'r','LineWidth',2)
hold on
plot(x1000(1:1000),w_2km_zmn_tm(:,wlev),'k','LineWidth',2)
ylabel('w (m/s)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
tit_e=strcat('Vertical Velocity',tit_st);
title(tit_e)
