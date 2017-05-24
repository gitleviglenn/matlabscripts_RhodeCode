%------------------------------------------------------------------------------------
% this script uses amip data to compute eis and lts
%
% used with: 
% driver_ensembles.m
% m2009/readvars.m
% global_eis.m
%
% to compute eis and lts use: 
% global_eis.m 
%
% levi silvers                                                 march 2017
%------------------------------------------------------------------------------------
%
%cont_wcolorbar_eisdiff(diff_term','EIS - LTS');

boo='have you saved changes you numskull?'

%% open netcdf files and load data
%%
%%modtitle='c96L32 am4g12r04: ';
%% this should only need to be called the first time after the experiment
%% paths are changed...
%
% use the 20 lines below when running first time with new input...
%openncfile_new.m
%
%
% compute a mask to eliminate values over continents
%onlyocean=make_onlyocean; 


%% compute the weighted global mean values of the 2m temperature
% careful with the size of v.tref_full... it may not be full!
%clear tindex;
%tindex=size(v.tref_am4ts,1);
%tref_gmn_ts=zeros(tindex,1);
%for ti=1:tindex;
%  fullfield=squeeze(v.tref_am4ts(ti,:,:));
%  global_wmean_script;
%  tref_gmn_am4ts(ti)=wgt_mean;
%  fullfield=squeeze(v.tsurf_am4ts(ti,:,:));
%  global_wmean_script;
%  tsurf_gmn_am4ts(ti)=wgt_mean;
%end

clear tindex;
tindex=size(temp_ll_ts,1);
eis_ts=zeros(tindex,nlat,nlon);
eis_gmn_ts=zeros(tindex,1);
lts_ts=zeros(tindex,nlat,nlon);
lts_gmn_ts=zeros(tindex,1);
%%
timenow=1;

vlevel=100.*vlevel;
nlev=size(vlevel,1);

for ti=1:tindex;
  %comp_eis_lts_09;
  global_eis;
  eis_ts(ti,:,:)=estinvs(:,:);
  lts_ts(ti,:,:)=lts_f(:,:);

  fullfield=squeeze(eis_ts(ti,:,:));
  global_wmean_script; 
  eis_gmn_ts(ti)=wgt_mean; 

  fullfield=squeeze(lts_ts(ti,:,:));
  global_wmean_script; 
  lts_gmn_ts(ti)=wgt_mean; 

  timenow=timenow+1;
end
fintimeindex=timenow
%
