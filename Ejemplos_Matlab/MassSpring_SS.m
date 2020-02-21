function MassSpring_SS(x0)
%Parametros del sistema
M = 2; 
b = 6; 
k = 4;

%Matrices del sistema
A = [0 1;-k/M -b/M];
B = [0;1/M];
C = [1 0];
D = 0;

%Modelo en SS
MassSpring_sys = ss(A,B,C,D);

%Graficando
    %Condiciones iniciales
[y,t,X] = initial(MassSpring_sys,x0);
figure;
subplot(2,1,1); plot(t,X(:,1)); title('Estado 1'); grid on;
subplot(2,1,2); plot(t,X(:,2)); title('Estado 2'); grid on;

    %Entradas
t = 0:0.01:10;
u = 2*sin(t);
[y,t,X] = lsim(MassSpring_sys,u,t,x0);
figure;
subplot(2,1,1); plot(t,X(:,1)); title('Estado 1'); grid on;
subplot(2,1,2); plot(t,X(:,2)); title('Estado 2'); grid on;
end