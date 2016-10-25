% massflux.m
%
% compute the subisdence mass flux from HIRAM model output
%
% take the time and horizontal spacial means of the input data
%
% first compute and verify the lapse rate
% second comput the subsidence mass flux as a function of the lapse rate
%
% units for mass flux and subs velocity should be kg/(m2 s)
%
% levi silvers                                            Oct 2016
%--------------------------------------------------------------------

infile297='/net2/Levi.Silvers/data/ming_doubprdc/h20_297_1800_rce/19930101.atmos_50d.nc'
%infile299='/net2/Levi.Silvers/data/ming_doubprdc/h20_299_1800_rce/19930101.atmos_50d.nc'
%infile301='/net2/Levi.Silvers/data/ming_doubprdc/h20_301_1800_rce/19930101.atmos_50d.nc'
%infile303='/net2/Levi.Silvers/data/ming_doubprdc/h20_303_1800_rce/19930101.atmos_50d.nc'
%
%fin297=netcdf(infile297,'nowrite');
expfile=netcdf(infile297,'nowrite');
%fin299=netcdf(infile299,'nowrite');
%fin301=netcdf(infile301,'nowrite');
%fin303=netcdf(infile303,'nowrite');

% constants
g=9.81;
cp=1003.5; % [J/(kg K)] specific heat of dry air at constant pressure 
Rd=287; % [J/(kg K)] gas constant for dry air

% dimensions: 
% pfull = 1:24       3.3236:996.1109

%w_sub=rho*Q/dthetadz
%
%Q=tdt_sw+tdt_lw
%rho=pres_full./(Rd*temp)
%dthetadz=gamma+dTdz=g/cp-rho*g*dTdp
%
%d(temp)/d(pfull)=

pfull=expfile{'pfull'}(:);
pres_full=expfile{'pres_full'}(:,:,:,:); % (time,pfull,lat,lon)
pres_h=expfile{'pres_half'}(:);
tdt_sw_full=expfile{'tdt_sw'}(:,:,:,:);    % (time,pfull,lat,lon)
tdt_lw_full=expfile{'tdt_lw'}(:,:,:,:);    % (time,pfull,lat,lon)
temp_full=expfile{'temp'}(:,:,:,:);        % (time,pfull,lat,lon)

% cum cloud base mass flux from RAS
conv_massf_full=expfile{'mfcb'}(:,:,:,:);        % (time,pfull,lat,lon)

% compute the time mean values
pres_ft=squeeze(mean(pres_full,1));
pres_ft_a=squeeze(mean(pres_ft,2));
pres_ft_b=squeeze(mean(pres_ft_a,2));
pres_f=pres_ft_b;

temp_ft=squeeze(mean(temp_full,1));
temp_ft_a=squeeze(mean(temp_ft,2));
temp_ft_b=squeeze(mean(temp_ft_a,2));
temp=temp_ft_b;

tdt_sw_ft=squeeze(mean(tdt_sw_full,1));
tdt_sw_ft_a=squeeze(mean(tdt_sw_ft,2));
tdt_sw_ft_b=squeeze(mean(tdt_sw_ft_a,2));
tdt_sw=tdt_sw_ft_b;

tdt_lw_ft=squeeze(mean(tdt_lw_full,1));
tdt_lw_ft_a=squeeze(mean(tdt_lw_ft,2));
tdt_lw_ft_b=squeeze(mean(tdt_lw_ft_a,2));
tdt_lw=tdt_lw_ft_b;

conv_massf_ft=squeeze(mean(conv_massf_full,1));
conv_massf_ft_a=squeeze(mean(conv_massf_ft,2));
conv_massf_ft_b=squeeze(mean(conv_massf_ft_a,2));
cmassf=conv_massf_ft_b;

% compute the density
rho=pres_f./(Rd*temp);

tempt=squeeze(temp(:));
tempp=squeeze(pres_f(:));
% compute the lapse rate
dtdp=zeros(24,1);
%tt=1;
%ilat=1;
%jlon=1;
for j=2:23;
  dtdp(j,1)=(tempt(j+1)-tempt(j-1))/(tempp(j+1)-tempp(j-1));
end
dtdp(1,1)=dtdp(2);
dtdp(24,1)=dtdp(23);

dthetadz=g/cp-g*rho.*dtdp;

%compute the radiative heating: 
Q=tdt_sw+tdt_lw;

% compute the subsidence velocity
% w_sub = rho*(Q/dthetadz)
w_sub=rho.*(Q./dthetadz);


