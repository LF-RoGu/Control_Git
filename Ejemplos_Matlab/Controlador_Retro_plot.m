function Controlador_Retro_plot(tspan, x0, Pd)

global A B C K F

%Param
k1 = 150;
k2 = 700;
b1 = 15;
b2 = 30;
M1 = 5;
M2 = 20;

Mp = 0.1;

a = -k1 / M1;
b = k1 / M1;
c = -b1/M1;
d = b1/M1;

e = k1 / M2;
f = (-k1 - k2) / M2;
g = b1 / M2;
h = (-b1 -b2) / M2;

i = 1 / M1;

%Matrix
A = [0, 0, 1, 0;
     0, 0, 0, 1;
     a, b, c, d;
     e, f, g, h];
B = [0;
     0;
     i;
     0];
C = [1, 0, 0, 0];

Mc = [B, A*B, A^2 * B, A^3 * B];clc

H = ( A - Pd(1)*eye(4) )*( A - Pd(2)*eye(4) )*( A - Pd(3)*eye(4) )*( A - Pd(4)*eye(4) );

K = -[0, 0, 0, 1]*Mc^-1*H;

F = 1 / (C*(-A-B*K)^-1*B);

%Dif Eq
[t,X] = ode45(@Controlador_Retro_sys,tspan,x0);

close all;
figure;
subplot(4,1,1);plot(t,X(:,1));title('Estado 1');
subplot(4,1,2);plot(t,X(:,2));title('Estado 2');
subplot(4,1,3);plot(t,X(:,3));title('Estado 3');
subplot(4,1,4);plot(t,X(:,4));title('Estado 4');

y_ref = 2;
U = X*K' + F*y_ref;

maxU = max(abs(U))

figure;
subplot(2,1,1);plot(t,C*X', 'r',t,y_ref);title('SALIDA');grid;
subplot(2,1,2);plot(t,U);title('Control Signal');grid
end

function dX = Controlador_Retro_sys(t,X)

global A B C K F

y_ref = 2;

U = K*X + F*y_ref;

dX = A*X + B*U;
end