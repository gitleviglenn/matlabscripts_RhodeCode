%WalkerEnergetics.m
%
% this script opens files and reads energy related variables from them 
% so that various computations can be made and figure plotted.
% 
% calls the functions 
%    rho_2d_gen()
%    read_1var_ztmn()
%    prec_wat()
%    press_deriv()
%
% Parameters which are computed include: 
% -- static stability 
% -- static stability parameter
% -- integrated water vapor path is computed (precipitable water)
% -- diabatic vertical velocity: vvel_d_25km 
% -- press derivative of the diabatic vertical velocity (blast_25)
%
%  vvel_d_25km =rad_heating_25./staticst_par_25km; (omega_d=Q/sigma)
%  the diabatic vertical velocity is also computed using idealized Q and sigma
%  rad_heating_25=tdtlw_25_ztmn+tdtsw_25_ztmn; heating rate
%
% plots several figures
% 
% run this within WalkerCell.m
%-----------------------------------------------------------------

%% define colors for figures
colyel=[0.9290,0.6940,0.1250];  % 25km 
colblu=[0.3010,0.7450,0.9330];  % 2km
colgrn=[0.4660,0.6740,0.1880];  % 1km

conv=60*60*24; % convert to Kelvin per day

%source_100km_month=strcat(path_100km,yearstr,'.atmos_month_tmn.nc');

% kg/m2 s
%evap_25km_ztmn=read_1var_ztmn(source_gcm_month,'evap');
evap_25km_full=ncread(source_gcm_month,'evap');
evap_25km_tmn=squeeze(mean(evap_25km_full,3));
evap_25km_ztmn=squeeze(mean(evap_25km_tmn,2));

evap_2km=ncread(source_2km_month,'evap');
evap_2km_zmn=squeeze(mean(evap_2km,2));
evap_2km_zmn_last3=squeeze(evap_2km_zmn(:,4:6));
evap_2km_ztmn=squeeze(mean(evap_2km_zmn,2));

evap_1km=ncread(source_1km_month,'evap');
evap_1km_zmn=squeeze(mean(evap_1km,2));
evap_1km_zmn_last3=squeeze(evap_1km_zmn(:,4:6));
evap_1km_ztmn=squeeze(mean(evap_1km_zmn_last3,2));

% W/m2
sh_1km=ncread(source_1km_month,'shflx');
sh_2km=ncread(source_2km_month,'shflx');
sh_25km_en_ztmn=read_1var_ztmn(source_gcm_month,'shflx');
sh_25km_ztmn=squeeze(mean(sh_25km_en_ztmn,2));

sh_1km_zmn=squeeze(mean(sh_1km,2));
sh_1km_zmn_last3=squeeze(sh_1km_zmn(:,4:6));
sh_1km_ztmn=squeeze(mean(sh_1km_zmn_last3,2));
sh_2km_zmn=squeeze(mean(sh_2km,2));
sh_2km_zmn_last3=squeeze(sh_2km_zmn(:,4:6));
sh_2km_ztmn=squeeze(mean(sh_2km_zmn_last3,2));


% convert to energy units of W/m2
% lvlv = 2.5e6 J/kg  % seems to give values that are too large.
% latheat = 2.26e6 J/kg    
evap_25km_en_ztmn=latheat.*evap_25km_ztmn;
evap_2km_en_ztmn=latheat.*evap_2km_ztmn;
evap_1km_en_ztmn=latheat.*evap_1km_ztmn;
%evap_25km_en_ztmn=lvlv.*evap_25km_ztmn;
%evap_2km_en_ztmn=lvlv.*evap_2km_ztmn;
%evap_1km_en_ztmn=lvlv.*evap_1km_ztmn;

% deg K/s; using 'conv' converts to K/day
%tdtconv_2km=ncread(source_2km_month,'tdt_conv');
tdtconv_25km_ztmn=conv.*read_1var_ztmn(source_gcm_month,'tdt_conv');
tdtconv_25km_prof=squeeze(mean(tdtconv_25km_ztmn,1));

tdtconv_100km_ztmn=conv.*read_1var_ztmn(source_100km_sm_month,'tdt_conv');
tdtconv_100km_prof=squeeze(mean(tdtconv_100km_ztmn,1));


% deg K/s
tdtls_100km=ncread(source_100km_sm_month,'tdt_ls');
%tdtls_25km=ncread(source_gcm_month,'tdt_ls');
tdtls_2km=ncread(source_2km_month,'tdt_ls');
tdtls_1km=ncread(source_1km_month,'tdt_ls');

tdtls_100km=conv.*tdtls_100km;
tdtls_100km_tmn=squeeze(mean(tdtls_100km,4));
tdtls_100km_ztmn=squeeze(mean(tdtls_100km_tmn,2));
tdtls_100km_prof=squeeze(mean(tdtls_100km_ztmn,1));

%tdtls_25km=conv.*tdtls_25km;
%tdtls_25km_tmn=squeeze(mean(tdtls_25km,4));
%tdtls_25km_ztmn=squeeze(mean(tdtls_25km_tmn,2));
tdtls_25km_ztmn=conv.*read_1var_ztmn(source_gcm_month,'tdt_ls');
tdtls_25km_prof=squeeze(mean(tdtls_25km_ztmn,1));

tdtls_2=conv.*tdtls_2km(:,:,:,t_mid:t_end);
tdtls_2_tmn=squeeze(mean(tdtls_2,4));
tdtls_2_ztmn=squeeze(mean(tdtls_2_tmn,2));
tdtls_2km_prof=squeeze(mean(tdtls_2_ztmn,1));

tdtls_1=conv.*tdtls_1km(:,:,:,t_mid:t_end);
tdtls_1_tmn=squeeze(mean(tdtls_1,4));
tdtls_1_ztmn=squeeze(mean(tdtls_1_tmn,2));
tdtls_1km_prof=squeeze(mean(tdtls_1_ztmn,1));

% deg K/s
tdtvdif_25km=ncread(source_gcm_month,'tdt_vdif');
tdtvdif_25km=conv.*tdtvdif_25km;

tdtvdif_2km=ncread(source_2km_month,'tdt_vdif');
tdtvdif_2km=conv.*tdtvdif_2km;

% det K/s; using 'conv' converts to K/day
tdtlw_25_ztmn=conv.*read_1var_ztmn(source_gcm_month,'tdt_lw');
tdtlw_100_ztmn=conv.*read_1var_ztmn(source_100km_sm_month,'tdt_lw');

tdtlw_2km=ncread(source_2km_month,'tdt_lw');
tdtlw_2km=conv.*tdtlw_2km(:,:,:,t_mid:t_end);
tdtlw_2_tmn=squeeze(mean(tdtlw_2km,4));
tdtlw_2_ztmn=squeeze(mean(tdtlw_2_tmn,2));

tdtlw_1km=ncread(source_1km_month,'tdt_lw');
tdtlw_1km=conv.*tdtlw_1km(:,:,:,t_mid:t_end);
tdtlw_1_tmn=squeeze(mean(tdtlw_1km,4));
tdtlw_1_ztmn=squeeze(mean(tdtlw_1_tmn,2));

% det K/s
tdtsw_100_ztmn=conv.*read_1var_ztmn(source_100km_sm_month,'tdt_sw');
tdtsw_25_ztmn=conv.*read_1var_ztmn(source_gcm_month,'tdt_sw');

tdtsw_2km=ncread(source_2km_month,'tdt_sw');
tdtsw_2km=conv.*tdtsw_2km(:,:,:,4:6);
tdtsw_2_tmn=squeeze(mean(tdtsw_2km,4));
tdtsw_2_ztmn=squeeze(mean(tdtsw_2_tmn,2));

tdtsw_1km=ncread(source_1km_month,'tdt_sw');
tdtsw_1km=conv.*tdtsw_1km(:,:,:,4:6);
tdtsw_1_tmn=squeeze(mean(tdtsw_1km,4));
tdtsw_1_ztmn=squeeze(mean(tdtsw_1_tmn,2));

% W/m2  net lw flux (at the surface i think)
lwflx_25km=ncread(source_gcm_month,'lwflx');
lwflx_2km=ncread(source_2km_month,'lwflx');

% W/m2  net sh flux 
shflx_25km=ncread(source_gcm_month,'shflx');
shflx_2km=ncread(source_2km_month,'shflx');

%% W/m2

%olr_zmn=squeeze(mean(olr_25km,2));
%olr_zxmn=squeeze(mean(olr_zmn,1));
%
%swdn_t_25km=ncread(source_gcm_month,'swdn_toa');
%swdn_t_2km=ncread(source_2km_month,'swdn_toa');
%swdn_t_zmn=squeeze(mean(swdn_t_25km,2));
%swdn_t_zxmn=squeeze(mean(swdn_t_zmn,1));
%
%swup_t_25km=ncread(source_gcm_month,'swup_toa');
%swup_t_2km=ncread(source_2km_month,'swup_toa');
%swup_t_zmn=squeeze(mean(swup_t_25km,2));
%swup_t_zxmn=squeeze(mean(swup_t_zmn,1));
%
%rad_net_toa=-olr_zxmn+swdn_t_zxmn-swup_t_zxmn;

% test new function read_1var_xymn.m

% what is the latent heat of vaporization constant?  
lvlv=2500000.;  % this gives a smaller imbalance than that in the phys_constants

olr_gcm_toa      =read_1var_xymn(source_gcm_month,'olr');
olr_l_25km       =read_1var_xymn(source_25km_lg_month,'olr');
olr_s_100km      =read_1var_xymn(source_100km_sm_month,'olr');
%olr_s_100km_lwoff=read_1var_xymn(source_100km_sm_lwoff_daily,'olr');
olr_l_100km      =read_1var_xymn(source_100km_lg_month,'olr');
olr_2km          =ncread(source_2km_month,'olr');
olr_1km          =ncread(source_1km_month,'olr');

swdn_gcm_toa     =read_1var_xymn(source_gcm_month,'swdn_toa');
swup_gcm_toa     =read_1var_xymn(source_gcm_month,'swup_toa');

rad_net_toa_gcm  =-olr_gcm_toa+swdn_gcm_toa-swup_gcm_toa;

swdn_gcm_sfc     =read_1var_xymn(source_gcm_month,'swdn_sfc');
lwdn_gcm_sfc     =read_1var_xymn(source_gcm_month,'lwdn_sfc');
swup_gcm_sfc     =read_1var_xymn(source_gcm_month,'swup_sfc');
lwup_gcm_sfc     =read_1var_xymn(source_gcm_month,'lwup_sfc');
lwflx_gcm        =read_1var_xymn(source_gcm_month,'lwflx');
shflx_gcm        =read_1var_xymn(source_gcm_month,'shflx');
evap_gcm         =read_1var_xymn(source_gcm_month,'evap');

%evap_gcm_en      =latheat.*evap_gcm;
evap_gcm_en      =lvlv.*evap_gcm;

%% W/m2

olr_a=squeeze(mean(olr_1km,3));
olr_b=squeeze(mean(olr_a,2));
olr_2km=squeeze(mean(olr_b,1))

olr_a=squeeze(mean(olr_2km,3));
olr_b=squeeze(mean(olr_a,2));
olr_2km=squeeze(mean(olr_b,1))
%olr_zmn=squeeze(mean(olr_25km,2));

rad_net_sfc_gcm  =swdn_gcm_sfc-swup_gcm_sfc+lwdn_gcm_sfc-lwup_gcm_sfc-shflx_gcm-evap_gcm_en;
atm_imb_rad=rad_net_toa_gcm-rad_net_sfc_gcm;

% compute domain mean olr: 
olr_s_100km_dmn=squeeze(mean(olr_s_100km,2));
olr_l_100km_dmn=squeeze(mean(olr_l_100km,2));
olr_s_25km_dmn =squeeze(mean(olr_gcm_toa,2));
olr_l_25km_dmn =squeeze(mean(olr_l_25km,2));

olr_a=squeeze(mean(olr_1km,3));
olr_b=squeeze(mean(olr_a,2));
olr_1km_dmn    =squeeze(mean(olr_b,1))

olr_a=squeeze(mean(olr_2km,3));
olr_b=squeeze(mean(olr_a,2));
olr_2km_dmn    =squeeze(mean(olr_b,1))

% compute domain mean precipitation
precip_100km=ncread(source_100km_sm_month,'precip');
precip_25km=ncread(source_gcm_month,'precip');
precip_2km=ncread(source_2km_month,'precip');
precip_1km=ncread(source_1km_month,'precip');

precip_100_zmn=squeeze(mean(precip_100km,2));
precip_100_zxmn=squeeze(mean(precip_100_zmn,1));
precip_100_tmn=squeeze(mean(precip_100_zxmn,2));
precip_100km_en=latheat*precip_100_tmn

precip_25_zmn=squeeze(mean(precip_25km,2));
precip_25_zxmn=squeeze(mean(precip_25_zmn,1));
precip_25_tmn=squeeze(mean(precip_25_zxmn,2));
precip_25km_en=latheat*precip_25_tmn

precip_2_zmn=squeeze(mean(precip_2km,2));
precip_2_zxmn=squeeze(mean(precip_2_zmn,1));
precip_2_tmn=squeeze(mean(precip_2_zxmn(1,4:6),2));
precip_2km_en=latheat*precip_2_tmn
precip_2km_en_b=lvlv*precip_2_tmn

precip_1_zmn=squeeze(mean(precip_1km,2));
precip_1_zxmn=squeeze(mean(precip_1_zmn,1));
precip_1_tmn=squeeze(mean(precip_1_zxmn(1,4:6),2));
precip_1km_en=latheat*precip_1_tmn
precip_1km_en_b=lvlv*precip_1_tmn

%precip_ts=latheat.*precip_zxmn;

% compute the surface enthalpy flux (sum of latent and sensible heat fluxes)
% see for example, Wing and Emanuel, 2014
s_enth_25km=evap_25km_en_ztmn+sh_25km_ztmn;
s_enth_2km=evap_2km_en_ztmn+sh_2km_ztmn;
s_enth_1km=evap_1km_en_ztmn+sh_1km_ztmn;

%

heatrad_100km=ncread(source_100km_sm_month,'heat2d_rad');
heatrad_25km=ncread(source_gcm_month,'heat2d_rad');
heatrad_2km=ncread(source_2km_month,'heat2d_rad');
heatrad_1km=ncread(source_1km_month,'heat2d_rad');

heatsw_25km=ncread(source_gcm_month,'heat2d_sw');
%heatsw_2km=ncread(source_2km_month,'heat2d_sw');

heatr_100km_1=squeeze(mean(heatrad_100km,1));
heatr_100km_2=squeeze(mean(heatr_100km_1,1));
heatr_100km_dmn=squeeze(mean(heatr_100km_2,2));

MeanRadH_100km=heatr_100km_dmn

heatr_25km_1=squeeze(mean(heatrad_25km,1));
heatr_25km_2=squeeze(mean(heatr_25km_1,1));
heatr_25km_dmn=squeeze(mean(heatr_25km_2,2));

MeanRadH_25km=heatr_25km_dmn

heatr_2km_1=squeeze(mean(heatrad_2km,1));
heatr_2km_2=squeeze(mean(heatr_2km_1,1));
heatr_2km_dmn=squeeze(mean(heatr_2km_2,2));

MeanRadH_2km=heatr_2km_dmn

heatr_1km_1=squeeze(mean(heatrad_1km,1));
heatr_1km_2=squeeze(mean(heatr_1km_1,1));
heatr_1km_dmn=squeeze(mean(heatr_1km_2,2));

MeanRadH_1km=heatr_1km_dmn

MeanRadPrec=[MeanRadH_1km MeanRadH_2km MeanRadH_25km MeanRadH_100km; precip_1km_en precip_2km_en precip_25km_en precip_100km_en]
%MeanPrecip_25km=mean(p_25km_tmean,1)
%MeanPrecip_2km=mean(p_2km_tmean,1)

%compTheta

stst=zeros(160,33);
app_R=zeros(160,33);

for j=2:32
    for i=1:160
%        stst(i,j)=(.102/rho_25km(i,j)).*(temp_25km_ztmn(i,j)/theta_znm(i,j).*((theta_znm(i,j+1)-theta_znm(i,j-1))/(zfull_25km_ztmn(i,j+1)-zfull_25km_ztmn(i,j-1))));
        stst(i,j)=(.102/rho_25km(i,j)).*(temp_25km_ztmn(i,j)/theta_gcm(i,j).*((theta_gcm(i,j+1)-theta_gcm(i,j-1))/(zfull_25km_ztmn(i,j+1)-zfull_25km_ztmn(i,j-1))));
    end 
end

for i=1:160
    %stst(i,1)=-(.1/rho_25km(i,j)).*(temp_znm(i,1)/theta_znm(i,1).*((theta_znm(i,2)-theta_znm(i,1))/(pfull_25km(2)-pfull_25km(1))));
    %stst(i,33)=-(.1/rho_25km(i,j)).*(temp_znm(i,33)/theta_znm(i,33).*((theta_znm(i,33)-theta_znm(i,32))/(pfull_25km(33)-pfull_25km(32))));
    stst(i,1)=(.102/rho_25km(i,1)).*(temp_25km_ztmn(i,1)/theta_gcm(i,1).*((theta_gcm(i,2)-theta_gcm(i,1))/(zfull_25km_ztmn(i,2)-zfull_25km_ztmn(i,1))));
    stst(i,33)=(.102/rho_25km(i,33)).*(temp_25km_ztmn(i,33)/theta_gcm(i,33).*((theta_gcm(i,33)-theta_gcm(i,32))/(zfull_25km_ztmn(i,33)-zfull_25km_ztmn(i,32))));
end 


%stst_conv=stst*conv;
%app_R=w_25km_ztmn./stst;
%app_R=conv*w_25km_ztmn.*stst;   % units?  should be K/day

rad_heating_100=tdtlw_100_ztmn+tdtsw_100_ztmn;
rad_heat_prof_100=mean(rad_heating_100,1);

rad_heating_25=tdtlw_25_ztmn+tdtsw_25_ztmn; % radiative heating is needed in compTheta
rad_heat_prof_25=mean(rad_heating_25,1);

rad_heating_1=tdtlw_1_ztmn+tdtsw_1_ztmn;
rad_heat_prof_1=mean(rad_heating_1,1);

rad_heating_2=tdtlw_2_ztmn+tdtsw_2_ztmn;
rad_heat_prof_2=mean(rad_heating_2,1);

% compute radiative heating in the subsidence region
tdtlw_1km_sub_a=tdtlw_1_ztmn(1:bc_a_1km,:);
tdtlw_1km_sub_prof_a=mean(tdtlw_1km_sub_a,1);
tdtlw_1km_sub_b=tdtlw_1_ztmn(bc_b_1km:bc_c_1km,:);
tdtlw_1km_sub_prof_b=mean(tdtlw_1km_sub_b,1);
tdtlw_1km_sub_prof=(tdtlw_1km_sub_prof_a+tdtlw_1km_sub_prof_b)/2;

tdtlw_2km_sub_a=tdtlw_2_ztmn(1:bc_a_2km,:);
tdtlw_2km_sub_prof_a=mean(tdtlw_2km_sub_a,1);
tdtlw_2km_sub_b=tdtlw_2_ztmn(bc_b_2km:bc_c_2km,:);
tdtlw_2km_sub_prof_b=mean(tdtlw_2km_sub_b,1);
tdtlw_2km_sub_prof=(tdtlw_2km_sub_prof_a+tdtlw_2km_sub_prof_b)/2;

tdtlw_25km_sub_a=tdtlw_25_ztmn(1:bc_a_25km,:);
tdtlw_25km_sub_prof_a=mean(tdtlw_25km_sub_a,1);
tdtlw_25km_sub_b=tdtlw_25_ztmn(bc_b_25km:bc_c_25km,:);
tdtlw_25km_sub_prof_b=mean(tdtlw_25km_sub_b,1);
tdtlw_25km_sub_prof=(tdtlw_25km_sub_prof_a+tdtlw_25km_sub_prof_b)/2;

tdtlw_100km_sub_a=tdtlw_100_ztmn(1:bc_a_100km,:);
tdtlw_100km_sub_prof_a=mean(tdtlw_100km_sub_a,1);
tdtlw_100km_sub_b=tdtlw_100_ztmn(bc_b_100km:bc_c_100km,:);
tdtlw_100km_sub_prof_b=mean(tdtlw_100km_sub_b,1);
tdtlw_100km_sub_prof=(tdtlw_100km_sub_prof_a+tdtlw_100km_sub_prof_b)/2;

figure
plot(tdtlw_1km_sub_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
set(gca,'Ydir','reverse')
hold on
plot(tdtlw_2km_sub_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(tdtlw_25km_sub_prof,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(tdtlw_100km_sub_prof,pfull_2km,'r','LineWidth',1.5)
%xlim([0 15])
%title('tdtlw in Subsiding region with LWCRE')
tit_tdtlw=strcat('tdtlw in Subsiding region ',lwcreonoff);
%title('Cloud Fraction in Subsiding region with LWCRE')
title(tit_tdtlw)

figure
plot(clt_1km_sub_prof,pfull_2km,'Color',colgrn,'LineWidth',1.5)
set(gca,'Ydir','reverse')
hold on
plot(clt_2km_sub_prof,pfull_2km,'Color',colblu,'LineWidth',1.5)
plot(clt_25km_sub_prof,pfull_2km,'Color',colyel,'LineWidth',1.5)
plot(clt_100km_sub_prof,pfull_2km,'r','LineWidth',1.5)
xlim([0 15])
tit_clt=strcat('Cloud Fraction in Subsiding region ',lwcreonoff);
%title('Cloud Fraction in Subsiding region with LWCRE')
title(tit_clt)

% compute the diabatic vertical velocity
% following some of the ideas in Mapes 2001 in which the diabatic divergence is equal to the
% pressure derivative of teh diabatic omega.  it can also be computed as the pressure derivative
% of Q/sigma where Q is the heating rate and sigma is the static stability paramete?  

% test an ideal cooling profile:
rad_cool=zeros(1,33);
rad_cool=-2.; % Kelvin/day
staticst_const=zeros(1,33)-0.0005;
x_local_25=100;
x_local_2=1000;
x_local_1=2000;

vvel_d_25km               = zeros(160,nlev);
vvel_d_2km                = zeros(2000,nlev);
vvel_d_1km                = zeros(4000,nlev);
vvel_d_25km_1d            = zeros(1,nlev);
vvel_d_2km_1d             = zeros(1,nlev);
vvel_d_1km_1d             = zeros(1,nlev);
vvel_d_25km_1d_sig        = zeros(1,nlev);
vvel_d_2km_1d_sig         = zeros(1,nlev);
vvel_d_1km_1d_sig         = zeros(1,nlev);

% diabatic vertical velocity (omega_d = Q/sigma, see Mapes, 2001)
vvel_d_25km        =rad_heating_25./staticst_par_25km;
vvel_d_2km         =rad_heating_2./staticst_par_2km;
vvel_d_1km         =rad_heating_1./staticst_par_1km;

vvel_d_1km_1d      =rad_heating_1(x_local_1,:)./staticst_par_1km(x_local_1,:);
vvel_d_2km_1d      =rad_heating_2(x_local_2,:)./staticst_par_1km(x_local_2,:);
vvel_d_25km_1d     =rad_heating_25(x_local_25,:)./staticst_par_1km(x_local_25,:);

vvel_d_ideal       =rad_cool./staticst_par_25km;
vvel_d_ideal_2     =rad_cool./staticst_par_2km;
vvel_d_ideal_1     =rad_cool./staticst_par_1km;

vvel_d_1km_1d_sig  =rad_heating_1(x_local_1,:)./staticst_const;
vvel_d_2km_1d_sig  =rad_heating_2(x_local_2,:)./staticst_const;
vvel_d_25km_1d_sig =rad_heating_25(x_local_25,:)./staticst_const;

% compute the divergent velocity at individual locations
% full variability in Q and sigma
blast_25=press_deriv(vvel_d_25km(x_local_25,:),99800,pfull_2km);
blast_1=press_deriv(vvel_d_1km(x_local_1,:),99800,pfull_2km);
blast_2=press_deriv(vvel_d_2km(x_local_2,:),99800,pfull_2km);
% full variability in Q, all profiles use the 1km sigma
blast_25_1d=press_deriv(vvel_d_25km_1d,99800,pfull_2km);
blast_2_1d=press_deriv(vvel_d_2km_1d,99800,pfull_2km);
blast_1_1d=press_deriv(vvel_d_1km_1d,99800,pfull_2km);
% full variability in sigma, all profiles use a Q that is uniformly -2K/d
blast_ideal_25=press_deriv(vvel_d_ideal(x_local_25,:),99800,pfull_2km);
blast_ideal_2=press_deriv(vvel_d_ideal_2(x_local_2,:),99800,pfull_2km);
blast_ideal_1=press_deriv(vvel_d_ideal_1(x_local_1,:),99800,pfull_2km);

div_idealsig_25 =press_deriv(vvel_d_25km_1d_sig,99800,pfull_2km);
div_idealsig_2  =press_deriv(vvel_d_2km_1d_sig,99800,pfull_2km);
div_idealsig_1  =press_deriv(vvel_d_1km_1d_sig,99800,pfull_2km);


figure
plot(blast_25,pfull_2km,'Color',colyel)
set(gca,'Ydir','reverse')
xlim([-0.5,0.5])
hold on
plot(blast_25_1d,pfull_2km,'Color',colyel)
plot(blast_2,pfull_2km,'Color',colblu)
plot(blast_2_1d,pfull_2km,'Color',colblu)
plot(blast_1,pfull_2km,'Color',colgrn)
plot(blast_1_1d,pfull_2km,'Color',colgrn)
plot(blast_ideal_25,pfull_2km,'k')
plot(blast_ideal_2,pfull_2km,'--k')
plot(blast_ideal_1,pfull_2km,'-.k')
title('diabatic divergence')

figure
plot(blast_25,pfull_2km,'Color',colyel)
set(gca,'Ydir','reverse')
set(gca,'YScale','log')
ylim([10000,100000])
xlim([-0.5,0.5])
hold on
%plot(blast_ideal_25,pfull_2km,'--','Color',colyel)
%plot(blast_25_1d,pfull_2km,'-.','Color',colyel)
plot(blast_2,pfull_2km,'Color',colblu)
%plot(blast_ideal_2,pfull_2km,'--','Color',colblu)
%plot(blast_2_1d,pfull_2km,'-.','Color',colblu)
plot(blast_1,pfull_2km,'Color',colgrn)
%plot(blast_ideal_1,pfull_2km,'--','Color',colgrn)
%plot(blast_1_1d,pfull_2km,'-.','Color',colgrn)
title('diabatic divergence')

figure
plot(blast_ideal_25,pfull_2km,'k')
hold on
set(gca,'Ydir','reverse')
xlim([-0.5,0.5])
plot(blast_ideal_2,pfull_2km,'--k')
plot(blast_ideal_1,pfull_2km,'-.k')
plot(div_idealsig_25,pfull_2km,'r')
plot(div_idealsig_2,pfull_2km,'--r')
plot(div_idealsig_1,pfull_2km,'-.r')


%figure_prof=figure  % radiative cooling only
%axes2 = axes('Parent',figure_prof,'BoxStyle','full','YMinorTick','on',...
%    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
%    'YScale','log',...
%    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
%    'Layer','top',...
%    'YDir','reverse',...
%    'FontWeight','bold',...
%    'FontSize',14);%,...
%ylim(axes2,[10000 100000]);
%box(axes2,'on');
%hold(axes2,'on');
%%set(gca,'Ydir','reverse')
%%plot(rad_heat_prof_25,pfull_2km,'-.k','LineWidth',2.0);
%plot(rad_heat_prof_25,pfull_2km,'Color',colyel,'LineWidth',2.0);
%hold on
%%plot(rad_heat_prof_100,pfull_2km,':k','LineWidth',2.0);
%%plot(rad_heat_prof_2,pfull_2km,'k','LineWidth',1.5);
%plot(rad_heat_prof_2,pfull_2km,'Color',colblu,'LineWidth',1.5);
%plot(rad_heat_prof_1,pfull_2km,'Color',colgrn,'LineWidth',1.5);


% static stability parameter across entire domain
staticst_par_25km_w=mean(staticst_par_25km(80:120,:),1);
staticst_par_25km_c=mean(staticst_par_25km(1:40,:),1);
staticst_par_2km_w=mean(staticst_par_2km(750:1250,:),1);
staticst_par_2km_c=mean(staticst_par_2km(1:500,:),1);
staticst_par_1km_w=mean(staticst_par_1km(1500:2500,:),1);
staticst_par_1km_c=mean(staticst_par_1km(1:100,:),1);
figure_stst_prof=figure
axes2 = axes('Parent',figure_stst_prof,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
xlim(axes2,[-20 1]);
title('Static Stab Par')
box(axes2,'on');
hold(axes2,'on');
plot(10000.*staticst_par_25km,pfull_2km,'Color',colyel,'LineWidth',1.5);
hold on
plot(10000.*staticst_par_2km,pfull_2km,'Color',colblu,'LineWidth',1.5);
plot(10000.*staticst_par_1km,pfull_2km,'Color',colgrn,'LineWidth',1.5);

figure_stst_prof_b=figure
axes2 = axes('Parent',figure_stst_prof_b,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'XTick',[-15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
xlim(axes2,[-15 1]);
title('StatStab Par over warm and cold regions: LWCRE')
xlabel('K/100hPa')
box(axes2,'on');
hold(axes2,'on');
plot(10000.*staticst_par_25km_w,pfull_2km,'Color',colyel,'LineWidth',1.5);
hold on
plot(10000.*staticst_par_25km_c,pfull_2km,'--','Color',colyel,'LineWidth',1.5);
plot(10000.*staticst_par_2km_w,pfull_2km,'Color',colblu,'LineWidth',1.5);
plot(10000.*staticst_par_2km_c,pfull_2km,'--','Color',colblu,'LineWidth',1.5);
plot(10000.*staticst_par_1km_w,pfull_2km,'Color',colgrn,'LineWidth',1.5);
plot(10000.*staticst_par_1km_c,pfull_2km,'--','Color',colgrn,'LineWidth',1.5);

%figure
%plot(tdtls_100km_prof,pfull_2km,'-.b');
%set(gca,'Ydir','reverse')
%hold on
%plot(tdtconv_100km_prof,pfull_2km,'--b');
%plot(tdtconv_100km_prof+tdtls_100km_prof,pfull_2km,'b','LineWidth',2);
%plot(tdtls_25km_prof,pfull_2km,'-.r');
%plot(tdtconv_25km_prof,pfull_2km,'--r');
%plot(tdtconv_25km_prof+tdtls_25km_prof,pfull_2km,'r','LineWidth',2);
%plot(tdtls_2km_prof,pfull_2km,'k','LineWidth',2);
%plot(tdtls_1km_prof,pfull_2km,'g','LineWidth',2);

figure_full_prof=figure
axes2 = axes('Parent',figure_full_prof,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'XTick',[-5 -4 -3 -2 -1 0 1 2 3 4 5],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(rad_heat_prof_25,pfull_2km,'Color',colyel,'LineWidth',2);
set(gca,'Ydir','reverse')
title('Heating: K/day: LWCRE ')
hold on
plot(tdtconv_25km_prof+tdtls_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2);
%plot(rad_heat_prof_100,pfull_2km,':k','LineWidth',2);
%plot(tdtconv_100km_prof+tdtls_100km_prof,pfull_2km,':k','LineWidth',2);
plot(rad_heat_prof_2,pfull_2km,'Color',colblu,'LineWidth',2);
plot(tdtls_2km_prof,pfull_2km,'Color',colblu,'LineWidth',2);
plot(rad_heat_prof_1,pfull_2km,'Color',colgrn,'LineWidth',2);
plot(tdtls_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2);

tdt_heat_prof_100=tdtconv_100km_prof+tdtls_100km_prof;
tdt_heat_prof_25=tdtconv_25km_prof+tdtls_25km_prof;
tdt_heat_prof_2=tdtls_2km_prof;
tdt_heat_prof_1=tdtls_1km_prof;

figure
plot(rad_heat_prof_25(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
plot(tdt_heat_prof_25(1,10:33),zzfull(10:33),'-o','Color',colyel)
plot(rad_heat_prof_2(1,10:33),zzfull(10:33),'-o','Color',colblu)
plot(tdt_heat_prof_2(1,10:33),zzfull(10:33),'-o','Color',colblu)
plot(rad_heat_prof_1(1,10:33),zzfull(10:33),'-o','Color',colgrn)
plot(tdt_heat_prof_1(1,10:33),zzfull(10:33),'-o','Color',colgrn)

tdt_total_cloud=tdtconv_25km_ztmn+tdtls_25km_ztmn;

%---------------------------------------------------------------
% % FIGURES ----------------------------------------------
% 
figure
subplot(3,3,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,4)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: sw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,7)
plot(xgcm(1:xgcm_ngp),evap_25km_en_ztmn,'r','LineWidth',1.5);
hold on;
plot(xgcm(1:xgcm_ngp),sh_25km_ztmn,'r','LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),evap_2km_en_ztmn,'k','LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),sh_2km_ztmn,'k','LineWidth',1.5);
title('Surface Fluxes: W/m2')

%
subplot(3,3,2)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtls_25km_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 

subplot(3,3,5)
heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtconv_25km_ztmn',heating_cons);
v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: convective heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,8)
heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdt_total_cloud',heating_cons);
v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: conv + ls heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,9)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtls_2_ztmn',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 

subplot(3,3,6)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtsw_2_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: sw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,3)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtlw_2_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: lw heating K/d')
set(gca,'Ydir','reverse')

tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)
%
%
figure
subplot(3,3,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,4)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: sw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,2)
plot(xgcm(1:xgcm_ngp),evap_25km_en_ztmn,'r','LineWidth',1.5);
hold on;
plot(xgcm(1:xgcm_ngp),sh_25km_ztmn,'r','LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),evap_2km_en_ztmn,'k','LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),sh_2km_ztmn,'k','LineWidth',1.5);
title('Surface Fluxes: W/m2')

%
tdt_cond_25km_ztmn=tdtls_25km_ztmn+tdtconv_25km_ztmn;
tdt_total_25km_ztmn=tdt_cond_25km_ztmn+tdtlw_25_ztmn+tdtsw_25_ztmn;
tdt_total_2km_ztmn=tdtls_2_ztmn+tdtlw_2_ztmn+tdtsw_2_ztmn;
%
subplot(3,3,7)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdt_cond_25km_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: condensational heating K/d')
set(gca,'Ydir','reverse') 

subplot(3,3,5)
heating_cons=[-3.,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdt_total_25km_ztmn',heating_cons);
%v=[-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
v=[-3.0,-1.5,-0.5,0.0,0.5,1.5,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: latent plus radiative K/d')
set(gca,'Ydir','reverse')

subplot(3,3,8)
heating_cons=[-3.,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
%heating_cons=[-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdt_total_2km_ztmn',heating_cons);
v=[-3.0,-1.5,-0.5,0.0,0.5,1.5,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: conv + ls heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,9)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtls_2_ztmn',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: strat cloud heating K/d')
set(gca,'Ydir','reverse') 

subplot(3,3,6)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtsw_2_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: sw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,3,3)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdtlw_2_ztmn',heating_cons);
v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('CRM: lw heating K/d')
set(gca,'Ydir','reverse')

tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)

figure
subplot(2,1,1)
%heating_cons=[-5.,-4.,-3.,-2.0,-1.5,-1.,-0.5,0.0,1.0,2.0,3.,4.,5.,6.];
heating_cons=[-5.,-4.,-3.,-2.0,-1.,0.0,1.0,2.0,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,tdt_total_25km_ztmn',heating_cons);
%v=[-5.0,-4.0,-3.0,-2.0,-1.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0]; % if labels are desired on contours
v=[-5.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0,10.0,12.0]; % if labels are desired on contours
clabel(C,h,v);
set(h,'EdgeColor','none') % to turn off the black overline on the contours
title('25km: tdt due to rad and cond K/d')
set(gca,'Ydir','reverse')

subplot(2,1,2)
[C,h]=contourf(1:xcrm_ngp,pfull_2km,tdt_total_2km_ztmn',heating_cons);
%v=[-3.0,-1.5,-0.5,0.0,0.5,1.5,3.0]; % if labels are desired on contours
clabel(C,h,v);
set(h,'EdgeColor','none') % no contour lines
title('2km: tdt due to rad and cond K/d')
set(gca,'Ydir','reverse')

tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)


% %------------------------
% 
% figure
% subplot(2,2,1)
% heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtsw_25_ztmn',heating_cons);
% v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
% clabel(C,h,v);
% title('GCM: sw heating K/d')
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(2,2,2)
% heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,tdtlw_25_ztmn',heating_cons);
% v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
% clabel(C,h,v);
% title('GCM: lw heating K/d')
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(2,2,3)
% heating_cons=[-1.5,-1.25,-1.0,-0.75,-.5,-.25,0.0,0.25,0.5,0.75,1.,1.25,1.5];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,rad_heating',heating_cons);
% v=[-1.5,-1.0,-.5,0.0,0.5,1.0,1.5]; % if labels are desired on contours
% caxis=([-1.5 1.25]);
% clabel(C,h,v);
% title('GCM: heating from lw + sw (K/d)')
% set(gca,'Ydir','reverse')
% colorbar
% 
% subplot(2,2,4)
% heating_cons=[-1.5,-1.25,-1.0,-0.75,-.5,-.25,0.0,0.25,0.5,0.75,1.,1.25,1.5];
% [C,h]=contourf(1:xgcm_ngp,pfull_2km,app_R',heating_cons);
% v=[-1.5,-1.0,-.5,0.0,0.5,1.0,1.5]; % if labels are desired on contours
% caxis=([-1.5 1.25]);
% clabel(C,h,v);
% title('GCM: app heating, S*w (K/d)?')
% set(gca,'Ydir','reverse')
% colorbar
% 
% tit_en=strcat('Energetics: ',tit_st);
% suptitle(tit_en)
