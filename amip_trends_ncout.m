%------------------------------------------------------------------------------------------
% amip_trends_ncout.m
%
% write output to a netcdf file for use in ncl
% this netcdf file doesn't have to work as input for gfdl model
%
% levi silvers                                        Aug 2016
%------------------------------------------------------------------------------------------

% name the output nc files
%fnout_cm4_diff='AM4OM2F_c96l32_am4g5r11_2000climo_1pct_response.nc'
%file_out='testout.nc'
%fnout_cm2_1_diff='CM2.1U-D4_1PctTo2X_response.nc'

%%%------------------------------------------------------------------------------------------
%% Figures
%%------------------------------------------------------------------------------------------
% create a new netcdf file
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'Modified SST pattern from Monthly version of HadISST sea surface temperature component';
nc.institution = 'GFDL' ;
nc.source      = 'HadISST';
nc.history     = '09/11/2006 HadISST converted to NetCDF from pp format by John Kennedy; 31/12/2015 modified by Levi Silvers';

%nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = 12; 
%nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'}(1:v.nt) = v.time(:); 
nc('lat') = v.nlat;          nc('lon')     = v.nlon;
nc{'lat'} = ncfloat('lat');  nc{'lat'} (:) = v.lat; 
nc{'lon'} = ncfloat('lon');  nc{'lon'} (:) = v.lon; 

%toa_trend=squeeze(toa_fdbck);
%cre_trend=squeeze(toa_cre_fdbck);
%lw_clr_trend=squeeze(lw_clr_fdbck);
%lw_cre_trend=squeeze(olr_cre_fdbck);
%sw_clr_trend=squeeze(sw_clr_fdbck);
%sw_cre_trend=squeeze(sw_cre_fdbck);
%%% moisture related variables
%%precip_gnorm=squeeze(precip_fdbck_gnorm);
%%lwp_gnorm=squeeze(lwp_fdbck_gnorm);
%%wvp_gnorm=squeeze(wvp_fdbck_gnorm);
%%t_ref_gnorm=squeeze(t_ref_fdbck_gnorm);
%%
nc{'toa_response'}=ncfloat('lat','lon'); 
nc{'toa_response'}(:,:)=toa_trend(:,:);
nc{'toa_cre_response'}=ncfloat('lat','lon'); 
nc{'toa_cre_response'}(:,:)=cre_trend(:,:);
nc{'lw_clr_response'}=ncfloat('lat','lon'); 
nc{'lw_clr_response'}(:,:)=lw_clr_trend(:,:);
nc{'sw_clr_response'}=ncfloat('lat','lon'); 
nc{'sw_clr_response'}(:,:)=sw_clr_trend(:,:);
nc{'sw_cre_response'}=ncfloat('lat','lon'); 
nc{'sw_cre_response'}(:,:)=sw_cre_trend(:,:);
nc{'lw_cre_response'}=ncfloat('lat','lon'); 
nc{'lw_cre_response'}(:,:)=lw_cre_trend(:,:);
%% moisture related variables
%nc{'precip_response'}=ncfloat('lat','lon'); 
%nc{'precip_response'}(:,:)=precip_gnorm(:,:);
%nc{'lwp_response'}=ncfloat('lat','lon'); 
%nc{'lwp_response'}(:,:)=lwp_gnorm(:,:);
%nc{'wvp_response'}=ncfloat('lat','lon'); 
%nc{'wvp_response'}(:,:)=wvp_gnorm(:,:);
%nc{'t_ref_response'}=ncfloat('lat','lon'); 
%%nc{'t_ref_response'}(:,:)=t_ref_gnorm(:,:);

nc{'TIME'}.long_name     ='TIME';      
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

close(nc); 

'finished nc file'
%%------------------------------------------------------------------------------------------
% this is the end
