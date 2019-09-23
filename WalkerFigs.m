%----------------------------------------------------------------------------
% basically a driver script that relies on fields computed in WalkerCell.m to 
% create a variety of figures
%
% levi silvers                               jan 2019
%----------------------------------------------------------------------------

colyel=[0.9290,0.6940,0.1250];  % used for 25km runs
colblu=[0.3010,0.7450,0.9330];  % 2 km runs
colgrn=[0.4660,0.6740,0.1880];  % 1 km runs


%rh_tmp_arr       =zeros(5,33);
%rh_sub_arr       =zeros(5,33);
%ice_prof_arr     =zeros(5,33);
%liq_prof_arr     =zeros(5,33);
%gam_arr          =zeros(5,33);
%gam_m_arr        =zeros(5,33);
%rad_prof_arr     =zeros(5,33);
%tdtconv_prof_arr =zeros(5,33);
%tdtls_prof_arr   =zeros(5,33);
%stap_arr         =zeros(5,33);
%th_e_gcm_arr     =zeros(5,33);
%th_gcm_arr       =zeros(5,33);


xcrm_2to1=0:2:3998;
xaxis_gcm2crm=0:25:3975;

% figure with lwcre
lwoff = true;

% for the lwoff switch to work the model needs to be run with the lwoff path names
% which are set in the WalkerCell script.  Then the resulting data needs to be 
% saved to the appropriate arrays to be plotted as lwoff, as below.  Then the paths
% must be changed back to the control experiment and rerun. 

%evap_25km_ztmn_lwoff=evap_25km_ztmn;
%evap_2km_ztmn_lwoff=evap_2km_ztmn;
%evap_1km_ztmn_lwoff=evap_1km_ztmn;
%q_25km_ztmn_lwoff=q_25km_ztmn;
%q_2km_ztmn_lwoff=q_2km_ztmn;
%q_1km_ztmn_lwoff=q_1km_ztmn;
%u_25km_ztmn_lwoff=u_25km_ztmn;
%u_2km_ztmn_lwoff=u_2km_ztmn;
%u_1km_ztmn_lwoff=u_1km_ztmn;
%theta_e_gcm_lwoff=theta_e_gcm;
%theta_e_crm2_lwoff=theta_e_crm2;
%theta_e_crm1_lwoff=theta_e_crm1;
%temp_eq_ztmn_lwoff=temp_eq_ztmn;
%temp_crm1_ztmn_lwoff=temp_crm1_ztmn;
%temp_crm_ztmn_lwoff=temp_crm_ztmn;
%Tv_1km_lwoff=Tv_1km;
%Tv_2km_lwoff=Tv_2km;
%Tv_25km_lwoff=Tv_25km;
%u_1km_dmn_lwoff=u_1km_dmn;
%u_2km_dmn_lwoff=u_2km_dmn;
%u_25km_dmn_lwoff=u_25km_dmn;
%

%-------------------------------------(*&()*&(*&)(*&)(*&
% save data from particular experiments so that it can be 
% plotted on the same figure

% to get the full figure, this code will need to be run 4 times
% each time switching the value of ind in WalkerCell.m

%if ind==3; % control
%  evap_25km_ztmn_ctl=evap_25km_ztmn;
%  theta_e_gcm_ctl   =theta_e_gcm;
%  q_25km_ztmn_ctl   =q_25km_ztmn;
%  u_25km_ztmn_ctl   =u_25km_ztmn;
%  temp_eq_ztmn_ctl  =temp_eq_ztmn;
%  Tv_25km_ctl       =Tv_25km;
%  u_25km_dmn_ctl    =u_25km_dmn;
%  s_enth_25km_ctl   =s_enth_25km;
%  % below is for high resolution experiments
%  evap_2km_ztmn_ctl =evap_2km_ztmn;
%  evap_1km_ztmn_ctl =evap_1km_ztmn;
%  s_enth_2km_ctl    =s_enth_2km;
%  s_enth_1km_ctl    =s_enth_1km;
%  q_2km_ztmn_ctl    =q_2km_ztmn;
%  q_1km_ztmn_ctl    =q_1km_ztmn;
%  theta_e_crm2_ctl  =theta_e_crm2;
%  theta_e_crm1_ctl  =theta_e_crm1;
%  temp_crm1_ztmn_ctl=temp_crm1_ztmn;
%  temp_crm_ztmn_ctl =temp_crm_ztmn;
%  Tv_1km_ctl        =Tv_1km;
%  Tv_2km_ctl        =Tv_2km;
%  u_1km_dmn_ctl     =u_1km_dmn;
%  u_2km_dmn_ctl     =u_2km_dmn;
%elseif (ind==1)
%  evap_25km_ztmn_noconv=evap_25km_ztmn;
%  theta_e_gcm_noconv=theta_e_gcm;
%  q_25km_ztmn_noconv=q_25km_ztmn;
%  u_25km_ztmn_noconv=u_25km_ztmn;
%  temp_eq_ztmn_noconv=temp_eq_ztmn;
%  Tv_25km_noconv=Tv_25km;
%  u_25km_dmn_noconv=u_25km_dmn;
%  s_enth_25km_noconv   =s_enth_25km;
%elseif (ind==2)  % lwoff
%  evap_25km_ztmn_lwoff=evap_25km_ztmn;
%  theta_e_gcm_lwoff=theta_e_gcm;
%  q_25km_ztmn_lwoff=q_25km_ztmn;
%  u_25km_ztmn_lwoff=u_25km_ztmn;
%  temp_eq_ztmn_lwoff=temp_eq_ztmn;
%  Tv_25km_lwoff=Tv_25km;
%  u_25km_dmn_lwoff=u_25km_dmn;
%  s_enth_25km_lwoff   =s_enth_25km;
%  % below is for high resolution experiments
%  evap_2km_ztmn_lwoff =evap_2km_ztmn;
%  evap_1km_ztmn_lwoff =evap_1km_ztmn;
%  s_enth_2km_lwoff    =s_enth_2km;
%  s_enth_1km_lwoff    =s_enth_1km;
%  q_2km_ztmn_lwoff    =q_2km_ztmn;
%  q_1km_ztmn_lwoff    =q_1km_ztmn;
%  theta_e_crm2_lwoff  =theta_e_crm2;
%  theta_e_crm1_lwoff  =theta_e_crm1;
%  temp_crm1_ztmn_lwoff=temp_crm1_ztmn;
%  temp_crm_ztmn_lwoff =temp_crm_ztmn;
%  Tv_1km_lwoff        =Tv_1km;
%  Tv_2km_lwoff        =Tv_2km;
%  u_1km_dmn_lwoff     =u_1km_dmn;
%  u_2km_dmn_lwoff     =u_2km_dmn;
%elseif (ind==4)
%  evap_25km_ztmn_noconvlwoff =evap_25km_ztmn;
%  theta_e_gcm_noconvlwoff    =theta_e_gcm;
%  q_25km_ztmn_noconvlwoff    =q_25km_ztmn;
%  u_25km_ztmn_noconvlwoff    =u_25km_ztmn;
%  temp_eq_ztmn_noconvlwoff   =temp_eq_ztmn;
%  Tv_25km_noconvlwoff        =Tv_25km;
%  u_25km_dmn_noconvlwoff     =u_25km_dmn;
%  s_enth_25km_noconvlwoff    =s_enth_25km;
%end

thin=0.5;
thick=2;

  figure
  subplot(2,2,1)
  plot(xcrm_2to1,s_enth_2km,'Color',colblu,'LineWidth',thick)
  hold on
  plot(xcrm_2to1,s_enth_2km_lwoff,'Color',colblu,'LineWidth',thin)
  plot(s_enth_1km,'Color',colgrn,'LineWidth',thick)
  plot(s_enth_1km_lwoff,'Color',colgrn,'LineWidth',thin)
%  plot(xaxis_gcm2crm,s_enth_25km,'Color',colyel,'LineWidth',thin)
%  plot(xaxis_gcm2crm,s_enth_25km_lwoff,'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,s_enth_25km_noconvlwoff,'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,s_enth_25km_noconv,'Color',colyel,'LineWidth',thick)
  ylabel('W/m2')
  xlabel('km')
  title('Surface Enthalpy Flux')
  
  subplot(2,2,2)
  plot(xcrm_2to1,theta_e_crm2(:,33),'Color',colblu,'LineWidth',thick)
  hold on
  plot(xcrm_2to1,theta_e_crm2_lwoff(:,33),'--','Color',colblu,'LineWidth',thin)
  plot(theta_e_crm1(:,33),'Color',colgrn,'LineWidth',thick)
  plot(theta_e_crm1_lwoff(:,33),'--','Color',colgrn,'LineWidth',thin)
%  plot(xaxis_gcm2crm,theta_e_gcm(:,33),'Color',colyel,'LineWidth',thin)
%  plot(xaxis_gcm2crm,theta_e_gcm_lwoff(:,33),'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,theta_e_gcm_noconvlwoff(:,33),'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,theta_e_gcm_noconv(:,33),'Color',colyel,'LineWidth',thick)
  ylabel('K')
  xlabel('km')
  title('equivalent theta')
  
  subplot(2,2,3)
  plot(u_1km_ztmn(:,33),'Color',colgrn,'LineWidth',thick)
  hold on
  plot(u_1km_dmn_lwoff(:,33),'Color',colgrn,'LineWidth',thin)
  title('u wind at 33, lowest atm level')
  plot(xcrm_2to1,u_2km_ztmn(:,33),'Color',colblu,'LineWidth',thick)
  plot(xcrm_2to1,u_2km_dmn_lwoff(:,33),'Color',colblu,'LineWidth',thin)
%  plot(xaxis_gcm2crm,u_25km_ztmn(:,33),'Color',colyel,'LineWidth',thin)
%  plot(xaxis_gcm2crm,u_25km_ztmn_lwoff(:,33),'Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,u_25km_ztmn_noconvlwoff(:,33),'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,u_25km_ztmn_noconv(:,33),'Color',colyel,'LineWidth',thick)
  xlabel('km')
  ylabel('m/s')
  
  subplot(2,2,4)
  plot(u_1km_dmn(10:33),zzfull(10:33),'Color',colgrn,'LineWidth',thick)
  hold on
  plot(u_1km_dmn_lwoff(10:33),zzfull(10:33),'Color',colgrn,'LineWidth',thin)
  plot(u_2km_dmn(10:33),zzfull(10:33),'Color',colblu,'LineWidth',thick)
  plot(u_2km_dmn_lwoff(10:33),zzfull(10:33),'Color',colblu,'LineWidth',thin)
%  plot(u_25km_dmn(10:33),zzfull(10:33),'Color',colyel,'LineWidth',thin)
%  plot(u_25km_dmn_lwoff(10:33),zzfull(10:33),'--','Color',colyel,'LineWidth',thin)
  plot(u_25km_dmn_noconvlwoff(10:33),zzfull(10:33),'--','Color',colyel,'LineWidth',thin)
  plot(u_25km_dmn_noconv(10:33),zzfull(10:33),'Color',colyel,'LineWidth',thick)
  xlabel('m/s')
  ylabel('height (m)')
  ylim([0 16000])

  %  end of 4 panel figure for low-level variables
%-------------------------------------(*&()*&(*&)(*&)(*&


% a few computation before makeing figures...
rh_25km_ind=hur_25km_ztmn;
rh_25km_sub_a=rh_25km_ind(1:40,:);
rh_25km_sub=squeeze(mean(rh_25km_sub_a,1));
rh_25km_tmp=squeeze(mean(rh_25km_ind,1));

hur_crm=mean(hur_2km_ztmn,1);
hur_crm_sub_a=hur_2km_ztmn(1:500,:);
hur_crm_sub=squeeze(mean(hur_crm_sub_a,1));
hur_crm_1km=mean(hur_1km_ztmn,1);
hur_crm_1km_sub_a=hur_1km_ztmn(1:1000,:);
hur_crm_1km_sub=mean(hur_crm_1km_sub_a,1);

%rh_tmp=rh_25km_tmp;
%rh_sub=rh_25km_sub;
%ice_prof=ice_25km_prof;
%liq_prof=liq_25km_prof;
%gam=gamma(1,:);
%gam_m=gamma_m(1,:);
%rad_prof=rad_heat_prof_25;
%tdtconv_prof=tdtconv_25km_prof;
%tdtls_prof=tdtls_25km_prof;
%stap=stastapar;
%th_e_gcm=theta_e_gcm_mid;
%th_gcm=theta_gcm;

% Specify the averaging region-------------------------------
  stasta_dmn=mean(staticst_par_25km,1);
plotDomainM  = false
plotCentralM = true
plotSubM     = false
% compute domain mean values for theta:
if plotDomainM
  theta_e_dmn=mean(theta_e_gcm,1);
  theta_dmn=mean(theta_gcm,1);
  stasta_dmn=mean(staticst_par_25km,1);
end
% compute the mean over the central quarter of the domain:
if plotCentralM
  x1=60;
  x2=100;
  theta_e_cent=theta_e_gcm(x1:x2,:);
  theta_e_dmn=mean(theta_e_cent,1);
  theta_cent=theta_gcm(x1:x2,:);
  theta_dmn=mean(theta_cent,1);
  %stasta_dmn=mean(staticst_par_25km,1);
end
% compute the mean over the outer quarter of the domain:
if plotSubM
  x1=1;
  x2=40;
  theta_e_sub=theta_e_gcm(x1:x2,:);
  theta_e_dmn=mean(theta_e_sub,1);
  theta_sub=theta_gcm(x1:x2,:);
  theta_dmn=mean(theta_sub,1);
  %stasta_dmn=mean(staticst_par_25km,1);
end
% End Specify the averaging region-------------------------------


% arr_ind=1 should correspond to the case with fully parameterized convection
% arr_ind=2 should correspond to the case with no parameterized convection
%arr_ind=1; % should be set in WalkerCell.m where the type of simulation is set. 

rh_tmp_arr(arr_ind,:)=rh_25km_tmp;
rh_sub_arr(arr_ind,:)=rh_25km_sub;
ice_prof_arr(arr_ind,:)=ice_25km_prof;
liq_prof_arr(arr_ind,:)=liq_25km_prof;
gam_arr(arr_ind,:)=gamma(1,:);
gam_asc_arr(arr_ind,:)=gamma_asc(1,:);
gam_m_arr(arr_ind,:)=gamma_m(1,:);
rad_prof_arr(arr_ind,:)=rad_heat_prof_25;
tdtconv_prof_arr(arr_ind,:)=tdtconv_25km_prof;
tdtls_prof_arr(arr_ind,:)=tdtls_25km_prof;
%stap_arr(arr_ind,:)=stastapar(1,:);
stap_arr(arr_ind,:)=stasta_dmn;
%th_e_gcm_arr(arr_ind,:)=theta_e_gcm_mid; % theta_e_gcm has dims of 160:33; theta_e_gcm_mid dims of 33
%th_gcm_arr(arr_ind,:)=theta_gcm(100,:);  % theta_gcm has dims of 160:33 and is computed in compTheta.m
th_e_gcm_arr(arr_ind,:)=theta_e_dmn; % theta_e_gcm has dims of 160:33; theta_e_gcm_mid dims of 33
th_gcm_arr(arr_ind,:)=theta_dmn;  % theta_gcm has dims of 160:33 and is computed in compTheta.m

linesize=2;
colnoconv=colblu;


%---------------------------------------------------------------------------------------
% now begin the making of figures.........
%---------------------------------------------------------------------------------------
figure
plot(xgcm(1:xgcm_ngp),evap_25km_en_ztmn,'--','Color',colyel,'LineWidth',1);
hold on
plot(xcrm(1:xcrm_ngp),evap_2km_en_ztmn,'--','Color',colblu,'LineWidth',1);
plot(xcrm_1km(1:xcrm_1km_ngp),evap_1km_en_ztmn,'--','Color',colgrn,'LineWidth',1);
plot(xgcm(1:xgcm_ngp),sh_25km_ztmn,'--','Color',colyel,'LineWidth',1);
plot(xcrm_1km(1:xcrm_1km_ngp),sh_1km_ztmn,'--','Color',colgrn,'LineWidth',1);
plot(xcrm(1:xcrm_ngp),sh_2km_ztmn,'--','Color',colblu,'LineWidth',1);
plot(xgcm(1:xgcm_ngp),s_enth_25km,'Color',colyel,'LineWidth',1.5);
plot(xcrm(1:xcrm_ngp),s_enth_2km,'Color',colblu,'LineWidth',1.5);
plot(xcrm_1km(1:xcrm_1km_ngp),s_enth_1km,'Color',colgrn,'LineWidth',1.5);
title('Surface Enthalpy FLux: LWCRE on: Exp Conv')


if lwoff 

  thin=0.5;

  figure
  subplot(2,3,1)
  plot(xcrm_2to1,evap_2km_ztmn,'Color',colblu,'LineWidth',1.5)
  hold on
  plot(xcrm_2to1,evap_2km_ztmn_lwoff,'Color',colblu,'LineWidth',thin)
  plot(evap_1km_ztmn,'Color',colgrn,'LineWidth',1.5)
  plot(evap_1km_ztmn_lwoff,'Color',colgrn,'LineWidth',thin)
  plot(xaxis_gcm2crm,evap_25km_ztmn,'Color',colyel,'LineWidth',1.5)
  plot(xaxis_gcm2crm,evap_25km_ztmn_lwoff,'Color',colyel,'LineWidth',thin)
%  plot(xaxis_gcm2crm,evap_25km_ztmn_noconvlwoff,'-.','Color',colyel)
  title('evaporation')
  
  subplot(2,3,2)
  plot(xcrm_2to1,theta_e_crm2(:,33),'Color',colblu,'LineWidth',1.5)
  hold on
  plot(xcrm_2to1,theta_e_crm2_lwoff(:,33),'--','Color',colblu,'LineWidth',thin)
  plot(theta_e_crm1(:,33),'Color',colgrn,'LineWidth',1.5)
  plot(theta_e_crm1_lwoff(:,33),'--','Color',colgrn,'LineWidth',thin)
  plot(xaxis_gcm2crm,theta_e_gcm(:,33),'Color',colyel,'LineWidth',1.5)
  plot(xaxis_gcm2crm,theta_e_gcm_lwoff(:,33),'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,theta_e_gcm_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',1.5)
  title('equivalent theta')
  
  subplot(2,3,3)
  plot(q_1km_ztmn(:,33),'Color',colgrn,'LineWidth',1.5)
  hold on
  title('q at 33, lowest atm level')
  plot(q_1km_ztmn_lwoff(:,33),'--','Color',colgrn,'LineWidth',thin)
  plot(xcrm_2to1,q_2km_ztmn(:,33),'Color',colblu,'LineWidth',1.5)
  plot(xcrm_2to1,q_2km_ztmn_lwoff(:,33),'--','Color',colblu,'LineWidth',thin)
  plot(xaxis_gcm2crm,q_25km_ztmn(:,33),'Color',colyel,'LineWidth',1.5)
  plot(xaxis_gcm2crm,q_25km_ztmn_lwoff(:,33),'--','Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,q_25km_ztmn_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',1.5)
  
  subplot(2,3,4)
  plot(u_1km_ztmn(:,33),'Color',colgrn,'LineWidth',1.5)
  hold on
%  plot(-u_1km_ztmn(:,33),'Color',colgrn,'LineWidth',1.5)
  plot(u_1km_dmn_lwoff(:,33),'Color',colgrn,'LineWidth',thin)
%  plot(-u_1km_ztmn_lwoff(:,33),'--','Color',colgrn,'LineWidth',1.5)
  title('u wind at 33, lowest atm level')
  plot(xcrm_2to1,u_2km_ztmn(:,33),'Color',colblu,'LineWidth',1.5)
  plot(xcrm_2to1,u_2km_dmn_lwoff(:,33),'Color',colblu,'LineWidth',thin)
%  plot(xcrm_2to1,-u_2km_ztmn(:,33),'Color',colblu,'LineWidth',1.5)
%  plot(xcrm_2to1,-u_2km_ztmn_lwoff(:,33),'Color',colblu,'LineWidth',1.5)
  plot(xaxis_gcm2crm,u_25km_ztmn(:,33),'Color',colyel,'LineWidth',1.5)
  plot(xaxis_gcm2crm,u_25km_ztmn_lwoff(:,33),'Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,u_25km_ztmn_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',1.5)
%  plot(xaxis_gcm2crm,-u_25km_ztmn(:,33),'Color',colyel,'LineWidth',1.5)
%  plot(xaxis_gcm2crm,-u_25km_ztmn_lwoff(:,33),'Color',colyel,'LineWidth',1.5)
%  plot(xaxis_gcm2crm,-u_25km_ztmn_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',1.5)
  
  subplot(2,3,5)
  plot(tsurf_crm1_ztmn,'k','LineWidth',1.5)
  hold on
  plot(temp_crm1_ztmn(:,33),'Color',colgrn,'LineWidth',1.5)
  plot(temp_crm1_ztmn_lwoff(:,33),'Color',colgrn,'LineWidth',thin)
  plot(xcrm_2to1,temp_crm_ztmn(:,33),'Color',colblu,'LineWidth',1.5)
  plot(xcrm_2to1,temp_crm_ztmn_lwoff(:,33),'Color',colblu,'LineWidth',thin)
  plot(xaxis_gcm2crm,temp_eq_ztmn(:,33),'Color',colyel,'LineWidth',1.5)
  plot(xaxis_gcm2crm,temp_eq_ztmn_lwoff(:,33),'Color',colyel,'LineWidth',thin)
  plot(xaxis_gcm2crm,temp_eq_ztmn_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',1.5)
  plot(Tv_1km(:,33),'Color',colgrn,'LineWidth',1.5) 
  plot(Tv_1km_lwoff(:,33),'Color',colgrn,'LineWidth',thin) 
  plot(xcrm_2to1,Tv_2km(:,33),'Color',colblu,'LineWidth',1.5) 
  plot(xcrm_2to1,Tv_2km_lwoff(:,33),'Color',colblu,'LineWidth',thin) 
  plot(xaxis_gcm2crm,Tv_25km(:,33),'Color',colyel,'LineWidth',1.5) 
  plot(xaxis_gcm2crm,Tv_25km_lwoff(:,33),'Color',colyel,'LineWidth',thin) 
  plot(xaxis_gcm2crm,Tv_25km_noconvlwoff(:,33),'-.','Color',colyel,'LineWidth',2) 
  title('surf temp and temp and lowest atm level')
  
  subplot(2,3,6)
  plot(u_1km_dmn(10:33),zzfull(10:33),'Color',colgrn,'LineWidth',1.5)
  hold on
  plot(u_1km_dmn_lwoff(10:33),zzfull(10:33),'Color',colgrn,'LineWidth',thin)
  plot(u_2km_dmn(10:33),zzfull(10:33),'Color',colblu,'LineWidth',1.5)
  plot(u_2km_dmn_lwoff(10:33),zzfull(10:33),'Color',colblu,'LineWidth',thin)
  plot(u_25km_dmn(10:33),zzfull(10:33),'Color',colyel,'LineWidth',1.5)
  plot(u_25km_dmn_lwoff(10:33),zzfull(10:33),'Color',colyel,'LineWidth',thin)
  plot(u_25km_dmn_noconvlwoff(10:33),zzfull(10:33),'-.','Color',colyel,'LineWidth',1.5)
  title('domain mean u wind')
  ylim([0 15000])
else
  figure
  subplot(2,3,1)
  plot(xcrm_2to1,evap_2km_ztmn,'Color',colblu)
  hold on
  plot(evap_1km_ztmn,'Color',colgrn)
  plot(xaxis_gcm2crm,evap_25km_ztmn,'Color',colyel)
  title('evaporation')
  
  subplot(2,3,2)
  plot(xcrm_2to1,theta_e_crm2(:,33),'Color',colblu)
  hold on
  plot(theta_e_crm1(:,33),'Color',colgrn)
  plot(xaxis_gcm2crm,theta_e_gcm(:,33),'Color',colyel)
  title('equivalent theta')
  
  subplot(2,3,3)
  plot(q_1km_ztmn(:,33),'Color',colgrn)
  hold on
  title('q at 33, lowest atm level')
  plot(xcrm_2to1,q_2km_ztmn(:,33),'Color',colblu)
  plot(xaxis_gcm2crm,q_25km_ztmn(:,33),'Color',colyel)
  
  subplot(2,3,4)
  plot(u_1km_ztmn(:,33),'Color',colgrn)
  hold on
  plot(-u_1km_ztmn(:,33),'Color',colgrn)
  title('u wind at 33, lowest atm level')
  plot(xcrm_2to1,u_2km_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,-u_2km_ztmn(:,33),'Color',colblu)
  plot(xaxis_gcm2crm,u_25km_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,-u_25km_ztmn(:,33),'Color',colyel)
  
  subplot(2,3,5)
  plot(tsurf_crm1_ztmn,'k','LineWidth',2)
  hold on
  plot(temp_crm1_ztmn(:,33),'Color',colgrn)
  plot(Tv_1km(:,33),'Color',colgrn,'LineWidth',1.5)
  plot(xcrm_2to1,temp_crm_ztmn(:,33),'Color',colblu)
  plot(xcrm_2to1,Tv_2km(:,33),'Color',colblu,'LineWidth',1.5)
  plot(xaxis_gcm2crm,temp_eq_ztmn(:,33),'Color',colyel)
  plot(xaxis_gcm2crm,Tv_25km(:,33),'Color',colyel,'LineWidth',1.5)
  title('surf temp, T and Tv lowest atm level')
  
  subplot(2,3,6)
  plot(u_1km_dmn(10:33),zzfull(10:33),'Color',colgrn)
  hold on
  plot(u_2km_dmn(10:33),zzfull(10:33),'Color',colblu)
  plot(u_25km_dmn(10:33),zzfull(10:33),'Color',colyel)
  title('domain mean u wind')
  ylim([0 15000])
end

% figures from compTheta.m

% Figures -----------------------------------------

figure
subplot(1,3,1)
msts_cons=[300.,305.,310.,315.,320.,325.,330.,335.,340.,345.,350.,355.,360.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,h_25km',msts_cons);
v=msts_cons;
clabel(C,h,v);
ylim([20000 100000])
title('25km h[K]')
set(gca,'Ydir','reverse')
subplot(1,3,2)
%h_2km=msts_2km./cp;
[C,h]=contourf(1:xcrm_ngp,pfull_2km,h_2km',msts_cons);
clabel(C,h,v);
ylim([20000 100000])
title('2km h[K]')
set(gca,'Ydir','reverse')
subplot(1,3,3)
%h_1km=msts_1km./cp;
[C,h]=contourf(1:xcrm_1km_ngp,pfull_2km,h_1km',msts_cons);
clabel(C,h,v);
ylim([20000 100000])
title('1km h[K]')
set(gca,'Ydir','reverse')
tit_en=strcat('moist static energy divided by cp');
suptitle(tit_en)

figure
subplot(1,3,1)
msts_cons=[300.,305.,310.,315.,320.,325.,330.,335.,340.,345.,350.,355.,360.];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,s_25km',msts_cons);
v=msts_cons;
clabel(C,h,v);
ylim([20000 100000])
title('25km h[K]')
set(gca,'Ydir','reverse')
subplot(1,3,2)
%h_2km=msts_2km./cp;
[C,h]=contourf(1:xcrm_ngp,pfull_2km,s_2km',msts_cons);
clabel(C,h,v);
ylim([20000 100000])
title('2km h[K]')
set(gca,'Ydir','reverse')
subplot(1,3,3)
%h_1km=msts_1km./cp;
[C,h]=contourf(1:xcrm_1km_ngp,pfull_2km,s_1km',msts_cons);
clabel(C,h,v);
ylim([20000 100000])
title('1km h[K]')
set(gca,'Ydir','reverse')
tit_en=strcat('dry static energy divided by cp');
suptitle(tit_en)

figure
thck=1.5;
plot(hsat_25km_full(80,:)./cp,pfull_2km,'Color',colyel,'LineWidth',thck) % the location at which hsat is computed is set in the compTheta.m script
set(gca,'Ydir','reverse')
ylim([20000 100000])
hold on
plot(h_25km(80,:),pfull_2km,'Color',colyel,'LineWidth',thck)
plot(s_25km(80,:),pfull_2km,'Color',colyel,'LineWidth',thck)
plot(hsat_2km_full(850,:)./cp,pfull_2km,'Color',colblu,'LineWidth',thck)
plot(h_2km(850,:),pfull_2km,'Color',colblu,'LineWidth',thck)
plot(s_2km(850,:),pfull_2km,'Color',colblu,'LineWidth',thck)
plot(hsat_1km_full(1750,:)./cp,pfull_2km,'Color',colgrn,'LineWidth',thck)
plot(h_1km(1750,:),pfull_2km,'Color',colgrn,'LineWidth',thck)
plot(s_1km(1750,:),pfull_2km,'Color',colgrn,'LineWidth',thck)
title('Static Energies over the warm pool: s,h,hsat')

figure
plot(hsat_25km_dmn./cp,pfull_2km,'Color',colyel,'LineWidth',thck)
set(gca,'Ydir','reverse')
ylim([20000 100000])
hold on
plot(s_25km_dmn,pfull_2km,'Color',colyel,'LineWidth',thck)
plot(h_25km_dmn,pfull_2km,'Color',colyel,'LineWidth',thck)
plot(hsat_2km_dmn./cp,pfull_2km,'Color',colblu,'LineWidth',thck)
plot(s_2km_dmn,pfull_2km,'Color',colblu,'LineWidth',thck)
plot(h_2km_dmn,pfull_2km,'Color',colblu,'LineWidth',thck)
plot(hsat_1km_dmn./cp,pfull_2km,'Color',colgrn,'LineWidth',thck)
plot(s_1km_dmn,pfull_2km,'Color',colgrn,'LineWidth',thck)
plot(h_1km_dmn,pfull_2km,'Color',colgrn,'LineWidth',thck)
title('Domain Mean Static Energies: s,h,hsat')

figure
subplot(1,3,1)
plot(hsat_25km./cp,pfull_2km)
set(gca,'Ydir','reverse')
ylim([20000 100000])
hold on
plot(h_25km(80,:),pfull_2km)
%plot(msts_25km(100,:),pfull_2km) % problematic
%plot(s_25km(100,:),pfull_2km)
title('25km')
subplot(1,3,2)
plot(hsat_2km./cp,pfull_2km)
set(gca,'Ydir','reverse')
ylim([20000 100000])
hold on
%plot(msts_2km(850,:)./cp,pfull_2km)
plot(h_2km(850,:),pfull_2km)
title('2km')
subplot(1,3,3)
plot(hsat_1km./cp,pfull_2km)
set(gca,'Ydir','reverse')
ylim([20000 100000])
hold on
%plot(msts_1km(1750,:)./cp,pfull_2km)
plot(h_1km(1750,:),pfull_2km)
title('1km')
tit_en=strcat('moist static energy divided by cp, saturated and unsaturated ');
suptitle(tit_en)

figure
subplot(2,3,1)
% the 0.01 factor converts to 100hPa/day
% I think, that vvel_d should be computed in units of Pa/day
vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
[C,h]=contourf(1:xgcm_ngp,pfull_2km,0.01.*vvel_d_25km',vvel_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
v=vvel_cons;
clabel(C,h,v);
set(h,'EdgeColor','none')
ylim([20000 100000])
title('GCM: diab vert velocity [hPa/d]')
set(gca,'Ydir','reverse')

subplot(2,3,2)
[C,h]=contourf(1:xcrm_ngp,pfull_2km,0.01.*vvel_d_2km',vvel_cons);
v=vvel_cons;
clabel(C,h,v);
set(h,'EdgeColor','none')
ylim([20000 100000])
title('CRM 2km: diab vert velocity [hPa/d]')
set(gca,'Ydir','reverse')

subplot(2,3,3)
[C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,0.01.*vvel_d_1km',vvel_cons);
v=vvel_cons;
clabel(C,h,v);
set(h,'EdgeColor','none')
ylim([20000 100000])
title('CRM 1km: diab vert velocity [hPa/d]')
set(gca,'Ydir','reverse')

%figure
plotOmega=true;

% if desired, the difference between the two vertical motion fields
% can be plotted.  the vvel_cons needs to be changed for the difference...
diff_omega_25km=864.*omega_25km_ztmn-0.01.*vvel_d_25km;
diff_omega_2km=864.*omega_2km_ztmn-0.01.*vvel_d_2km;
diff_omega_1km=864.*omega_1km_ztmn-0.01.*vvel_d_1km;

%diff_omega_25km=omega_25km_ztmn;
%diff_omega_2km=omega_2km_ztmn;
%diff_omega_1km=omega_1km_ztmn;

if plotOmega 
  %vvel_conl=[0.0,5,15,25,50];
  vvel_conl=[0.0];
  subplot(2,3,4)
  vvel_cons=[-50.0,-30.,-25,-20,-15,-10.,-5,0.0,5,10,15,20.,25,30,50];
  %vvel_cons=[-6,-4,-2,0.0,2,4,6];
  [C,h]=contourf(1:xgcm_ngp,pfull_2km,864.*omega_25km_ztmn',vvel_cons);
%  [C,h]=contourf(1:xgcm_ngp,pfull_2km,diff_omega_25km',vvel_cons);
  %v=[-50.,-25.,-5.,0.0,5,25,50];
  v=vvel_conl;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('GCM 25km: omega [hPa/d]')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,5)
  [C,h]=contourf(1:xcrm_ngp,pfull_2km,864.*omega_2km_ztmn',vvel_cons);
  %[C,h]=contourf(1:xcrm_ngp,pfull_2km,diff_omega_2km',vvel_cons);
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 2km: omega [hPa/d]')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,6)
  [C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,864.*omega_1km_ztmn',vvel_cons);
  %[C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,diff_omega_1km',vvel_cons);
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 1km: omega [hPa/d]')
  set(gca,'Ydir','reverse')
else
  subplot(2,3,4)
  div_cons=[-.45,-.4,-.35,-.3,-.25,-.2,-0.15,-0.1,-0.05,-0.01,0.0,0.01,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45];
  div_cons_lab=[-.3,-0.1,0.0,0.1,0.3];
  [C,h]=contourf(1:xgcm_ngp,pfull_2km,div_d_25km',div_cons);
  v=div_cons;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('GCM: diabatic divergence')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,5)
  [C,h]=contourf(1:xcrm_ngp,pfull_2km,div_d_2km',div_cons);
  v=div_cons_lab;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 2km: diabatic divergence')
  set(gca,'Ydir','reverse')
  
  subplot(2,3,6)
  [C,h]=contourf(1:xcrm_1km_ngp,pfull_1km,div_d_1km',div_cons);
  v=div_cons_lab;
  clabel(C,h,v);
  set(h,'EdgeColor','none')
  ylim([20000 100000])
  title('CRM 1km: diabatic divergence')
  set(gca,'Ydir','reverse')
end

figure
centerp_25=100;
centerp_2=1000;
centerp_1=2000;
plot(squeeze(temp_25km_ztmn(centerp_25,:)),pfull_2km,'Color',colyel)
hold on
ylim([20000 100000])
%ylim([85000 100000])
set(gca,'Ydir','reverse')
xlabel('temperature [K]')
plot(squeeze(temp_crm_ztmn(centerp_2,:)),pfull_2km,'Color',colblu)
plot(squeeze(temp_crm1_ztmn(centerp_1,:)),pfull_2km,'Color',colgrn)
temp_25km_ztmn(centerp_25,33)
temp_crm_ztmn(centerp_2,33)
temp_crm1_ztmn(centerp_1,33)
temp_25km_ztmn(centerp_25,18)
temp_crm_ztmn(centerp_2,18)
temp_crm1_ztmn(centerp_1,18)

%--------------------------------------

figure 
subplot(2,3,1)
plot(rh_25km_tmp,pfull_2km,'Color',colyel,'LineWidth',2);
%set(gca,'YScale','log')
hold on
plot(rh_25km_sub,pfull_2km,'--','Color',colyel,'LineWidth',2);
set(gca,'Ydir','reverse')
%title('equivalent pot temp')
ylim([10000 100000])
title('Relative Humidity')
plot(hur_crm(:),pfull_2km,'Color',colblu,'LineWidth',2);
plot(hur_crm_sub(:),pfull_2km,'--','Color',colblu,'LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);
plot(hur_crm_1km_sub(:),pfull_2km,'--','Color',colgrn,'LineWidth',2);
xlabel('%')

subplot(2,3,2)
plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim([10000 100000]);
set(gca,'Ydir','reverse')
hold on
%plot(liq_25km_prof,pfull_2km,'Color',colyel)
%plot(ice_25km_prof,pfull_2km,'Color',colyel)
%plot(ice_2km_prof,pfull_2km,'Color',colblu)
%plot(liq_2km_prof,pfull_2km,'Color',colblu)
%plot(liq_1km_prof,pfull_2km,'Color',colgrn)
%plot(ice_1km_prof,pfull_2km,'Color',colgrn)
%plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn)
%plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2)
plot(ice_2km_prof+liq_2km_prof,pfull_2km,'Color',colblu,'LineWidth',2)
plot(ice_25km_prof+liq_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2)
title('Mn Liq + Ice ')
xlabel('kg/kg')
%plot(hur_crm(:),pfull_2km,'Color',/Users/silvers/code/matlabscripts/WalkerCirc colblu,'LineWidth',2);
%hold on
%plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);

subplot(2,3,4)
% to plot the data points with an open circle use '-o' before 'Color'
%ylim([10000 100000]);
ylim([10000 100000]);
box('on');
hold('on');
plot(-1000.*gamma(1,:),pfull_2km,'Color',colyel,'LineWidth',2)
hold on
plot(-1000.*gamma(2,:),pfull_2km,'Color',colblu,'LineWidth',2)
plot(-1000.*gamma(3,:),pfull_2km,'Color',colgrn,'LineWidth',2)
plot(1000.*gamma_m(3,:),pfull_2km,'Color',colgrn)
plot(1000.*gamma_m(2,:),pfull_2km,'Color',colblu)
plot(1000.*gamma_m(1,:),pfull_2km,'Color',colyel)
xlim([0 10])
set(gca,'Ydir','reverse')
title('Lapse Rate')
xlabel('K/km')

%figure_full_prof=figure
subplot(2,3,3)
ylim([10000 100000]);
plot(rad_heat_prof_25,pfull_2km,'Color',colyel,'LineWidth',2);
set(gca,'Ydir','reverse')
title('Diabatic Heating')
xlabel('K/day')
hold on
plot(tdtconv_25km_prof+tdtls_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2);
plot(rad_heat_prof_2,pfull_2km,'Color',colblu,'LineWidth',2);
plot(tdtls_2km_prof,pfull_2km,'Color',colblu,'LineWidth',2);
plot(rad_heat_prof_1,pfull_2km,'Color',colgrn,'LineWidth',2);
plot(tdtls_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2);

subplot(2,3,5)
ylim([10000 100000]);
plot(10000*stastapar(1,:),pfull_2km,'-o','Color',colyel)
set(gca,'Ydir','reverse')
hold on
plot(10000*stastapar(2,:),pfull_2km,'-o','Color',colblu)
plot(10000*stastapar(3,:),pfull_2km,'-o','Color',colgrn)
xlim([-10 0])
xlabel('K/100hPa')
title('Static Stability Par')

subplot(2,3,6)
ylim([10000 100000])
plot(theta_e_gcm_mid,pfull_2km,'Color',colyel,'LineWidth',2)
hold on
set(gca,'Ydir','reverse')
%plot(theta_e_gcm(80,:),pfull_2km,'Color',colyel)
plot(theta_gcm(100,:),pfull_2km,'Color',colyel)
plot(theta_e_crm2_mid,pfull_2km,'Color',colblu,'LineWidth',2)
plot(theta_crm2(1000,:),pfull_2km,'Color',colblu)
%plot(theta_e_crm2(1000,:),pfull_2km,'Color',colblu)
plot(theta_e_crm1_mid,pfull_2km,'Color',colgrn,'LineWidth',2)
plot(theta_crm1(2000,:),pfull_2km,'Color',colgrn)
%plot(theta_e_crm1(2000),pfull_2km,'Color',colgrn)
title('Equivalent Pot Temp')
xlabel('K')
xlim([295 345])

tit_en=strcat('Mock Walker Cell: ','Vert Structure');
suptitle(tit_en)


%%%%%%%%%%%%%%%%%%%%%%%
%
%linesize=2;
%colnoconv=colblu;

% ConvNoConv
% figure comparing convection vs no convection in the 25km simulations

figure  % just for the caorse simulations
subplot(2,3,1)
plot(rh_tmp_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize);
hold on
plot(rh_tmp_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize);
plot(rh_sub_arr(1,:),pfull_2km,'--','Color',colyel,'LineWidth',linesize);
plot(rh_sub_arr(2,:),pfull_2km,'--','Color',colnoconv,'LineWidth',linesize);
set(gca,'Ydir','reverse')
ylim([10000 100000])
title('Relative Humidity')
xlabel('%')

subplot(2,3,2)
plot(ice_prof_arr(1,:)+liq_prof_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize)
ylim([10000 100000]);
set(gca,'Ydir','reverse')
hold on
plot(ice_prof_arr(2,:)+liq_prof_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize)
%plot(ice_25km_prof+liq_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2)
title('Mn Liq + Ice ')
xlabel('kg/kg')

subplot(2,3,4)
% to plot the data points with an open circle use '-o' before 'Color'
ylim([10000 100000]);
box('on');
hold('on');
plot(-1000.*gam_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize)
hold on
plot(-1000.*gam_asc_arr(1,:),pfull_2km,'--','Color',colyel,'LineWidth',linesize);
plot(-1000.*gam_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize)
plot(-1000.*gam_asc_arr(2,:),pfull_2km,'--','Color',colnoconv,'LineWidth',linesize);
plot(1000.*gam_m_arr(1,:),pfull_2km,'Color',colyel)
plot(1000.*gam_m_arr(2,:),pfull_2km,'Color',colnoconv)
xlim([0 10])
set(gca,'Ydir','reverse')
title('Lapse Rate')
xlabel('K/km')

%figure_full_prof=figure
subplot(2,3,3)
ylim([10000 100000]);
plot(rad_prof_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize);
set(gca,'Ydir','reverse')
title('Diabatic Heating')
xlabel('K/day')
hold on
plot(rad_prof_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize);
plot(tdtconv_prof_arr(1,:)+tdtls_prof_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize);
plot(tdtconv_prof_arr(2,:)+tdtls_prof_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize);

subplot(2,3,5)
ylim([10000 100000]);
plot(10000*stap_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize)
set(gca,'Ydir','reverse')
hold on
plot(10000*stap_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize)
xlim([-10 0])
xlabel('K/100hPa')
title('Static Stability Par')

subplot(2,3,6)
ylim([10000 100000])
plot(th_e_gcm_arr(1,:),pfull_2km,'Color',colyel,'LineWidth',linesize)
hold on
plot(th_e_gcm_arr(2,:),pfull_2km,'Color',colnoconv,'LineWidth',linesize)
set(gca,'Ydir','reverse')
plot(th_gcm_arr(1,:),pfull_2km,'Color',colyel)
plot(th_gcm_arr(2,:),pfull_2km,'Color',colnoconv)
title('Equivalent Pot Temp')
xlabel('K')
xlim([295 345])

tit_en=strcat('Mock Walker Cell: ','Conv vs. Noconv');
suptitle(tit_en)


stop

figure
plot(temp_crm_ztmn(1000,top_2plot:33),zzfull(top_2plot:33),'k')
hold on
plot(temp_crm_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'k','LineWidth',2)
plot(temp_crm_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--k')
plot(temp_crm1_ztmn(2000,top_2plot:33),zzfull(top_2plot:33),'g')
plot(temp_crm1_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'g','LineWidth',2)
plot(temp_crm1_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--g')
plot(temp_eq_ztmn(80,top_2plot:33),zzfull(top_2plot:33),'c')
plot(temp_eq_ztmn_mid(top_2plot:33),zzfull(top_2plot:33),'c','LineWidth',2)
plot(temp_eq_ztmn(1,top_2plot:33),zzfull(top_2plot:33),'--c')
title('Temperature')

figure
plot(temp_crm_ztmn(1000,top_2plot:33),pfull_gen(top_2plot:33),'k')
hold on
plot(temp_crm_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'k','LineWidth',2)
plot(temp_crm_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--k')
plot(temp_crm1_ztmn(2000,top_2plot:33),pfull_gen(top_2plot:33),'g')
plot(temp_crm1_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'g','LineWidth',2)
plot(temp_crm1_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--g')
plot(temp_eq_ztmn(80,top_2plot:33),pfull_gen(top_2plot:33),'c')
plot(temp_eq_ztmn_mid(top_2plot:33),pfull_gen(top_2plot:33),'c','LineWidth',2)
plot(temp_eq_ztmn(1,top_2plot:33),pfull_gen(top_2plot:33),'--c')
plot(fr_line(top_2plot:33),pfull_gen(top_2plot:33))
title('Temperature')
set(gca,'Ydir','reverse')

% plot the lapse rate
figure
plot(-1000.*gamma(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
plot(-1000.*gamma(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(-1000.*gamma(3,10:33),zzfull(10:33),'-o','Color',colgrn)
plot(1000.*gamma_m(1,10:33),zzfull(10:33),'-o','Color',colyel)
plot(1000.*gamma_m(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(1000.*gamma_m(3,10:33),zzfull(10:33),'-o','Color',colgrn)
xlim([0 10])
title('Lapse Rate (K/km)')

figure_plev=figure
axes2 = axes('Parent',figure_plev,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(-1000.*gamma(1,:),pfull_2km,'-o','Color',colyel)
hold on
plot(-1000.*gamma(2,:),pfull_2km,'-o','Color',colblu)
plot(-1000.*gamma(3,:),pfull_2km,'-o','Color',colgrn)
plot(1000.*gamma_m(3,:),pfull_2km,'-o','Color',colgrn)
plot(1000.*gamma_m(2,:),pfull_2km,'-o','Color',colblu)
plot(1000.*gamma_m(1,:),pfull_2km,'-o','Color',colyel)
xlim([0 10])
title('Lapse Rate (K/km)')


figure
gamma_crm_2d=gamma_2d_cen';
gamma_cons=[0,1,2,3,4,5,6];
v=gamma_cons;
[C,h]=contourf(750:1250,zzfull,-1000.*gamma_crm_2d)
clabel(C,h,v);
ylim([0 16000])
colorbar
title('Lapse Rate (K/km) center')

figure
gamma_crm_2d=gamma_2d_edg';
gamma_cons=[0,1,2,3,4,5,6];
v=gamma_cons;
[C,h]=contourf(0:500,zzfull,-1000.*gamma_crm_2d)
label(C,h,v);
ylim([0 16000])
colorbar
title('Lapse Rate (K/km) edge')


figure % convert from K/Pa to K/100hPa to compare with Mapes
plot(10000*stastapar(1,10:33),zzfull(10:33),'-o','Color',colyel)
hold on
% the second index is for 2km, the third for 1km
plot(10000*stastapar(2,10:33),zzfull(10:33),'-o','Color',colblu)
plot(10000*stastapar(3,10:33),zzfull(10:33),'-o','Color',colgrn)
xlim([-10 0])
ylim([0 15000])
title('Static Stability Par (K/100hPa)')

figure_stasta_prof=figure
axes2 = axes('Parent',figure_stasta_prof,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
box(axes2,'on');
hold(axes2,'on');
plot(10000*stastapar(1,:),pfull_2km,'-o','Color',colyel)
plot(10000*stastapar(2,:),pfull_2km,'-o','Color',colblu)
plot(10000*stastapar(3,:),pfull_2km,'-o','Color',colgrn)
xlim([-10 0])
title('Static Stability Par (K/100hPa)')


figure
plot(theta_e_gcm_mid,pfull_2km,'Color',colyel)
hold on
%plot(theta_e_gcm(80,:),pfull_2km,'Color',colyel)
plot(theta_gcm(100,:),pfull_2km,'Color',colyel)
plot(theta_e_crm2_mid,pfull_2km,'Color',colblu,'LineWidth',2)
plot(theta_crm2(1000,:),pfull_2km,'Color',colblu)
%plot(theta_e_crm2(1000,:),pfull_2km,'Color',colblu)
plot(theta_e_crm1_mid,pfull_2km,'Color',colgrn)
plot(theta_crm1(2000,:),pfull_2km,'Color',colgrn)
%plot(theta_e_crm1(2000),pfull_2km,'Color',colgrn)
set(gca,'Ydir','reverse')
title('equivalent pot temp')
ylim([20000 100000])
xlim([295 345])

figure
thetae_cons=[0.0,290,295,300,305,310,315,320,325.,330,335.];
[C,h]=contourf(1:xcrm_ngp,pfull_2km,theta_e_crm2',thetae_cons);
set(gca,'Ydir','reverse')
colorbar
clabel(C,h,thetae_cons);

% contour figures of the energetics

% for the crm's
tdtlw=tdtlw_2_ztmn;
tdtsw=tdtsw_2_ztmn;
tdtls=tdtls_2_ztmn;
xaxis=xcrm_ngp;

tdtlw=tdtlw_25_ztmn;
tdtsw=tdtsw_25_ztmn;
tdtls=tdtls_25km_ztmn;
xaxis=xgcm_ngp;

tit_st='2km Conv Exp';

figure
subplot(3,1,1)
heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xaxis,pfull_2km,tdtlw',heating_cons);
v=[-3.0,-2.0,-1.0,-0.5,0.0,0.5,1.0,2.0,3.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: lw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,1,2)
%heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xaxis,pfull_2km,tdtsw',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: sw heating K/d')
set(gca,'Ydir','reverse')

subplot(3,1,3)
%heating_cons=[-5.0,-3.,-2.5,-2.0,-1.5,-1.,-0.5,0.0,0.5,1.0,1.5,2.,2.5,3.];
[C,h]=contourf(1:xaxis,pfull_2km,tdtls',heating_cons);
%v=[-3.5,-2.5,-1.5,-0.5,0.0,0.5,1.0,2.0]; % if labels are desired on contours
clabel(C,h,v);
title('GCM: strat cloud heating K/d')
set(gca,'Ydir','reverse')

tit_en=strcat('Energetics: ',tit_st);
suptitle(tit_en)

% create profile figures of domain mean relative humidity

%rh_25km_control=squeeze(mean(rh_mat,2));
%blab_rh=squeeze(mean(rh_mat,2));
%rh_25km_tmp=squeeze(mean(rh_mat,2));
%rh_25km_current=squeeze(rh_25km_tmp(ind,:));
%
%rh_25km_noconv_2d=rh_25km_current;


%% compute domain mean rh and the mean in the outer regions where subsidence dominates.  
%%rh_25km_ind=squeeze(rh_mat(ind,:,:));
%rh_25km_ind=hur_25km_ztmn;
%rh_25km_sub_a=rh_25km_ind(1:40,:);
%rh_25km_sub=squeeze(mean(rh_25km_sub_a,1));
%rh_25km_tmp=squeeze(mean(rh_25km_ind,1));
%
%hur_crm=mean(hur_2km_ztmn,1);
%hur_crm_sub_a=hur_2km_ztmn(1:500,:);
%hur_crm_sub=squeeze(mean(hur_crm_sub_a,1));
%hur_crm_1km=mean(hur_1km_ztmn,1);
%hur_crm_1km_sub_a=hur_1km_ztmn(1:1000,:);
%hur_crm_1km_sub=mean(hur_crm_1km_sub_a,1);

% multipanel figure illustrating the mean vertical structure of key variables

figure1=figure
axes2 = axes('Parent',figure1,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
xlim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'on');
%rh_25km_control=blab_rh(3,:);
plot(rh_25km_control,pfull_2km,'--','Color',colyel,'LineWidth',1);
plot(rh_25km_noconv_2d,pfull_2km,'Color',colyel,'LineWidth',2);
hold on
plot(rh_25km_nolwcre,pfull_2km,'-.','Color',colyel,'LineWidth',1);
plot(hur_crm_ctl(:),pfull_2km,'Color',colblu,'LineWidth',2);
plot(hur_crm_nolw(:),pfull_2km,'-.','Color',colblu,'LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);
title('Mean Cloud and RH')

%figure1=figure
%axes2 = axes('Parent',figure1,'BoxStyle','full','YMinorTick','on',...
%    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
%    'YScale','log',...
%    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
%    'Layer','top',...
%    'YDir','reverse',...
%    'FontWeight','bold',...
%    'FontSize',14);%,...
%ylim(axes2,[10000 100000]);
%xlim(axes2,[0 100]);
%box(axes2,'on');
%hold(axes2,'on');
figure
figure1=figure
subplot(2,1,1)
plot(rh_25km_tmp,pfull_2km,'Color',colyel,'LineWidth',2);
%plot(rh_25km_sub,pfull_2km,'Color',colyel,'LineWidth',2);
hold on
%hur_crm=mean(hur_2km_ztmn,1);
%hur_crm_1km=mean(hur_1km_ztmn,1);
plot(hur_crm(:),pfull_2km,'Color',colblu,'LineWidth',2);
%plot(hur_crm_nolw(:),pfull_2km,'-.','Color',colblu,'LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);
title('Mean Cloud and RH')

subplot(2,2,2)
axes2 = axes('Parent',figure1,'BoxStyle','full','YMinorTick','on',...
    'YTickLabel',{'100','200','300','400','500','600','700','800','900','1000'},...
    'YScale','log',...
    'YTick',[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000],...
    'Layer','top',...
    'YDir','reverse',...
    'FontWeight','bold',...
    'FontSize',14);%,...
ylim(axes2,[10000 100000]);
xlim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'on');
plot(rh_25km_tmp,pfull_2km,'Color',colyel,'LineWidth',2);
hold on
plot(hur_crm(:),pfull_2km,'Color',colblu,'LineWidth',2);
%plot(hur_crm_nolw(:),pfull_2km,'-.','Color',colblu,'LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);
title('Mean Cloud and RH')

%---------------------------------------------------------------------

figure 
subplot(2,3,1)
plot(rh_25km_tmp,pfull_2km,'Color',colyel,'LineWidth',2);
%set(gca,'YScale','log')
hold on
plot(rh_25km_sub,pfull_2km,'--','Color',colyel,'LineWidth',2);
set(gca,'Ydir','reverse')
%title('equivalent pot temp')
ylim([10000 100000])
title('Relative Humidity')
plot(hur_crm(:),pfull_2km,'Color',colblu,'LineWidth',2);
plot(hur_crm_sub(:),pfull_2km,'--','Color',colblu,'LineWidth',2);
plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);
plot(hur_crm_1km_sub(:),pfull_2km,'--','Color',colgrn,'LineWidth',2);
xlabel('%')

subplot(2,3,2)
plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2)
ylim([10000 100000]);
set(gca,'Ydir','reverse')
hold on
%plot(liq_25km_prof,pfull_2km,'Color',colyel)
%plot(ice_25km_prof,pfull_2km,'Color',colyel)
%plot(ice_2km_prof,pfull_2km,'Color',colblu)
%plot(liq_2km_prof,pfull_2km,'Color',colblu)
%plot(liq_1km_prof,pfull_2km,'Color',colgrn)
%plot(ice_1km_prof,pfull_2km,'Color',colgrn)
%plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn)
%plot(ice_1km_prof+liq_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2)
plot(ice_2km_prof+liq_2km_prof,pfull_2km,'Color',colblu,'LineWidth',2)
plot(ice_25km_prof+liq_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2)
title('Mn Liq + Ice ')
xlabel('kg/kg')
%plot(hur_crm(:),pfull_2km,'Color',/Users/silvers/code/matlabscripts/WalkerCirc colblu,'LineWidth',2);
%hold on
%plot(hur_crm_1km(:),pfull_2km,'Color',colgrn,'LineWidth',2);

subplot(2,3,4)
% to plot the data points with an open circle use '-o' before 'Color'
%ylim([10000 100000]);
ylim([10000 100000]);
box('on');
hold('on');
%plot(-1000.*gamma(1,:),pfull_2km,'Color',colyel,'LineWidth',2)
plot(-1000.*gamma_asc(1,:),pfull_2km,'Color',colyel,'LineWidth',2)
hold on
%plot(-1000.*gamma(2,:),pfull_2km,'Color',colblu,'LineWidth',2)
plot(-1000.*gamma_asc(2,:),pfull_2km,'Color',colblu,'LineWidth',2)
%plot(-1000.*gamma(3,:),pfull_2km,'Color',colgrn,'LineWidth',2)
plot(-1000.*gamma_asc(3,:),pfull_2km,'Color',colgrn,'LineWidth',2)
plot(1000.*gamma_m(3,:),pfull_2km,'Color',colgrn)
plot(1000.*gamma_m(2,:),pfull_2km,'Color',colblu)
plot(1000.*gamma_m(1,:),pfull_2km,'Color',colyel)
xlim([0 10])
set(gca,'Ydir','reverse')
title('Lapse Rate')
xlabel('K/km')

%figure_full_prof=figure
subplot(2,3,3)
plot(rad_heat_prof_25,pfull_2km,'Color',colyel,'LineWidth',2);
set(gca,'Ydir','reverse')
title('Diabatic Heating')
xlabel('K/day')
hold on
plot(tdtconv_25km_prof+tdtls_25km_prof,pfull_2km,'Color',colyel,'LineWidth',2);
plot(rad_heat_prof_2,pfull_2km,'Color',colblu,'LineWidth',2);
plot(tdtls_2km_prof,pfull_2km,'Color',colblu,'LineWidth',2);
plot(rad_heat_prof_1,pfull_2km,'Color',colgrn,'LineWidth',2);
plot(tdtls_1km_prof,pfull_2km,'Color',colgrn,'LineWidth',2);
ylim([10000 100000]);

subplot(2,3,5)
ylim([10000 100000]);
plot(10000*stastapar(1,:),pfull_2km,'-o','Color',colyel)
set(gca,'Ydir','reverse')
hold on
plot(10000*stastapar(2,:),pfull_2km,'-o','Color',colblu)
plot(10000*stastapar(3,:),pfull_2km,'-o','Color',colgrn)
xlim([-10 0])
xlabel('K/100hPa')
title('Static Stability Par')

subplot(2,3,6)
ylim([10000 100000])
plot(theta_e_gcm_mid,pfull_2km,'Color',colyel,'LineWidth',2)
hold on
set(gca,'Ydir','reverse')
%plot(theta_e_gcm(80,:),pfull_2km,'Color',colyel)
plot(theta_gcm(100,:),pfull_2km,'Color',colyel)
plot(theta_e_crm2_mid,pfull_2km,'Color',colblu,'LineWidth',2)
plot(theta_crm2(1000,:),pfull_2km,'Color',colblu)
%plot(theta_e_crm2(1000,:),pfull_2km,'Color',colblu)
plot(theta_e_crm1_mid,pfull_2km,'Color',colgrn,'LineWidth',2)
plot(theta_crm1(2000,:),pfull_2km,'Color',colgrn)
%plot(theta_e_crm1(2000),pfull_2km,'Color',colgrn)
title('Equivalent Pot Temp')
xlabel('K')
xlim([295 345])

tit_en=strcat('Mock Walker Cell: ','Vert Structure with LWCRE');
suptitle(tit_en)

%-------------------------------------------------------
% look at equilibration times of RH for the 25km control case and the case with no convective param.
source_gcm_ctl='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9/1980th1983.atmos_month_tmn.nc';
rh_gcm_rh=ncread(source_gcm_ctl,'rh');
size(rh_gcm_rh)
rh_gcm_rh_a=squeeze(mean(rh_gcm_rh,2));
rh_gcm_rh_sub_a=rh_gcm_rh_a(1:40,:,:);
rh_gcm_rh_sub=squeeze(mean(rh_gcm_rh_a,1));

figure
plot(rh_gcm_rh_sub(:,1),pfull_2km)
set(gca,'Ydir','reverse')
hold on
plot(rh_gcm_rh_sub(:,2),pfull_2km,'r')
plot(rh_gcm_rh_sub(:,3),pfull_2km,'g')
plot(rh_gcm_rh_sub(:,4),pfull_2km,'b')
title('rh at years 2,3,4 and 5 for ctl at 25km')

source_gcm_noconv='/Users/silvers/data/WalkerCell/testing_20181203/c8x160L33_am4p0_25km_wlkr_ent0p9_noconv//1980th1983.atmos_month_tmn.nc';
rh_gcm_rh=ncread(source_gcm_noconv,'rh');
size(rh_gcm_rh)
rh_gcm_rh_a=squeeze(mean(rh_gcm_rh,2));
rh_gcm_rh_sub_a=rh_gcm_rh_a(1:40,:,:);
rh_gcm_rh_sub=squeeze(mean(rh_gcm_rh_a,1));
figure
plot(rh_gcm_rh_sub(:,1),pfull_2km)
set(gca,'Ydir','reverse')
hold on
plot(rh_gcm_rh_sub(:,2),pfull_2km,'r')
plot(rh_gcm_rh_sub(:,3),pfull_2km,'g')
plot(rh_gcm_rh_sub(:,4),pfull_2km,'b')
title('rh at years 2,3,4 and 5 for noconv at 25km')


