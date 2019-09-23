
%path_base='/Users/silvers/data/WalkerCell/'
%
%path=strcat(path_base,'gauss_d/');
%path_n=strcat(path_base,'testing_20181203/');

%% source paths for experiments: 
%source_gcm_month=strcat('/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv/',yearstr,'.atmos_month_tmn.nc');
%source_1km_month=strcat(path_n,'c10x4000L33_am4p0_1km_wlkr_4K_1979_6mn.atmos_month.nc');
%source_2km_month=strcat(path_n,'c50x2000L33_am4p0_2km_wlkr_4K_1979_6mn.atmos_month.nc');
%

temp_eq_ztmn=read_1var_ztmn(source_gcm_month,'temp');
temp_crm_ztmn=read_1var_ztmn(source_2km_month,'temp');
temp_crm1_ztmn=read_1var_ztmn(source_1km_month,'temp');

temp_25km_ztmn = read_1var_ztmn(source_gcm_month,'temp');

q_25km_ztmn    = read_1var_ztmn(source_gcm_month,'sphum');

q_2km=ncread(source_2km_month,'sphum');
q_2km_zmn=squeeze(mean(q_2km,2));
q_2km_ztmn=squeeze(q_2km_zmn(:,:,1));

q_1km=ncread(source_1km_month,'sphum');
q_1km_zmn=squeeze(mean(q_1km,2));
q_1km_ztmn=squeeze(q_1km_zmn(:,:,1));

