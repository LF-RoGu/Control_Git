function avion_error_plot(tspan, x0, Pd)

global A B C D Ke

a = -0.313;
b = 56.7;
c = -0.0139;
d = -0.426;
e = 56.7;

f = 0.232;
g = 0.0203;

A = [a, b, 0;
     c, d, 0;
     0, e, 0];
B = [f;
     g;
     0];
C = [1, 0, 1];
D = 0;

Ke = Pd;

[t,X] = ode45(@avion_error_sys,tspan,x0);

ref = 1.5;

dref = 1.5*cos(t);

e = ref - X*C';
U = (C*B)^-1*(dref - X*(C*A)' - Ke*e);

figure;
subplot(3,1,1);plot(t,X(:,1));title('Estado 1');
subplot(3,1,2);plot(t,X(:,2));title('Estado 2');
subplot(3,1,3);plot(t,X(:,3));title('Estado 3');

maxU = max(abs(U));

figure;
subplot(2,1,1);plot(t,X*C',t,ref,'red');title('SALIDA Y REF');grid on;
subplot(2,1,2);plot(t,U);title('ENTRADA');grid on;
end

function dX = avion_error_sys(t, X)

global A B C D Ke

ref = 1.5;

dref = 1.5*cos(t);

e = ref - C*X;

U = (C*B)^-1*(dref * C*A*X - Ke*e);

dX = A*X + B*U;

end