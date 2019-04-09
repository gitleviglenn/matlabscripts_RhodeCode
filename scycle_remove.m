function [deseasoned_data]=scycle_remove(seasonal_data,nlat,nlon,nyears)

tlength=nyears*12;

month=repmat(1:12,1,nyears);

latlon=false;
if latlon
  deseasoned_data=zeros(tlength,nlat,nlon);
  for lat=1:1:nlat
    for lon=1:1:nlon
      for k=1:12
        monthlymeans(k)=mean(seasonal_data(month==k,lat,lon));
      end
      for k=1:12
        deseasoned_data(month==k,lat,lon)=seasonal_data(month==k,lat,lon)-monthlymeans(k);
      end
    end
  end
else
  deseasoned_data=zeros(tlength,nlon,nlat);
  for lat=1:1:nlat
    for lon=1:1:nlon
      for k=1:12
        monthlymeans(k)=mean(seasonal_data(month==k,lon,lat));
      end
      for k=1:12
        deseasoned_data(month==k,lon,lat)=seasonal_data(month==k,lon,lat)-monthlymeans(k);
      end
    end
  end
end
