
% create lists of indices for each 3 month period
endt=360;
mam=sort([[3:12:endt],[4:12:endt],[5:12:endt]]);
jja=sort([[6:12:endt],[7:12:endt],[8:12:endt]]);
son=sort([[9:12:endt],[10:12:endt],[11:12:endt]]);
djf=sort([[1:12:endt],[2:12:endt],[12:12:endt]]);

% create new arrays containing only the given 3 month period
mampart=field(mam,:,:);
jjapart=field(jja,:,:);
sonpart=field(son,:,:);
djfpart=field(djf,:,:);

% compute spatial mean values
% the part arrays should have dimenions of mampart(endt/4,lat,lon)
mampart_mn1=mean(mampart,2);
mampart_mn2=mean(mampart_mn1,3);
mampart_mn=squeeze(mean(mampart_mn2,1));

jjapart_mn1=mean(jjapart,2);
jjapart_mn2=mean(jjapart_mn1,3);
jjapart_mn=squeeze(mean(jjapart_mn2,1));

sonpart_mn1=mean(sonpart,2);
sonpart_mn2=mean(sonpart_mn1,3);
sonpart_mn=squeeze(mean(sonpart_mn2,1));

djfpart_mn1=mean(djfpart,2);
djfpart_mn2=mean(djfpart_mn1,3);
djfpart_mn=squeeze(mean(djfpart_mn2,1));
