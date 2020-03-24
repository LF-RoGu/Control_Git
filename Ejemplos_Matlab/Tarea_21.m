%%
close all
clear
clc

% Vector de tiempo para espacio de estados
tspan = [0 10];
% Condiciones iniciales
init = [0;0;0;0];
%Polos deseados
Pd = [-4+5.45i, -4-5.45i, -12.5, -12.5];
%Pd = [-4+5.45i, -4-5.45i, -40, -40];

carritos_ref_plot(tspan,init,Pd);

%% Functions Section

function carritos_ref_plot(tspan, x0, Pd)
global A B C D K F

%Parametros del sistema
k1=150; k2=700; b1=15; b2=30; m1=5; m2=20;

%Matrices del sistema
A = [0 0 1 0; 0 0 0 1; -k1/m1 k1/m1 -b1/m1 b1/m1; k1/m2 (-k1-k2)/m2 b1/m2 (-b1-b2)/m2];
B = [0; 0; 1/m1; 0];
C = [1 0 0 0];

%CALCULAMOS GANANCIAS DE CONTROL
MC = [B A*B A^2*B A^3*B] %Matriz de controlabilidad
H = (A - Pd(1)*eye(4))*(A - Pd(2)*eye(4))*(A - Pd(3)*eye(4))*(A - Pd(4)*eye(4))
K = -[0 0 0 1]*inv(MC)*H
F = 1/(C*inv(-A-B*K)*B)

%RESUELVE LAS ECUACIONES DIFERENCIALES ORDINARIAS (ODES)
[t, X] = ode45(@carritos_ref_sys,tspan,x0);

figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

ref = 2; U = X*K' + F*ref; maxU = max(abs(U));

figure; plot(t, C*X', 'r', t, ref); title('SALIDA'); grid;
figure; plot(t,U); title('SENAL DE CONTROL'); grid;

end

function dX = carritos_ref_sys(t,X)

global A B C K F

ref = 2;

U=K*X + F*ref; %Ley de control para seguimiento
%U=10;          %Escalon

%ODEs
dX = A*X + B*U;
end
