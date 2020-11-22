%% Sistema 4
A = [-2, -1;
     0, 3];
B = [2, 1, 3;
     -4, -2, 1];
C = [2, 1;
     1, 3;
     0, 1];
 
 
% Vector de tiempo para espacio de estados
tspan = [0 10];
% Condiciones iniciales
x0 = [10, 10];

Pdc = -5;
Pdo = [-4, -4];

exam_plot(tspan, x0, Pdo, Pdc)
%% Sistema 5
A = [-2, 0;
     1, -3];
B = [2, -1;
     1, 3];
C = [1, -2;
     -3, 6];
 
 Mc = [B (A)*B]; rank(Mc)
 Mo = [C C*A]'; rank(Mo)
 
 %% functions

 function exam_plot(tspan, x0, Pdo, Pdc)
  global A B C L Ke
 %matrices
A = [-2, -1;
     0, 3];
B = [2, 1, 3;
     -4, -2, 1];
C = [2, 1;
     1, 3;
     1, 0];
C1 = C(1,:);
C2 = C(2,:);
 %diseño de observador
Mo = [C C*A]'; rank(Mo)

Ho = (A - Pdo(1)*eye(2))*(A - Pdo(2)*eye(2));
L = -Ho*inv(Mo)*[0;1];

%diseño de controlador
Ke = Pdc;

[t,X] = ode45(@exam_sys, tspan, [x0 0 0]);

%graph
 end
 
 function dX = exam_sys(t,X)
 
 global A B C L Ke
 
 x = X(1:2);
 xo = X(3:4);
 
ref = [sin(t);
       cos(t)];
    
dref = [cos(t);
       -sin(t)];
   
e = ref - C*x;
U = (C*B)^-1 * (dref*C*A*x-Ke*e);

Y = C*x;
Ye = Y - C*xo;

dx = A*x + B*U;
dxo = A*xo + B*U - L*Ye;

dx = [dx;
      dxo]

 end