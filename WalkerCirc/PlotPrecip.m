% plot the time evolution of the domain mean precipitation field.  
%
% a running mean is applied multiple times to the data to smooth it a bit.
%
% levi silvers                                   april 2018


precip_mean_daily_25km=squeeze(mean(p_25km_znm,1));
tendindex=365;
incoming_ts=precip_mean_daily_25km;
running_mean;

figure
subplot(1,2,1)
plot(output_ts)
title('first application of running mean')

incoming_ts=output_ts;
tendindex=357;
running_mean;

subplot(1,2,2)
plot(output_ts)
title('second application of running mean')

precip_dmn_smooth=output_ts;


% compute and plot the fraction of precip that is large-scale, as well as
% the large-scale and convective precipitation

precip_25km_last10m=precip_25km(:,:,an_t1:an_t2);
precip_25km_tmn=squeeze(mean(precip_25km_last10m,3));
precip_25km_ztmn=squeeze(mean(precip_25km_tmn,2));
p_cv_25km_last10m=p_cv_25km(:,:,an_t1:an_t2);
p_cv_25km_tmn=squeeze(mean(p_cv_25km_last10m,3));
p_cv_25km_ztmn=squeeze(mean(p_cv_25km_tmn,2));
p_ls_25km_last10m=p_ls_25km(:,:,an_t1:an_t2);
p_ls_25km_tmn=squeeze(mean(p_ls_25km_last10m,3));
p_ls_25km_ztmn=squeeze(mean(p_ls_25km_tmn,2));

p_cv_25km_ztmn=scale1*p_cv_25km_ztmn;
p_ls_25km_ztmn=scale1*p_ls_25km_ztmn;

f_ls=p_ls_25km_ztmn./(p_ls_25km_ztmn+p_cv_25km_ztmn);
f_test=p_ls_25km_ztmn./(precip_25km_ztmn);

figure
subplot(1,2,1)
plot(f_ls)
title('fraction of precip which is LS')
subplot(1,2,2)
plot(p_cv_25km_ztmn,'k');
hold on
plot(p_ls_25km_ztmn,'b');
title('conv (black) and ls (blue)')
tit_pr=strcat('Precip LS: ',tit_st);
suptitle(tit_pr)