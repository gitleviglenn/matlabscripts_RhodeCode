% massflux.m
%
% compute the subisdence mass flux from HIRAM model output
%
% take the time and horizontal spacial means of the input data
%
% goals:
% first compute and verify the lapse rate
% second comput the subsidence mass flux as a function of the lapse rate
%
% units for mass flux and subs velocity should be kg/(m2 s)
%
% levi silvers                                            Oct 2016
%--------------------------------------------------------------------

infile297='/net2/Levi.Silvers/data/ming_doubprdc/h20_297_1800_rce/19930101.atmos_50d.nc'
infile299='/net2/Levi.Silvers/data/ming_doubprdc/h20_299_1800_rce/19930101.atmos_50d.nc'
infile301='/net2/Levi.Silvers/data/ming_doubprdc/h20_301_1800_rce/19930101.atmos_50d.nc'
infile303='/net2/Levi.Silvers/data/ming_doubprdc/h20_303_1800_rce/19930101.atmos_50d.nc'
%
%fin297=netcdf(infile297,'nowrite');
expfile=netcdf(infile297,'nowrite');
expfile_299=netcdf(infile299,'nowrite');
expfile_301=netcdf(infile301,'nowrite');
expfile_303=netcdf(infile303,'nowrite');

% constants
g=9.81;
cp=1003.5; % [J/(kg K)] specific heat of dry air at constant pressure 
Rd=287; % [J/(kg K)] gas constant for dry air
p0=100160.; % reference pressure
kappa=Rd/cp;

% dimensions: 
% pfull = 1:24       3.3236:996.1109

%w_sub=Q/dthetadz
%
%rho=pres_full./(Rd*temp)
%Q=tdt_sw+tdt_lw
%dthetadz=gamma+dTdz=g/cp-rho*g*dTdp
%
%d(temp)/d(pfull)=

bl_top=18;  % approximate model level at the top of the boundary layer

pfull=expfile{'pfull'}(1:bl_top);
pres_full=expfile{'pres_full'}(:,1:bl_top,:,:); % (time,pfull,lat,lon)
z_full=expfile{'z_full'}(:,1:bl_top,:,:); % (time,pfull,lat,lon)
pres_h=expfile{'pres_half'}(1:bl_top);
cld_amt=expfile{'cld_amt'}(:,1:bl_top,:,:);
cld_amt299=expfile_299{'cld_amt'}(:,1:bl_top,:,:);
cld_amt301=expfile_301{'cld_amt'}(:,1:bl_top,:,:);
cld_amt303=expfile_303{'cld_amt'}(:,1:bl_top,:,:);
evap=expfile{'evap'}(:,1:bl_top,:,:);
evap299=expfile_299{'evap'}(:,1:bl_top,:,:);
evap301=expfile_301{'evap'}(:,1:bl_top,:,:);
evap303=expfile_303{'evap'}(:,1:bl_top,:,:);
tdt_sw_full_297=expfile{'tdt_sw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_sw_full_299=expfile_299{'tdt_sw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_sw_full_301=expfile_301{'tdt_sw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_sw_full_303=expfile_303{'tdt_sw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_lw_full_297=expfile{'tdt_lw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_lw_full_299=expfile_299{'tdt_lw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_lw_full_301=expfile_301{'tdt_lw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
tdt_lw_full_303=expfile_303{'tdt_lw_clr'}(:,1:bl_top,:,:);    % (time,pfull,lat,lon)
temp_full=expfile{'temp'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)

% cum cloud base mass flux from RAS [kg/ (m2 s)]
conv_massf_full=expfile{'mfcb'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
conv_massf_full_299=expfile_299{'mfcb'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
conv_massf_full_301=expfile_301{'mfcb'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
conv_massf_full_303=expfile_303{'mfcb'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
%conv_massf_full=expfile{'mc_full'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
%conv_massf_full_299=expfile_299{'mc_full'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
%conv_massf_full_301=expfile_301{'mc_full'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)
%conv_massf_full_303=expfile_303{'mc_full'}(:,1:bl_top,:,:);        % (time,pfull,lat,lon)

% compute the mean values
pres_ft=squeeze(mean(pres_full,1));
pres_ft_a=squeeze(mean(pres_ft,2));
pres_ft_b=squeeze(mean(pres_ft_a,2));
pres_f=pres_ft_b;

evapft=squeeze(mean(evap,1));
evapft_a=squeeze(mean(evapft,2));
evapft_b=squeeze(mean(evapft_a,2));
evapf=evapft_b;

cld_amtft=squeeze(mean(cld_amt,1));
cld_amtft_a=squeeze(mean(cld_amtft,2));
cld_amtft_b=squeeze(mean(cld_amtft_a,2));
cld_amtf=cld_amtft_b;

cld_amt299ft=squeeze(mean(cld_amt299,1));
cld_amt299ft_a=squeeze(mean(cld_amt299ft,2));
cld_amt299ft_b=squeeze(mean(cld_amt299ft_a,2));
cld_amt299f=cld_amt299ft_b;

cld_amt301ft=squeeze(mean(cld_amt301,1));
cld_amt301ft_a=squeeze(mean(cld_amt301ft,2));
cld_amt301ft_b=squeeze(mean(cld_amt301ft_a,2));
cld_amt301f=cld_amt301ft_b;

cld_amt303ft=squeeze(mean(cld_amt303,1));
cld_amt303ft_a=squeeze(mean(cld_amt303ft,2));
cld_amt303ft_b=squeeze(mean(cld_amt303ft_a,2));
cld_amt303f=cld_amt303ft_b;

z_ft=squeeze(mean(z_full,1));
z_ft_a=squeeze(mean(z_ft,2));
z_ft_b=squeeze(mean(z_ft_a,2));
z_f=z_ft_b;

temp_ft=squeeze(mean(temp_full,1));
temp_ft_a=squeeze(mean(temp_ft,2));
temp_ft_b=squeeze(mean(temp_ft_a,2));
temp=temp_ft_b;

tdt_lw_ft=squeeze(mean(tdt_lw_full_297,1));
tdt_lw_ft_a=squeeze(mean(tdt_lw_ft,2));
tdt_lw_ft_b=squeeze(mean(tdt_lw_ft_a,2));
tdt_lw_297=tdt_lw_ft_b;

tdt_lw_299ft=squeeze(mean(tdt_lw_full_299,1));
tdt_lw_299ft_a=squeeze(mean(tdt_lw_299ft,2));
tdt_lw_299ft_b=squeeze(mean(tdt_lw_299ft_a,2));
tdt_lw_299=tdt_lw_299ft_b;

tdt_lw_301ft=squeeze(mean(tdt_lw_full_301,1));
tdt_lw_301ft_a=squeeze(mean(tdt_lw_301ft,2));
tdt_lw_301ft_b=squeeze(mean(tdt_lw_301ft_a,2));
tdt_lw_301=tdt_lw_301ft_b;

tdt_lw_303ft=squeeze(mean(tdt_lw_full_303,1));
tdt_lw_303ft_a=squeeze(mean(tdt_lw_303ft,2));
tdt_lw_303ft_b=squeeze(mean(tdt_lw_303ft_a,2));
tdt_lw_303=tdt_lw_303ft_b;

tdt_sw_ft=squeeze(mean(tdt_sw_full_297,1));
tdt_sw_ft_a=squeeze(mean(tdt_sw_ft,2));
tdt_sw_ft_b=squeeze(mean(tdt_sw_ft_a,2));
tdt_sw_297=tdt_sw_ft_b;

tdt_sw_299ft=squeeze(mean(tdt_sw_full_299,1));
tdt_sw_299ft_a=squeeze(mean(tdt_sw_299ft,2));
tdt_sw_299ft_b=squeeze(mean(tdt_sw_299ft_a,2));
tdt_sw_299=tdt_sw_299ft_b;

tdt_sw_301ft=squeeze(mean(tdt_sw_full_301,1));
tdt_sw_301ft_a=squeeze(mean(tdt_sw_301ft,2));
tdt_sw_301ft_b=squeeze(mean(tdt_sw_301ft_a,2));
tdt_sw_301=tdt_sw_301ft_b;

tdt_sw_303ft=squeeze(mean(tdt_sw_full_303,1));
tdt_sw_303ft_a=squeeze(mean(tdt_sw_303ft,2));
tdt_sw_303ft_b=squeeze(mean(tdt_sw_303ft_a,2));
tdt_sw_303=tdt_sw_303ft_b;

conv_massf_ft=squeeze(mean(conv_massf_full,1));
conv_massf_ft_a=squeeze(mean(conv_massf_ft,2));
conv_massf_ft_b=squeeze(mean(conv_massf_ft_a,2));
cmassf297=conv_massf_ft_b;

conv_massf_299_ft=squeeze(mean(conv_massf_full_299,1));
conv_massf_299_ft_a=squeeze(mean(conv_massf_299_ft,2));
conv_massf_299_ft_b=squeeze(mean(conv_massf_299_ft_a,2));
cmassf299=conv_massf_299_ft_b;

conv_massf_301_ft=squeeze(mean(conv_massf_full_301,1));
conv_massf_301_ft_a=squeeze(mean(conv_massf_301_ft,2));
conv_massf_301_ft_b=squeeze(mean(conv_massf_301_ft_a,2));
cmassf301=conv_massf_301_ft_b;

conv_massf_303_ft=squeeze(mean(conv_massf_full_303,1));
conv_massf_303_ft_a=squeeze(mean(conv_massf_303_ft,2));
conv_massf_303_ft_b=squeeze(mean(conv_massf_303_ft_a,2));
cmassf303=conv_massf_303_ft_b;

% compute the density
rho=pres_f./(Rd*temp);

tempt=squeeze(temp(:));
tempp=squeeze(pres_f(:));
tempz=squeeze(z_f(:));
% compute the lapse rate
%dtdp=zeros(24,1);
%%tt=1;
%%ilat=1;
%%jlon=1;
%for j=2:23;
%  dtdp(j,1)=(tempt(j+1)-tempt(j-1))/(tempp(j+1)-tempp(j-1));
%  dtdz(j,1)=(tempt(j+1)-tempt(j-1))/(tempz(j+1)-tempz(j-1));
%end
%dtdp(1,1)=dtdp(2);
%dtdp(24,1)=dtdp(23);
%dtdz(1,1)=dtdz(2);
%dtdz(24,1)=dtdz(23);

% end points
dthetadz(1)=((p0/tempp(1))^kappa)*(g/cp-rho(1)*g*((tempt(2)-tempt(1))/(tempp(2)-tempp(1))));
dthetadz(18)=((p0/tempp(18))^kappa)*(g/cp-rho(18)*g*((tempt(18)-tempt(17))/(tempp(18)-tempp(17))));

for j=2:17;
  dthetadz(j)=((p0/tempp(j))^kappa)*(g/cp-rho(j)*g*((tempt(j+1)-tempt(j-1))/(tempp(j+1)-tempp(j-1))));
end

%dry adiabat
for j=1:17;
  dthetadz_dry(j)=(g/cp)*(p0/tempp(j))^kappa;
end

%compute the radiative heating: 
Q=tdt_sw_297+tdt_lw_297;
Q_299=tdt_sw_299+tdt_lw_299;
Q_301=tdt_sw_301+tdt_lw_301;
Q_303=tdt_sw_303+tdt_lw_303;

% compute the subsidence velocity and mass flux
dthetadz=dthetadz';
w_sub=(Q./dthetadz); % m/s
%w_sub=(); % m/s
mf_sub=rho.*w_sub; % kg/(m2 s)

figure;
plot1=plot(cmassf297,pfull,'k',-mf_sub,pfull,'b')
title('conv and sub mass flux sst297')
xlabel('kg/(m2 s)')
set(plot1,'LineWidth',2);
set(gca,'YDir','reverse')
%figure;
%%plot(cmassf,pfull)
%plot(cmassf297,pfull,'k',cmassf299,pfull,'b',cmassf301,pfull,'r',cmassf303,pfull,'g')
%set(gca,'YDir','reverse')
%xlabel('kg/(m2 s)')
%title('convective mass flux')
%figure;
%plot(mf_sub,pfull)
%set(gca,'YDir','reverse')
%xlabel('kg/(m2 s)')
%title('sub mass flux')
%figure;
%plot(w_sub,pfull)
%set(gca,'YDir','reverse')
%xlabel('(m/s)')
%title('w_{sub}')
%figure;
%kperday=86400.*Q;
%%plot(kperday,pfull)
%plot(Q,pfull,'k',Q_299,pfull,'b',Q_301,pfull,'r',Q_303,pfull,'g')
%set(gca,'YDir','reverse')
%title('radiative heating')
%figure;
%plot(cld_amtf,temp,'k',cld_amt299f,temp,'b',cld_amt301f,temp,'r',cld_amt303f,temp,'g')
%set(gca,'YDir','reverse')
%title('cloud amount')
