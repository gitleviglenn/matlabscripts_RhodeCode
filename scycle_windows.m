function [scycle_stmn_wind,mamavg,jjaavg,sonavg,djfavg] = scycle_windows(field_in);
%------------------------------------------------------------------------------------------
% field_in(time,lat,lon)
%
% pulls out the seasonal cycle of field_in within the 7 windows
% see Wood and Bretherton 2006 for the windows
%
% output is:  scycle_stmn_wind(season,window)
%
% levi silvers                                     jan 2017
%------------------------------------------------------------------------------------------

% define the window of interest
% the five windows below are those defined in Klein and Hartmann 1993;
% latitude runs from 0 at the SP to 180 at NP
% i think that 0 long is at Greenwich...
conv=288.0/360.;
scycle_stmn_wind=zeros(4,5);
% peruvian window -------------------------------------
long1=conv*270.;
long2=conv*280.; % max of 288
lat1=70;
lat2=80;
eis_p=field_in(:,lat1:lat2,long1:long2);
field=eis_p;
scycle_script
blah_p=mampart_mn;
%% take the seasonal time mean
mamavg=squeeze(mean(mampart,1));
jjaavg=squeeze(mean(jjapart,1));
sonavg=squeeze(mean(sonpart,1));
djfavg=squeeze(mean(djfpart,1));
% below should be the time averaged spatial mean of the peruvian window...
j=1;
scycle_stmn_wind(1,j)=mampart_mn;
scycle_stmn_wind(2,j)=jjapart_mn;
scycle_stmn_wind(3,j)=sonpart_mn;
scycle_stmn_wind(4,j)=djfpart_mn;
% namibian window -------------------------------------;
long1=conv*1;
long2=conv*10;
lat1=70;
lat2=80;
eis_n=field_in(:,lat1:lat2,long1:long2);
field=eis_n;
scycle_script
blah_n=mampart_mn;
%
j=2;
scycle_stmn_wind(1,j)=mampart_mn;
scycle_stmn_wind(2,j)=jjapart_mn;
scycle_stmn_wind(3,j)=sonpart_mn;
scycle_stmn_wind(4,j)=djfpart_mn;
%Californian window -------------------------------------;
long1=conv*220;
long2=conv*230;
lat1=110;
lat2=120;
eis_c=field_in(:,lat1:lat2,long1:long2);
field=eis_c;
scycle_script
blah_c=mampart_mn;
%
j=3;
scycle_stmn_wind(1,j)=mampart_mn;
scycle_stmn_wind(2,j)=jjapart_mn;
scycle_stmn_wind(3,j)=sonpart_mn;
scycle_stmn_wind(4,j)=djfpart_mn;
%Australian window -------------------------------------;
long1=conv*95;
long2=conv*105;
lat1=55;
lat2=65;
eis_a=field_in(:,lat1:lat2,long1:long2);
field=eis_a;
scycle_script
blah_a=mampart_mn;
%
j=4;
scycle_stmn_wind(1,j)=mampart_mn;
scycle_stmn_wind(2,j)=jjapart_mn;
scycle_stmn_wind(3,j)=sonpart_mn;
scycle_stmn_wind(4,j)=djfpart_mn;
%Canarian window -------------------------------------;
long1=conv*325;
long2=conv*335;
lat1=105;
lat2=115;
eis_ca=field_in(:,lat1:lat2,long1:long2);
field=eis_ca;
scycle_script
blah_ca=mampart_mn;
%
j=5;
scycle_stmn_wind(1,j)=mampart_mn;
scycle_stmn_wind(2,j)=jjapart_mn;
scycle_stmn_wind(3,j)=sonpart_mn;
scycle_stmn_wind(4,j)=djfpart_mn;
%

%% take the seasonal time mean
mamavg=mean(mampart,1);
jjaavg=mean(jjapart,1);
sonavg=mean(sonpart,1);
djfavg=mean(djfpart,1);
%
