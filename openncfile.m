%----------------------------------------------------------------------------
% openncfile.m
%
% this script opens a netcdf file and stores variables in a structure 'v'
%
% input: fin
%
% levi silvers                                        Apr 2016
%----------------------------------------------------------------------------
%fin_sst='/archive/cjg/mdt/cm3/ipcc_ar5/input/common/sst.climo.1981-2000.data.nc'
fin='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/atmos.000101-014012.t_surf.nc'

% output file
fnout='testfile.nc'

% read input file
f =netcdf(fin,'nowrite');
ncid=netcdf.open(fin,'NC_NOWRITE');
[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
% set up a structure(v) to hold info related to variables
%-------------------------------------------------
v.lon=f{'lon'}(:); v.lat =f{'lat'}(:);
v.nlon=length(v.lon); v.nlat=length(v.lat); v.ngrid=v.nlat*v.nlon;
v.latweight=cos(pi/180*v.lat);
v.xs0=1; v.xe0=v.nlon;
v.ys0=1; v.ye0=v.nlat;
v.time=f{'time'}(:); v.nt=length(v.time);
v.sst =f{'t_surf'}(:,:,:); 
%tstart=600;
%tend=1299;
%tint=tend-tstart+1;
%v.sst_full =f{'SST'} (tstart:tend,:,:); 
v.yr  =f{'yr'} (:);
v.mo  =f{'mo'} (:);
v.dy  =f{'dy'} (:);
v.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
v.nt=12;
%-------------------------------------------------
close(f);


