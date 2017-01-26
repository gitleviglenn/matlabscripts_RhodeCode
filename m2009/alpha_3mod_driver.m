%---------------------------------------------------------
%
% calls
% alpha_09
%
% levi silvers                                jan 2017
%---------------------------------------------------------

% compute the alpha time series for am4
temp_ts=v.tref_am4ts;
olr_ts =v.olr_toa_am4ts;
olr_clr_ts=v.olr_toa_clr_am4ts;
swup_clr_ts=v.swup_toa_clr_am4ts;
swdn_ts=v.swdn_toa_am4ts;
swup_ts=v.swup_toa_am4ts;
vlon   =v.lon_am4;
vlat   =v.lat_am4;

alpha_09
alpha_tsam4=alpha_30y;
delTs_am4=delTs;
delR_am4=delR;
correlation=num2str(whycorr(2));
titin=strcat(modtitle_am4,' corr: ',correlation)
title(titin)
figure
scatter(delTs_am4,delR_am4,40,'filled')

% compute the alpha time series for am3
temp_ts=v.tref_am3ts;
olr_ts =v.olr_toa_am3ts;
olr_clr_ts=v.olr_toa_clr_am3ts;
swup_clr_ts=v.swup_toa_clr_am3ts;
swdn_ts=v.swdn_toa_am3ts;
swup_ts=v.swup_toa_am3ts;
vlon   =v.lon_am3;
vlat   =v.lat_am3;

alpha_09
alpha_tsam3=alpha_30y;
delTs_am3=delTs;
delR_am3=delR;
correlation=num2str(whycorr(2));
titin=strcat(modtitle_am3,' corr: ',correlation)
title(titin)

% compute the alpha time series for am2
temp_ts=v.tref_am2ts;
olr_ts =v.olr_toa_am2ts;
olr_clr_ts=v.olr_toa_clr_am2ts;
swup_clr_ts=v.swup_toa_clr_am2ts;
swdn_ts=v.swdn_toa_am2ts;
swup_ts=v.swup_toa_am2ts;
vlon   =v.lon_am2;
vlat   =v.lat_am2;

alpha_09
alpha_tsam2=alpha_30y;
delTs_am2=delTs;
delR_am2=delR;
correlation=num2str(whycorr(2));
titin=strcat(modtitle_am2,' corr: ',correlation)
title(titin)


