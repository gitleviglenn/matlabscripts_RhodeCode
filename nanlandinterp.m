function sst_o = nanlandinterp(sstin,landm,XN,YN)
%
% incoming sst is 360x180, landm from AM4 is 288x180
% performs an interpolation to apply the land mask to sst data.  
%
% levi silvers    

[X,Y]=meshgrid(1:288,1:180);
%[XN,YN]=meshgrid(0.2:0.8:288,1:180);
testland=interp2(X,Y,landm',XN,YN);

onlyocean=zeros(size(testland));
onlyocean(testland~=0)=-999.;
onlyocean(onlyocean==0)=1.;
onlyocean(onlyocean==-999.)=0.;

% this results in land points having a value of 1.  There is a gradient, presumably for
% grid cells that are partially land.

% and now to translate land points to NaNs...
%sst_1t=squeeze(sstin(1,:,:));
sst_oc_only=sstin.*onlyocean';
sst_oc_only(sst_oc_only==0.)=NaN;
sst_o=sst_oc_only;
end % end function get nanland

