function var = qstar(estar,press)

% approximate computation of the saturation mixing ratio
% orignally taken from notes by DAvid Randall

phys_constants

for j=1:33
	var(j) = epsilon.*estar(j)/press(j);
end
