%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FIGURE 5 CESANA ET AL 2015 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%
%%% OBS %%%
%%%%%%%%%%%
%ncload5('~/Desktop/GOCCP/3D_CloudFraction_Temp330m_200701-201612_night_CFMIP2.5_sat_2.9.nc')
%ncload('~/data/SatData/CALIPSO/3D_CloudFraction_Temp330m_200701-201612_night_CFMIP2.5_sat_2.9.nc')
clear cltemp

data_file='~/data/SatData/CALIPSO/3D_CloudFraction_Temp330m_200701-201612_night_CFMIP2.5_sat_2.9.nc';
%cltemp=ncread(data_file,'cltemp');
latitude=ncread(data_file,'latitude');
longitude=ncread(data_file,'longitude');
cltemp_ice=ncread(data_file,'cltemp_ice');
cltemp_liq=ncread(data_file,'cltemp_liq');

% DEFINE temperature vectors
tempmid=[-91.5:3:19.5];
tempmod=[-93:3:22];

lat_obs=latitude;
lat_obs2=-90:2.5:90;

% SANITY CHECK
cltemp_ice(cltemp_ice<0)=nan;
cltemp_liq(cltemp_liq<0)=nan;

% TOT = ICE + LIQ (UNDEF ARE NOT TAKEN INTO ACCOUNT HERE)
cltemp(1,:,:,:,:)=cltemp_ice(:,:,:,:);
cltemp(2,:,:,:,:)=cltemp_liq(:,:,:,:);
cltot(:,:,:,:)=squeeze(nansum(cltemp,1));
clear cltemp

phase=cltemp_ice./cltot;  % PHASE RATIO = ICE/(ICE+LIQ) (AGAIN NO UNDEF)
phaseobs=squeeze(nanmean(nanmean(phase(:,:,:,:),4),1))';  % MEAN
phaseobs(:,73)=nan;  % add +1 dimension for pcolor representation issues
phaseobs(39,:)=nan;  % add +1 dimension for pcolor representation issues


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% JUST COMPUTING THE T50 and T90 CONTOUR 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(22)  %DUMMY FIGURE
tata=contour(lat_obs,tempmid,phaseobs(1:38,1:72),[0.9 0.9],'green.','linewidth',3); 
tata2=tata(1,2:end);
tata3=tata(2,2:end);
close(22)
for t=1:length(lat_obs)
lattmp=find(tata2==lat_obs(t));
latsize=size(lattmp);
if latsize(2) ~=0
phasetemp90obs(t)=tata3(lattmp(1));
else
   phasetemp90obs(t)=nan;
end
end
clear tata tata2 tata3

figure(22)
tata=contour(lat_obs,tempmid,phaseobs(1:38,1:72),[0.5 0.5],'green.','linewidth',3); 
tata2=tata(1,2:end);
tata3=tata(2,2:end);
close(22)
for t=1:length(lat_obs)
lattmp=find(tata2==lat_obs(t));
latsize=size(lattmp);
if latsize(2) ~=0
phasetemp50obs(t)=tata3(lattmp(1));
else
   phasetemp50obs(t)=nan;
end
end
clear tata tata2 tata3
%%%%%%%%%%%%%%%%%%%%
%%% T50 T90 COMPUTED
%%%%%%%%%%%%%%%%%%%%


%%% PLOT THE FIGURE
figure(1)
subplot(2,1,1)  
pcolor(lat_obs2,tempmod,phaseobs)
shading flat
hold on
plot([-90 90],[-40 -40],'white--')
plot([-90 90],[0 0],'white--')
plot(lat_obs,phasetemp90obs,'yellow-','linewidth',3)
plot(lat_obs,phasetemp50obs,'yellow--','linewidth',3)
set(gca,'ydir','normal')
set(gca,'tickdir','out')
set(gca,'ytick',[-45, -40:5:0, 3],'fontname','times','fontsize',14)
set(gca,'xtick',[-90:30:90],'fontname','times','fontsize',14)
axis ij
%caxis([0 1])
axis([-90 90 -45 3])
title('Obs (CALIPSO-GOCCP)','fontname','times','fontweight','bold','fontsize',14)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FIGURE 10 CESANA ET AL 2015 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% DEFINE VECTORS
tempmod=[-91:3:24];
presmod=0:0.1:1.;
presmod(11)=1.01;

lat=latitude;
lon=longitude;

%%% DEFINE 2D_HISTOGRAM
totoobs(1:39,1:length(presmod))=0;
cltemp_phase=phase;

for t=1:120  
for itemp=1:38
    
for ilat=1:length(lat)-1
for ilon=1:length(lon)-1
    
    for l=1:length(presmod)-1
      if cltemp_phase(ilon,ilat,itemp,t)>=presmod(l) &&  cltemp_phase(ilon,ilat,itemp,t)<presmod(l+1)
        totoobs(itemp,l)=totoobs(itemp,l)+1;
      end
    end
    
end
end

end
end

%%% NORMALIZE BY THE TOTAL NB OF OCCURRENCES
phasevstempobs=(totoobs(16:33,:)./squeeze(nansum(nansum(totoobs(16:33,:)))))';
phasevstempobs(:,19)=nan;

figure(2)
subplot(2,1,1)
pcolor(tempmod(16:34),presmod,phasevstempobs);shading flat
%caxis([0 0.02])
hold on
plot(tempmod(1:38)+1.5,squeeze(nanmean(nanmean(nanmean(cltemp_phase,4),1),2))','yellow-','linewidth',2)
axis([-45 3 0 1])
set(gcf,'color','white')
set(gca,'ytick',[0:0.1:1],'yticklabel',[0:10:100],'fontname','times','fontsize',14)
set(gca,'tickdir','out')
title('Obs (CALIPSO-GOCCP)','fontname','times','fontweight','bold','fontsize',14)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%
%%% MODEL %%%
%%%%%%%%%%%%%

clear
%%% LOAD YOUR MODEL OUTPUTS HERE

% DEFINE temperature vectors !!!! BE CAREFULL TEMPERATURE VECTOR DIFFERENT
% IN THE SIMULATOR !!!!
tempmid=[25.5:-3:-91.5];
tempmod=27:-3:-93;
lat2=-90:2:90;


% IN MY MODEL CF_liq & ice ARE clcalipsotmpliq $ clcalipsotmpice

data_file_modliq='/Users/silvers/data/c96L33_am4p0_DynVeg_cfamip_a_caltmp/atmos_cmip.187401-187412.clcalipsotmpliq.nc';
data_file_modice='/Users/silvers/data/c96L33_am4p0_DynVeg_cfamip_a_caltmp/atmos_cmip.187401-187412.clcalipsotmpice.nc';

%cltemp=ncread(data_file,'cltemp');
latitude=ncread(data_file_modliq,'lat');
%cltemp_ice=ncread(data_file_modice,'clcalipsotmpice');
%cltemp_liq=ncread(data_file_modliq,'clcalipsotmpliq');
clcalipsotmpice=ncread(data_file_modice,'clcalipsotmpice');
clcalipsotmpliq=ncread(data_file_modliq,'clcalipsotmpliq');

% REPLACE BY THE CORRESPONDING NAMES FOR YOUR OUPUTS
 tot1(:,:,:,:,1)=clcalipsotmpliq;
 tot1(:,:,:,:,2)=clcalipsotmpice;
 tot=squeeze(nansum(tot1,5));
 phase=clcalipsotmpice./tot;
 phasemod=squeeze(nanmean(nanmean(clcalipsotmpice./tot,4),1));
 phasemod(91,:)=nan;
 phasemod(:,41)=nan;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% JUST COMPUTING THE T50 and T90 CONTOUR 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(22)  %DUMMY FIGURE
tata=contour(latitude,tempmid,phasemod(1:90,1:40)',[0.5 0.5],'green.','linewidth',3); 
tata2=tata(1,2:end);
tata3=tata(2,2:end);
close(22)

for t=1:length(lat)
lattmp=find(tata2==lat(t));
latsize=size(lattmp);
if latsize(2) ~=0
    if latsize(2) >1
        phasetemp50mod(t)=tata3(lattmp(end));
    else
        phasetemp50mod(t)=tata3(lattmp(1));
    end
else
   phasetemp50mod(t)=nan;
end
end
clear tata tata2 tata3

figure(22)
tata=contour(lat2,tempmid,phasemod(1:90,1:40)',[0.9 0.9],'green.','linewidth',3); 
tata2=tata(1,2:end);
tata3=tata(2,2:end);
close(22)

for t=1:length(lat)
lattmp=find(tata2==lat(t));
latsize=size(lattmp);
if latsize(2) ~=0
    if latsize(2) >1
        phasetemp90mod(t)=tata3(lattmp(end));
    else
        phasetemp90mod(t)=tata3(lattmp(1));
    end
else
   phasetemp90mod(t)=nan;
end
end
clear tata tata2 tata3
%%%%%%%%%%%%%%%%%%%%
%%% T50 T90 COMPUTED
%%%%%%%%%%%%%%%%%%%%

%%% PLOT THE FIGURE
figure(1)
subplot(2,1,2)
pcolor(lat2,tempmod,phasemod')
shading flat
hold on
plot([-90 90],[-40 -40],'white--')
plot([-90 90],[0 0],'white--')
plot(lat,phasetemp90mod,'green-','linewidth',3)
plot(lat_obs,phasetemp90obs,'yellow-','linewidth',3)
plot(lat,phasetemp50mod,'green--','linewidth',3)
plot(lat_obs,phasetemp50obs,'yellow--','linewidth',3)
set(gca,'ydir','normal')
set(gca,'tickdir','out')
set(gca,'ytick',[-45, -40:5:0, 3],'fontname','times','fontsize',14)
set(gca,'xtick',[-90:30:90],'fontname','times','fontsize',14)
axis ij
caxis([0 1])
axis([-90 90 -45 3])
set(gcf,'color','white')
set(gca,'tickdir','out')
ylabel('Temperature (\circC)','fontname','times','fontweight','bold','fontsize',14)
xlabel('Latitude (\circN))','fontname','times','fontweight','bold','fontsize',14)
load colorbars
colormap(redblue)
title('ModelE3','fontname','times','fontweight','bold','fontsize',14)
tutu=colorbar('west','ytick',[-0:2*1/10:1],'yticklabel',[-0:2*100/10:100],'fontname','times','fontsize',12);
ylabel(tutu,'Phase Ratio (%)','fontname','times','fontsize',12)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FIGURE 10 CESANA ET AL 2015 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% DEFINE VECTORS
tempmod=27:-3:-93;
presmod=0:0.1:1.;
presmod(11)=1.01;

%%% DEFINE 2D_HISTOGRAM
totomod(1:40,1:length(presmod))=0;
cltemp_phase=phase;

for t=1:length(time)
for itemp=1:40
    
for ilat=1:length(lat)-1
for ilon=1:length(lon)-1
    
    for l=1:length(presmod)-1
      if cltemp_phase(ilon,ilat,itemp,t)>=presmod(l) &&  cltemp_phase(ilon,ilat,itemp,t)<presmod(l+1)
        totomod(itemp,l)=totomod(itemp,l)+1;
      end
    end
    
end
end

end
end

%%% NORMALIZE BY THE TOTAL NB OF OCCURRENCES
phasevstempmod=(totomod(8:25,:)./squeeze(nansum(nansum(totomod(8:25,:)))))';
phasevstempmod(:,19)=nan;

figure(2)
subplot(2,1,2)
pcolor(tempmod(8:26),presmod,phasevstempmod);shading flat
caxis([0 0.02])
hold on
plot(tempmod(1:40)-1.5,squeeze(nanmean(nanmean(cltemp_phase,1),2))','g-','linewidth',2)
axis([-45 3 0 1])
set(gcf,'color','white')
set(gca,'ytick',[0:0.1:1],'yticklabel',[0:10:100],'fontname','times','fontsize',14)
set(gca,'tickdir','out')
xlabel('Temperature (\circC)','fontname','times','fontweight','bold','fontsize',14)
title('ModelE3','fontname','times','fontweight','bold','fontsize',14)
load color100bis
colormap(color100bis)

tutu=colorbar('west','ytick',[-0:2*0.02/10:0.02],'yticklabel',[-0:2*2/10:2],'fontname','times','fontsize',12);
ylabel(tutu,'Normalized Occurrence (%)','fontname','times','fontsize',12)

