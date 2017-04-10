%------------------------------------------------------------
%
% create figures with modis output that can be compared to the 
% figures on the website: 
% cfmip.metoffice.com/cosp_quicklooks.html
%
% the modis figures on that webpage are: 
% 1. global map of total cloud cover: computed from CTP-tau data
% 2. globally averaged CTP-tau joint histogram
% 3. global map of liquid effective radius
% 4. global map of ice effective radius
% it appears that the fields shown on the quicklooks page are means
% of the january data from either 1989(model) or 2008(data)
%
% this scripts needs: 
%    vin.tclmodis
%    normlremn
%    lwp_norm_tcl
%    vin.lwp
%
% this scripts uses: 
%    global_wmean_script
%    cont_map_modis
%
% levi silvers                            dec 2016
%------------------------------------------------------------

% open the appropriate file and read cosp variables
% openncfile_cosp
%
% 2D total cloud field
clear tcl2d;
tcl2d=vin.tclmodis;
tcl2d_new=tcl2d;
tcl2d_new(tcl2d<0.0)=NaN;
%tcl2d=tcl2d';
%tcl2d_new=tcl2d_new';

fullfield=tcl2d;
global_wmean_script;
cont_map(tcl2d,vlat,vlon)
%figure;
%contourf(vlon,vlat,tcl2d_new)
colorbar
title('modis total cloud fraction: am4g10r8')
%cont_map(tcl2d_new,vlat,vlon)
%wmean_st=num2str(wgt_mean);
%tit=strcat('tcl modis: glb mean = ',wmean_st);
%title(tit)
%
%lre normalized by total cloud frac 
normlren=squeeze(lre_norm_tcl.*1e6);
lre_norm_lcl=squeeze(lre_norm_lcl.*1e6);
normlren(normlren>400)=NaN;
%lre normalized by total liquid cloud frac
%normlrebylcln=squeeze(normlrebylclmn.*10e6);
%normlrebylcln(normlrebylcln>400)=NaN;
% lre unnormalized 
%nonormlren=squeeze(nonormlremn.*10e6);
%nonormlren(nonormlren>400)=NaN;
%contslre=[70,80,90,100,110,120,130,140];
%caxislre=[60 150];
%figure;
%contslre=[1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6];
contslre=[1,2,3,4,5,6,7,8,9,10,11];
caxislre=[0 11];
cont_map_modis(normlren,vlat,vlon,contslre,caxislre)
%figure
%contourf(vlon,vlat,normlren)
colorbar
title('lre modis/tcl modis')
max(max(normlremn))
min(min(normlremn))
colorbar

cont_map_modis(lre_norm_lcl,vlat,vlon,contslre,caxislre)
colorbar
title('lre modis/lcl modis')

% plot Yi Ming's approximate lre:
cont_map_modis(lre_yim,vlat,vlon,contslre,caxislre)
colorbar
title('reffmodis/reffmodis2')

%lremodisn=vin.lremodis.*10e6;
%contslrenn=[130,140,150,160,170,180,190,200];
%caxislrenn=[120 210];
%cont_map_modis(lremodisn,vlat,vlon,contslrenn,caxislrenn)
%title('vin.lremodis glb mean: ')
%max(max(lremodisn))
%min(min(lremodisn))

normiremn=normiremn*1e6;
%contsire=[140,150,160,170,180,190,200,210,220];
%caxisire=[130 230];
%figure;
contsire=[10,20,30,40,50,60,70,80,90,100,110];
caxisire=[0 120];
cont_map_modis(normiremn,vlat,vlon,contsire,caxisire)
%figure
%contourf(vlon,vlat,normiremn)
title('ire modis/tcl modis')
max(max(normiremn))
min(min(normiremn))
colorbar

% LWP
contsire=[10,20,30,40,50,60,70,80,90,100,110];
caxisire=[0 12];
varin=lwp_norm_tcl*1000; % converts to g/m2
varin(lwp_norm_tcl>0.99)=NaN;
cont_map_modis(varin,vlat,vlon,contsire,caxisire)
%figure
%contourf(vlon,vlat,varin)
title('lwp modis/tcl modis')
max(max(varin))
min(min(varin))
colorbar

%varin=lwp_norm_lcl*100;
%varin(lwp_norm_lcl>0.99)=NaN;
%cont_map_modis(varin,vlat,vlon,contsire,caxisire)
%title('lwp modis/lcl modis')
%max(max(normire))
%min(min(normire))
%colorbar

varin=vin.lwp*1000; % converts to g/m2
%varin(lwp_norm_tcl>0.99)=NaN;
cont_map_modis(varin,vlat,vlon,contsire,caxisire)
%figure
%contourf(vlon,vlat,varin)
title('lwp ')
max(max(varin))
min(min(varin))
colorbar

%function cont_map_modis(field_in,vlat,vlon)
%% first get the continental outlines
%load coast
%figure; 
%%axesm('MapProjection','ortho','origin',[90,180])
%axesm('MapProjection','hammer','origin',[0,-180])
%framem
%plotm(lat,long,'k')
%gridm
%clear lat long;
%%
%%%conts=[-2,-1,0,1,2,3,4,5,6,7,8,9];
%%%conts=[-5,-4,-3,-2,-1,0,1,2,3,4,5];
%%%caxis([-5 5]);
%%conts=[10,20,30,40,50,60,70,75,80,85,90];
%%%caxis([10 90]);
%%caxis([0 100]);
%%%conts=[100,245,250,255,260,265,270,275,280,285,288];
%%%caxis([100 288]);
%%%fig1=contourfm(vlat,vlon,squeeze(field_in),conts);
%fig1=contourfm(vlat,vlon,squeeze(field_in));
%%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%%cmap_blue=[255,255,255;
%%197,255,255;
%%138,255,255;
%%82,211,255;
%%27,153,255;
%%0,96,226;
%%0,41,167;
%%0,0,110;
%%0,0,55;
%%0,0,0];
%%cmap_orang=[255,255,255;
%%255,255,197;
%%255,255,138;
%%255,211,82;
%%255,153,27;
%%226,96,0;
%%168,41,0;
%%111,0,0;
%%56,0,0;
%%0,0,0];
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
%cmap=cmap_blueorange/256;
%colormap(cmap(1:10,:))
