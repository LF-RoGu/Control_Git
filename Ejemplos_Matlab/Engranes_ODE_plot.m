function Engranes_ODE_plot(tspan,x0)

%Evaluando las ODE's definidas en sys
[t,X] = ode45(@Engranes_ODE_sys,tspan,x0);

%Graficando
subplot(2,1,1);plot(t,X(:,1)); title('Estado 1'); grid;
subplot(2,1,2);plot(t,X(:,2)); title('Estado 2'); grid;

end

function dX = Engranes_ODE_sys(t,X)

Jm1 = 0.5; 
Jm2 = 0.6; 
n1 = 20; 
n2 = 30; 
K = 0.8; 
B = 2.5;

A = [0, 1; -K/(Jm2 + Jm1*(n2/n1)^2), -B/(Jm2 + Jm1*(n2/n1)^2)];
B = [0; -1/(n1*Jm2/2 + n2*Jm1/n1)];
C = [1, 0];
D = 0;

U = 0;

dX = A*X + B*U;
end