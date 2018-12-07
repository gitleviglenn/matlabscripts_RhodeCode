function var = read_1var_ztmn(filnam,varnam)
  var = ncread(filnam,varnam);
  var = squeeze(mean(var(:,:,:,:),4)); % average over time
  var = squeeze(mean(var,2)); % average meridionally
end
