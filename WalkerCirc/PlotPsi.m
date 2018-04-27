% PlotPsi.m

figure
subplot(1,5,1)
stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
[C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(1,:,:))',stream_cons);
v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('ent0p5')
set(gca,'Ydir','reverse')

subplot(1,5,2)
[C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(2,:,:))',stream_cons);
clabel(C,h,v);
title('ent0p7')
set(gca,'Ydir','reverse')

subplot(1,5,3)
[C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(3,:,:))',stream_cons);
clabel(C,h,v);
title('ent0p9')
set(gca,'Ydir','reverse')

subplot(1,5,4)
[C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(4,:,:))',stream_cons);
clabel(C,h,v);
title('ent1p1')
set(gca,'Ydir','reverse')

subplot(1,5,5)
[C,h]=contourf(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(5,:,:))',stream_cons);
clabel(C,h,v);
title('ent1p3')
set(gca,'Ydir','reverse')

tit_str=strcat('GCM Mass Streamfunction: ');
suptitle(tit_str)


figure
%subplot(1,5,1)
stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
[C,h]=contour(1:xgcm_ngp,pfull_25km,squeeze(psi_mat(1,:,:))',stream_cons);
v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
clabel(C,h,v);
title('ent0p5')
set(gca,'Ydir','reverse')