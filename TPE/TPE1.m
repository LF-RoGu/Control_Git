t = (0:0.001:10);
subplot(2,1,1);
plot(t,2*exp(-t)-exp(-2*t),'b','linewidth',1.5);grid;
title('k = 2');

subplot(2,1,2);
plot(t,2*exp(-3*t),'b','linewidth',1.5);grid;
title('k = 0.05');