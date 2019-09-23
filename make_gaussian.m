function gauss=make_gaussian(timeseries,mu,xgps)

%xgps=1:160;
%mu_s=80;
sigma_s=13;
sigma=std(timeseries);

gauss=exp(-(xgps-mu).^2./(2*sigma^2))./(sigma*sqrt(2*pi));
