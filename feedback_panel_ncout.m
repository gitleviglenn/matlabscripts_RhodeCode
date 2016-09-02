%------------------------------------------------------------------------------------------
% feedback_panel_ncout.m
%
% write output to a netcdf file for use in ncl
% this netcdf file doesn't have to work as input for gfdl model
%
% levi silvers                                        Aug 2016
%------------------------------------------------------------------------------------------

% name the output nc files
%fnout_cm4_diff='AM4OM2F_c96l32_am4g5r11_2000climo_1pct_response.nc'
file_out='testout.nc'
%fnout_cm2_1_diff='CM2.1U-D4_1PctTo2X_response.nc'

%%%------------------------------------------------------------------------------------------
%% Figures
%%------------------------------------------------------------------------------------------
%figure;
%ppplot(1)=subplot(2,1,1);
%contourf(squeeze(toa_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('TOA fdbck')
%ppplot(2)=subplot(2,1,2);
%contourf(squeeze(toa_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('TOA CRE fdbck')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h=colorbar('SouthOutside');
%set(h, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(ppplot(i), 'Position');
%  set(ppplot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar = findobj(gcf,'Tag','Colorbar');
%initpos = get(h_bar,'Position');
%initfontsize = get(h_bar,'FontSize');
%set(h_bar, ...
%   'Position',[initpos(1)+initpos(3)*0.25 initpos(2)+initpos(4)*0.25 ...
%         initpos(3)*0.5 initpos(4)*0.5], ...
%	    'FontSize',initfontsize*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%
%% second
%%clear pplot;
%%clear h; clear h_bar; clear initpos; clear initfontsize;
%% because we want to plot warming of system as positive switch sign of lw_clr
%%lw_clr_fdbck_warm=-lw_clr_fdbck_part_mn;
%figure;
%pp3lot(1)=subplot(2,1,1);
%contourf(squeeze(lw_clr_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('LW clr fdbck')
%pp3lot(2)=subplot(2,1,2);
%contourf(squeeze(sw_clr_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('SW clr fdbck')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h2=colorbar('SouthOutside');
%set(h2, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(pp3lot(i), 'Position');
%  set(pp3lot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar2 = findobj(gcf,'Tag','Colorbar');
%initpos2 = get(h_bar2,'Position');
%initfontsize2 = get(h_bar2,'FontSize');
%set(h_bar2, ...
%   'Position',[initpos2(1)+initpos2(3)*0.25 initpos2(2)+initpos2(4)*0.25 ...
%         initpos2(3)*0.5 initpos2(4)*0.5], ...
%	    'FontSize',initfontsize2*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%
%% third
%%clear pplot;
%%clear h; clear h_bar; clear initpos; clear initfontsize;
%% because warming from clouds corresponds to a neg sw_cre switch sign
%%sw_cre_warming=-sw_cre_fdbck_part_mn;
%figure;
%pp4lot(1)=subplot(2,1,1);
%contourf(squeeze(olr_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('LW CRE fdbck')
%pp4lot(2)=subplot(2,1,2);
%contourf(squeeze(sw_cre_fdbck_gnorm),[-4,-3,-2,-1,0,1,2,3,4]);
%caxis([-4 4]);
%title('SW CRE fdbck')
%cmap2=[0 0 1 ; .4 .4 1; .6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 0 0 ];
%%cmap2=[.6 .6 1;.9 .9 1;1 .9 .9;1 .7 .7;1 .6 .6;1 .5 .5;1 .4 .4 ;1 .3 .3;1 .1 .1 ;1 0 0 ];
%%cmap2=[.6 .6 1 ; .9 .9 1 ; 1 .9 .9 ; 1 .6 .6 ;1 .4 .4 ;1 .2 .2 ;1 0 0 ];
%colormap(cmap2(1:8,:))
%h3=colorbar('SouthOutside');
%set(h3, 'Position', [.1 .05 .8150 .05]);
%for i=1:2
%  pos=get(pp4lot(i), 'Position');
%  set(pp4lot(i), 'Position', [pos(1) 0.1+pos(2) pos(3) 0.8*pos(4)]);
%end;
%% try to change colorbar size...
%h_bar3 = findobj(gcf,'Tag','Colorbar');
%initpos3 = get(h_bar3,'Position');
%initfontsize3 = get(h_bar3,'FontSize');
%set(h_bar3, ...
%   'Position',[initpos3(1)+initpos3(3)*0.25 initpos3(2)+initpos3(4)*0.25 ...
%         initpos3(3)*0.5 initpos3(4)*0.5], ...
%	    'FontSize',initfontsize3*1)
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%
%% plot the zonal mean feedback and individual compoenents of feedback
%figure; plot(v.lat',toa_fdbck_part_zmn,'k',v.lat',olr_fdbck_part_zmn,'b', ...
%v.lat',sw_fdbck_part_zmn,'r',v.lat',lw_clr_fdbck_part_zmn,'b--',v.lat',sw_clr_fdbck_part_zmn,'r--',...
%v.lat',toa_cre_fdbck_part_zmn,'k*',v.lat',olr_cre_fdbck_part_zmn,'b*',v.lat',sw_cre_fdbck_part_zmn,'r*');
%title('zmn feedbck')
%legend('net','olr','sw','lw_{clr}','sw_{clr}','toa_{cre}','olr_{cre}','sw_{cre}','boxoff','Location','southwest')
%annotation('textbox',[0.0 0.9 1 0.1],'string',modelname, 'EdgeColor', 'none')
%
%%------------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------------
% create a new netcdf file
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

toa_gnorm=squeeze(toa_fdbck_gnorm);
cre_gnorm=squeeze(toa_cre_fdbck_gnorm);
lw_clr_gnorm=squeeze(lw_clr_fdbck_gnorm);
sw_clr_gnorm=squeeze(sw_clr_fdbck_gnorm);
sw_cre_gnorm=squeeze(sw_cre_fdbck_gnorm);
lw_cre_gnorm=squeeze(olr_cre_fdbck_gnorm);
% moisture related variables
precip_gnorm=squeeze(precip_fdbck_gnorm);
lwp_gnorm=squeeze(lwp_fdbck_gnorm);
wvp_gnorm=squeeze(wvp_fdbck_gnorm);
t_ref_gnorm=squeeze(t_ref_fdbck_gnorm);
%
nc{'toa_response'}=ncfloat('lat','lon'); 
nc{'toa_response'}(:,:)=toa_gnorm(:,:);
nc{'toa_cre_response'}=ncfloat('lat','lon'); 
nc{'toa_cre_response'}(:,:)=cre_gnorm(:,:);
nc{'lw_clr_response'}=ncfloat('lat','lon'); 
nc{'lw_clr_response'}(:,:)=lw_clr_gnorm(:,:);
nc{'sw_clr_response'}=ncfloat('lat','lon'); 
nc{'sw_clr_response'}(:,:)=sw_clr_gnorm(:,:);
nc{'sw_cre_response'}=ncfloat('lat','lon'); 
nc{'sw_cre_response'}(:,:)=sw_cre_gnorm(:,:);
nc{'lw_cre_response'}=ncfloat('lat','lon'); 
nc{'lw_cre_response'}(:,:)=lw_cre_gnorm(:,:);
% moisture related variables
nc{'precip_response'}=ncfloat('lat','lon'); 
nc{'precip_response'}(:,:)=precip_gnorm(:,:);
nc{'lwp_response'}=ncfloat('lat','lon'); 
nc{'lwp_response'}(:,:)=lwp_gnorm(:,:);
nc{'wvp_response'}=ncfloat('lat','lon'); 
nc{'wvp_response'}(:,:)=wvp_gnorm(:,:);
nc{'t_ref_response'}=ncfloat('lat','lon'); 
nc{'t_ref_response'}(:,:)=t_ref_gnorm(:,:);

nc{'TIME'}.long_name     ='TIME';      
%nc{'TIME'}.climatology   ='climatology_bounds';      
nc{'TIME'}.standard_name ='TIME';
nc{'TIME'}.calendar      ='gregorian';
nc{'TIME'}.units         ='days since 1869-12-1 00:00:00';      
nc{'TIME'}.delta_t       ='0000-00-01 00:00:00';      
nc{'TIME'}.modulo        =' ';      

nc{'lat'}.standard_name  = 'latitude' ;    nc{'lat'}.units  = 'degrees_north' ;
nc{'lon'}.standard_name  = 'longitude';    nc{'lon'}.units  = 'degrees_east' ;

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

nc{'toa_response'}.long_name     ='toa_net_rad_response';
nc{'toa_cre_response'}.long_name ='total_cre_response';
nc{'lw_clr_response'}.long_name ='lw_clr_response';
nc{'sw_clr_response'}.long_name ='sw_clr_response';
nc{'lw_cre_response'}.long_name ='lw_cre_response';
nc{'sw_cre_response'}.long_name ='sw_cre_response';
%nc{'sst'}.standard_name ='sea_surface_temperature';
%nc{'sst'}.units         ='degK';      
%nc{'sst'}.add_offset    = 0.e0;
%nc{'sst'}.scale_factor  = 1.e0;
%nc{'sst'}.FillValue_    =-1.e+30;
%nc{'sst'}.missing_value =-1.e+30;
%nc{'sst'}.description   ='HadIsst 1.1 monthly average sea surface temperature';
%nc{'sst'}.cell_methods  ='TIME: lat: lon: mean within months TIME: mean over years';
%nc{'sst'}.time_avg_info ='average_T1,average_T2,average_DT';

%nc{'average_T1'}.long_name ='Start TIME for average period';
%nc{'average_T1'}.units     ='days since 1869-12-1 00:00:00';      

%nc{'average_T2'}.long_name ='End TIME for average period';
%nc{'average_T2'}.units     ='days since 1869-12-1 00:00:00';      
%
%nc{'average_DT'}.long_name ='Length of average period';
%nc{'average_DT'}.units     ='days';      

close(nc); 

'finished first nc file'
% create a new netcdf file
%%------------------------------------------------------------------------------------------
% this is the end

