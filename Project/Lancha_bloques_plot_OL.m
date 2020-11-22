
Lancha_bloques_plot([0 100], [0 0 0 0 0 pi/4] , 0.3 , pi/3 )
%% funcions
function Lancha_bloques_plot(tspan, x0,nd, thetad)

global n theta 

n = nd; 
theta = thetad; 

%Resuelve las ecuaciones diferenciales ordinarias
[t, X] = ode45(@Lancha_bloques_sys, tspan, x0);
 
%Grafica estados
figure(1);
hold on
subplot(6,1,1); plot(t, X(:,1)); title('Surge')
hold on
subplot(6,1,2); plot(t, X(:,2)); title('Sway')
hold on
subplot(6,1,3); plot(t, X(:,3)); title('Dirección de Psi')
hold on
subplot(6,1,4); plot(t, X(:,4)); title('Posicion en x')
hold on
subplot(6,1,5); plot(t, X(:,5)); title('Posicion en Y')
hold on
subplot(6,1,6); plot(t, X(:,6)); title('Psi')
hold on
%Grafica salida y referencia

%Grafica en plano cartesiano
figure(2); plot(X(:,4),X(:,5)); title('plano cartesiano')
hold on
end

function dX = Lancha_bloques_sys(t, X)
global n theta


n = zeros(1, numel(t))+n;
%theta = 100*sin(2*pi*t);
theta = zeros(1, numel(t))+theta;
%Parametros del sistema
m11 = 54;   m22 = 33.8;  m23 = 1.0115;  m32 = 1.0115;  m33 = 2.76; 
n11 = 15;   n22 = 7;     n23 = 23.8;    n32 = 0.1;     n33 = 1.095;
T1 = 0.26;  T2= 0.1; b = 1; 

%Calcular inversa de Matriz M

fu = (T1*abs(n)*n - T2*abs(n)*n*sqrt(X(1)^2 + (X(6)*b)^2) )*cos(theta);
fr = (T1*abs(n)*n - T2*abs(n)*n*sqrt(X(1)^2 + (X(6)*b)^2) )*sin(theta);

M_inv = [m11 0 0; 0 m22 m23 ; 0 m32 m33]^-1;
N = [ n11 0 0 ; 0 n22 n23 ; 0 n32 n33];

R = [cos(X(6)) -sin(X(6)) 0 ; sin(X(6)) cos(X(6)) 0; 0 0 1]*[ X(4); X(5); X(6)];

dX = [ M_inv*[fu; 0 ; fr*b] - M_inv*N*[X(1) ; X(2) ; X(3) ]; R];
end
