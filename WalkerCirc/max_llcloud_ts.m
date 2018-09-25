%compute low-level clouds for GCM

clt_25km_znm_ll=clt_25km_znm(:,20:33,:);
cl_ll_mean=squeeze(mean(clt_25km_znm_ll,1));
max_cl_ll_mean=max(cl_ll_mean,[],1);
%figure
%plot(max_cl_ll_mean)
mean(max_cl_ll_mean)

tendindex=365;
incoming_ts=max_cl_ll_mean;
running_mean
smooth1=output_ts;
incoming_ts=smooth1;
tendindex=357;
running_mean
max_cl_ll_sm=output_ts;

% figure
% %hold on
% plot(max_cl_ll_sm)
% ylabel('Cloud Fraction [%]','FontSize',15)
% xlabel('days','FontSize',15)

% % only works after all five ensembles have been run
% figure
% plot(clt_25km_znm_ent0p5,'LineWidth',1)
% hold on
% plot(clt_25km_znm_ent0p7,'LineWidth',1.5)
% plot(clt_25km_znm_ent0p9,'k','LineWidth',2)
% plot(clt_25km_znm_ent1p1,'LineWidth',2.5)
% plot(clt_25km_znm_ent1p3,'LineWidth',3)
% ylabel('Cloud Fraction [%]','FontSize',15)
% xlabel('days','FontSize',15)