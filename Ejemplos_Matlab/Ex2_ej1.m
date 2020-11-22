%Examen_2 705694
tspan = [0,50];
x0 = [0;0;0];
Pd = [-2.3,-2,-2];

ej1_plot(tspan, x0, Pd);
%% Functions
function ej1_plot(tspan, x0, Pd)

global A B C k1 k2

A = [0, 1, 0;
     0, 0, 1;
     -2, -3, -4];
B = [2;
     0;
     4];
C = [2, 0, -1];

k1 = Pd(1);

%RESUELVE LAS ECUACIONES DIFERENCIALES ORDINARIAS (ODES)
[t, X] = ode45(@ej1_sys,tspan,x0);

figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;

y_ref = 10 - 2*cos(t);

d_e1 = 2*sin(t) - 2*X(:,1) - 5*X(:,2) -4*X(:,3);

x1_ref = (-1/2)*(k1*e1 + 5*X(:,2) + 4*X(:,3) - 2*sin(t));

U = (-1/6) * (k2*e2 - ( (k1 + 4)*X(:,1) + ((5/2)*k1 + 5)*X(:,2) + (2*k1 - (5/2) + 8)*X(:,3) + (1-k1)*cos(t)))

maxU = max(abs(U))

figure; plot(t, C*X', 'r', t, y_ref); title('SALIDA'); grid;
figure; plot(t,U); title('SENAL DE CONTROL'); grid;
end

function dX = ej1_sys(t,X)

global A B C K F

ref = 10 - 2*cos(t);

U=K*X + F*ref; %Ley de control para seguimiento
%U=10;          %Escalon

%ODEs
dX = A*X + B*U;
end