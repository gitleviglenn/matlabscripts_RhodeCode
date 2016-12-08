function cont_wcolorbar_eis(field_in)
%------------------------------------------------------------------------------------------
% this was originally written to take data computed with the script
% feedback_panel.m and then processes to compute seasonal means.
%
% the colormaps have been taken from
% http://jdherman.github.io/colormap/
% which is a great resource to create others
%
% levi silvers                                       aug 2016
%------------------------------------------------------------------------------------------
figure; 
%conts=[-2,-1,0,1,2,3,4,5,6,7,8,9];
conts=[7,10,13,16,19,22,25,28,31,34,37];
%fig1=contourf(squeeze(field_in),[-5,-4,-3,-2,-1,0,1,2,3,4,5]);
fig1=contourf(squeeze(field_in),conts);
caxis([7 37]);
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
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
cmap=cmap_orang/256;
colormap(cmap(1:10,:))
h=colorbar('SouthOutside');
