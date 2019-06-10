%---------------------------------------------------------------------------
% some of this code was taken from lcc_mlr.m, some of it from lcc_mlr_driver
%
% compute spatially averaged time series of surface temperature, estimated
% inversion strength, and low level cloud
%
% time series are computed for three different regions of the globe: 
%                    tropics:  between 30S and 30N
%                    mid:      between 60S and 60N
%                    global
%
% time series are also computed with and without cosine latitude weighting
%
% these time series can be written to a netcdf file using the 
% lcc_eis_tsfc_raw_ncout.m script.  that script writes the following ts out:
%    lcc_del_pm30,lcc_del_pm60,lcc_del_gl
%    eis_del_pm30,eis_del_pm60,eis_del_glb
%    sst_del_pm30,sst_del_pm60,sst_del_glb
%
% the output netcdf file will have the name set by: ncoutfile
%
% the am4p0_5ens_gmn_write_ncout.m script writes out radiative fluxes
%     am4p0_5ens_gmn_write_ncout.m depends on am4p0_radflux_ncout.m
%
% levi silvers                                                 june 2019
%---------------------------------------------------------------------------

ncoutfile='levi_test_garbage.nc';

% first define vlon and vlat appropriately for am2, am3, or am4
global_weights
% put this in a loop to creat a time series of cosine weighted data
endtime=1740;
nyears=endtime/12;

month=repmat(1:12,1,nyears);


temp_sfc_w=zeros(nmonths,nlat,nlon);
eis_w=zeros(nmonths,nlat,nlon);
lcloud_w=zeros(nmonths,nlat,nlon);

% apply the weighting array
for index=1:endtime;
  temp_sfc_w(index,:,:)  =glblatweight_gen.*squeeze(temp_sfc_am4_mn(index,:,:));
  eis_w(index,:,:)       =glblatweight_gen.*squeeze(eis_ens_am4_mn(index,:,:));
  lcloud_w(index,:,:)    =glblatweight_gen.*squeeze(lcloud_am4_mn(index,:,:));
end

% for the tropics plus/minus 30
% 45 is equator
latso=30;
latno=60;
% convert to latitudes relevent to the am4 grid
latso_am4=2*latso;
latno_am4=2*latno;

% grab data only from the specified region
eis_tr=eis_ens_am4_mn(:,latso_am4:latno_am4,:); 
sst_tr=temp_sfc_am4_mn(:,latso_am4:latno_am4,:); 
lcc_tr=lcloud_am4_mn(:,latso_am4:latno_am4,:);

% unweighted
% average over the tropics
sst_del_pm30=compute_tmn_anom(sst_tr);
eis_del_pm30=compute_tmn_anom(eis_tr);
lcc_del_pm30=compute_tmn_anom(lcc_tr);

% weighted
% average over the tropics
eis_w_tr=eis_w(:,latso_am4:latno_am4,:); 
sst_w_tr=temp_sfc_w(:,latso_am4:latno_am4,:); 
lcc_w_tr=lcloud_w(:,latso_am4:latno_am4,:); 

sst_w_del_pm30=compute_tmn_anom(sst_w_tr);
eis_w_del_pm30=compute_tmn_anom(eis_w_tr);
lcc_w_del_pm30=compute_tmn_anom(lcc_w_tr);

%%deseasonalize
%for i=1:1620;
%for k=1:12;
%	var_noseas(i)=sst_w_del_pm30(i)-mean(sst_w_del_pm(month==k));
%end
%end

% for the plus/minus 60N/S domain
% 45 is equator
latso=15;
latno=75;
% convert to latitudes relevent to the am4 grid
latso_am4=2*latso;
latno_am4=2*latno;

% grab data only from the specified region
eis_tr=eis_ens_am4_mn(:,latso_am4:latno_am4,:); 
sst_tr=temp_sfc_am4_mn(:,latso_am4:latno_am4,:); 
lcc_tr=lcloud_am4_mn(:,latso_am4:latno_am4,:);

% unweighted
% average over the tropics
sst_del_pm60=compute_tmn_anom(sst_tr);
eis_del_pm60=compute_tmn_anom(eis_tr);
lcc_del_pm60=compute_tmn_anom(lcc_tr);

% weighted
% average over the tropics
eis_w_tr=eis_w(:,latso_am4:latno_am4,:); 
sst_w_tr=temp_sfc_w(:,latso_am4:latno_am4,:); 
lcc_w_tr=lcloud_w(:,latso_am4:latno_am4,:); 

sst_w_del_pm60=compute_tmn_anom(sst_w_tr);
eis_w_del_pm60=compute_tmn_anom(eis_w_tr);
lcc_w_del_pm60=compute_tmn_anom(lcc_w_tr);

% for the global
% 45 is equator
latso=1;
latno=90;
% convert to latitudes relevent to the am4 grid
latso_am4=2*latso;
latno_am4=2*latno;

% grab data only from the specified region
eis_tr=eis_ens_am4_mn(:,latso_am4:latno_am4,:); 
sst_tr=temp_sfc_am4_mn(:,latso_am4:latno_am4,:); 
lcc_tr=lcloud_am4_mn(:,latso_am4:latno_am4,:);

% unweighted
% average over the tropics
sst_del_glb=compute_tmn_anom(sst_tr);
eis_del_glb=compute_tmn_anom(eis_tr);
lcc_del_glb=compute_tmn_anom(lcc_tr);

% weighted
% average over the tropics
eis_w_tr=eis_w(:,latso_am4:latno_am4,:); 
sst_w_tr=temp_sfc_w(:,latso_am4:latno_am4,:); 
lcc_w_tr=lcloud_w(:,latso_am4:latno_am4,:); 

sst_w_del_glb=compute_tmn_anom(sst_w_tr);
eis_w_del_glb=compute_tmn_anom(eis_w_tr);
lcc_w_del_glb=compute_tmn_anom(lcc_w_tr);

% write out time series to ncout file
lcc_eis_tsfc_raw_ncout

% if we want to write the weighted data out: 
ncoutfile='levi_weighted_garbage.nc';
lcc_del_pm30 =lcc_w_del_pm30;
lcc_del_pm60 =lcc_w_del_pm60;
lcc_del_glb  =lcc_w_del_glb;
eis_del_pm30 =eis_w_del_pm30;
eis_del_pm60 =eis_w_del_pm60;
eis_del_glb  =eis_w_del_glb;
sst_del_pm30 =sst_del_pm30;
sst_del_pm60 =sst_del_pm60;
sst_del_glb  =sst_del_glb;

% write out weighted time series to ncout file
lcc_eis_tsfc_raw_ncout



%sst_tr_mn_a=mean(sst_tr,3);
%sst_tr_mn=mean(sst_tr_mn_a,2);
%eis_tr_mn_a=mean(eis_tr,3);
%eis_tr_mn=mean(eis_tr_mn_a,2);
%lcc_tr_mn_a=mean(lcc_tr,3);
%lcc_tr_mn=mean(lcc_tr_mn_a,2);
%
%% average over time
%sst_tmn=mean(sst_tr_mn,1);
%eis_tmn=mean(eis_tr_mn,1);
%lcc_tmn=mean(lcc_tr_mn,1);
%
%% compute anomalies
%eis_del=eis_tr_mn-eis_tmn;
%sst_del=sst_tr_mn-sst_tmn;
%lcc_del=lcc_tr_mn-lcc_tmn;

% now save the eis_del, sst_del, and lcc_del arrays to the eis_del_pm90 type arrays 
% that will be written to netcdf with lcc_eis_tsfc_raw_ncout.m


%sst_w_mn_a=mean(sst_w,3);
%sst_w_mn=mean(sst_w_mn_a,2);
%eis_w_mn_a=mean(eis_w,3);
%eis_w_mn=mean(eis_w_mn_a,2);
%lcc_w_mn_a=mean(lcc_w,3);
%lcc_w_mn=mean(lcc_w_mn_a,2);
%
%% average over time
%sst_w_tmn=mean(sst_w_mn,1);
%eis_w_tmn=mean(eis_w_mn,1);
%lcc_w_tmn=mean(lcc_w_mn,1);
%
%% compute anomalies
%eis_w_del=eis_w_mn-eis_w_tmn;
%sst_w_del=sst_w_mn-sst_w_tmn;
%lcc_w_del=lcc_w_mn-lcc_w_tmn;
%

