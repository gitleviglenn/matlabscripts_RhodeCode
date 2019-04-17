function var = read_1var_xymn(filnam,varnam)
  var = ncread(filnam,varnam);
  var = squeeze(mean(var(:,:,:),1)); % average over xdim 
  var = squeeze(mean(var,1)); % average over ydim 
end
