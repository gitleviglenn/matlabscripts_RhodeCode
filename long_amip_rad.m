
%path_to_longamip='/Users/silvers/data/amip_long/AM4/ens1';

%clear source_tmp_olr, source_tmp_olr_clr, source_tmp_swup_toa, source_tmp_swup_toa_clr;

source_tmp_olr             =strcat(path_tmp,'atmos.187001-201412.olr.nc');
source_tmp_olr_clr         =strcat(path_tmp,'atmos.187001-201412.olr_clr.nc');
source_tmp_swup_toa_clr    =strcat(path_tmp,'atmos.187001-201412.swup_toa_clr.nc');
source_tmp_swup_toa        =strcat(path_tmp,'atmos.187001-201412.swup_toa.nc');

olr        =ncread(source_tmp_olr,'olr');
olr_clr    =ncread(source_tmp_olr_clr,'olr_clr');
swup_clr   =ncread(source_tmp_swup_toa_clr,'swup_toa_clr');
swup       =ncread(source_tmp_swup_toa,'swup_toa');

%% define parameters and initialize arrays
endtime=1740; % needs to be an integer of 12
nyears=endtime/12;
monthint=1/12;
nlat=180;
nlon=288;
years=1860.0833:monthint:1860+nyears;
years_n=1860.75:monthint:1860+nyears; % time series to use for the smoothed data.


%-------------------------------------------
% process the sw data

% cloud Radiative Effect = All sky flux - Clear sky flux
swcre=swup-swup_clr;
% remove seasonal cycle
swup_nocycle=scycle_remove(swup,nlat,nlon,nyears);
swcre_nocycle=scycle_remove(swcre,nlat,nlon,nyears);
% grab tropical points
swcre_tr=swcre(:,60:120,:);
swcre_tr_nocycle=swcre_nocycle(:,60:120,:);

% compute domain mean values
swcre_tr_mn1=mean(swcre_tr,1);
swcre_tr_mn=squeeze(mean(swcre_tr_mn1,2));
swcre_tr_nc_mn1=mean(swcre_tr_nocycle,1);
swcre_tr_nocycle_mn=squeeze(mean(swcre_tr_nc_mn1,2));

%% convert all of the points over land to nans.  
%for timin=1:endtime
%  test1=squeeze(swup_nocycle(:,:,timin));
%  swup_nocycle_noocean(:,:,timin)=nanland(test1);
%  test2=squeeze(swcre_nocycle(:,:,timin));
%  swcre_nocycle_noland(:,:,timin)=nanland(test2);
%end 
%swcre_tr_nocycle_noland=swcre_nocycle_noland(:,60:120,:);
%swcre_tr_ncnl_mn1=nanmean(swcre_tr_nocycle_noland,1);
%swcre_trnocycnoland_mn=squeeze(nanmean(swcre_tr_ncnl_mn1,2));

% compute a 7 pt running mean to compare with Stephans CERES figure
tendindex=1740;
incoming_ts=swcre_tr_nocycle_mn;
  running_mean_7pt;
smooth_swcre_temp=output_ts;

