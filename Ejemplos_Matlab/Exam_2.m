%Examen_2 705694
tspan = [0,10];
x0 = [0;0];
Pd = [-30,-30];

ej2_plot(tspan, x0, Pd);
%% Functions
function ej2_plot(tspan, x0, Pd)

global A B C k1 k2

k1 = Pd(1);
k2 = Pd(2);

%RESUELVE LAS ECUACIONES DIFERENCIALES ORDINARIAS (ODES)
[t, X] = ode45(@ej2_sys,tspan,x0);

y_ref = 2-exp(-t);
dy_ref = exp(-t);
ddy_ref = -exp(-t);



figure;
subplot(3,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(3,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(3,1,3); plot(t, X(:,1),t, y_ref, 'red'); title('SALIDA Y REFERENCA');grid;
end

function dX = ej2_sys(t,X)

global A B C k1 k2

B = [0;1];

dx1 = -(X(1)^2) + 2*X(2);
dx2 = -3*sin(X(1))-4*X(1)*X(2);

y_ref = 2-exp(-t);
dy_ref = exp(-t);
ddy_ref = -exp(-t);

e1 = y_ref - X(1);
d_e1 = dy_ref - dx1;

x2_ref = (1/2)*(dy_ref + X(1)^2 - e1*k1);
dx2_ref = (1/2)*(ddy_ref + 2*dx1 - d_e1*k1);

e2 = x2_ref - X(2);

U = dx2_ref + 3*sin(X(1)) + 4*X(1)*X(2) - e2*k2;

%ODEs
dX = [dx1;
      dx2] + B*U;
end