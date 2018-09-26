%---------------------------------------
% toa_rad_driver.m
%
% compute the change in net radiative flux at toa
% between experiments
%
% levi silvers                sep 2018
%---------------------------------------

del_R=[0,0,0,0,0];
del_Rsw=[0,0,0,0,0];
del_Rlw=[0,0,0,0,0];
del_cre=[0,0,0,0,0];
del_swcre=[0,0,0,0,0];
del_lwcre=[0,0,0,0,0];
atm_enimb=zeros(2,5);

grid_spac='25km';

entval='0p5';

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

del_R(1)=toa_R_ctl-toa_R_p4K;
del_cre(1)=net_cre_ctl-net_cre_p4K;
del_swcre(1)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(1)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(1)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(1)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,1)=atm_enimb_ctl;
atm_enimb(2,1)=atm_enimb_p4K;
%
entval='0p7';

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

del_R(2)=toa_R_ctl-toa_R_p4K;
del_cre(2)=net_cre_ctl-net_cre_p4K;
del_swcre(2)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(2)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(2)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(2)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,2)=atm_enimb_ctl;
atm_enimb(2,2)=atm_enimb_p4K;

%
entval='0p9';

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

lhflux_dmn
shflx_s_dmn
lwdn_s_dmn
lwup_s_dmn
swdn_s_dmn
swup_s_dmn

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

lhflux_dmn
shflx_s_dmn
lwdn_s_dmn
lwup_s_dmn
swdn_s_dmn
swup_s_dmn

del_R(3)=toa_R_ctl-toa_R_p4K;
del_cre(3)=net_cre_ctl-net_cre_p4K;
del_swcre(3)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(3)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(3)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(3)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,3)=atm_enimb_ctl;
atm_enimb(2,3)=atm_enimb_p4K;
%
entval='1p1';

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

del_R(4)=toa_R_ctl-toa_R_p4K;
del_cre(4)=net_cre_ctl-net_cre_p4K;
del_swcre(4)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(4)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(4)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(4)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,4)=atm_enimb_ctl;
atm_enimb(2,4)=atm_enimb_p4K;
%
entval='1p3';

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval);
toa_rad
toa_R_ctl     = toa_R;
toa_Rsw_ctl   = toa_Rsw;
toa_Rlw_ctl   = toa_Rlw;
sw_cre_ctl    = sw_cre;
lw_cre_ctl    = lw_cre;
net_cre_ctl   = net_cre;
atm_enimb_ctl = atm_imb;

experimentn=strcat('/c8x160L33_am4p0_',grid_spac,'_wlkr_ent',entval,'_p4K');
toa_rad
toa_R_p4K     = toa_R;
toa_Rsw_p4K   = toa_Rsw;
toa_Rlw_p4K   = toa_Rlw;
sw_cre_p4K    = sw_cre;
lw_cre_p4K    = lw_cre;
net_cre_p4K   = net_cre;
atm_enimb_p4K = atm_imb;

del_R(5)=toa_R_ctl-toa_R_p4K;
del_cre(5)=net_cre_ctl-net_cre_p4K;
del_swcre(5)=sw_cre_ctl-sw_cre_p4K;
del_lwcre(5)=lw_cre_ctl-lw_cre_p4K;
del_Rsw(5)  =toa_Rsw_ctl-toa_Rsw_p4K;
del_Rlw(5)  =toa_Rlw_ctl-toa_Rlw_p4K;
atm_enimb(1,5)=atm_enimb_ctl;
atm_enimb(2,5)=atm_enimb_p4K;
