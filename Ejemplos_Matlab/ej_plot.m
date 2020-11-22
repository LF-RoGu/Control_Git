%Examen_2 705694
tspan = [0,50];
x0 = [0;0;0];
Pd = [-2,-3.2,-1.2];

ej3_plot(tspan, x0, Pd);
%% Functions
function ej3_plot(tspan, x0, K)

global A B C Kp Ki Kd





%RESUELVE LAS ECUACIONES DIFERENCIALES ORDINARIAS (ODES)
[t, X] = ode45(@ej3_sys,tspan,x0);

figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;

ref = 10 - 2*cos(t); 
U = X*K' + F*ref; maxU = max(abs(U))

figure; plot(t, C*X', 'r', t, ref); title('SALIDA'); grid;
figure; plot(t,U); title('SENAL DE CONTROL'); grid;
end

function dX = ej3_sys(t,X)

global A B C K F

ref = 10 - 2*cos(t);

U=K*X + F*ref; %Ley de control para seguimiento
%U=10;          %Escalon

%ODEs
dX = A*X + B*U;
end