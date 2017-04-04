%---------------------------------------------------------
%
% calls
% alpha_09
%
% levi silvers                                jan 2017
%---------------------------------------------------------

% compute the alpha time series for am4
temp_ts=v.tref_am4ts;
olr_ts =v.olr_toa_am4ts;
olr_clr_ts=v.olr_toa_clr_am4ts;
swup_clr_ts=v.swup_toa_clr_am4ts;
swdn_ts=v.swdn_toa_am4ts;
swup_ts=v.swup_toa_am4ts;
vlon   =v.lon_am4;
vlat   =v.lat_am4;

'calling alpha09'
alpha_09
window_yr
alpha_tsam4_cre=alpha_cre_30y;
alpha_tsam4=alpha_30y;
delTs_am4=delTs;
delR_am4=delR;
correlation=num2str(whycorr(2));
titin=strcat(modtitle_am4,' corr: ',correlation)
title(titin)
figure
scatter(delTs_am4,delR_am4,40,'filled')

% compute the alpha time series for am3
temp_ts=v.tref_am3ts;
olr_ts =v.olr_toa_am3ts;
olr_clr_ts=v.olr_toa_clr_am3ts;
swup_clr_ts=v.swup_toa_clr_am3ts;
swdn_ts=v.swdn_toa_am3ts;
swup_ts=v.swup_toa_am3ts;
vlon   =v.lon_am3;
vlat   =v.lat_am3;

alpha_09
alpha_tsam3_cre=alpha_cre_30y;
alpha_tsam3=alpha_30y;
delTs_am3=delTs;
delR_am3=delR;
correlation=num2str(whycorr(2));
titin=strcat(modtitle_am3,' corr: ',correlation)
title(titin)

% compute the alpha time series for am2
temp_ts=v.tref_am2ts;
olr_ts =v.olr_toa_am2ts;
olr_clr_ts=v.olr_toa_clr_am2ts;
swup_clr_ts=v.swup_toa_clr_am2ts;
swdn_ts=v.swdn_toa_am2ts;
swup_ts=v.swup_toa_am2ts;
vlon   =v.lon_am2;
vlat   =v.lat_am2;

alpha_09
alpha_tsam2_cre=alpha_cre_30y;
alpha_tsam2=alpha_30y;
delTs_am2=delTs;
delR_am2=delR;
correlation=num2str(whycorr(2));
titin=strcat(modtitle_am2,' corr: ',correlation)
title(titin)

% compute the 30 point running mean of the low level temperature
windwind=window_yr;
for ti=1:tend;
  delT_per_am2=delTs_am2(ti:ti+windwind);
  delT_am2_run(ti)=mean(delT_per_am2);
  delT_per_am3=delTs_am3(ti:ti+windwind);
  delT_am3_run(ti)=mean(delT_per_am3);
  delT_per_am4=delTs_am4(ti:ti+windwind);
  delT_am4_run(ti)=mean(delT_per_am4);
end

% plot figure with all 3 time series 
firstyr=1871;
lastyr=2014;

%firstyr:lastyr % length of am4 ts
%tend/2
timearr=1886:1999;
tgap=window_yr/2;
window_ts_str=firstyr+tgap;
window_ts_end=lastyr-tgap;
timearr=window_ts_str:window_ts_end;
%
figure
plot(timearr,alpha_tsam4,'k','LineWidth',2)
hold on
mn_arr=zeros(length(alpha_tsam4),1);
mn_arr=mn_arr+mean(alpha_tsam4,1);
plot(timearr,mn_arr,'k','LineWidth',2)
%
%plot(timearr(1:tend),alpha_tsam3(2:tend+1),'r','LineWidth',2)
plot(timearr(1:tend-1),alpha_tsam3(2:tend),'r','LineWidth',2)
mn_arr=zeros(length(alpha_tsam4),1);
mn_arr=mn_arr+mean(alpha_tsam3,1);
plot(timearr,mn_arr,'r','LineWidth',2)
%
plot(timearr(1:tend-1),alpha_tsam2(2:tend),'b','LineWidth',2)
mn_arr=zeros(length(alpha_tsam4));
mn_arr=mn_arr+mean(alpha_tsam2,1);
plot(timearr,mn_arr,'b','LineWidth',2)
title('net feedback')
hold off
%plot(timearr(1:104),alpha_tsam3(2:105),'r')
%plot(timearr(1:103),alpha_tsam2(2:104),'b')
%
figure
plot(timearr,-alpha_tsam4_cre,'k','LineWidth',2)
hold on
mn_arr=zeros(length(alpha_tsam4_cre));
mn_arr=mn_arr-mean(alpha_tsam4_cre,1);
plot(timearr,mn_arr,'k','LineWidth',2)
%
%plot(timearr(1:tend),-alpha_tsam3_cre(2:tend+1),'r','LineWidth',2)
plot(timearr(1:tend-1),-alpha_tsam3_cre(2:tend),'r','LineWidth',2)
mn_arr=zeros(length(alpha_tsam4_cre));
mn_arr=mn_arr-mean(alpha_tsam3_cre,1);
plot(timearr,mn_arr,'r','LineWidth',2)
%
plot(timearr(1:tend-1),-alpha_tsam2_cre(2:tend),'b','LineWidth',2)
mn_arr=zeros(length(alpha_tsam4_cre));
mn_arr=mn_arr-mean(alpha_tsam2_cre,1);
plot(timearr,mn_arr,'b','LineWidth',2)
title('cre feedback')
hold off
%
