%---------------------------------------------------------------------------------------
% budget_1cfsite.m
%---------------------------------------------------------------------------------------
% purpose:   quick look at data from a particular grid point.
%
%            the data and location of the station are based on
%            the cfSites component from cfmip3
%
%            check the moisture and temperature budgets
%
%            quality control and check the varaibles from the cf diag_table
%
% levi silvers                                                    oct 2018
%---------------------------------------------------------------------------------------

%path='/archive/Levi.Silvers/awg/warsaw/c96L33_am4p0_cmip6Diag_oldcfsite_nocosp_2sites/gfdl.ncrc3-intel-prod-openmp/history/'
%path='/net2/Levi.Silvers/data/cfamip_testdiag/'
% path to the CFsite data
path='/archive/oar.gfdl.cmip6/CM4/warsaw_201803/CM4_amip/gfdl.ncrc4-intel16-prod-openmp/pp/cfmip_CFsite/ts/30min/5yr/'
% path to the atmos_level_cmip variable group
path2atmoscmip='/archive/oar.gfdl.cmip6/CM4/warsaw_201803/CM4_amip/gfdl.ncrc4-intel16-prod-openmp/pp/atmos_level_cmip/ts/monthly/6yr/atmos_level_cmip.199701-200212.pfull.nc'
%
%fileincming='19800101.atmos_station_001.tile5.nc'
%fileincming='19830101.atmos_station_120.tile5.nc'

%fileincming='cfsites/18700101.CFsite.nc'
fileincming='cfmip_CFsite.1990010100:00-1994123123:59'
file_site=strcat(path,fileincming);
filestr=strcat(path2atmoscmip);

%% below are the old ways...
%statstring='Station 001';
%source_file=strcat(path,fileincming);
%fin_total=netcdf(source_file,'nowrite');

fin_pfull=netcdf(filestr);
pfull=fin_pfull{'pfull'};

file_ta=strcat(file_site,'.ta.nc');
fin_ta=netcdf(file_ta);
ta=fin_ta{'ta'}; % temperature

file_hus=strcat(file_site,'.hus.nc');
fin_hus=netcdf(file_hus);
hus=fin_hus{'hus'}; % temperature

file_hur=strcat(file_site,'.hur.nc');
fin_hur=netcdf(file_hur);
hur=fin_hur{'hur'}; % temperature

file_tntmp=strcat(file_site,'.tntmp.nc');
fin_tntmp=netcdf(file_tntmp);
tntmp=fin_tntmp{'tntmp'}; % temperature

file_tnta=strcat(file_site,'.tnta.nc');
fin_tnta=netcdf(file_tnta);
tnta=fin_tnta{'tnta'}; % temperature

file_tnt=strcat(file_site,'.tnt.nc');
fin_tnt=netcdf(file_tnt);
tnt=fin_tnt{'tnt'}; % temperature

file_tntr=strcat(file_site,'.tntr.nc');
fin_tntr=netcdf(file_tntr);
tntr=fin_tntr{'tntr'}; % temperature

file_tntrl=strcat(file_site,'.tntrl.nc');
fin_tntrl=netcdf(file_tntrl);
tntrl=fin_tntrl{'tntrl'}; % temperature

file_tntrs=strcat(file_site,'.tntrs.nc');
fin_tntrs=netcdf(file_tntrs);
tntrs=fin_tntrs{'tntrs'}; % temperature

file_tntc=strcat(file_site,'.tntc.nc');
fin_tntc=netcdf(file_tntc);
tntc=fin_tntc{'tntc'}; % temperature

file_tntpbl=strcat(file_site,'.tntpbl.nc');
fin_tntpbl=netcdf(file_tntpbl);
tntpbl=fin_tntpbl{'tntpbl'}; % temperature

file_tntscp=strcat(file_site,'.tntscp.nc');
fin_tntscp=netcdf(file_tntscp);
tntscp=fin_tntscp{'tntscp'}; % temperature

%file_qdt_vdif=strcat(file_site,'.qdt_vdif.nc');
%fin_qdt_vdif=netcdf(file_qdt_vdif);
%qdt_vdif=fin_qdt_vdif{'qdt_vdif'}; % temperature

file_tnhus=strcat(file_site,'.tnhus.nc');
fin_tnhus=netcdf(file_tnhus);
tnhus=fin_tnhus{'tnhus'}; % tend of spec hum

file_tnhuspbl=strcat(file_site,'.tnhuspbl.nc');
fin_tnhuspbl=netcdf(file_tnhuspbl);
tnhuspbl=fin_tnhuspbl{'tnhuspbl'}; % tend of spec hum due to BL mixing

file_tnhusscp=strcat(file_site,'.tnhusscp.nc');
fin_tnhusscp=netcdf(file_tnhusscp);
tnhusscp=fin_tnhusscp{'tnhusscp'}; % tend of spec hum due to strat clouds and precip

file_tnhusa=strcat(file_site,'.tnhusa.nc');
fin_tnhusa=netcdf(file_tnhusa);
tnhusa=fin_tnhusa{'tnhusa'}; % tend of spec hum due to advection

file_tnhusmp=strcat(file_site,'.tnhusmp.nc');
fin_tnhusmp=netcdf(file_tnhusmp);
tnhusmp=fin_tnhusmp{'tnhusmp'}; % tend of spec hum due to model physics

file_tnhusc=strcat(file_site,'.tnhusc.nc');
fin_tnhusc=netcdf(file_tnhusc);
tnhusc=fin_tnhusc{'tnhusc'}; % tend of specific humidity due to convection

%file_qdt_ls=strcat(file_site,'.qdt_ls.nc');
%fin_qdt_ls=netcdf(file_qdt_ls);
%qdt_ls=fin_qdt_ls{'qdt_ls'}; % temperature

%file_qdt_dyn=strcat(file_site,'.qdt_dyn.nc');
%fin_qdt_dyn=netcdf(file_qdt_dyn);
%qdt_dyn=fin_qdt_dyn{'qdt_dyn'}; % temperature

%file_qdt_conv=strcat(file_site,'.qdt_conv.nc');
%fin_qdt_conv=netcdf(file_qdt_conv);
%qdt_conv=fin_qdt_conv{'qdt_conv'}; % temperature


% tendencies are in units of blah blah per second.  Output is every halfhour
%conv=1800.; % number of seconds per half hour
conv=1.; % when comparing to values from PiControl experiments to QC no conversion is better..
%timest=1750;
timest=200;
sitenum=68; % 52 is deep tropics; 24 the trades in the north tropical pacific
% 68 is off the coast of S.A. a few degrees

% these correspond to the actual profiles, that should be matched by adding tendencies
%husdiff=hus(timest,:,1,1)-hus(timest-1,:,1,1);
%tadiff=ta(timest,:,1,1)-ta(timest-1,:,1,1);
husdiff=hus(timest,sitenum,:)-hus(timest-1,sitenum,:); % units?
tadiff=ta(timest,sitenum,:)-ta(timest-1,sitenum,:); % units? K/30 minutes?  

% compute time series
vlev=5;
timeone=20;
timetwo=100;
for timei=1:200;
  %tadiff_fullts(timei)=ta(timei,vlev,1,1)-ta(timei-1,vlev,1,1);
  %husdiff_fullts(timei)=hus(timei,vlev,1,1)-hus(timei-1,vlev,1,1);
  tadiff_fullts(timei)=ta(timei,sitenum,vlev)-ta(timei-1,sitenum,vlev);
  husdiff_fullts(timei)=hus(timei,sitenum,vlev)-hus(timei-1,sitenum,vlev);
end

tadiff_ts=squeeze(tadiff_fullts(timeone:timetwo));
husdiff_ts=squeeze(husdiff_fullts(timeone:timetwo));

%% specific humidity tendency terms
%%qdtcheck=conv*(qdt_ls(timest,:,1,1)+qdt_dyn(timest,:,1,1)+qdt_conv(timest,:,1,1)+qdt_vdif(timest,:,1,1));
%%qdtcheck_ts=conv*(qdt_ls(timeone:timetwo,vlev,1,1)+qdt_dyn(timeone:timetwo,vlev,1,1)+qdt_conv(timeone:timetwo,vlev,1,1)+qdt_vdif(timeone:timetwo,vlev,1,1));
%qdtcheck=conv*(qdt_ls(timest,sitenum,:)+qdt_dyn(timest,sitenum,:)+tnhusc(timest,sitenum,:)+qdt_vdif(timest,sitenum,:));
%qdtcheck_ts=conv*(qdt_ls(timeone:timetwo,vlev)+qdt_dyn(timeone:timetwo,vlev)+tnhusc(timeone:timetwo,vlev)+qdt_vdif(timeone:timetwo,vlev));

%qdtcheck=conv*(qdt_ls(timest,sitenum,:)+qdt_dyn(timest,sitenum,:)+tnhusc(timest,sitenum,:)+qdt_vdif(timest,sitenum,:));
qdtcheck=conv*(tnhus(timest,sitenum,:));
qdtmp=conv*(tnhusmp(timest,sitenum,:));
qdta=conv*(tnhusa(timest,sitenum,:));
qdtc=conv*(tnhusc(timest,sitenum,:));
qdtpbl=conv*(tnhuspbl(timest,sitenum,:));
qdtscp=conv*(tnhusscp(timest,sitenum,:));
qdtctl  =husdiff; % apparently we don't need to multiply by conv..

qdt_pbl_c_scp=qdtc+qdtpbl+qdtscp; % does this constitute the physics?  

newvf=pfull(1,:,90,90); % this is complicated because the pressure levels are a 
% functio of both space and time. 
yyax=1:33; % it is probably better to simply plot the data on the model levels 
% for that particular cfsite.

qdt_tb=qdt_pbl_c_scp+qdta;

figure
plot(qdt_pbl_c_scp,yyax,'b')
hold on
plot(qdtmp,yyax,'k')
plot(qdtcheck,yyax,'c','Linewidth',2)
plot(qdta,yyax,'r')
plot(qdt_tb,yyax,'--k')
title('moisture tends')

%%% temperature tendency terms

tdtmp=conv*(tntmp(timest,sitenum,:));
tdtr=conv*(tntr(timest,sitenum,:));
tdtc=conv*(tntc(timest,sitenum,:));
tdta=conv*(tnta(timest,sitenum,:));
tdtpbl=conv*(tntpbl(timest,sitenum,:));
tdtscp=conv*(tntscp(timest,sitenum,:));
tdt=conv*(tnt(timest,sitenum,:));

tdt_test=tdta+tdtmp; % tendency due to advection and 'model physics'
tdt_testmp=tdtr+tdtc+tdtpbl+tdtscp; % tendencies due to individual physics terms
% it looks like tdta + tdtmp (tendency due to model physics plus the 
% tendency due to the advection) equal the tendency computed explicitly 
% by differencing the temperature.  
% However, the tendency due to model physics (tdtmp) is not equal to 
% the tendencies of the individual components (tdtr+tdtc+tdtpbl+tdtscp)

% this suggests that there is a term which changes the temperature of the
% atmosphere that is included in the tdtmp term but which is not included 
% in tdtr, tdtc, tdtpbl, or tdtscp.

figure
plot(tdtr,yyax,'b')
hold on
plot(tdtc,yyax,'r')
plot(tdtpbl,yyax,'c')
plot(tdtscp,yyax,'--c')
plot(tdta,yyax,'--k')
plot(tadiff./1800.,yyax,'k')
sitechar=int2str(sitenum);
tottit=strcat('temperature tends at:',sitechar)
title(tottit)

figure
plot(tdtr,yyax,'b')
hold on
plot(tdtc,yyax,'r')
plot(tdtmp,yyax,'c')
%plot(tdtscp,yyax,'--c')
plot(tdta,yyax,'k')
plot(tdt,yyax,'g')
%plot(tadiff./1800.,yyax,'k')
sitechar=int2str(sitenum);
tottit=strcat('req in QC temp tends at:',sitechar)
title(tottit)

figure
plot(tdt_test,yyax,'--k')
hold on
plot(tdt_testmp,yyax,'b')
plot(tdta,yyax,'r')
plot(tadiff./1800.,yyax,'k')
title('temperature tends test')

figure
plot(tdt_testmp,yyax,'b')
hold on
plot(tdtmp,yyax,'r')
title('2 physics tmprtr tnds')

%%% dyn 
%%% rad + c + ls + vdif + topo
%%%tdtcheck= conv*(tnt_rad(timest,:,1,1)+tnt_dyn(timest,:,1,1) ...
%%%               +tntc(timest,:,1,1)   +tntls(timest,:,1,1)   ...
%%%               +tnt_vdif(timest,:,1,1)+tnt_topo(timest,:,1,1));
%%% dyn 
%%% rad + c + ls + vdif
%%tdtcheck= conv*(tnt_rad(timest,sitenum,:)+tnt_dyn(timest,sitenum,:) ...
%%               +tntc(timest,sitenum,:)+tntls(timest,sitenum,:) ...
%%	       +tnt_vdif(timest,sitenum,:));
%%% dyn 
%%% phy + vdif
%%tdtcheck2=conv*(tnt_phy(timest,sitenum,:)+tnt_dyn(timest,sitenum,:) ...
%%               +tnt_vdif(timest,sitenum,:));
%%% dyn 
%%% rad + c + ls 
%%tdtcheck3=conv*(tnt_rad(timest,sitenum,:)+tnt_dyn(timest,sitenum,:) ...
%%               +tntc(timest,sitenum,:)+tntls(timest,sitenum,:));
%%% dyn 
%%% phy  
%%tdtcheck4=conv*(tnt_phy(timest,sitenum,:)+tnt_dyn(timest,sitenum,:));
%%
%%% time series...
%%tdtcheck4_ts=conv*(tnt_phy(timeone:timetwo,vlev,1,1)+tnt_dyn(timeone:timetwo,vlev,1,1));
%
%figure
%plot(squeeze(husdiff),newvf,'k','Linewidth',2)
%set(gca,'Ydir','reverse')
%hold on
%plot(squeeze(qdtcheck),newvf,'--g')
%titlestr=strcat(statstring,': moisture budget tendency [kg/kg per 30 min]')
%title(titlestr)
%
%hold off
