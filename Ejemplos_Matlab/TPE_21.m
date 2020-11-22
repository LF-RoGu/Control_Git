%% TPE 2.1
close all;clc; clear;

tspan = [0,10];
x0 = [0;0;0;0];
Pd = [-4/3];

pendulo_inv_error_plot(tspan, x0, Pd);
%% Functions
function pendulo_inv_error_plot(tspan, x0, Pd)

global A B C Ke

a = 20.601;
b = -0.4905;
c = -1;
d = 0.5;

A = [0, 1, 0, 0;
     a, 0, 0, 0;
     0, 0, 0, 1;
     b, 0, 0, 0];
B = [0, 0;
     c, 0;
     0, 0;
     d, 1];
C = [0, 1, 0, 0;
     0, 0, 0, 1];
D = 0;

Ke = Pd;

Mc = C*B
rank(Mc)

[t,X] = ode45(@pend_inv_sys,tspan,x0);

%ref = 1.5;
ref = [1.5*sin(t), 2 + 1.5*cos(t)];

%dref = 0;
dref = [1.5*cos(t), -1.5*sin(t)];

% e = r(t) - y(t)
y = X*C';
e = [ref(:,1)-y(:,1), ref(:,2)-y(:,2)];
U = (dref - X*(C*A)' - Ke*e)*inv(C*B);

figure;
subplot(4,1,1);plot(t,X(:,1));title('Estado 1');
subplot(4,1,2);plot(t,X(:,2));title('Estado 2');
subplot(4,1,3);plot(t,X(:,3));title('Estado 3');
subplot(4,1,4);plot(t,X(:,4));title('Estado 4');

figure;
subplot(4,1,1);plot(t,y(:,1),t,ref(:,1),'red');title('SALIDA 1 Y REF');grid on;
subplot(4,1,2);plot(t,y(:,2),t,ref(:,2),'red');title('SALIDA 2 Y REF');grid on;
subplot(4,1,3);plot(t,U(:,1));title('ENTRADA 1');grid on;
subplot(4,1,4);plot(t,U(:,2));title('ENTRADA 2');grid on;
end

function dX = pend_inv_sys(t, X)

global A B C Ke

%ref = 1.5;
ref = [1.5*sin(t); 2 + 1.5*cos(t)];

%dref = 0;
dref = [1.5*cos(t); -1.5*sin(t)];

e = [ref(1,:) - C(1,:)*X ; ref(2,:) - C(2,:)*X];

U = inv(C*B)*(dref - C*A*X - Ke*e);

dX = A*X + B*U;

end