%---------------------------------------------------------------------------------------
% window_decomposition_driver.m
%
% this and window_decomposition_ts.m are meant to simplify by breaking into smaller
% chunks the script alpha_plot_windows.m
%
% levi silvers                                                        oct 2017
%---------------------------------------------------------------------------------------

starti=1;
endi=105;
firstyr=1886;
timearr=firstyr:firstyr+104;

alpha_wind_arr=alpha_lcc_wind(1:5,:,:); % dimensions (ensnum,windownum,time)
%alpha_wind_arr=alpha_wind(6:10,:,:); % dimensions (ensnum,windownum,time)
%alpha_wind_arr=alpha_lcc_wind(11:15,:,:); % dimensions (ensnum,windownum,time)

window_decomposition_ts

alpha_test_decomp_am2=alpha_test_arr;
alpha_strcu_wind_trops_am2=alpha_wind_trop1_arr;
alpha_rest_wind_trops_am2=alpha_wind_trop2_arr;

figure

solidstr='b';
dashedstr='-.b';

%plot(timearr(starti:endi),mean_alpha(starti:endi),'b','Linewidth',3)
%hold on
%plot(timearr(starti:endi),mean_alpha_am3(starti:endi),'r','Linewidth',3)
%plot(timearr(starti:endi),mean_alpha_am4(starti:endi),'k','Linewidth',3)

plot(timearr(starti:endi),mean_alpha_lcc(starti:endi),'b','Linewidth',3)
hold on
plot(timearr(starti:endi),mean_alpha_lcc_am3(starti:endi),'r','Linewidth',3)
plot(timearr(starti:endi),mean_alpha_lcc_am4(starti:endi),'k','Linewidth',3)
% these mean values are computed in driver_ensembles.m 
%plot(timearr(starti:endi),mean_alpha_cre_am4(starti:endi),'k','Linewidth',3)
%plot(timearr(starti:endi),mean_alpha_clr_am4(starti:endi),'k','Linewidth',3)

plot(timearr(starti:endi),squeeze(alpha_test_decomp_am2(starti:endi)),solidstr)
plot(timearr(starti:endi),squeeze(alpha_strcu_wind_trops_am2(starti:endi)),dashedstr)
plot(timearr(starti:endi),squeeze(alpha_rest_wind_trops_am2(starti:endi)),solidstr)
%plot(timearr(starti:endi),squeeze(alpha_wind_arr_mn(1,5,starti:endi)),'-.b')

title('alpha lcc by region')

alpha_wind_arr=alpha_lcc_wind(6:10,:,:); % dimensions (ensnum,windownum,time)

window_decomposition_ts

alpha_test_decomp_am3=alpha_test_arr;
alpha_strcu_wind_trops_am3=alpha_wind_trop1_arr;
alpha_rest_wind_trops_am3=alpha_wind_trop2_arr;

solidstr='r';
dashedstr='-.r';
plot(timearr(starti:endi),squeeze(alpha_test_decomp_am3(starti:endi)),solidstr)
plot(timearr(starti:endi),squeeze(alpha_strcu_wind_trops_am3(starti:endi)),dashedstr)
plot(timearr(starti:endi),squeeze(alpha_rest_wind_trops_am3(starti:endi)),solidstr)



alpha_wind_arr=alpha_lcc_wind(11:15,:,:); % dimensions (ensnum,windownum,time)

window_decomposition_ts

alpha_test_decomp_am4=alpha_test_arr;
alpha_strcu_wind_trops_am4=alpha_wind_trop1_arr;
alpha_rest_wind_trops_am4=alpha_wind_trop2_arr;

solidstr='k';
dashedstr='-.k';
plot(timearr(starti:endi),squeeze(alpha_test_decomp_am4(starti:endi)),solidstr)
plot(timearr(starti:endi),squeeze(alpha_strcu_wind_trops_am4(starti:endi)),dashedstr)
plot(timearr(starti:endi),squeeze(alpha_rest_wind_trops_am4(starti:endi)),solidstr)

