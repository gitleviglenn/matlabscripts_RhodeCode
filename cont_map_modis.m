%------------------------------------------------------------
% levi silvers                            dec 2016
%
% field_in should be lat x lon, second incoming var lat and third lon
%
% the colormaps have been taken from
% http://jdherman.github.io/colormap/
% which is a great resource to create others
%
%------------------------------------------------------------
function cont_map_modis(field_in,vlat,vlon,contsin,caxisin)
% first get the continental outlines
load coast
figure; 
%axesm('MapProjection','ortho','origin',[90,180])
%axesm('MapProjection','hammer','origin',[0,-180])
axesm('MapProjection','hammer','origin',[0,0])
framem
plotm(lat,long,'k')
gridm
clear lat long;
clear conts caxis
%
%conts=[2.5,5.0,7.5,10.0,12.5,15.0,17.5,20.0,22.5];
%caxis([2.5 22.5]);
%conts=[70,80,90,100,110,120,130,140];
conts=contsin;
caxis=([caxisin(1) caxisin(2)]);
%caxis([60 150]);
%%conts=[100,245,250,255,260,265,270,275,280,285,288];
%%caxis([100 288]);
fig1=contourfm(vlat,vlon,squeeze(field_in),conts);
%fig1=contourfm(vlat,vlon,squeeze(field_in));
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
%cmap_orang=[255,255,255;
%255,255,197;
%255,255,138;
%255,211,82;
%255,153,27;
%226,96,0;
%168,41,0;
%111,0,0;
%56,0,0;
%0,0,0];
cmap_dirtorange=[255,255,255;
255,255,200;
255,240,175;
255,225,150;
255,210,125;
255,195,100;
235,180,75;
205,165,50;
185,133,25;
165,91,10];
%cmap_blueorange=[10,41,255;
%10,100,255;
%27,153,255;
%138,255,255;
%225,255,255;
%255,255,225;
%255,255,138;
%255,153,27;
%255,100,10;
%255,41,10];
cmap_blueorange=[10,50,255;
10,100,255;
10,150,255;
27,200,255;
138,250,255;
%225,255,255; % these are very light
%255,255,225;
255,250,138;
255,200,27;
255,150,10;
255,100,10;
255,50,10];
cmap=cmap_blueorange/256;
colormap(cmap(1:10,:))
