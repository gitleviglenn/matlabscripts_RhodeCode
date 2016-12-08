source='/Users/silvers/data/cre_sstpatt/c96L32_am4g10r8_2000climo_av10yr_atmos_subsvar.0002-0011.all.nc'
ncid=netcdf.open(source);
[numdims,nvars,natts]=netcdf.inq(ncid);
nvars
%[varname,xtype,dimids,atts]=netcdf.inqVar(ncid,21)
%vardatatest=ncread(source,tot_cld_amt);
[tcld,xtype,dimids,atts]=netcdf.inqVar(ncid,21);
vardatatest=ncread(source,tcld);
size(vardatatest);

for ii=1:22
	%varid=netcdf.inqVarID(ncid,varname);
	varid=int2str(ii);
	[varname,xtype,dimids,atts]=netcdf.inqVar(ncid,varid);
        varname
end
