
%con_stream_arr=[0,0,0,-1e4,0,0,5e4];
con_stream_arr=[0,0,0,0,0,0,0];
%con_stream_arr=[2000.,-3000.,-14000.,-16000.,20000.,0.,5000.];
%con_stream_arr=[0.,0.,-14000.,-16000.,20000.,0.,5000.];

exp_n=''  % control
%exp_n='_p4K'
%exp_n='_lwoff'
%filen='/19790101.atmos_month.nc'
filen='/1980th1983.atmos_month_tmn.nc'
res='_100km_'


% constant added to the streamfunction
%con_stream=2000.;
con_stream=con_stream_arr(1);
gridspac=2
%scale2m2=4e6;
source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c50x2000L33_am4p0_2km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
dx_gen=2000.; % grid cell size in meters
x_ngp_gen=2000; % width of domain in grid points
tit_id=' 2 km'

StreamFunNew
psi_gen_2km=psi_gen;

% constant added to the streamfunction
%con_stream=-3000.;
con_stream=con_stream_arr(2);
gridspac=1
%scale2m2=1e6;
%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c50x2000L33_am4p0_2km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c10x4000L33_am4p0_1km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
dx_gen=1000.; % grid cell size in meters
x_ngp_gen=4000; % width of domain in grid points
tit_id=' 1 km'

StreamFunNew
psi_gen_1km=psi_gen;

figure
subplot(1,2,1)
[C,h]=contourf(1:4000,pfull_gen,psi_gen_1km',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: 1km');
title(tit_str)
set(gca,'Ydir','reverse')

subplot(1,2,2)
[C,h]=contourf(1:2000,pfull_gen,psi_gen_2km',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: 2km');
title(tit_str)
set(gca,'Ydir','reverse')

% hopefully all the incoming data will be in atmos_month...
%con_stream=-3000.; % how should this be deterimined?
%con_stream=-14000.; % how should this be deterimined?
con_stream=con_stream_arr(3);
gridspac=25
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent0p5/19790101.atmos_month.nc';
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent0p5_lwoff/19790101.atmos_month.nc';
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent0p5_p4K/19790101.atmos_month.nc';

source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0',res,'wlkr_ent0p5',exp_n,filen);
dx_gen=25000.; % grid cell size in meters
x_ngp_gen=160; % width of domain in grid points
tit_id=' 25 km 0p5';
tit_id_0p5=tit_id;
StreamFunNew
psi_gen_0p5=psi_gen;
mmax=max(max(psi_gen_0p5))
mmin=min(min(psi_gen_0p5))
offset1=(mmax-mmin)/2.;

%figure
%subplot(5,2,1)
%[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen_0p5',stream_cons);
%clabel(C,h,v);
%tit_str=strcat('mass Streamfunction: ',tit_id);
%title(tit_str)
%set(gca,'Ydir','reverse')

%con_stream=-16000.; % how should this be deterimined?
con_stream=con_stream_arr(4);
gridspac=25
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent0p7/19790101.atmos_month.nc';
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent0p7_lwoff/19790101.atmos_month.nc';
source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0',res,'wlkr_ent0p7',exp_n,filen);
dx_gen=25000.; % grid cell size in meters
x_ngp_gen=160; % width of domain in grid points
tit_id=' 25 km 0p7';
tit_id_0p7=tit_id;
StreamFunNew
psi_gen_0p7=psi_gen;
mmax=max(max(psi_gen_0p7))
mmin=min(min(psi_gen_0p7))
offset2=(mmax-mmin)/2.;

%con_stream=20000.; % how should this be deterimined?
con_stream=con_stream_arr(5);
gridspac=25
%scale2m2=625e6;
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent0p9/19790101.atmos_month.nc';
source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0',res,'wlkr_ent0p9',exp_n,filen);
dx_gen=25000.; % grid cell size in meters
x_ngp_gen=160; % width of domain in grid points
tit_id=' 25 km 0p9';
tit_id_0p9=tit_id;
StreamFunNew
psi_gen_0p9=psi_gen;
mmax=max(max(psi_gen_0p9))
mmin=min(min(psi_gen_0p9))
offset3=(mmax-mmin)/2.;

%con_stream=0.; % how should this be deterimined?
con_stream=con_stream_arr(6);
gridspac=25
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent1p1/19790101.atmos_month.nc';
source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0',res,'wlkr_ent1p1',exp_n,filen);
dx_gen=25000.; % grid cell size in meters
x_ngp_gen=160; % width of domain in grid points
tit_id=' 25 km 1p1';
tit_id_1p1=tit_id;
StreamFunNew
psi_gen_1p1=psi_gen;
mmax=max(max(psi_gen_1p1))
mmin=min(min(psi_gen_1p1))
offset4=(mmax-mmin)/2.;

%con_stream=5000.; % how should this be deterimined?
con_stream=con_stream_arr(7);
gridspac=25
%scale2m2=625e6;
%source_psi='/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0_25km_wlkr_ent1p3/19790101.atmos_month.nc';
source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c8x160L33_am4p0',res,'wlkr_ent1p3',exp_n,filen);
dx_gen=25000.; % grid cell size in meters
x_ngp_gen=160; % width of domain in grid points
tit_id=' 25 km 1p3';
tit_id_1p3=tit_id;
StreamFunNew
psi_gen_1p3=psi_gen;
mmax=max(max(psi_gen_1p3))
mmin=min(min(psi_gen_1p3))
offset5=(mmax-mmin)/2.;

figure
subplot(1,5,1)
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen_0p5',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id_0p5);
title(tit_str)
set(gca,'Ydir','reverse')

subplot(1,5,2)
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen_0p7',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id_0p7);
title(tit_str)
set(gca,'Ydir','reverse')

subplot(1,5,3)
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen_0p9',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id_0p9);
title(tit_str)
set(gca,'Ydir','reverse')

subplot(1,5,4)
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen_1p1',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id_1p1);
title(tit_str)
set(gca,'Ydir','reverse')

subplot(1,5,5)
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen_1p3',stream_cons);
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id_1p3);
title(tit_str)
set(gca,'Ydir','reverse')

psi_mat       = zeros(5,160,33);
psi_mat(1,:,:)=psi_gen_0p5(:,:);
psi_mat(2,:,:)=psi_gen_0p7(:,:);
psi_mat(3,:,:)=psi_gen_0p9(:,:);
psi_mat(4,:,:)=psi_gen_1p1(:,:);
psi_mat(5,:,:)=psi_gen_1p3(:,:);

%an_t1=3;
%an_t2=12;
%w_25km=ncread(source_25km,'w');
%u_25km=ncread(source_25km,'ucomp');
%sphum_25km=ncread(source_25km,'sphum');
%temp_25km=ncread(source_25km,'temp');
%pfull_25km=ncread(source_25km,'pfull');
%
%w_25km_eq=w_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
%w_25km_tmn=squeeze(mean(w_25km_eq,4)); % time mean
%
%u_25km_eq=u_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
%u_25km_tmn=squeeze(mean(u_25km_eq,4)); % time mean
%
%sphum_25km_eq=sphum_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
%sphum_25km_tmn=squeeze(mean(sphum_25km_eq,4)); % time mean
%
%temp_25km_eq=temp_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
%temp_25km_tmn=squeeze(mean(temp_25km_eq,4)); % time mean
%
%% i think the zonal mean should be taken in the streamfunction script
%w_25km_zmn=squeeze(mean(w_25km_tmn,2)); % zonal mean
%u_25km_zmn=squeeze(mean(u_25km_tmn,2)); % zonal mean
%
%pfull_gen=100.*pfull_gen;
