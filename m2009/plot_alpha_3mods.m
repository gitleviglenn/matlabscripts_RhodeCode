figure
starti=1;
endi=104;
firstyr=1886;
timearr=firstyr:firstyr+103;
% for am3
plot(timearr(starti:endi),alpha_array_am3(starti:endi,1),'r')
hold on
plot(timearr(starti:endi),alpha_array_am3(starti:endi,2),'r')
plot(timearr(starti:endi),alpha_array_am3(starti:endi,3),'r')
plot(timearr(starti:endi),alpha_array_am3(starti:endi,4),'r')
plot(timearr(starti:endi),alpha_array_am3(starti:endi,5),'r')
% ensemble mean
plot(timearr(starti:endi),mean_alpha_am3(starti:endi),'r','Linewidth',2)

% for am2
plot(timearr(starti:endi),alpha_array(starti:endi,1),'b')
plot(timearr(starti:endi),alpha_array(starti:endi,2),'b')
plot(timearr(starti:endi),alpha_array(starti:endi,3),'b')
plot(timearr(starti:endi),alpha_array(starti:endi,4),'b')
plot(timearr(starti:endi),alpha_array(starti:endi,5),'b')
plot(timearr(starti:endi),alpha_array(starti:endi,6),'b') 
% ensemble mean
plot(timearr(starti:endi),mean_alpha(starti:endi),'b','Linewidth',3)

% for am4
plot(timearr(starti:endi),alpha_array_am4(starti:endi,1),'k','Linewidth',3)

title('alpha: differential climate feedback parameter')

% the commands below eventually became alpha_simplemn.m and as of yet do not help much...
%
% temp commands to compute the regional values of alpha using a running mean of N/T and T
tendindex=134; % should correspond to Jan 1871 through Dec 2004, 134 years
% using a 30 year window removes 15 years from each side of the time series
% 104 corresponds to Jan 1876 through Dec 1989.  This is the range for alpha  
% however, the range of analysis for trends and regional impacts on alpha can 
% extend to the whole series.  

% to do this use the time series for toa_R and delTs to compute approximate
% values of alpha.  To smooth them use a 9 year running mean.  This will shave off 
% 4 years from each end of the time series.  So we will have a time series from
% Jan 1875 through Dec 2000.  
% compute mean values using the time series with the following years
% late period: Jan 1975:Dec 2000
% early period: Jan 1925: Dec 1955
incoming_ts=toa_R; % 134
running_mean;
toa_R_smooth=output_ts;
incoming_ts=delTs;
running_mean;
delTs_smooth=output_ts; % 126 should correspond to 2000

%periodend=89;
%periodst=59; % 1871+5(running mean)+59 should put us at 1935, + 89 should be 1965
periodend=126;
periodst=101;
%periodend=81;
%periodst=51;
num=toa_R_smooth(periodend)-toa_R_smooth(periodst);
den=delTs_smooth(periodend)-delTs_smooth(periodst);
alpha_reg=num/den;
%
%
