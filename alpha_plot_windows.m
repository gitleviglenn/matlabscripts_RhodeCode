%--------------------------------------------------------------------------------------------------
% alpha_plot_windows.m
%
% script used to add the values from particular windows in the tropics and plot the comparison 
% of alpha from those windows with alpha from the rest of the tropics. 
%
% use with: 
%	driver_ensembles
%
% levi silvers                                                                          Aug 2017
%--------------------------------------------------------------------------------------------------

% Windows
% 1: s atlantic; 2: s indian; 3: e pacific; 4: s ocean; 5: tropics
% 6: n tropics;  7: s tropics

starti=1;
endi=105;
firstyr=1886;
timearr=firstyr:firstyr+104;

alpha_wind_am2=alpha_wind(1:5,:,:); % dimensions: (ensnum,windownum,time)
alpha_wind_am3=alpha_wind(6:10,:,:);
alpha_wind_am4=alpha_wind(11:15,:,:);

figure

plot(timearr(starti:endi),mean_alpha(starti:endi),'b','Linewidth',3)
hold on
plot(timearr(starti:endi),mean_alpha_am3(starti:endi),'r','Linewidth',3)
plot(timearr(starti:endi),mean_alpha_am4(starti:endi),'k','Linewidth',3)

% compute ensemble mean
alpha_wind_am2_mn=mean(alpha_wind_am2,1); % dimensions: (windownum,time)
alpha_wind_am3_mn=mean(alpha_wind_am3,1);
alpha_wind_am4_mn=mean(alpha_wind_am4,1);

% add tropics with north of tropics and south of tropics, should be 
% very close to mean_alpha...
alpha_test_am2=alpha_wind_am2_mn(1,5,:)+alpha_wind_am2_mn(1,6,:)+alpha_wind_am2_mn(1,7,:)+alpha_wind_am2_mn(1,8,:);
alpha_test_am3=alpha_wind_am3_mn(1,5,:)+alpha_wind_am3_mn(1,6,:)+alpha_wind_am3_mn(1,7,:)+alpha_wind_am3_mn(1,8,:);
alpha_test_am4=alpha_wind_am4_mn(1,5,:)+alpha_wind_am4_mn(1,6,:)+alpha_wind_am4_mn(1,7,:)+alpha_wind_am4_mn(1,8,:);

% compute the total contribution from the epac, satl, and sind tropical windows...
alpha_wind_trop1_am2=alpha_wind_am2_mn(1,1,:)+alpha_wind_am2_mn(1,2,:)+alpha_wind_am2_mn(1,3,:);
alpha_wind_trop1_am3=alpha_wind_am3_mn(1,1,:)+alpha_wind_am3_mn(1,2,:)+alpha_wind_am3_mn(1,3,:);
alpha_wind_trop1_am4=alpha_wind_am4_mn(1,1,:)+alpha_wind_am4_mn(1,2,:)+alpha_wind_am4_mn(1,3,:);

% compute the total contribution from the rest of the tropical windows...
alpha_wind_trop2_am2=alpha_wind_am2_mn(1,9,:)+alpha_wind_am2_mn(1,10,:)+alpha_wind_am2_mn(1,11,:)+alpha_wind_am2_mn(1,12,:)+alpha_wind_am2_mn(1,13,:)+alpha_wind_am2_mn(1,14,:);
alpha_wind_trop2_am3=alpha_wind_am3_mn(1,9,:)+alpha_wind_am3_mn(1,10,:)+alpha_wind_am3_mn(1,11,:)+alpha_wind_am3_mn(1,12,:)+alpha_wind_am3_mn(1,13,:)+alpha_wind_am3_mn(1,14,:);
alpha_wind_trop2_am4=alpha_wind_am4_mn(1,9,:)+alpha_wind_am4_mn(1,10,:)+alpha_wind_am4_mn(1,11,:)+alpha_wind_am4_mn(1,12,:)+alpha_wind_am4_mn(1,13,:)+alpha_wind_am4_mn(1,14,:);


plot(timearr(starti:endi),squeeze(alpha_test_am2(starti:endi)),'b')
plot(timearr(starti:endi),squeeze(alpha_test_am3(starti:endi)),'r')
plot(timearr(starti:endi),squeeze(alpha_test_am4(starti:endi)),'k')

plot(timearr(starti:endi),squeeze(alpha_wind_am2_mn(1,5,starti:endi)),'-.b')
plot(timearr(starti:endi),squeeze(alpha_wind_am2_mn(1,6,starti:endi)),'-.b')
plot(timearr(starti:endi),squeeze(alpha_wind_am2_mn(1,7,starti:endi)),'b')
plot(timearr(starti:endi),squeeze(alpha_wind_am2_mn(1,8,starti:endi)),'-.b')

plot(timearr(starti:endi),squeeze(alpha_wind_am3_mn(1,5,starti:endi)),'-.r')
plot(timearr(starti:endi),squeeze(alpha_wind_am3_mn(1,6,starti:endi)),'-.r')
plot(timearr(starti:endi),squeeze(alpha_wind_am3_mn(1,7,starti:endi)),'r')
plot(timearr(starti:endi),squeeze(alpha_wind_am3_mn(1,8,starti:endi)),'r')

plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,5,starti:endi)),'-.k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,6,starti:endi)),'-.k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,7,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,8,starti:endi)),'k')

title('alpha by region ')

figure
plot(timearr(starti:endi),mean_alpha_am4(starti:endi),'k','Linewidth',3)
hold on
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,1,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,2,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,3,starti:endi)),'r')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,4,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,5,starti:endi)),'-.k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,6,starti:endi)),'-.k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,7,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_wind_am4_mn(1,8,starti:endi)),'k')

title('alpha by region: am4')


alpha_lcc_wind_am2=alpha_lcc_wind(1:5,:,:);
alpha_lcc_wind_am3=alpha_lcc_wind(6:10,:,:);
alpha_lcc_wind_am4=alpha_lcc_wind(11:15,:,:);

figure

plot(timearr(starti:endi),mean_alpha_lcc(starti:endi),'b','Linewidth',3)
hold on
plot(timearr(starti:endi),mean_alpha_lcc_am3(starti:endi),'r','Linewidth',3)
plot(timearr(starti:endi),mean_alpha_lcc_am4(starti:endi),'k','Linewidth',3)

alpha_lcc_wind_am2=alpha_lcc_wind(1:5,:,:);
alpha_lcc_wind_am3=alpha_lcc_wind(6:10,:,:);
alpha_lcc_wind_am4=alpha_lcc_wind(11:15,:,:);

alpha_lcc_wind_am2_mn=mean(alpha_lcc_wind_am2,1);
alpha_lcc_wind_am3_mn=mean(alpha_lcc_wind_am3,1);
alpha_lcc_wind_am4_mn=mean(alpha_lcc_wind_am4,1);

% add tropics with north of tropics and south of tropics, should be 
% very close to mean_alpha...
alpha_lcc_test_am2=alpha_lcc_wind_am2_mn(1,5,:)+alpha_lcc_wind_am2_mn(1,6,:)+alpha_lcc_wind_am2_mn(1,7,:);
alpha_lcc_test_am3=alpha_lcc_wind_am3_mn(1,5,:)+alpha_lcc_wind_am3_mn(1,6,:)+alpha_lcc_wind_am3_mn(1,7,:);
alpha_lcc_test_am4=alpha_lcc_wind_am4_mn(1,5,:)+alpha_lcc_wind_am4_mn(1,6,:)+alpha_lcc_wind_am4_mn(1,7,:);

plot(timearr(starti:endi),squeeze(alpha_lcc_test_am2(starti:endi)),'b')
plot(timearr(starti:endi),squeeze(alpha_lcc_test_am3(starti:endi)),'r')
plot(timearr(starti:endi),squeeze(alpha_lcc_test_am4(starti:endi)),'k')

plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am2_mn(1,5,starti:endi)),'-*b')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am2_mn(1,6,starti:endi)),'b')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am2_mn(1,7,starti:endi)),'b')

plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am3_mn(1,5,starti:endi)),'-*r')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am3_mn(1,6,starti:endi)),'r')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am3_mn(1,7,starti:endi)),'r')

plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,5,starti:endi)),'-*k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,6,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,7,starti:endi)),'k')

title('alpha lcc by region: stars indicate tropics')

figure
plot(timearr(starti:endi),mean_alpha_lcc_am4(starti:endi),'k','Linewidth',3)
hold on
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,1,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,2,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,3,starti:endi)),'r')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,4,starti:endi)),'k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,5,starti:endi)),'-*k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,6,starti:endi)),'-*k')
plot(timearr(starti:endi),squeeze(alpha_lcc_wind_am4_mn(1,7,starti:endi)),'-*k')

title('alpha lcc by region: am4')

%figure
%plot(timearr(starti:endi),mean_alpha_am4(starti:endi),'k','Linewidth',3)
%hold on
%plot(timearr(starti:endi),squeeze(alpha_poleward30_am4(starti:endi)),'-.b','Linewidth',2)
%plot(timearr(starti:endi),squeeze(alpha_pm30_am4(starti:endi)),'b','Linewidth',2)
%% tropical windows: s atlantic, s east pacific, s indian
%%alpha_wind_trop1_am4=alpha_wind_am4_mn(1,1,:)+alpha_wind_am4_mn(1,2,:)+alpha_wind_am4_mn(1,3,:);
%plot(timearr(starti:endi),squeeze(alpha_wind_trop1_am4(starti:endi)),'-.r','Linewidth',1)
%% the rest of the tropics: 
%%alpha_wind_trop2_am4=alpha_wind_am4_mn(1,9,:)+alpha_wind_am4_mn(1,10,:)+alpha_wind_am4_mn(1,11,:)+alpha_wind_am4_mn(1,12,:)+alpha_wind_am4_mn(1,13,:)+alpha_wind_am4_mn(1,14,:);
%plot(timearr(starti:endi),squeeze(alpha_wind_trop2_am4(starti:endi)),'r','Linewidth',1)
%plot(timearr(starti:endi),squeeze(alpha_pm10_am4(starti:endi)),'g','Linewidth',1)
%
%title('watch it you schmuck')
