%--------------------------------------------------------------------------------------------%
%  This program plot zonalmean of        
%  of CloudSat Obs.                     
% 
%  to do: 1. import file with output from cosp cloudsat data and plot
%         2. compute difference between observations and model output
%         3. plot cloudsat data and model output as a function of hieght and reflectivity
%
%         change colormap!
%
% modified by levi silvers            nov 2016

%--------------------------------------------------------------------------------------------%


close ('all');
clear all;

%%% colormap vector
a=[0.75 0 1; 0.5 0 1; 0 0 1; 0 0.5 1; 0 1 1; 0 1 0.5; 0 1 0; 0.5 1 0; 1 1 0; 1 0.5 0; 1 0 0; 1 0 0.5];


ncload('/work/Levi.Silvers/satdata/cloudsat/TotalCloudFraction_CloudSat_200606-200612.nc');

%%% Create the matrix
cltcloudsat(cltcloudsat==-999)=nan;  % Set NaN values
clt=squeeze(nanmean(cltcloudsat,1));  % Average over the time
clt=permute(clt,[2 1]);

%%% New matrix to match to m_proj graphic
clt2(1:180,1:90)=0;
clt2(:,5:86)=clt;

%%% Create the plot
figure;

%%% Load the file
ncload('/work/Levi.Silvers/satdata/cloudsat/cfadDbze94_200701-200712.nc');

%%% Create the matrix
cfadDbze94(cfadDbze94==-999)=nan;  % NaN values
 
%%% average to make the 2dim matrix  
cloud1=squeeze(nanmean(cfadDbze94,5)); % average over longitude 
cloud2=squeeze(nansum(cloud1,2)); % sum over dbz values
cloud3=squeeze(nanmean(cloud2,1)); % average in time

%%% Create the plot
subplot(2,1,2)
imagesc(lat,alt40/1000,cloud3);
set(gca,'ydir','normal')
caxis([0 0.33])
axis([-80 80 0 16])
colorbar
colormap(a)
ylabel('ALTITUDE (KM)')
xlabel('LATITUDE')
title('CloudSat Cloud Fraction 3D')
