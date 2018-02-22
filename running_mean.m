%-----------------------------------------------------------------------------------------
% running_mean.m
%
% smooths an incoming time series with a 9 point running mean
%
% levi silvers                                                           june 2017
%-----------------------------------------------------------------------------------------
%tend_a is presumably the end of the series
% tend_a = iend_a-istart_a;
%incoming_ts=v.sst_mn_ts_a;
% compute a running mean
rough_ts=incoming_ts;
% for a 13 point running mean
%for ti=7:tendindex-6
%  ts_smooth(ti-6)=(rough_ts(ti-6)+rough_ts(ti-5)+rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4)+rough_ts(ti+5)+rough_ts(ti+6))/13.;
%end
% for a 9 point running mean
for ti=5:tendindex-4
  ts_smooth(ti-4)=(rough_ts(ti-4)+rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3)+rough_ts(ti+4))/9.;
end
output_ts=ts_smooth;
clear rough_ts; clear ts_smooth;
%-----------------------------------------------------------------------------------------
%
