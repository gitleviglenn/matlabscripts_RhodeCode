
% import the sst and landmask data, they are on different grids
sst=ncread('~/data/amip_long/hadisst_sst.data.nc','sst');
% the sst data starts in 1860
landm=ncread('~/data/am4p0/atmos.static.nc','land_mask');

%% define parameters and initialize arrays
endtime=1776; % needs to be an integer of 12
nyears=endtime/12;
monthint=1/12;
years=1860.0833:monthint:1860+nyears;
years_n=1860.75:monthint:1860+nyears; % time series to use for the smoothed data.
month=repmat(1:12,1,nyears);
binnum=100;
[XN,YN]=meshgrid(0.2:0.8:288,1:180);

% define arrays
sst_ocean                    =zeros(360,180,endtime);
sst_oc_tr                    =zeros(endtime,binnum);
sst_oc_tr_deseas             =zeros(endtime,binnum);

% impose landseamask
for timin=1:endtime
  sst_time1=squeeze(sst(:,:,timin)); % get sst at one time
  sst_ocean(:,:,timin)=nanlandinterp(sst_time1,landm,XN,YN); % impose a landmask of NaNs
end

% grab only tropical points
sst_tr=sst(:,60:120,1:endtime);
sst_ocean_tr=sst_ocean(:,60:120,1:endtime);

% i believe this is computing the empirical cummulative distribution function; 
%which appears to sort the data as well.  
for tim=1:endtime
  sst_ocean_tr_cdf=histogram(sst_ocean_tr(:,:,tim),binnum,'Normalization','cdf');
  for i=1:binnum
%    sst_oc_tr(tim,i-1)=sst_ocean_tr_cdf.BinEdges(i);
    sst_oc_tr(tim,i)=sst_ocean_tr_cdf.Values(i);
  end
end

% deseasonalize
for i=1:binnum-1;
  for k=1:12;
%    oc_monmean(k)=mean(sst_oc_tr(month==k,i));
    oc_monmean(k,i)=mean(sst_oc_tr(month==k,i));
  end
  for k=1:12;
    sst_oc_tr_deseas(month==k,i)=sst_oc_tr(month==k,i)-oc_monmean(k,i);
  end
end

yblu_b=0.0:1./binnum:1.0-1./binnum;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,sst_oc_tr_deseas');
set(h,'EdgeColor','none');
colorbar
title('new crap')

smooth=zeros(1776,92);
smoothlong=zeros(1768,92);

% smooth data
tendindex=100;
for t=1:1776;
  incoming_ts=sst_oc_tr_deseas(t,:);
  running_mean;
  smooth(t,:)=output_ts(:);
end

binnm=binnum-8;
yblu_b=0.0:1./binnm:1.0-1./binnm;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,smooth');
set(h,'EdgeColor','none');
colorbar
title('new crap')

tendindex=1776;
for t=1:binnm;
  incoming_ts=sst_oc_tr_deseas(:,t);
  running_mean;
  smoothlong(:,t)=output_ts(:);
end

yblu_b=0.0:1./binnm:1.0-1./binnm;
figure
colormap(jet)
[C,h]=contourf(years_n,yblu_b,smoothlong');
set(h,'EdgeColor','none');
colorbar
title('new crap')
