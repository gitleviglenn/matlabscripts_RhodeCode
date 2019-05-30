%--------------------------------------------------------------------------------------------
% sst_signal_ceres.m
%
% open data file with ebaf/ceres data from Stephan Fueglistaler 
% my impression from Stephans paper is that this data covers march 2000 through march 2018
%
% levi silvers                                                               may 2019
%--------------------------------------------------------------------------------------------

path_to_data='/Users/silvers/data/SatData/';

source_ceres=strcat(path_to_data,'dist_ebaf_levi_silvers.nc');

swcre_trp=ncread(source_ceres,'toa_cre_sw_mon_sfc_lw_up_all_mon_sorted_wgt_tropic_all');

nyears=18;
monthint=1/12;
% do the years start in 1870 or 1860?
axisyr=1870.0:monthint:2018.1667; % 2018 feb
swcre_trp_mn=mean(swcre_trp,1);
month=repmat(1:12,1,nyears);

% deseasonalize the data
seasonal_data=swcre_trp_mn(1:216);
for k=1:12
monthlymeans(k)=mean(seasonal_data(month==k));
end

deseasoned_data=zeros(1,nyears*12);
for k=1:12
deseasoned_data(1,month==k)=seasonal_data(month==k)-monthlymeans(k);
end

% smooth the data with a 7 pt running mean
% taking off 3 months on each end of the data would mean 
% the data covers june 2000 through december 2017.
tendindex=216;
incoming_ts=deseasoned_data;
running_mean_7pt
sm_swcre_ceres=output_ts;

%figure
%% the negative value is simply to follow Fueglistaler Figure 1
%plot(-smooth_deseasoned)
%title('CERES/EBAF deseasonalized tropical swcre 7pt running mean')
%
%axist=2000.4167:monthint:2017.916; % this should extend from june 2000 th nov 2017

%figure
%plot(axisyr(4:1737),smooth_swcre_7pt(:))
%title('swcre from AM4 longamip experiment');
%hold on
%plot(axisyr(1567:1776),-smooth_deseasoned(:))

%figure
%plot(axisyr(1503:1737),smooth_swcre_7pt(1500:1734))
%hold on
%plot(axisyr(1567:1776),-smooth_deseasoned(:))
%title('swcre from AM4 longamip experiment');

path_tmp='/Users/silvers/data/amip_long/AM4/ens1/';
long_amip_rad
swcre_ens1=smooth_swcre_temp;

path_tmp='/Users/silvers/data/amip_long/AM4/ens2/';
long_amip_rad
swcre_ens2=smooth_swcre_temp;

path_tmp='/Users/silvers/data/amip_long/AM4/ens3/';
long_amip_rad
swcre_ens3=smooth_swcre_temp;

path_tmp='/Users/silvers/data/amip_long/AM4/ens4/';
long_amip_rad
swcre_ens4=smooth_swcre_temp;



figure
plot(axisyr(1503:1737),swcre_ens1(1500:1734))
hold on
plot(axisyr(1567:1776),-sm_swcre_ceres(:),'k')
plot(axisyr(1503:1737),swcre_ens2(1500:1734))
plot(axisyr(1503:1737),swcre_ens3(1500:1734))
plot(axisyr(1503:1737),swcre_ens4(1500:1734))
title('swcre from AM4 longamip experiment');

figure
plot(axisyr(4:1737),swcre_ens1(1:1734))
hold on
plot(axisyr(1567:1776),-sm_swcre_ceres(:),'k')
plot(axisyr(4:1737),swcre_ens2(1:1734))
plot(axisyr(4:1737),swcre_ens3(1:1734))
plot(axisyr(4:1737),swcre_ens4(1:1734))
title('swcre from AM4 longamip experiment');
