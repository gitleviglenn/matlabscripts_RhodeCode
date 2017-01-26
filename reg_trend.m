
% levi silvers                          jan 2017

% endtime and ts_length are defined in openncfile_new.m
% stime=endtime-ts_length+1;

%time=stime:endtime;
%time=1:tlength;
time=1:ts_length;

yvar_period=vartotrend(rstime:rendtime,:,:);

regarray=zeros(nlat,nlon);
for ilon=1:1:nlon
  for ilat=1:1:nlat
    regval=polyfit(time',yvar_period(:,ilat,ilon),1);
    regarray(ilat,ilon)=regval(1);
  end
end

trend_reg=ts_length.*regarray;
regtrend_var_oo=trend_reg.*onlyocean;

%cont_wcolorbar_eisdiff(regtrend_var_oo,regtitle)

%%%contsin=[-5,-4,-3,-2,-1,0,1,2,3,4,5];
%%%caxisin=[-5 5];
%%cont_map_modis(regtrend_var_oo,v.lat,v.lon,contsin,caxisin)
%contourf(regtrend_var_oo)
%colorbar
