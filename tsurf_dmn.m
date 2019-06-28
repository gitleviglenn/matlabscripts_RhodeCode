function temp_sfc_gen = tsurf_dmn(ens,latin1,latin2,do_fig)
%--------------------------------------------------------------------------------------- 
% assume a variable with two spatial dimensions that varies in time.
%
% apply glb lat weights
%
% apply the land-sea mask from am4
%
% deseasonalize
%
% compute the domain mean average over specified range of latitudes
%
% e.g. for no figure: temp_ens1_pm60=tsurf_dmn('ens1',30,150,0);
% e.g. with figure:   temp_ens1_pm60=tsurf_dmn('ens1',30,150,1);
%
% levi silvers                                                             june 2019
%--------------------------------------------------------------------------------------- 

%source_fl='/Users/silvers/data/amip_long/AM4/ens2/atmos.187001-201412.t_surf.nc';
source_fl=strcat('/Users/silvers/data/amip_long/AM4/',ens,'/atmos.187001-201412.t_surf.nc');

tsfc=ncread(source_fl,'t_surf');

%vlon=size(tsfc,1);
vlon=ncread(source_fl,'lon');
vlat=ncread(source_fl,'lat');
%vlat=size(tsfc,2);
global_weights;
% put this in a loop to creat a time series of cosine weighted data
endtime=1740;
nyears=endtime/12;
nyears_n=1724/12;
monthint=1/12;
years=1860.0833:monthint:1860+nyears;
years_n=1860.75:monthint:1860.6667+nyears_n; % time series starting eight months later (app for 2 running_mean apps)
month=repmat(1:12,1,nyears);

latit_gen  =vlat(latin1:latin2)';
latit_pm =cos(double(pi)/180*latit_gen);

for index=1:endtime;
  temp                      =squeeze(tsfc(:,:,index))';
  %tsf_nol(:,:,index)        =nanland(tsfc(:,:,index)');
  tsf_nol(:,:,index)        =nanland(temp');
  temppm                    =squeeze(tsfc(:,latin1:latin2,index))';
  temppm_nol                =squeeze(tsf_nol(:,latin1:latin2,index))';
  temp_sfc_pm(index)        =mean(latit_gen*temppm,2)/sum(latit_pm);
  temp_sfc_nol_pm(index)    =mean(latit_gen*temppm_nol,2,'omitnan')/sum(latit_pm);
end
%  temp_nol                  =nanland(temp');

month=repmat(1:12,1,nyears);

for k=1:12
  monthlymeans(k)      =mean(temp_sfc_pm(month==k));
  monthlymeans_nol(k)  =mean(temp_sfc_nol_pm(month==k));
end
for k=1:12
  temp_sfc_gen_nos(month==k) =temp_sfc_pm(month==k)-monthlymeans(k);
  temp_sfc_gen_nols(month==k)=temp_sfc_nol_pm(month==k)-monthlymeans_nol(k);
end

tendindex=endtime;
incoming_ts=temp_sfc_gen_nos;
running_mean
temp_sfc_gen_nos_a=output_ts;
tendindex=endtime-8;
incoming_ts=temp_sfc_gen_nos_a;
running_mean
temp_sfc_gen=output_ts;

tendindex=endtime;
incoming_ts=temp_sfc_gen_nols;
running_mean
temp_sfc_gen_nols_a=output_ts;
tendindex=endtime-8;
incoming_ts=temp_sfc_gen_nols_a;
running_mean
temp_sfc_nol_gen=output_ts;

if(do_fig)
figure
plot(years_n,temp_sfc_gen)
ylim([-30 60])
hold on
plot(years_n,temp_sfc_nol_gen,'k')

end

