%vect = [1, 1, 1, 1];
%Q = diag(vect);
%R = 0.001;
%x0 = [0,0,3,0];
%tspan = [0, 5];

function PendInv_LQR_plot(tspan, x0, Q, R)

global A B C K F

M = 1;
m = 0.1;
g = 9.81;
l = 0.5;

a = (M + m) * g / (M + l);
b = (-m*g/M);
c = -1/(M*l);
d = 1/M;

A = [0, 1, 0, 0;
     a, 0, 0, 0;
     0, 0, 0, 1;
     b, 0, 0, 0];
B = [0;
     c;
     0;
     d];
C = [0, 0, 1, 0];

Mc = [B, A*B, A^2*B, A^3*B];

K = lqr(A,B,Q,R);

ref = 2;

F = 1/(C*(-A-B*K)^-1*B);

eigs(A-B*K);

[t,X] = ode45(@PendInv_LQR_sys,tspan,x0);

close all;

figure;
subplot(4,1,1);plot(t,X(:,1));title('Estado 1');
subplot(4,1,2);plot(t,X(:,2));title('Estado 2');
subplot(4,1,3);plot(t,X(:,3));title('Estado 3');
subplot(4,1,4);plot(t,X(:,4));title('Estado 4');

figure;
plot(t,-K*X');title('Control Signal');

end

function dX = PendInv_LQR_sys(t, X)

global A B K F ref

U = -K*X;

dX = A*X + B*U;
end