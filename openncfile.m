%frchive/Levi.Silvers/awg/verona/c96L32_am4g10r8_had_p_1pctco2_climo/gfdl.ncrc3-intel-prod-openmp/pp/atmos/av/annual_5yr/atmos.0007-0011.ann.nc'unction openncfile(stringincoming)
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
%fin='/archive/Ming.Zhao/awglg/ulm/AM4OM2F_c96l32_am4g5r11_2000climo/ts_all/atmos.000101-014012.t_surf.nc'

% output file
%fnout='testfile.nc'

% read input file
fin =netcdf(stringincoming,'nowrite');
%ncid=netcdf.open(fin,'NC_NOWRITE');
%[ndim,nvar,natt,unlim]=netcdf.inq(ncid);
% set up a structure(v) to hold info related to variables
%-------------------------------------------------
vin.lon=fin{'lon'}(:); vin.lat =fin{'lat'}(:);
vin.nlon=length(vin.lon); vin.nlat=length(vin.lat); vin.ngrid=vin.nlat*vin.nlon;
vin.latweight=cos(pi/180*vin.lat);
vin.xs0=1; vin.xe0=vin.nlon;
vin.ys0=1; vin.ye0=vin.nlat;
vin.time=fin{'time'}(:); vin.nt=length(vin.time);
vin.sst =fin{'t_surf'}(:,:,:); 
%tstart=600;
%tend=1299;
%tint=tend-tstart+1;
%vin.sst_full =f{'SST'} (tstart:tend,:,:); 
vin.yr  =fin{'yr'} (:);
vin.mo  =fin{'mo'} (:);
vin.dy  =fin{'dy'} (:);
vin.time = [49354 49385 49413 49444 49474 49505 49535 49566 49597 49627 49658 49688];
vin.nt=12;
%-------------------------------------------------
%close(fin);


