t = (0:0.001:50);
figure(1);
plot(t,5.*exp(-t/10).*(cos((39^(1/2).*t)/10) - (39^(1/2).*sin((39^(1/2).*t)/10))/13),'b','linewidth',1.5);grid;
title('System with gravity');
xlabel('Time');
ylabel('Magnitud');