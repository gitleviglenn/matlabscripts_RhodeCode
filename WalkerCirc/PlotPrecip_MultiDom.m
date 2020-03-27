%------------------------------------------------------------------
% PlotPrecip_MultiDom.m
%
% purpose: plot time mean precipitation as a function of the x dim
% for the equilibrated periods of the mock-Walker Circulation exps
%
% plots made for both 25km and 100km grid spacing on domains with
% an x dimension of 4000km and 16000km.
%
% levi silvers                                     june 2019
%------------------------------------------------------------------

% define physical constants
phys_constants

% domain related parameters:
xgcm_100_s=0:100:4000; % size of gcm domain in km
xgcm_100_l=0:100:16000; % size of gcm domain in km
xgcm_25_s=0:25:4000; % size of gcm domain in km
xgcm_25_l=0:25:16000; % size of gcm domain in km

xgcm_ngp_640=640; % gcm number of grid points in x
xgcm_ngp_160=160; % gcm number of grid points in x
xgcm_ngp_40=40; % gcm number of grid points in x

xcrm=0:2:4000; % size of crm domain in km
xcrm_ngp=2000; % crm number of grid points in x

xcrm_1km=0:1:4000;
xcrm_1km_ngp=4000;

% latent heat of vaporization
%latheat=2.26e6 % J/kg

% scaling factors
% precip can be converted into mm/day (scale1)
% what is the value of the latent heat conversion used in AM4?
% or energy units of W/m2 (scale2)
scale1=86400.; % s m^2 mm / kg day

% define parameters related to reading the data...
path_base='/Users/silvers/data/WalkerCell/'

path=strcat(path_base,'gauss_d/');
path_n=strcat(path_base,'testing_20181203/');

%estr2='ent0p9'

% filenames for monthly mean data are a mess...  sometimes they are called
%1980th1983.atmos_month_tmn.nc   % and sometimes they are called
%1979_th_1983.atmos_month.nc

%yearstr='/1980th1983';
%fileext='/1980th1983.atmos_month_tmn.nc';
fileext_1='/1980th1983.atmos_month_tmn.nc';
fileext_2='/1979_th_1983.atmos_month.nc';

% import daily precip for histograms
fileext_daily='/1979th1983_daily.nc';

estr2='ent0p9';

path_25km_l=strcat(path_n,'c8x640L33_am4p0_25km_wlkr_',estr2);
path_25km_s=strcat(path_n,'c8x160L33_am4p0_25km_wlkr_',estr2);
path_100km_l=strcat(path_n,'c8x160L33_am4p0_100km_wlkr_',estr2);
path_100km_s=strcat(path_n,'c8x40L33_am4p0_100km_wlkr_',estr2);
path_2km=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_4K_lwoff/');
path_1km=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_4K_lwoff/');
superTit='Location of Max Precip with LW CRE on'

source_gcm_month_s=strcat(path_25km_s,fileext_1);
source_gcm_month_l=strcat(path_25km_l,fileext_2);
source_100km_month_s=strcat(path_100km_s,fileext_2);
source_100km_month_l=strcat(path_100km_l,fileext_1);

source_2km=strcat(path_2km,fileext_1);
source_1km=strcat(path_1km,fileext_1);

% monthly data
precip_25km_s=ncread(source_gcm_month_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_l=ncread(source_gcm_month_l,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_100km_s=ncread(source_100km_month_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_100km_l=ncread(source_100km_month_l,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run

w_25km_s=ncread(source_gcm_month_s,'w'); % [xdim ydim tdim], last four yrs of 5 yr run
w_25km_l=ncread(source_gcm_month_l,'w'); % [xdim ydim tdim], last four yrs of 5 yr run
w_100km_s=ncread(source_100km_month_s,'w'); % [xdim ydim tdim], last four yrs of 5 yr run
w_100km_l=ncread(source_100km_month_l,'w'); % [xdim ydim tdim], last four yrs of 5 yr run

w_100km_s_tmn=squeeze(mean(w_100km_s,4));
w_100km_s_ztmn=squeeze(mean(w_100km_s_tmn,2));
w_100km_l_tmn=squeeze(mean(w_100km_l,4));
w_100km_l_ztmn=squeeze(mean(w_100km_l_tmn,2));

w_25km_s_tmn=squeeze(mean(w_25km_s,4));
w_25km_s_ztmn=squeeze(mean(w_25km_s_tmn,2));
w_25km_l_tmn=squeeze(mean(w_25km_l,4));
w_25km_l_ztmn=squeeze(mean(w_25km_l_tmn,2));

% this is bad coding...
estr2='ent0p9_lwoff';
%estr2='ent0p9';
superPHistTit='parameterized with lwCRE off'

path_25km_l=strcat(path_n,'c8x640L33_am4p0_25km_wlkr_',estr2);
path_25km_s=strcat(path_n,'c8x160L33_am4p0_25km_wlkr_',estr2);
%path_25km_s=strcat(path_n,'c8x160L33_am4p0_25km_wlkr_ent0p9_noconv');
path_100km_l=strcat(path_n,'c8x160L33_am4p0_100km_wlkr_',estr2);
path_100km_s=strcat(path_n,'c8x40L33_am4p0_100km_wlkr_',estr2);


source_gcm_daily_s        =strcat(path_25km_s,fileext_daily);
source_gcm_daily_c_s      =strcat(path_n,'c8x160L33_am4p0_25km_wlkr_ent0p9',fileext_daily);
source_gcm_daily_nc_s     =strcat(path_n,'c8x160L33_am4p0_25km_wlkr_ent0p9_noconv',fileext_daily);
source_gcm_daily_nlw_s    =strcat(path_n,'c8x160L33_am4p0_25km_wlkr_ent0p9_lwoff',fileext_daily);
source_gcm_daily_nc_nlw_s =strcat(path_n,'c8x160L33_am4p0_25km_wlkr_ent0p9_noconv_lwoff',fileext_daily);
source_gcm_daily_l=strcat(path_25km_l,fileext_daily);
source_100_gcm_daily_s=strcat(path_100km_s,fileext_daily);
source_100_gcm_daily_l=strcat(path_100km_l,fileext_daily);

source_2km_daily=strcat(path_2km,'1979.6mn.atmos_daily_selvars.nc');
source_1km_daily=strcat(path_1km,'1979.6mn.atmos_daily_selvars.nc');

% daily data
precip_25km_dly_s         =ncread(source_gcm_daily_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_dly_c_s       =ncread(source_gcm_daily_c_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_nc_dly_s      =ncread(source_gcm_daily_nc_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_nlw_dly_s     =ncread(source_gcm_daily_nlw_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_nc_nlw_dly_s  =ncread(source_gcm_daily_nc_nlw_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_25km_dly_l=ncread(source_gcm_daily_l,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_100km_dly_s=ncread(source_100_gcm_daily_s,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_100km_dly_l=ncread(source_100_gcm_daily_l,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run

precip_2km_dly=ncread(source_2km_daily,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run
precip_1km_dly=ncread(source_1km_daily,'precip'); % [xdim ydim tdim], last four yrs of 5 yr run

% histogram hogwash
p_25dly_l=squeeze(mean(precip_25km_dly_l,2));
[blue,in_25_l]=max(p_25dly_l);
p_25dly_s=squeeze(mean(precip_25km_dly_s,2));
[blue,in_25_s]=max(p_25dly_s);
p_100dly_l=squeeze(mean(precip_100km_dly_l,2));
[blue,in_100_l]=max(p_100dly_l);
p_100dly_s=squeeze(mean(precip_100km_dly_s,2));
[blue,in_100_s]=max(p_100dly_s);
p_2dly=squeeze(mean(precip_2km_dly,2));
[blue,in_2km]=max(p_2dly);
p_1dly=squeeze(mean(precip_1km_dly,2));
[blue,in_1km]=max(p_1dly);
% extra 25km experiments
p_25dly_c_s=squeeze(mean(precip_25km_dly_c_s,2));
[blue,in_25_c_s]=max(p_25dly_c_s);
p_25dly_nc_s=squeeze(mean(precip_25km_nc_dly_s,2));
[blue,in_25_nc_s]=max(p_25dly_nc_s);
p_25dly_nlw_s=squeeze(mean(precip_25km_nlw_dly_s,2));
[blue,in_25_nlw_s]=max(p_25dly_nlw_s);
p_25dly_nc_nlw_s=squeeze(mean(precip_25km_nc_nlw_dly_s,2));
[blue,in_25_nc_nlw_s]=max(p_25dly_nc_nlw_s);

%--------------------------------------------------------------

% compute the standard deviation for each case:
std25s=std(in_25_s);
std25l=std(in_25_l);
std100s=std(in_100_s);
std100l=std(in_100_l);
std1km =std(in_1km);
std2km =std(in_2km);
std_arr=([std1km std2km std25s std25l std100s std100l])

xgp=1:160;
gauss_25s=make_gaussian(in_25_s,80,xgp);
gauss_25s_c=make_gaussian(in_25_c_s,80,xgp);
gauss_25s_nc=make_gaussian(in_25_nc_s,80,xgp);
gauss_25s_nlw=make_gaussian(in_25_nlw_s,80,xgp);
gauss_25s_nc_nlw=make_gaussian(in_25_nc_nlw_s,80,xgp);
xgp=1:40;
gauss_100s=make_gaussian(in_100_s,20,xgp);
xgp=1:640;
gauss_25l=make_gaussian(in_25_l,320,xgp);
xgp=1:160;
gauss_100l=make_gaussian(in_100_l,80,xgp);
xgp=1:2000;
gauss_2km=make_gaussian(in_2km,1000,xgp);
xgp=1:4000;
gauss_1km=make_gaussian(in_1km,2000,xgp);
%
nbins_crm=60;
figure
%ax=axes;
subplot(1,3,1)
ax=gca;
%ax=axes;
histogram(in_25_s,60,'Normalization','pdf','DisplayStyle','stairs')
set(ax,'XTick',0:40:160,'XTickLabel',{'0','1000','2000','3000','4000'});
xlim([0 160])
%ax.XTick=[0 40 80 120 160];
hold on
grid on
plot(gauss_25s,'k','LineWidth',2)
title('25km Par Conv')
subplot(1,3,2)
ax=gca;
%bx=axes;
histogram(in_2km,nbins_crm,'Normalization','pdf','DisplayStyle','stairs')
set(ax,'XTick',0:500:2000,'XTickLabel',{'0','1000','2000','3000','4000'});
xlim([0 2000])
hold on
grid on
plot(gauss_2km,'k','LineWidth',2)
title('2km ')
subplot(1,3,3)
ax=gca;
histogram(in_1km,nbins_crm,'Normalization','pdf','DisplayStyle','stairs')
set(ax,'XTick',0:1000:4000,'XTickLabel',{'0','1000','2000','3000','4000'});
xlim([0 4000])
hold on
grid on
plot(gauss_1km,'k','LineWidth',2)
title('1km ')
suptitle(superTit)
%
figure
subplot(2,2,1)
histogram(in_25_s,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,160])
hold on
grid on
plot(gauss_25s,'k','LineWidth',2)
title('25km small')
subplot(2,2,2)
histogram(in_100_s,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,40])
hold on
grid on
plot(gauss_100s,'k','LineWidth',2)
title('100km small')
subplot(2,2,3)
histogram(in_25_l,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,640])
hold on
grid on
plot(gauss_25l,'k','LineWidth',2)
%xlim([240,400])
title('25km large')
subplot(2,2,4)
histogram(in_100_l,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,160])
hold on
grid on
plot(gauss_100l,'k','LineWidth',2)
%xlim([60,100])
title('100km large')

suptitle(superPHistTit)

figure
subplot(2,2,1)
histogram(in_25_c_s,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,160])
hold on
grid on
plot(gauss_25s,'k','LineWidth',2)
title('25km control')
subplot(2,2,2)
histogram(in_25_nc_s,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,160])
hold on
grid on
plot(gauss_25s_nc,'k','LineWidth',2)
title('25km noconv')
subplot(2,2,3)
histogram(in_25_nlw_s,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,160])
hold on
grid on
plot(gauss_25s_nlw,'k','LineWidth',2)
title('25km lwcre off')
subplot(2,2,4)
histogram(in_25_nc_nlw_s,150,'Normalization','pdf','DisplayStyle','stairs')
xlim([0,160])
hold on
grid on
plot(gauss_25s_nc_nlw,'k','LineWidth',2)
title('25km noconv lwcre off')
suptitle('small domain (4000 km)')

%--------------------------------------------------------------

figure
subplot(2,2,1)
histogram(in_25_s,100)
xlim([0,160])
title('25km small')
subplot(2,2,2)
histogram(in_100_s,100)
xlim([0,40])
title('100km small')
subplot(2,2,3)
histogram(in_25_l,100)
xlim([0,640])
%xlim([240,400])
title('25km large')
subplot(2,2,4)
histogram(in_100_l,100)
xlim([0,160])
%xlim([60,100])
title('100km large')




%xgcm_ngp_25=xgcm_ngp_640;
%xgcm_ngp_25=xgcm_ngp_160;
%xgcm_ngp_25=xgcm_ngp_40;

xgcm_25=xgcm_25_s;
xgcm_ngp_100=xgcm_ngp_40;
xgcm_100=xgcm_100_s;

% we shouldn't have to change anything after this point...

% for files with fileext_1
precip_100km_znm=mean(precip_100km_l,2);
precip_25km_znm=mean(precip_25km_s,2);

% define the level at which the vertical velocity will be plotted:
wlev=29;
w_100km_s_lev_znm =w_100km_s_ztmn(:,wlev);
w_100km_l_lev_znm =w_100km_l_ztmn(:,wlev);
w_25km_s_lev_znm  =w_25km_s_ztmn(:,wlev);
w_25km_l_lev_znm  =w_25km_l_ztmn(:,wlev);

p_100km_znm=scale.*(squeeze(precip_100km_znm));
p_25km_znm=scale.*(squeeze(precip_25km_znm));

p_100km_l_tmean=mean(p_100km_znm,2);
p_25km_s_tmean=mean(p_25km_znm,2);

% for files with fileext_2
precip_100km_s_znm=mean(precip_100km_s,2);
precip_25km_l_znm=mean(precip_25km_l,2);

p_100km_s_znm=scale.*(squeeze(precip_100km_s_znm));
p_25km_l_znm=scale.*(squeeze(precip_25km_l_znm));

p_100km_s_tmean=p_100km_s_znm;
p_25km_l_tmean=p_25km_l_znm;

% compute the domain and time mean values
MeanPrecip_100km_s=mean(p_100km_s_tmean,1)
MeanPrecip_100km_l=mean(p_100km_l_tmean,1)
MeanPrecip_25km_s=mean(p_25km_s_tmean,1)
MeanPrecip_25km_l=mean(p_25km_l_tmean,1)

figure
%plot(xcrm(1:xcrm_ngp),p_2km_tmean(:),'Color',colblu,'LineWidth',2);
subplot(1,2,1)
plot(xgcm_25_l(1:xgcm_ngp_640),w_25km_l_lev_znm(:),'Color',colyel,'LineWidth',2);
hold on
plot(xgcm_100_l(1:xgcm_ngp_160),w_100km_l_lev_znm(:),'r','LineWidth',2);
ylabel('w (m/s)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
xlim([0,16000])
tit_e=strcat('Vert Vel 100km,25km GCM:');
%title(tit_e);
%suptitle(tit_st)
subplot(1,2,2)
plot(xgcm_25_s(1:xgcm_ngp_160),w_25km_s_lev_znm(:),'Color',colyel,'LineWidth',2);
hold on
plot(xgcm_100_s(1:xgcm_ngp_40),w_100km_s_lev_znm(:),'r','LineWidth',2);
ylabel('w (m/s)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
xlim([0,4000])
tit_e=strcat('Vert Vel 100km,25km GCM:');
%title(tit_e);
%suptitle(tit_st)


figure
%plot(xcrm(1:xcrm_ngp),p_2km_tmean(:),'Color',colblu,'LineWidth',2);
subplot(1,2,1)
plot(xgcm_25_l(1:xgcm_ngp_640),p_25km_l_tmean(:),'Color',colyel,'LineWidth',2);
hold on
plot(xgcm_100_l(1:xgcm_ngp_160),p_100km_l_tmean(:),'r','LineWidth',2);
ylabel('Precip (mm/d)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
xlim([0,16000])
tit_e=strcat('Precip 100km,25km GCM:',num2str(MeanPrecip_100km_l),'; ',num2str(MeanPrecip_25km_l));
%title(tit_e);
%suptitle(tit_st)
subplot(1,2,2)
plot(xgcm_25_s(1:xgcm_ngp_160),p_25km_s_tmean(:),'Color',colyel,'LineWidth',2);
hold on
plot(xgcm_100_s(1:xgcm_ngp_40),p_100km_s_tmean(:),'r','LineWidth',2);
ylabel('Precip (mm/d)','FontSize',20)
xlabel('km','FontSize',20)
yt=get(gca,'YTick');
set(gca,'FontSize',16)
xlim([0,4000])
tit_e=strcat('Precip 100km,25km GCM:',num2str(MeanPrecip_100km_s),'; ',num2str(MeanPrecip_25km_s));

