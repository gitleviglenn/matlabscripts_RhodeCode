%field1=-mn_olr_fdbck;
%field2=mn_sw_fdbck;
field1=mn_t_ref_fdbck;
field2=1000.*mn_lwp_fdbck;
conarray=[-10,-8,-6,-4,-2,0,2,4,6,8,10];

title1='mn tref fdbck';
title2='mn lwp fdbck';

cmap2=[0 0 1 ; .2 .2 1; .4 .4 1; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ; 1 0 0 ];
cmap3=[0 0 1 ; .2 .2 1; .4 .4 1; .6 .6 1; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 .2 .2; 1 0 0 ];

figure;
ppplot(1)=subplot(2,1,1);
contourf(squeeze(field1(1,:,:)),[-4,-3,-2,-1,0,1,2,3,4]);
caxis([-4 4]);
title(title1)
colormap(cmap2(1:8,:))
colorbar
ppplot(2)=subplot(2,1,2);
contourf(squeeze(field2(1,:,:)),conarray);
caxis([-10 10]);
title(title2)
colormap(cmap3(1:10,:))
colorbar
%%cmap2=[0 0 1 ; .2 .2 1; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ; 1 .2 .2 ;1 0 0 ];
%cmap2=[0 0 1 ; .2 .2 1; .4 .4 1; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ; 1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
