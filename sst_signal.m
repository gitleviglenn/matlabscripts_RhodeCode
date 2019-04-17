
% import the sst and landmask data, they are on different grids
sst=ncread('~/data/amip_long/hadisst_sst.data.nc','sst');
% the sst data starts in 1860
landm=ncread('~/data/am4p0/atmos.static.nc','land_mask');

% define parameters and initialize arrays
endtime=1776; % needs to be an integer of 12
nyears=endtime/12;
monthint=1/12;
years=1860.0833:monthint:1860+nyears;
month=repmat(1:12,1,nyears);
month_20y=repmat(1:12,1,20);
binnum=100;
i=1:binnum;
tim=1:endtime;
[XN,YN]=meshgrid(0.2:0.8:288,1:180);

sst_oc_tr                    =zeros(endtime,binnum);
sst_oc_tr_deseas             =zeros(endtime,binnum);
sst_cdf_slope                =zeros(endtime,binnum-1);
sst_cdf_slope_deseas         =zeros(endtime,binnum-1);
sst_cdfanom_slope            =zeros(endtime,binnum-1);
sst_ocean_cdf_slope          =zeros(endtime,binnum-1);
sst_ocean_cdf_slope_deseas   =zeros(endtime,binnum-1);
sst_tr                       =zeros(360,61,endtime);
sst_ocean_tr                 =zeros(360,61,endtime);
sst_tr_cdfanom               =zeros(endtime,61,360);
sst_ocean                    =zeros(360,180,endtime);

% impose landseamask
for timin=1:endtime
  sst_time1=squeeze(sst(:,:,timin)); % get sst at one time
  sst_ocean(:,:,timin)=nanlandinterp(sst_time1,landm,XN,YN); % impose a landmask of NaNs
end

%sst_tr(:,:,1)=sortedsst(:,60:120,1);
% grab only tropical points
sst_tr=sst(:,60:120,1:endtime);
sst_ocean_tr=sst_ocean(:,60:120,1:endtime);

% still to do: loop over time, deseasonalize, plot with the time as 
% the x axis and y ranging between 0 and 1.
%sst_tr_temp=histogram(sst_tr(:,:,1),100,'Normalization','cdf');
%sst_cdfslope(1,i)=sst_tr_temp.Values(i+1)-sst_tr_temp.Values(i);


%monthlymeans(k)=mean(seasonal_data(month==k,i));


% do I need to sort or is that done automatically with the 'cdf' option?  
%sortedsst=sort(sst); % I should almost certainly specify which dimension to sort along
%sst_tr=sortedsst(:,60:120,1);

for tim=1:endtime
  %sst_tr(:,:,tim)=sortedsst(:,60:120,tim);
  sst_tr_cdf=histogram(sst_tr(:,:,tim),binnum,'Normalization','cdf');
  for i=1:binnum-1
    sst_cdf_slope(tim,i)=sst_tr_cdf.Values(i+1)-sst_tr_cdf.Values(i);
  end
  sst_ocean_tr_cdf=histogram(sst_ocean_tr(:,:,tim),binnum,'Normalization','cdf');
  for i=1:binnum-1
    sst_ocean_cdf_slope(tim,i)=sst_ocean_tr_cdf.Values(i+1)-sst_ocean_tr_cdf.Values(i);
  end
  for i=2:binnum+1
    %sst_oc_tr(tim,i)=sst_ocean_tr_cdf.Values(i);
    sst_oc_tr(tim,i-1)=sst_ocean_tr_cdf.BinEdges(i);
  end
end

for i=1:binnum-1;
  for k=1:12;
    test_monmean(k)=mean(sst_cdf_slope(month==k,i));
    test_oc_monmean(k)=mean(sst_ocean_cdf_slope(month==k,i));
    %oc_monmean(k)=mean(sst_oc_tr(month==k,i));
  end
  for k=1:12;
    sst_cdf_slope_deseas(month==k,i)=sst_cdf_slope(month==k,i)-test_monmean(k);
    sst_ocean_cdf_slope_deseas(month==k,i)=sst_ocean_cdf_slope(month==k,i)-test_oc_monmean(k);
    %sst_ocean_cdf_deseas(month==k,i)=sst_ocean_cdf(month==k,i)-test_oc_monmean(k);
  end
end

sst_last20y=sst_oc_tr(1776-239:1776,:);
for i=1:binnum;
  for k=1:12;
    oc_monmean(k)=mean(sst_oc_tr(month==k,i));
    %oc_monmean(k)=mean(sst_last20y(month_20y==k,i));
  end
  for k=1:12;
    sst_oc_tr_deseas(month==k,i)=sst_oc_tr(month==k,i)-oc_monmean(k);
  end
end

    % make some figures now...
figure
ymax=0.04
subplot(3,1,1)
sst_tr_hist=histogram(sst_tr(:,:,tim),binnum,'Normalization','Probability');
title('histogram')
ylim([0 ymax])
xlim([286 307])
subplot(3,1,2)
sst_tr_cumsum=histogram(sst_tr(:,:,tim),binnum,'Normalization','cdf');
xlim([286 307])
title('cum sum')
ylim([0 1.0])
subplot(3,1,3)
plot(sst_cdf_slope(tim,:))
title('cdf slope')
ylim([-0.01 ymax])
hold on
plot(sst_cdf_slope_deseas(tim,:))

% deseasonalized figure...
figure
subplot(3,1,1)
sst_tr_hist=histogram(sst_ocean_tr(:,:,tim),binnum,'Normalization','Probability');
title('ocean only histogram')
ylim([0 ymax])
xlim([286 307])
subplot(3,1,2)
sst_tr_cumsum=histogram(sst_ocean_tr(:,:,tim),binnum,'Normalization','cdf');
ylim([0 1.0])
xlim([286 307])
title('oncean only cum sum')
subplot(3,1,3)
plot(sst_ocean_cdf_slope(tim,:))
hold on
title('ocean only cdf slope')
ylim([-0.001 ymax])
plot(sst_ocean_cdf_slope_deseas(tim,:))

int=binnum/100;
%yblu=0.01:.01:0.99;
%yblu=0.01:int:0.99;
yblu=0.0:1./binnum:1.0-2./binnum;
xblu=1:endtime;
%figure
%contourf(xblu,yblu,sst_cdf_slope')
%
%figure
%contourf(xblu,yblu,sst_ocean_cdf_slope')

figure
plot(sst_cdf_slope(1,:))
hold on
plot(sst_cdf_slope_deseas(1,:))
title('sst raw and deseasonalized')

figure
%conts=[-0.03,-0.025,-0.02,-0.015,-0.01,-0.005,0,0.005,0.01,0.015,0.02,0.025,0.03];
conts=[-0.02,-0.015,-0.01,-0.005,-0.004,-0.003,-0.002,-0.001,0,0.001,0.002,0.003,0.004,0.005,0.01,0.015,0.02];
%conts=[-0.02,-0.015,-0.01,-0.005,-0.003,-0.001,0,0.001,0.003,0.005,0.01,0.015,0.02];
[C,h]=contourf(years,yblu,sst_cdf_slope_deseas',conts);
%[C,h]=contourf(xblu,yblu,sst_cdf_slope_deseas',conts);
set(h,'EdgeColor','none');
title('tropical sst ')
colorbar

yblu_b=0.0:1./binnum:1.0-1./binnum;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,sst_oc_tr');
colorbar
title('new crap')

yblu_b=0.0:1./binnum:1.0-1./binnum;
figure
colormap(jet)
[C,h]=contourf(years,yblu_b,sst_oc_tr_deseas');
set(h,'EdgeColor','none');
colorbar
title('new crap')

figure
colormap(jet)
conts=[-0.01,-0.005,-0.004,-0.003,-0.002,-0.001,0,0.001,0.002,0.003,0.004,0.005,0.01];
[C,h]=contourf(years,yblu,sst_ocean_cdf_slope_deseas',conts);
set(h,'EdgeColor','none');
colorbar
title('tropical sst over ocean')

figure
[C,h]=contourf(xblu,yblu,sst_ocean_cdf_slope',conts);
set(h,'EdgeColor','none');
colorbar
title('tropical sst over ocean base state')

%% import the land sea mask from AM4 and interpolate to the 180x360 grid:
%landm=ncread('~/data/am4p0/atmos.static.nc','land_mask');
%sst_time1=squeeze(test(1,:,:));
%[XN,YN]=meshgrid(0.2:0.8:288,1:180);

%function sst_o = nanlandinterp(sstin,landm,XN,YN)
%[X,Y]=meshgrid(1:288,1:180);
%%[XN,YN]=meshgrid(0.2:0.8:288,1:180);
%testland=interp2(X,Y,landm',XN,YN);
%
%onlyocean(testland~=0)=-999.;
%onlyocean(onlyocean==0)=1.;
%onlyocean(onlyocean==-999.)=0.;
%
%% this results in land points having a value of 1.  There is a gradient, presumably for 
%% grid cells that are partially land. 
%
%% and now to translate land points to NaNs...
%%sst_1t=squeeze(sstin(1,:,:));
%sst_oc_only=sstin.*onlyocean';
%sst_oc_only(sst_oc_only==0.)=NaN;
%sst_o=sst_oc_only;
%end % end function get nanland

%sst_ocean=nanlandinterp(sst_time1,landm,XN,YN);
%sst_o_tr=squeeze(sst_ocean(:,60:120));

%figure
%subplot(3,1,1)
%sst_tr_hist=histogram(sst_o_tr(:,:),100,'Normalization','Probability');
%title('histogram of ocean points')
%subplot(3,1,2)
%sst_tr_cumsum=histogram(sst_o_tr(:,:),100,'Normalization','cdf');
%title('cum sum over ocean')
%subplot(3,1,3)
%plot(sst_cdfanom_slope(tim,:))
%title('cdf slope of deseas cum sum')











