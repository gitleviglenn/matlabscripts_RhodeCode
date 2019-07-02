function [p_cv_ztmn,p_ls_ztmn,frac_ls]=precip_largesc_vs_conv(filesource,t1,t2)

p_cv=ncread(filesource,'prec_conv'); %kg(h2o)/m2/2
p_ls=ncread(filesource,'prec_ls');

% get the convective numbers
p_cv_eq=p_cv(:,:,t1:t2);
p_cv_tmn=squeeze(mean(p_cv_eq,3));
p_cv_ztmn=squeeze(mean(p_cv_tmn,2));
% get the large scale numbers
p_ls_eq=p_ls(:,:,t1:t2);
p_ls_tmn=squeeze(mean(p_ls_eq,3));
p_ls_ztmn=squeeze(mean(p_ls_tmn,2));

% compute the fraction of precip that is due to the 
% large-scale scheme
frac_ls=p_ls_ztmn./(p_ls_ztmn+p_cv_ztmn);
