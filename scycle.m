function [mamavg,jjaavg,sonavg,djfavg] = scycle(field_in);
%------------------------------------------------------------------------------------------
% field_in(time,lat,lon)
% this script assumes time is monthly mean values over a 10 year period
%
% an example field_in is t_ref_fdbck which is output from feedback_panel.m
%
% levi silvers                                     aug 2016
%------------------------------------------------------------------------------------------

% first create lists of indices for each 3 month period
endt=360;
mam=sort([[3:12:endt],[4:12:endt],[5:12:endt]]);
jja=sort([[6:12:endt],[7:12:endt],[8:12:endt]]);
son=sort([[9:12:endt],[10:12:endt],[11:12:endt]]);
djf=sort([[1:12:endt],[2:12:endt],[12:12:endt]]);

% create new arrays containing only the given 3 month period
mampart=field_in(mam,:,:);
jjapart=field_in(jja,:,:);
sonpart=field_in(son,:,:);
djfpart=field_in(djf,:,:);

% take the seasonal mean
mamavg=mean(mampart,1);
jjaavg=mean(jjapart,1);
sonavg=mean(sonpart,1);
djfavg=mean(djfpart,1);

% plot one of the fields for demonstration
% 
% can also use contourf(squeeze(field_in),[-5,-4,-3,-2,-1,0,1,2,3,4,5]);
cont_wcolorbar(mamavg);
title('mam')
cont_wcolorbar(djfavg);
title('djf')
