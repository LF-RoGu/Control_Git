function Tarea1_3(tspan, x0)

[t,X] = ode45(@Circ_Doble_Malla_ODE_sys,tspan,x0);

%Graficando
subplot(2,1,1);plot(t,X(:,1)); title('Estado 1'); grid;
subplot(2,1,2);plot(t,X(:,2)); title('Estado 2'); grid;

end

function dX = Circ_Doble_Malla_ODE_sys(t,X)

%Parametros del sistema
C1 = 4e-6;
C2 = 2e-6;
R1 = 1e3;
R2 = 2e3;

%Matrices
%A = [( -1 / (R2*C2) ), ( 1 / (C1*C2*R2) ); ( 1 / R2 ), -( ( 1 / (R1*C1) ) + ( 1 / (C1*R2) ) )];
%B = [0; ( 1 / R1 )];
%C = [1, 0];
%D = 0;

A = [0,1;(R^2 * C),R];
B = [0,L/R];
C = [];
D = [];

%Entrada al sistema
U = 0;
%ODE's
dX = A*X + B*U;
end