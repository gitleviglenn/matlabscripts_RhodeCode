function cont_wcolorbar_omega(field_in,titlein)
figure; 
conts=[-0.3,-0.2,-0.15,-0.1,-0.05,0,0.05,0.1,0.15,0.2,0.3];
fig1=contourf(squeeze(field_in),conts);
caxis([-0.3 0.3]);
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
