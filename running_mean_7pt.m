%-----------------------------------------------------------------------------------------
% running_mean_7pt.m
%
% smooths an incoming time series with a 6 point running mean
%
% levi silvers                                                           
%-----------------------------------------------------------------------------------------

rough_ts=incoming_ts;
clear ts_smooth;
% for a 7 point running mean
for ti=4:tendindex-3
  ts_smooth(ti-3)=(rough_ts(ti-3)+rough_ts(ti-2)+rough_ts(ti-1)+rough_ts(ti)+rough_ts(ti+1)+rough_ts(ti+2)+rough_ts(ti+3))/7.;
end
output_ts=ts_smooth;
