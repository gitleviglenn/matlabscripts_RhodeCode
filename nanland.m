function varout = nanland(fieldin)
%
% apply the landmask from AM4 to global data.  output will have land masked as NaNs
%
% does the land mask include sea ice?  some timesteps appear to block out the highlats
%
% levi silvers                              april 2019

% land sea mask from am4 on macbook:
landm=ncread('~/data/am4p0/atmos.static.nc','land_mask');

onlyocean=zeros(size(landm));
onlyocean(landm~=0)=-999.; % shift land points to -999
onlyocean(onlyocean==0)=1.; % shift ocean points to 1.0
onlyocean(onlyocean==-999.)=0.; % shift land points to 0.0
just_ocean=onlyocean.*squeeze(fieldin);
just_ocean(just_ocean==0.)=NaN;

varout=just_ocean;
