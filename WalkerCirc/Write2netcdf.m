% PlotPsi.m

% useful example of creating a netcdf file...
% nccreate('myncfile.nc','vmark',...
%          'Dimensions', {'time', inf, 'cols', 6},...
%          'ChunkSize',  [3 3],...
%          'DeflateLevel', 2);
% ncwrite('myncfile.nc','vmark', eye(3),[1 1]);
% varData = ncread('myncfile.nc','vmark');
% disp(varData);
% ncwrite('myncfile.nc','vmark',fliplr(eye(3)),[1 4]);
% varData = ncread('myncfile.nc','vmark');
% disp(varData);   

% this appears to have worked...


% write gcm variables to appropriate arrays
% myclouds=cl_mat;
% myrh=rh_mat;
% tdtlw_gcm=tdtlw_mat;
% tdtsw_gcm=tdtsw_mat;
% tdtls_gcm=tdtls_mat;
% tdtconv_gcm=tdtconv_mat;
% tdt_totcl_gcm=tdt_totcl_mat;

% write crm variables to appropriate arrays
%tdtsw_crm=tdtsw_2_tzmn;
%tdtlw_crm=tdtlw_2_tzmn;
%tdtls_crm=tdtls_2km_tzmn;

% nccreate('mymy_psi_lwoff.nc','mystream',...
% 'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
% ncwrite('mymy_psi_lwoff.nc','mystream',psi_mat_lwoff);

% write to mymy_clouds.nc
nccreate('mymy_clouds.nc','myrh',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_clouds.nc','myrh',rh_mat);
nccreate('mymy_clouds.nc','myclouds',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_clouds.nc','myclouds',cl_mat);
nccreate('mymy_clouds.nc','tot_condensed',...
'Dimensions',{'xdim',160,'pdim',33});
ncwrite('mymy_clouds.nc','tot_condensed',liq_25km_zmn_9m);
nccreate('mymy_clouds.nc','pfull',...
'Dimensions',{'pdim',33});
ncwrite('mymy_clouds.nc','pfull',pfull_2km);

% write out gcm tdt variables to netcdf file...
% write to mymy_tdt.nc
nccreate('mymy_tdt.nc','tdtlw_gcm',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_tdt.nc','tdtlw_gcm',tdtlw_mat);

nccreate('mymy_tdt.nc','tdtsw_gcm',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_tdt.nc','tdtsw_gcm',tdtsw_mat);

nccreate('mymy_tdt.nc','tdtls_gcm',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_tdt.nc','tdtls_gcm',tdtls_mat);

nccreate('mymy_tdt.nc','tdtconv_gcm',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_tdt.nc','tdtconv_gcm',tdtconv_mat);

nccreate('mymy_tdt.nc','tdt_totcl_gcm',...
'Dimensions',{'ensemble',5,'xdim',160,'pdim',33});
ncwrite('mymy_tdt.nc','tdt_totcl_gcm',tdt_totcl_mat);

% write out crm tdt variables to netcdf file...
% crm_file='mymy_crm_tdt.nc';
% write to mymy_crm_tmn.nc
crm_file='mymy_crm_tmn.nc';
nccreate(crm_file,'tdtlw_2km',...
'Dimensions',{'xdim',2000,'pdim',33});
ncwrite(crm_file,'tdtlw_2km',tdtlw_2_tzmn);

nccreate(crm_file,'tdtlw_1km',...
'Dimensions',{'xdim2',4000,'pdim',33});
ncwrite(crm_file,'tdtlw_1km',tdtlw_1_tzmn);

nccreate(crm_file,'tdtsw_2km',...
'Dimensions',{'xdim',2000,'pdim',33});
ncwrite(crm_file,'tdtsw_2km',tdtsw_2_tzmn);

nccreate(crm_file,'tdtsw_1km',...
'Dimensions',{'xdim2',4000,'pdim',33});
ncwrite(crm_file,'tdtsw_1km',tdtsw_1_tzmn);

nccreate(crm_file,'tdtls_1km',...
'Dimensions',{'xdim2',4000,'pdim',33});
ncwrite(crm_file,'tdtls_1km',tdtls_1_tzmn);

nccreate(crm_file,'tdtls_2km',...
'Dimensions',{'xdim',2000,'pdim',33});
ncwrite(crm_file,'tdtls_2km',tdtls_2_tzmn);

nccreate(crm_file,'hur_2km',...
'Dimensions',{'xdim',2000,'pdim',33});
ncwrite(crm_file,'hur_2km',hur_2km_zmn_tmn);

nccreate(crm_file,'hur_1km',...
'Dimensions',{'xdim2',4000,'pdim',33});
ncwrite(crm_file,'hur_1km',hur_1km_zmn_tmn);

nccreate(crm_file,'tot_condensed_2km',...
'Dimensions',{'xdim',2000,'pdim',33});
ncwrite(crm_file,'tot_condensed_2km',liq_2km_zmn);

nccreate(crm_file,'tot_condensed_1km',...
'Dimensions',{'xdim2',4000,'pdim',33});
ncwrite(crm_file,'tot_condensed_1km',liq_1km_zmn);

nccreate(crm_file,'psi_2km',...
'Dimensions',{'xdim',2000,'pdim',33});
ncwrite(crm_file,'psi_2km',psi_gen_2km);

nccreate(crm_file,'psi_1km',...
'Dimensions',{'xdim2',4000,'pdim',33});
ncwrite(crm_file,'psi_1km',psi_gen_1km);

nccreate(crm_file,'pfull',...
'Dimensions',{'pdim',33});
ncwrite(crm_file,'pfull',pfull_2km);


% figure
% subplot(1,5,1)
% stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
% [C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(1,:,:))',stream_cons);
% v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
% clabel(C,h,v);
% title('ent0p5')
% set(gca,'Ydir','reverse')
% 
% subplot(1,5,2)
% [C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(2,:,:))',stream_cons);
% clabel(C,h,v);
% title('ent0p7')
% set(gca,'Ydir','reverse')
% 
% subplot(1,5,3)
% [C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(3,:,:))',stream_cons);
% clabel(C,h,v);
% title('ent0p9')
% set(gca,'Ydir','reverse')
% 
% subplot(1,5,4)
% [C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(4,:,:))',stream_cons);
% clabel(C,h,v);
% title('ent1p1')
% set(gca,'Ydir','reverse')
% 
% subplot(1,5,5)
% [C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(5,:,:))',stream_cons);
% clabel(C,h,v);
% title('ent1p3')
% set(gca,'Ydir','reverse')
% 
% tit_str=strcat('GCM Mass Streamfunction: ');
% suptitle(tit_str)
% 
% 
% figure
% %subplot(1,5,1)
% stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
% [C,h]=contour(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(ind,:,:))',stream_cons);
% v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
% clabel(C,h,v);
% title('ent0p5')
% set(gca,'Ydir','reverse')
% 
% figure
% rh_contours=[5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85];
% subplot(1,2,1)
% caxis=([10 80]);
% [C,h]=contourf(1:xcrm_ngp,pfull_2km,hur_2km_zmn_1m',rh_contours,'EdgeColor','None');
% v=[10,20,30,50,70];
% clabel(C,h,v);
% tit_a=strcat('relative humidity 2km');
% title(tit_a);
% %set(gca,'Ydir','reverse')
% %colorbar
% %hold on
% %contour(1:xcrm_ngp,pfull_2km,liq_2km_zmn_scale',q_contours,'EdgeColor','None');
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(1,2,2)
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,hur_25km_zmn_1m',rh_contours,'EdgeColor','None');
% caxis=([10 80]);
% %clabel(C,h,v);
% tit_b=strcat('relative humidity 25km');
% title(tit_b);
% set(gca,'Ydir','reverse')
% colorbar
% 
% hold on
% %stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
% [C,h]=contour(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(ind,:,:))',stream_cons);
% %v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
% %clabel(C,h,v);
% %contour(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(ind,:,:))','k');
% %caxis=([10 80]);
% tit_rh=strcat('RH and StreamFunction: ',tit_st);
% suptitle(tit_rh)