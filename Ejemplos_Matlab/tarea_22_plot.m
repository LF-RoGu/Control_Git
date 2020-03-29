
%Pd = [-4,-3,-3,-3,-1];
%x0 = [1;0;0;0;0];

function tarea_22_plot(tspan, x0, Pd)

close all;clc;

global A B C D K F

R = 15;
L = 5e-3;
J = 8.5e-6;
b = 3.5e-7;
Kt = 12e-3;
Kb = 12e-3;
r = 0.1;

M = 1;
m = 0.1;
l = 0.3;
g = 9.81;


alpha = 1/( (r*r*(M + m)) + J );
beta = 1/( 1 - (alpha*(r*r)*m) );
delta = 1/( l*(1 - (alpha*r*r*m)) );

A = [0, 1, 0, 0, 0;
     0, (-alpha*beta*b), (-alpha*beta*r*r*m*g), 0, (alpha*beta*r*Kt);
     0, 0, 0, 1, 0;
     0, (delta*alpha*b), (delta*g), 0, (-delta*alpha*r*Kt);
     0, (-Kb/L), 0, 0, (-R/L)];
B = [0; 0; 0; 0; 1/L];
C = [1, 0, 0, 0, 0];
Mc = [B, A*B, (A^2)*B, (A^3)*B, (A^4)*B];
% Como los valores no lo permiten, rank no funciona
% Al det no ser 0, podemos inferir que tiene un rango pleno y es
% controlable
det(Mc)

H = ( A - Pd(1)*eye(5) )*( A - Pd(2)*eye(5) )*( A - Pd(3)*eye(5) )*( A - Pd(4)*eye(5) )*( A - Pd(5)*eye(5) );

K = -[0, 0, 0, 0, 1]*(adjoint(Mc)/det(Mc))*H;

F = 1 / ( C*inv( -A-B*K ) * B );
[t,X] = ode45(@tarea_22_sys,tspan,x0);

ref = 5;

U = X*K' + F*ref;

maxU = max( abs(U) );

figure;
subplot(5,1,1); plot(t, X(:,1)); title('ESTADO 1: x(t)'); grid;
subplot(5,1,2); plot(t, X(:,2)); title('ESTADO 2: x`(t)'); grid;
subplot(5,1,3); plot(t, X(:,3)); title('ESTADO 3: 0(t)'); grid;
subplot(5,1,4); plot(t, X(:,4)); title('ESTADO 4: 0`(t)'); grid;
subplot(5,1,5); plot(t, X(:,5)); title('ESTADO 5: I(t)'); grid;

figure;
subplot(2,1,1); plot(t, X*C',t,ref,'red'); title('SALIDA Y REFERENCIA'); grid;
subplot(2,1,2); plot(t, U); title('ENTRADA'); grid;

end

function dX = tarea_22_sys (t,X)

global A B C D K F

ref = 5;

U = K*X + F*ref;

dX = A*X + B*U;

end