%% Tarea_24
clc; clear; close all;

tspan = [0,10];
x0 = [0,0,0];
kp = 160;
ki = 7.6;
kd = 40;
k = [kp, ki, kd];

controlador_PID_plot(tspan, x0, k)

%% Functions

function controlador_PID_plot(tspan, x0, k)

global A B C Kp Ki Kd

Kp = k(1);
Ki = k(2);
Kd= k(3);

A = [0, 1, 0; 0, 0, 1; -3, -31.1, -11.1];
B = [0;0;1];
C = [1, 0, 0];

[t,X] = ode45(@controlador_PID_sys, tspan, [0, x0]);

ref = 1;
dref = 0;

figure; 


subplot(3,1,1); plot( t, X(:,2:4)*C', 'k'); title('SALIDA  Y REFERENCA'); grid; hold on;
                plot(t, ref*ones(size(t)), 'red'); grid; hold off;

e = ref - X(:,2:4)*C';
subplot(3,1,2); plot(t,e); title('SEÑAL DE ERROR'); grid;

de = dref - X(:,2:4)*A'*C';

ie = X(:,1);

U = Kp*e + Ki*ie + Kd*de; 
subplot(3,1,3); plot(t,U); title('SENAL DE CONTROL'); grid; 
end

function dX = controlador_PID_sys(t,X)

global A B C Kp Ki Kd

ref = 1;
dref = 0;

e = ref - C*X(2:4);
de = dref - C*A*X(2:4)
ie = X(1);

U = Kp*e + Ki*ie + Kd*de; 

dX = [e;      
      A*X(2:4) + B*U];

end