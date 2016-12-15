function cont_wcolorbar_eisdiff(field_in,titlein)
%------------------------------------------------------------------------------------------
% this was originally written to take data computed with the script
% feedback_panel.m and then processes to compute seasonal means.
%
% the colormaps have been taken from
% http://jdherman.github.io/colormap/
% which is a great resource to create others
%
% levi silvers                                       dec 2016
%------------------------------------------------------------------------------------------
figure; 
%conts=[4,6,8,10,12,13,14,15,16,18,20];
conts=[-5,-4,-3,-2,-1,0,1,2,3,4,5];
fig1=contourf(squeeze(field_in),conts);
caxis([-5 5]);
%caxis([-10 10]);
cmap_blue=[255,255,255;
197,255,255;
138,255,255;
82,211,255;
27,153,255;
0,96,226;
0,41,167;
0,0,110;
0,0,55;
0,0,0];
cmap_orang=[255,255,255;
255,255,197;
255,255,138;
255,211,82;
255,153,27;
226,96,0;
168,41,0;
111,0,0;
56,0,0;
0,0,0];
cmap_coolwarm=[
0,41,167;
5,81,197;
27,153,255;
82,211,255;
138,255,255;
255,255,197;
255,211,82;
226,160,50;
226,120,20;
111,56,0];
%111,0,0;
%56,0,0];
%cmap=cmap_orang/256;
cmap=cmap_coolwarm/256;
colormap(cmap(1:10,:))
h=colorbar('SouthOutside');
title(titlein)
