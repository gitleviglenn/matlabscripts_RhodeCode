%----------------------------------------------------------------------
% StreamFun.m
%
% computes mass streamfunction (psi_3, psi_crm_3) for 25km and 2km data
%
% psi depends on: w,u,sphum,temp, and pfull
%
% psi is computed as: psi(rho,w,u)=dx*rho(i,j)*w_ztmn(i,j)+u_bc_p;
% 
% The density rho is computed with the virtual temperature Tv
% rho(i,j)=pfull(j)/(r_dry*Tv(i,j));
% Tv=temp_ztmn.*(1+sphum_ztmn./epsilon)./(1+sphum_ztmn);
% where sphum referes to the specific humidity
%
% The boundary condition in u is: 
%      u_bc_p=sum(u_bc); --> sum over vertical levels where u_bc is:
%      u_bc(jj)=(1/grav)*u_ztmn(i,jj)*(pfull(jj)-pfull(jj-1));
%
% It is likely that for the 25km experiments there will be an additional 
% time dimension compared to the 1km and 2km experiments.  Create a 
% driver script that calls this one.  
% In the driver before calling StreamFunNew define the following:
%   source_psi
%   con_stream
%   dx_gen
%   x_ngp_gen
%   title ; to indicate which resolution streamfunction is being plotted
%
% for the 6 variables below it is likely that a time average will
% need to be done before StreamFunNew is called
%   w_gen
%   u_gen
%   sphum_gen
%   temp_gen
%   pfull_gen
%
% levi silvers                                               june 2018
%----------------------------------------------------------------------
%path_base='/Users/silvers/data/WalkerCell/'

%% define colors
colyel=[0.9290,0.6940,0.1250];  % 25km 
colblu=[0.3010,0.7450,0.9330];  % 2km
colgrn=[0.4660,0.6740,0.1880];  % 1km


% constant added to the streamfunction
%con_stream=2000.;

%% specific parameters
%%%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c96L33_am4p0_10x4000_nh_1km_wlkr_4K/19790601.atmos_month_psivars.nc');
%%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c96L33_am4p0_10x4000_nh_1km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c10x4000L33_am4p0_1km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
%dx_gen=1000.; % grid cell size in meters
%x_ngp_gen=4000; % width of domain in grid points

%source_psi=strcat('/Users/silvers/data/WalkerCell/gauss_d/c50x2000L33_am4p0_2km_wlkr_4K/1979.mn3456.atmos_month_psivars.tmn.nc');
%dx_gen=2000.; % grid cell size in meters
%x_ngp_gen=2000; % width of domain in grid points
%tit_id=' 2km'

%% dimensions for the 1km run are: xdim,ydim,zdim, no time dimension
%w_gen=ncread(source_psi,'w');
%u_gen=ncread(source_psi,'ucomp');
%sphum_gen=ncread(source_psi,'sphum');
%temp_gen=ncread(source_psi,'temp');
%pfull_gen=ncread(source_psi,'pfull');
%pfull_gen=100.*pfull_gen;

% this generalization will not work if the incoming data has not already been time averaged...

%gridspac=2

% if using a 1km or 2km resolution...
if gridspac < 10
	start_tim=2;
        end_tim=6;
% incoming data should have xdim ydim zdim
  w_gen=ncread(source_psi,'w');
  u_gen=ncread(source_psi,'ucomp');
  sphum_gen=ncread(source_psi,'sphum');
  temp_gen=ncread(source_psi,'temp');
  pfull_gen=ncread(source_psi,'pfull');
  w_gen=w_gen(:,:,:,start_tim:end_tim);
  u_gen=u_gen(:,:,:,start_tim:end_tim);
  sphum_gen=sphum_gen(:,:,:,start_tim:end_tim);
  temp_gen=temp_gen(:,:,:,start_tim:end_tim);
% else if using a start_tim5km resolution...
  'grid spacing is less than 10km '
else % grid spacing is greater than 10 km 
  an_t1=1;
  an_t2=4
  w_25km=ncread(source_psi,'w');
  u_25km=ncread(source_psi,'ucomp');
  sphum_25km=ncread(source_psi,'sphum');
  temp_25km=ncread(source_psi,'temp');
  pfull_25km=ncread(source_psi,'pfull');
% incoming data should have xdim ydim zdim tdim
% compute the time average...
% the _gen variables should have xdim ydim zdim
% w_gen=w_25km_zmn
  u_25km_eq=u_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  u_25km_tmn=squeeze(mean(u_25km_eq,4)); % time mean
  u_gen=u_25km_tmn;

  w_25km_eq=w_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  w_25km_tmn=squeeze(mean(w_25km_eq,4)); % time mean
  w_gen=w_25km_tmn;

  sphum_25km_eq=sphum_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  sphum_25km_tmn=squeeze(mean(sphum_25km_eq,4)); % time mean
  sphum_gen=sphum_25km_tmn;

  temp_25km_eq=temp_25km(:,:,:,an_t1:an_t2); % grab equilibrated period
  temp_25km_tmn=squeeze(mean(temp_25km_eq,4)); % time mean
  temp_gen=temp_25km_tmn;

  pfull_gen=pfull_25km;
  'grid spacing is more than 10km '
end 

pfull_gen=100.*pfull_gen;

% compute the zonal mean of incoming data
temp_gen_ztmn=squeeze(mean(temp_gen,2));
sphum_gen_ztmn=squeeze(mean(sphum_gen,2));
u_gen_ztmn=squeeze(mean(u_gen,2));
w_gen_ztmn=squeeze(mean(w_gen,2));

%pfull_25km=100.*pfull_25km; % convert to Pa
%pfull_2km=100.*pfull_2km; % convert to Pa

% these should be defined in compTheta.m
%r_dry=287.; % J/kg K
%epsilon=0.622;
%grav=9.81; % m/s2
%a_earth=6350000; % m   lower bound on Earth's radius

clear rho_gen
Tv_gen=temp_gen_ztmn.*(1+sphum_gen_ztmn./epsilon)./(1+sphum_gen_ztmn);
for j=33:-1:1
    for i=1:x_ngp_gen
        rho_gen(i,j)=pfull_gen(j)/(r_dry*Tv_gen(i,j));
    end
end

%psi_gen=zeros(x_ngp_gen,33);
%
%u_bc(1)=(1/grav)*u_gen_ztmn(1,1)*(pfull_gen(2)-pfull_gen(1));
%
%for j=33:-1:2
%    psi_gen(1,j)=psi_gen(x_ngp_gen,j)-dx_gen.*rho_gen(1,j)*w_gen_ztmn(1,j);
%    for i=2:x_ngp_gen
%        % compute the boundary condition u_bc_p
%      u_bc=zeros(33,1);
%      for jj=33:-1:j 
%         %u_bc(jj)=(1/grav)*u_gen_ztmn(i,jj)*(pfull_gen(jj)-pfull_gen(jj-1));
%         u_bc(jj)=(1/(grav*rho_gen(i,j)))*u_gen_ztmn(i,jj)*(pfull_gen(jj)-pfull_gen(jj-1));
%      end
%      u_bc_p=sum(u_bc);
%        %%psi_crm_3(i+1,j)=psi_crm_3(i-1,j)-2*dx_crm.*rho_2km(i,j)*w_2km_ztmn(i,j);
%        %psi_gen(i,j)=dx_gen*rho_gen(i,j)*w_gen_ztmn(i,j)...
%        %    +u_bc_p;
%        psi_gen(i,j)=dx_gen*rho_gen(i,j)*w_gen_ztmn(i,j)...
%            +u_bc_p;
%    end
%end

% compute streamfunction by integrating the zonal velocity
clear psi_gen
psi_gen=zeros(x_ngp_gen,33)+con_stream;
for i=1:x_ngp_gen
    for jj=1:32
        %psi_gen(i,jj+1)=psi_gen(i,jj)-(u_gen_ztmn(i,jj+1)/(grav*rho_gen(i,jj+1)))*(pfull_gen(jj+1)-pfull_gen(jj));
        psi_gen(i,jj+1)=psi_gen(i,jj)-u_gen_ztmn(i,jj+1)*(pfull_gen(jj+1)-pfull_gen(jj));
    end
end

%%% % 
%figure
%subplot(1,3,3)
%%stream_cons=[-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.];
%stream_cons=[-9000.,-8000.,-7000.,-6000.,-5000.,-4000.,-3000.,-2000.,-1000.,0.0,1000.,2000.,3000.,4000.,5000.,6000.,7000.,8000.,9000.];
%[C,h]=contourf(1:xgcm_ngp,pfull_25km,psi_3',stream_cons);
%v=[-7000,-5000,-3000,-2000,-1000,0,1000,3000,5000,7000]; % if labels are desired on contours
%clabel(C,h,v);
%title('GCM mass streamfunction')
%set(gca,'Ydir','reverse')
%
%subplot(1,3,2)
%[C,h]=contourf(1:xcrm_ngp,pfull_2km,psi_crm_3',stream_cons);
%clabel(C,h,v);
%title('2km CRM mass streamfunction')
%set(gca,'Ydir','reverse')
%
%subplot(1,3,1)
%[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
%clabel(C,h,v);
%title('1km CRM mass streamfunction')
%set(gca,'Ydir','reverse')
%
%
%tit_str=strcat('Streamfunction: ',tit_st);
%suptitle(tit_str)

figure
%scale2m2=625e6;
%scale2mass=a_earth*grav;
scale_cons=1; % this worked well with 25km grid spacing
normscale=1e11; % this worked well with 25km grid spacing
scale2mass=a_earth/grav;
normfac=1/normscale;
psi_gen=normfac.*scale2mass.*psi_gen;
stream_convals=[-.5,-.45,-.4,-.35,-.3,-.25,-.2,-.15,-.1,-.05,0.0,.05,.1,.15,.20,.25,.3,.35,.4,.45,.5];
%stream_convals=[-.05,-.045,-.04,-.035,-.03,-.025,-.02,-.015,-.01,-.005,0.0,.005,.01,.015,.020,.025,.03,.035,.04,.045,.05];
%stream_convals=[-5,-4.5,-4,-3.5,-3,-2.5,-2.,-1.5,-1,-.5,0.0,.5,1,1.5,2.,2.5,3,3.5,4,4.5,5];
stream_cons=scale_cons.*stream_convals;
[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
%v=[-3000,-2000,-1000,0,1000,2000,3000]; % if labels are desired on contours
%v=stream_cons;
v=scale_cons*stream_convals;
clabel(C,h,v);
tit_str=strcat('mass Streamfunction: ',tit_id);
title(tit_str)
set(gca,'Ydir','reverse')

figure2=figure
tit_str=strcat('mass Streamfunction: ',tit_id);     
title(tit_str)    
axes2 = axes('Parent',figure2,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
    %'Position',[0.0415407854984894 0.10385253115539 0.86345921450151 0.753622122086883]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');

[C,h]=contourf(1:x_ngp_gen,pfull_gen,psi_gen',stream_cons);
clabel(C,h,v);               

figure3=figure
tit_str=strcat('Vertical Velocity: ');     
title(tit_str)    
axes3 = axes('Parent',figure3,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
    %'Position',[0.0415407854984894 0.10385253115539 0.86345921450151 0.753622122086883]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes3,[10000 100000]);
box(axes3,'on');
hold(axes3,'on');

vvel_convals=[-0.1,-0.05,-0.04,-0.03,-0.02,-0.01,0.0,.01,.02,.03,.04,.05,.1];
vvel_cons=scale_cons.*vvel_convals;

[C,h]=contourf(1:160,pfull_gen,w_25km_ztmn',vvel_cons);
clabel(C,h,v);               
colorbar

%%% take the average of the center half of the domain
%w_25km_center=w_25km_ztmn(40:120,:); % 80
%w_25km_center_mn=mean(w_25km_center,1);
%w_2km_center=w_2km_ztmn(500:1500,:); % 1000
%w_2km_center_mn=mean(w_2km_center,1);
%w_1km_center=w_1km_ztmn(1000:3000,:); % 2000
%w_1km_center_mn=mean(w_1km_center,1);

%% take the average of the center fourth of the domain
%%w_25km_center=w_25km_ztmn(80:120,:); % dependent on experiment!!
%w_25km_center=w_25km_ztmn(60:100,:); % dependent on experiment!!
%w_25km_center_mn=mean(w_25km_center,1);
%w_2km_center=w_2km_ztmn(750:1250,:);
%w_2km_center_mn=mean(w_2km_center,1);
%w_1km_center=w_1km_ztmn(1500:2500,:); % 1000
%w_1km_center_mn=mean(w_1km_center,1);

%% take the average of the center tenth of the domain
w_25km_center=w_25km_ztmn(80:120,:); % dependent on experiment!!
w_25km_center_mn=mean(w_25km_center,1);
w_2km_center=w_2km_ztmn(900:1100,:);
w_2km_center_mn=mean(w_2km_center,1);
w_1km_center=w_1km_ztmn(1800:2200,:); % 1000
w_1km_center_mn=mean(w_1km_center,1);

% take the average of subsiding region of the domain
w_25km_sub=w_25km_ztmn(1:40,:); % dependent on experiment!!
w_25km_sub_mn=mean(w_25km_sub,1);
w_2km_sub=w_2km_ztmn(1:500,:);
w_2km_sub_mn=mean(w_2km_sub,1);
w_1km_sub=w_1km_ztmn(1:1000,:); 
w_1km_sub_mn=mean(w_1km_sub,1);

figure
plot(w_25km_center_mn,pfull_gen,'Color',colyel)
set(gca,'Ydir','reverse')
hold on
plot(w_25km_sub_mn,pfull_gen,'--','Color',colyel)
plot(w_2km_center_mn,pfull_gen,'Color',colblu)
plot(w_2km_sub_mn,pfull_gen,'--','Color',colblu)
plot(w_1km_center_mn,pfull_gen,'Color',colgrn)
plot(w_1km_sub_mn,pfull_gen,'--','Color',colgrn)
title('vertical velocity: mn and sub region(--)')




