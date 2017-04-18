figure
% for am3
plot(alpha_array_am3(:,1),'r')
hold on
plot(alpha_array_am3(:,2),'r')
plot(alpha_array_am3(:,3),'r')
plot(alpha_array_am3(:,4),'r')
plot(alpha_array_am3(:,5),'r')
% ensemble mean
plot(mean_alpha_am3(:),'r','Linewidth',2)

% for am2
plot(alpha_array(:,1),'b')
plot(alpha_array(:,2),'b')
plot(alpha_array(:,3),'b')
plot(alpha_array(:,4),'b')
plot(alpha_array(:,5),'b')
plot(alpha_array(:,6),'b') 
% ensemble mean
plot(mean_alpha(:),'b','Linewidth',3)

% for am4
plot(alpha_array_am4(:,1),'k','Linewidth',3)

title('alpha: differential climate feedback parameter')
