%------------------------------------------------------------------------------------------
% ensmn_ncout.m
%
% write output to a netcdf file 
%
% at least initially, data this file writes to an netcdf file is being computed/processed
% in am4p0_radflux_ncout.m
%
% levi silvers                                        may 2017
%------------------------------------------------------------------------------------------

%%------------------------------------------------------------------------------------------
% create a new netcdf file
file_out='levis_longer_radflux_am4.nc'
nc = netcdf(file_out,'clobber'); 
if isempty(nc) error('NetCDF File Not Opened.'); end
nc.Conventions = 'CF-1.0';
nc.title = 'AM4p0 Ensembles of TOA rad fluxes from amip-PiForcing exp';
nc.institution = 'GFDL' ;
nc.source      = 'GFDL';
nc.history     = '06/13/2017 created by Levi Silvers';

nc('TIME')  = 0; nc('nv')  = 2; nc('idim') = nmonths; 
nc{'TIME'}  = ncdouble('TIME'); nc{'TIME'} (1:nmonths) = timearray(:); 

nc{'tref_ens1'}                    =ncfloat('TIME'); 
nc{'tref_ens1'}(:)                 =tref_gmn_ens1(:);
nc{'tref_ens1'}.long_name          ='temperature at 2m';

nc{'toa_net_rflux_ens1'}                    =ncfloat('TIME'); 
nc{'toa_net_rflux_ens1'}(:)                 =toa_net_rflux_gmn_ens1(:);
nc{'toa_net_rflux_ens1'}.long_name          ='toa net radiative flux';

nc{'toa_lw_clr_gmn_ens1'}                   =ncfloat('TIME'); 
nc{'toa_lw_clr_gmn_ens1'}(:)                =toa_lw_clr_gmn_ens1(:);
nc{'toa_lw_clr_gmn_ens1'}.long_name         ='toa lw clear sky radiative flux';

nc{'toa_lw_gmn_ens1'}                       =ncfloat('TIME'); 
nc{'toa_lw_gmn_ens1'}(:)                    =toa_lw_gmn_ens1(:);
nc{'toa_lw_gmn_ens1'}.long_name             ='toa lw radiative flux';

nc{'toa_sw_clr_gmn_ens1'}                   =ncfloat('TIME'); 
nc{'toa_sw_clr_gmn_ens1'}(:)                =toa_sw_clr_gmn_ens1(:);
nc{'toa_sw_clr_gmn_ens1'}.long_name         ='toa sw clear sky radiative flux';

nc{'toa_sw_gmn_ens1'}                       =ncfloat('TIME'); 
nc{'toa_sw_gmn_ens1'}(:)                    =toa_sw_gmn_ens1(:);
nc{'toa_sw_gmn_ens1'}.long_name             ='toa sw upward radiative flux';

nc{'toa_swdn_gmn_ens1'}                     =ncfloat('TIME'); 
nc{'toa_swdn_gmn_ens1'}(:)                  =toa_swdn_gmn_ens1(:);
nc{'toa_swdn_gmn_ens1'}.long_name           ='toa downward sw clear sky radiative flux';

nc{'tref_ens2'}                    =ncfloat('TIME'); 
nc{'tref_ens2'}(:)                 =tref_gmn_ens2(:);
nc{'tref_ens2'}.long_name          ='temperature at 2m';

nc{'toa_net_rflux_ens2'}                    =ncfloat('TIME'); 
nc{'toa_net_rflux_ens2'}(:)                 =toa_net_rflux_gmn_ens2(:);
nc{'toa_net_rflux_ens2'}.long_name          ='toa net radiative flux';

nc{'toa_lw_clr_gmn_ens2'}                   =ncfloat('TIME'); 
nc{'toa_lw_clr_gmn_ens2'}(:)                =toa_lw_clr_gmn_ens2(:);
nc{'toa_lw_clr_gmn_ens2'}.long_name         ='toa lw clear sky radiative flux';

nc{'toa_lw_gmn_ens2'}                       =ncfloat('TIME'); 
nc{'toa_lw_gmn_ens2'}(:)                    =toa_lw_gmn_ens2(:);
nc{'toa_lw_gmn_ens2'}.long_name             ='toa lw radiative flux';

nc{'toa_sw_clr_gmn_ens2'}                   =ncfloat('TIME'); 
nc{'toa_sw_clr_gmn_ens2'}(:)                =toa_sw_clr_gmn_ens2(:);
nc{'toa_sw_clr_gmn_ens2'}.long_name         ='toa sw clear sky radiative flux';

nc{'toa_sw_gmn_ens2'}                       =ncfloat('TIME'); 
nc{'toa_sw_gmn_ens2'}(:)                    =toa_sw_gmn_ens2(:);
nc{'toa_sw_gmn_ens2'}.long_name             ='toa sw upward radiative flux';

nc{'toa_swdn_gmn_ens2'}                     =ncfloat('TIME'); 
nc{'toa_swdn_gmn_ens2'}(:)                  =toa_swdn_gmn_ens2(:);
nc{'toa_swdn_gmn_ens2'}.long_name           ='toa downward sw clear sky radiative flux';

nc{'tref_ens3'}                    =ncfloat('TIME'); 
nc{'tref_ens3'}(:)                 =tref_gmn_ens3(:);
nc{'tref_ens3'}.long_name          ='temperature at 2m';

nc{'toa_net_rflux_ens3'}                    =ncfloat('TIME'); 
nc{'toa_net_rflux_ens3'}(:)                 =toa_net_rflux_gmn_ens3(:);
nc{'toa_net_rflux_ens3'}.long_name          ='toa net radiative flux';

nc{'toa_lw_clr_gmn_ens3'}                   =ncfloat('TIME'); 
nc{'toa_lw_clr_gmn_ens3'}(:)                =toa_lw_clr_gmn_ens3(:);
nc{'toa_lw_clr_gmn_ens3'}.long_name         ='toa lw clear sky radiative flux';

nc{'toa_lw_gmn_ens3'}                       =ncfloat('TIME'); 
nc{'toa_lw_gmn_ens3'}(:)                    =toa_lw_gmn_ens3(:);
nc{'toa_lw_gmn_ens3'}.long_name             ='toa lw radiative flux';

nc{'toa_sw_clr_gmn_ens3'}                   =ncfloat('TIME'); 
nc{'toa_sw_clr_gmn_ens3'}(:)                =toa_sw_clr_gmn_ens3(:);
nc{'toa_sw_clr_gmn_ens3'}.long_name         ='toa sw clear sky radiative flux';

nc{'toa_sw_gmn_ens3'}                       =ncfloat('TIME'); 
nc{'toa_sw_gmn_ens3'}(:)                    =toa_sw_gmn_ens3(:);
nc{'toa_sw_gmn_ens3'}.long_name             ='toa sw upward radiative flux';

nc{'toa_swdn_gmn_ens3'}                     =ncfloat('TIME'); 
nc{'toa_swdn_gmn_ens3'}(:)                  =toa_swdn_gmn_ens3(:);
nc{'toa_swdn_gmn_ens3'}.long_name           ='toa downward sw clear sky radiative flux';

nc{'tref_ens4'}                    =ncfloat('TIME'); 
nc{'tref_ens4'}(:)                 =tref_gmn_ens4(:);
nc{'tref_ens4'}.long_name          ='temperature at 2m';

nc{'toa_net_rflux_ens4'}                    =ncfloat('TIME'); 
nc{'toa_net_rflux_ens4'}(:)                 =toa_net_rflux_gmn_ens4(:);
nc{'toa_net_rflux_ens4'}.long_name          ='toa net radiative flux';

nc{'toa_lw_clr_gmn_ens4'}                   =ncfloat('TIME'); 
nc{'toa_lw_clr_gmn_ens4'}(:)                =toa_lw_clr_gmn_ens4(:);
nc{'toa_lw_clr_gmn_ens4'}.long_name         ='toa lw clear sky radiative flux';

nc{'toa_lw_gmn_ens4'}                       =ncfloat('TIME'); 
nc{'toa_lw_gmn_ens4'}(:)                    =toa_lw_gmn_ens4(:);
nc{'toa_lw_gmn_ens4'}.long_name             ='toa lw radiative flux';

nc{'toa_sw_clr_gmn_ens4'}                   =ncfloat('TIME'); 
nc{'toa_sw_clr_gmn_ens4'}(:)                =toa_sw_clr_gmn_ens4(:);
nc{'toa_sw_clr_gmn_ens4'}.long_name         ='toa sw clear sky radiative flux';

nc{'toa_sw_gmn_ens4'}                       =ncfloat('TIME'); 
nc{'toa_sw_gmn_ens4'}(:)                    =toa_sw_gmn_ens4(:);
nc{'toa_sw_gmn_ens4'}.long_name             ='toa sw upward radiative flux';

nc{'toa_swdn_gmn_ens4'}                     =ncfloat('TIME'); 
nc{'toa_swdn_gmn_ens4'}(:)                  =toa_swdn_gmn_ens4(:);
nc{'toa_swdn_gmn_ens4'}.long_name           ='toa downward sw clear sky radiative flux';

nc{'tref_ens5'}                    =ncfloat('TIME'); 
nc{'tref_ens5'}(:)                 =tref_gmn_ens5(:);
nc{'tref_ens5'}.long_name          ='temperature at 2m';

nc{'toa_net_rflux_ens5'}                    =ncfloat('TIME'); 
nc{'toa_net_rflux_ens5'}(:)                 =toa_net_rflux_gmn_ens5(:);
nc{'toa_net_rflux_ens5'}.long_name          ='toa net radiative flux';

nc{'toa_lw_clr_gmn_ens5'}                   =ncfloat('TIME'); 
nc{'toa_lw_clr_gmn_ens5'}(:)                =toa_lw_clr_gmn_ens5(:);
nc{'toa_lw_clr_gmn_ens5'}.long_name         ='toa lw clear sky radiative flux';

nc{'toa_lw_gmn_ens5'}                       =ncfloat('TIME'); 
nc{'toa_lw_gmn_ens5'}(:)                    =toa_lw_gmn_ens5(:);
nc{'toa_lw_gmn_ens5'}.long_name             ='toa lw radiative flux';

nc{'toa_sw_clr_gmn_ens5'}                   =ncfloat('TIME'); 
nc{'toa_sw_clr_gmn_ens5'}(:)                =toa_sw_clr_gmn_ens5(:);
nc{'toa_sw_clr_gmn_ens5'}.long_name         ='toa sw clear sky radiative flux';

nc{'toa_sw_gmn_ens5'}                       =ncfloat('TIME'); 
nc{'toa_sw_gmn_ens5'}(:)                    =toa_sw_gmn_ens5(:);
nc{'toa_sw_gmn_ens5'}.long_name             ='toa sw upward radiative flux';

nc{'toa_swdn_gmn_ens5'}                     =ncfloat('TIME'); 
nc{'toa_swdn_gmn_ens5'}(:)                  =toa_swdn_gmn_ens5(:);
nc{'toa_swdn_gmn_ens5'}.long_name           ='toa downward sw clear sky radiative flux';


nc{'TIME'}.long_name     ='TIME';      
nc{'TIME'}.standard_name ='TIME';
nc{'TIME'}.calendar      ='Julian';
nc{'TIME'}.units         ='days since 1870-01-01 00:00:00';      
nc{'TIME'}.delta_t       ='0000-00-01 00:00:00';      
nc{'TIME'}.modulo        =' ';      

nc{'yr'}.long_name    ='year';      
nc{'mo'}.long_name    ='month';      
nc{'dy'}.long_name    ='day';      

close(nc); 

'finished nc file'
%%------------------------------------------------------------------------------------------
% this is the end
