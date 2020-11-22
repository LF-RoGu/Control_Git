%% TPE 2.2
close all;clc; clear;

tspan = [0,10];
x0 = [0;0;0;0];
Pd = [-2,-2,-2];

controlador_bloques_plot(tspan, x0, Pd)
%% Opcion 2 (3 bloques)
    % A x1 lo contrlamos con x2
        % A x2 lo controlamos con x3
            % A x3 lo controlamos con u
%% Codigo matlab

function controlador_bloques_plot(tspan, x0, Pd)

global A B C k1 k2 k3

A = [ -4, 4, 0, 2; 
      0, -3, 3, 0; 
      0, 2, -5, 0; 
      1, 1, -4, -5];
B = [0;
     0;
     10;
     0];
C = [1, 0, 0, 0];

%Polos deseados
k1 = Pd(1);
k2 = Pd(2);
k3 = Pd(3);

[t,X] = ode45(@controlador_bloques_sys,tspan,x0);

%y_ref
ref = -3 + 2*cos(2*t);
%dy_ref
dref = -4*sin(2*t);
%ddy_ref
ddref = -8*cos(2*t);
%dddy_ref
dddref = 16*sin(2*t);

%Bloques
dx1 = -4*X(:,1) + 4*X(:,2) + 2*X(:,4);
dx2 = -3*X(:,2) + 3*X(:,3);
%dx3 = 2*X(:,2) - 5*X(:,3) + 10*U;
dx4 = X(:,1) + X(:,2) - 4*X(:,3) - 5*X(:,4);

%Señales de error
    %Paso 1: definimos el error para la salida
e1 = ref - X(:,1);
    %Paso 2: eleginmos opcion a usar (x2 o x4) / elegimos x2
d_e1 = ref - dx1;
    %Paso 3: definimos la dinamica que queremos en el error e_1
        %sustituye x2 por k1*e1
x2_ref = (1/4)*(dref + 4*X(:,1) - 2*X(:,4) - k1*e1);
    %Paso 4: definimos la siguiente variable como
e2 = x2_ref - X(:,2);
    %Paso 5: elegimos usar x3, por que ya controlamos x2 anteriormente
d_e2 = x2_ref - dx2;
    %Paso 7': calculamos dx2_ref
dx2_ref = (1/4)*(ddref + k1*dref + (4+k1)*dx1 - 2*dx4);
    %Paso 9'': calculamos ddx2_ref
ddx2_ref = (1/4)*(dddref - k1*ddref + (4+k1)*(-4*dx1 + 4*dx2 + 2*dx4) - 2*(dx1 + dx2 - 4*(2*X(:,2) - 5*X(:,3)) - 5*dx4));
    %Paso 6: definimos la dinamica que queremos en el error e_2
        %sustituye x3 por k2*e2
x3_ref = (1/3)*(dx2_ref + 3*X(:,2) - k2*e2);
    %Paso 7: sustituimos dx2_ref en x3_ref
        %sube para el paso 7' para calcular dx2_ref
    %Paso 8: definimos el error para la salida
        %sabemos que este bloque se controla con U
e3 = x3_ref - X(:,3);
    %Paso 9': calculamos dx2_ref
        %sube para calcular ddx2_ref
dx3_ref = (1/3)*(ddx2_ref + 3*dx2 - k2*(dx2_ref - dx2));
    %Paso 9: calculamos la ley de control
        %sube para el paso 9' para calcular dx3_ref y delta 
delta = ddx2_ref;
U = (3/10)*( (1/3)*(delta + 3*dx2 - k2*d_e2) - 2*X(:,2) + 5*X(:,3) - k3*e3 );

figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

figure;
subplot(2,1,1); plot(t, X(:,1), t, ref, 'red'); title('SALIDA Y REFERENCA'); grid;
subplot(2,1,1);  plot(t, U);                    title('SENAL DE CONTROL'); grid;

end

function dX = controlador_bloques_sys(t,X)

global A B C k1 k2 k3

%y_ref
ref = -3 + 2*cos(2*t);
%dy_ref
dref = -4*sin(2*t);
%ddy_ref
ddref = -8*cos(2*t);
%dddy_ref
dddref = 16*sin(2*t);

%Bloques
dx1 = -4*X(1) + 4*X(2) + 2*X(4);
dx2 = -3*X(2) + 3*X(3);
%dx3 = 2*X(2) - 5*X(3) + 10*U;
dx4 = X(1) + X(2) - 4*X(3) - 5*X(4);

%Señales de error
    %Paso 1: definimos el error para la salida
e1 = ref - X(1);
    %Paso 2: eleginmos opcion a usar (x2 o x4) / elegimos x2
d_e1 = ref - dx1;
    %Paso 3: definimos la dinamica que queremos en el error e_1
        %sustituye x2 por k1*e1
x2_ref = (1/4)*(dref + 4*X(1) - 2*X(4) - k1*e1);
    %Paso 4: definimos la siguiente variable como
e2 = x2_ref - X(2);
    %Paso 5: elegimos usar x3, por que ya controlamos x2 anteriormente
d_e2 = x2_ref - dx2;
    %Paso 7': calculamos dx2_ref
dx2_ref = (1/4)*(ddref + k1*dref + (4+k1)*dx1 - 2*dx4);
    %Paso 9'': calculamos ddx2_ref
ddx2_ref = (1/4)*(dddref - k1*ddref + (4+k1)*(-4*dx1 + 4*dx2 + 2*dx4) - 2*(dx1 + dx2 - 4*(2*X(2) - 5*X(3)) - 5*dx4));
    %Paso 6: definimos la dinamica que queremos en el error e_2
        %sustituye x3 por k2*e2
x3_ref = (1/3)*(dx2_ref + 3*X(2) - k2*e2);
    %Paso 7: sustituimos dx2_ref en x3_ref
        %sube para el paso 7' para calcular dx2_ref
    %Paso 8: definimos el error para la salida
        %sabemos que este bloque se controla con U
e3 = x3_ref - X(3);
    %Paso 9': calculamos dx2_ref
        %sube para calcular ddx2_ref
dx3_ref = (1/3)*(ddx2_ref + 3*dx2 - k2*(dx2_ref - dx2));
    %Paso 9: calculamos la ley de control
        %sube para el paso 9' para calcular dx3_ref y delta 
delta = ddx2_ref;
U = (3/10)*( (1/3)*(delta + 3*dx2 - k2*d_e2) - 2*X(2) + 5*X(3) - k3*e3 );

dX = A.*X + B.*U;

end