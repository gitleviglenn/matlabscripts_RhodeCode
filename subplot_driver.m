%--------------------------------------------------------------------------------------
% be careful with this script, the titles are hard wired and the data used needs to be 
% checked to ensure it matches the titles
%
% levi silvers                                 dec 2016
%--------------------------------------------------------------------------------------

figure;

subplot(3,2,1); 
cont_eisdiff2(norm_lcloud_diff_p3','norm lcloud diff P3');
subplot(3,2,2); 
cont_eisdiff2(norm_mcloud_diff_p3','norm mcloud diff P3');
subplot(3,2,3); 
cont_eisdiff2(tsurf_diff_p3','tsurf diff P3');

omega_700_oo=omega_700.*onlyocean;
sw_cre_fdbck_oo=sw_cre_fdbck_gnorm.*onlyocean;
subplot(3,2,4); cont_eisdiff2(omega_700_oo','700mb omega P3 ctl');
subplot(3,2,5); cont_eisdiff2(sw_cre_fdbck_oo','norm sw cre fdbck');
subplot(3,2,6); cont_eisdiff2(eis_diff_p3_nanland','EIS ptb minus ctol P3');

omega_700_oo_d=zeros(size(omega_700_oo));
omega_700_oo_d(omega_700_oo>0.0)=1;
omega_700_oo_d(omega_700_oo<=0.0)=0.0;

% use the mask on various fields
eis_omegamask=eis_diff_p3_nanland.*omega_700_oo_d;
sw_cre_fdbck_omegamask=sw_cre_fdbck_oo.*omega_700_oo_d;

