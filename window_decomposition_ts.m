%starti=1;
%endi=105;
%firstyr=1886;
%timearr=firstyr:firstyr+104;
%
%alpha_wind_arr=alpha_wind(1:5,:,:); % dimensions (ensnum,windownum,time)

%compute ensemble mean
alpha_wind_arr_mn=mean(alpha_wind_arr,1); % dimensions: (windownum,time)

% add tropics with north of tropics and south of tropics, should be
% very close to mean_alpha...
% 5: ntrops; 6: strops; 7: nextrops; 8: sextrops 
alpha_test_arr=alpha_wind_arr_mn(1,5,:)+alpha_wind_arr_mn(1,6,:)+alpha_wind_arr_mn(1,7,:)+alpha_wind_arr_mn(1,8,:);

% compute the total contribution from the epac, satl, and sind tropical windows...
alpha_wind_trop1_arr=alpha_wind_arr_mn(1,1,:)+alpha_wind_arr_mn(1,2,:)+alpha_wind_arr_mn(1,3,:);

% compute the total contribution from the rest of the tropical windows...
alpha_wind_trop2_arr=alpha_wind_arr_mn(1,9,:)+alpha_wind_arr_mn(1,10,:)+alpha_wind_arr_mn(1,11,:)+alpha_wind_arr_mn(1,12,:)+alpha_wind_arr_mn(1,13,:)+alpha_wind_arr_mn(1,14,:);

%figure
%
%plot(timearr(starti:endi),mean_alpha(starti:endi),'b','Linewidth',3)
%hold on
%plot(timearr(starti:endi),mean_alpha_am3(starti:endi),'r','Linewidth',3)
%plot(timearr(starti:endi),mean_alpha_am4(starti:endi),'k','Linewidth',3)
%
%plot(timearr(starti:endi),squeeze(alpha_test_arr(starti:endi)),'b')
%plot(timearr(starti:endi),squeeze(alpha_wind_trop1_arr(starti:endi)),'-.b')
%plot(timearr(starti:endi),squeeze(alpha_wind_trop2_arr(starti:endi)),'b')
%%plot(timearr(starti:endi),squeeze(alpha_wind_arr_mn(1,5,starti:endi)),'-.b')
%%plot(timearr(starti:endi),squeeze(alpha_wind_arr_mn(1,6,starti:endi)),'-.b')
%%plot(timearr(starti:endi),squeeze(alpha_wind_arr_mn(1,7,starti:endi)),'b')
%%plot(timearr(starti:endi),squeeze(alpha_wind_arr_mn(1,8,starti:endi)),'-.b')
%
%title('alpha by region')

