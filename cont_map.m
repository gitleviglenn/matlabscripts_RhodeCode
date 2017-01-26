function cont_map(field_in,vlat,vlon)
%------------------------------------------------------------------------------------------
% this was originally written to take data computed with the script
% feedback_panel.m and then processes to compute seasonal means.
%
% it build on the cont_wcolorbar.m script
%
% field_in should be lat x lon, second incoming var lat and third lon
%
% the colormaps have been taken from
% http://jdherman.github.io/colormap/
% which is a great resource to create others
%
% levi silvers                                       aug 2016
%
% recently modified for use with modis.              dec 2016
%------------------------------------------------------------------------------------------

% first get the continental outlines
load coast
figure; 
%axesm('MapProjection','ortho','origin',[90,180])
%axesm('MapProjection','ortho','origin',[-90,180])
axesm('MapProjection','hammer','origin',[0,-180])
framem
plotm(lat,long,'k')
gridm
clear lat long;
%
%conts=[-2,-1,0,1,2,3,4,5,6,7,8,9];
%conts=[-5,-4,-3,-2,-1,0,1,2,3,4,5];
%caxis([-5 5]);
conts=[10,20,30,40,50,60,70,75,80,85,90];
%caxis([10 90]);
caxis([0 100]);
%conts=[100,245,250,255,260,265,270,275,280,285,288];
%caxis([100 288]);
%fig1=contourf(squeeze(field_in),[-5,-4,-3,-2,-1,0,1,2,3,4,5]);
%fig1=contourfm(vlat,vlon,squeeze(field_in),conts);
%fig1=contourfm(squeeze(field_in),vlat,vlon,squeeze(field_in),conts);
%fig1=contourfm(vlon,vlat,squeeze(field_in),conts);
% according to documentation, contourm and contourfm are of the form
% contourfm(lat,lon,Z(lat,lon))
fig1=contourfm(vlat,vlon,squeeze(field_in));
%fig1=contourfm(vlat,vlon,squeeze(field_in),conts);
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
cmap_blue_light=[255,255,255;
200,255,255;
175,240,255;
150,225,255;
125,210,255;
100,195,255;
75,180,255;
50,165,255;
25,133,245;
0,41,167];
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
cmap_dirtorang=[255,255,255;
255,255,200;
255,240,175;
255,225,150;
255,210,125;
255,195,100;
235,180,75;
205,165,50;
185,133,25;
165,91,10];
cmap_blueorange=[10,41,255;
10,100,255;
27,153,255;
138,255,255;
225,255,255;
255,255,225;
255,255,138;
255,153,27;
255,100,10;
255,41,10];
cmap_yellgreen=[255,255,255;
255,255,197;
255,255,138;
211,255,82;
153,255,27;
96,243,0;
41,218,0;
0,177,0;
0,89,0;
0,0,0];
cmap=cmap_blue_light/256;
colormap(cmap(1:10,:))
h=colorbar('SouthOutside');
