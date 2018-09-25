% only works after all five ensembles have been run
figure
clt_25km_znm=clt_25km_znm_ent0p5;
max_llcloud_ts
plot(max_cl_ll_sm,'LineWidth',1)
hold on
clt_25km_znm=clt_25km_znm_ent0p7;
max_llcloud_ts
plot(max_cl_ll_sm,'LineWidth',1.5)
clt_25km_znm=clt_25km_znm_ent0p9;
max_llcloud_ts
plot(max_cl_ll_sm,'k','LineWidth',2)
clt_25km_znm=clt_25km_znm_ent1p1;
max_llcloud_ts
plot(max_cl_ll_sm,'LineWidth',2.5)
clt_25km_znm=clt_25km_znm_ent1p3;
max_llcloud_ts
plot(max_cl_ll_sm,'LineWidth',3)
ylabel('Cloud Fraction [%]','FontSize',15)
xlabel('days','FontSize',15)
title('time series of low level cloud fraction for 5 gcm experiments')