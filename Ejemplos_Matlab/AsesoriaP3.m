%% Problemas Asesoria
close all;clc; clear;

tspan = [0,10];
x0 = [4;10;20];
Pd = -4;

funct_plot(tspan, x0, Pd);

%% Functions
function funct_plot(tspan, x0, Pd)

global A B C k1

A = [-3, 2, 0;
     0, -4, -3;
     1, -1, -8];
B = [2, 0;
     3, 0;
     -1, 1];
C = [0, 3, 0];

[t,X] = ode45(@funct_sys,tspan,x0);

k1 = Pd;

ref = 2*sin(2*t);

figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;

figure;
plot(t, X*C',t,ref,'red'); title('Salida y Ref'); grid;
end

function dX = funct_sys(t,X)

global A B C k1

ref = 2*sin(2*t);
dref = 4*cos(2*t);

e = ref - C*X;

u1 = inv(C*B(:,1))*(dref-C*A*X-k1*e);
u2 = 0;

dX = A*X + B*[u1;u2];
end