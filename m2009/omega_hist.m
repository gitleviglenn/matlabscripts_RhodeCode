%nbins=4000;

first_t=708;
last_t=1008;
last_t_weight=last_t;

omega_am2_tr=omega500_am2_mn(first_t:last_t_weight,30:60,:);
omega_am2_tr=omega_am2_tr.*864; % convert from Pa/s to hPa/day
omega_am2_tr_arr=omega_am2_tr(:);
[counts_am2,centers_am2]=hist(omega_am2_tr_arr,nbins);
binwidth=(centers_am2(2)-centers_am2(1));
omega_am2_norm=(counts_am2./length(omega_am2_tr_arr))./binwidth;
figure
plot(centers_am2,omega_am2_norm,'b')
xlim([-100 90])
'sum of omega_am2_norm'
sum(omega_am2_norm)
totalsum=binwidth*sum(omega_am2_norm) % for proper normalization, this should be 1.0

hold on

omega_am3_tr=omega500_am3_mn(first_t:last_t_weight,30:60,:);
omega_am3_tr=omega_am3_tr.*864; % convert from Pa/s to hPa/day
omega_am3_tr_arr=omega_am3_tr(:);
[counts_am3,centers_am3]=hist(omega_am3_tr_arr,nbins);
binwidth=(centers_am3(2)-centers_am3(1));
omega_am3_norm=(counts_am3./length(omega_am3_tr_arr))./binwidth;
plot(centers_am3,omega_am3_norm,'r')
'sum of omega_am3_norm'
sum(omega_am3_norm)
totalsum=binwidth*sum(omega_am3_norm) % for proper normalization, this should be 1.0

omega_am4_tr=omega500_am4_mn(first_t:last_t,60:120,:);
omega_am4_tr=omega_am4_tr.*864; % convert from Pa/s to hPa/day
omega_am4_tr_arr=omega_am4_tr(:);
[counts_am4,centers_am4]=hist(omega_am4_tr_arr,nbins);
binwidth=(centers_am4(2)-centers_am4(1));
omega_am4_norm=(counts_am4./length(omega_am4_tr_arr))./binwidth;
plot(centers_am4,omega_am4_norm,'k')
'sum of omega_am4_norm'
sum(omega_am4_norm)
totalsum=binwidth*sum(omega_am4_norm) % for proper normalization, this should be 1.0

% later period
first_t=1308;
last_t=1608;
last_t_weight=last_t;

omega_am2_tr=omega500_am2_mn(first_t:last_t_weight,30:60,:);
omega_am2_tr=omega_am2_tr.*864; % convert from Pa/s to hPa/day
omega_am2_tr_arr=omega_am2_tr(:);
[counts_am2,centers_am2]=hist(omega_am2_tr_arr,nbins);
binwidth=(centers_am2(2)-centers_am2(1));
omega_am2_norm=(counts_am2./length(omega_am2_tr_arr))./binwidth;
plot(centers_am2,omega_am2_norm,'b','LineStyle','-')
'sum of omega_am2_norm'
sum(omega_am2_norm)
totalsum=binwidth*sum(omega_am2_norm) % for proper normalization, this should be 1.0

omega_am3_tr=omega500_am3_mn(first_t:last_t_weight,30:60,:);
omega_am3_tr=omega_am3_tr.*864; % convert from Pa/s to hPa/day
omega_am3_tr_arr=omega_am3_tr(:);
[counts_am3,centers_am3]=hist(omega_am3_tr_arr,nbins);
binwidth=(centers_am3(2)-centers_am3(1));
omega_am3_norm=(counts_am3./length(omega_am3_tr_arr))./binwidth;
plot(centers_am3,omega_am3_norm,'r')
'sum of omega_am3_norm'
sum(omega_am3_norm)
totalsum=binwidth*sum(omega_am3_norm) % for proper normalization, this should be 1.0

omega_am4_tr=omega500_am4_mn(first_t:last_t,60:120,:);
omega_am4_tr=omega_am4_tr.*864; % convert from Pa/s to hPa/day
omega_am4_tr_arr=omega_am4_tr(:);
[counts_am4,centers_am4]=hist(omega_am4_tr_arr,nbins);
binwidth=(centers_am4(2)-centers_am4(1));
omega_am4_norm=(counts_am4./length(omega_am4_tr_arr))./binwidth;
plot(centers_am4,omega_am4_norm,'k')
'sum of omega_am4_norm'
sum(omega_am4_norm)
totalsum=binwidth*sum(omega_am4_norm) % for proper normalization, this should be 1.0
