
Lancha_bloques_plot([0 50], [0 0 0 0 0 0] , [-100,-150])
%%
function Lancha_bloques_plot(tspan, x0,K)

global k1 k2 b

global y1_ref y2_ref

k1 = K(1);
k2 = K(2);
b = 1;
%Resuelve las ecuaciones diferenciales ordinarias
[t, X] = ode45(@Lancha_bloques_sys, tspan, x0);
 
y1_ref = 5*t.^3;
y2_ref = 5*t.^2;

%Grafica estados
figure(1);
hold on
subplot(6,1,1); plot(t, X(:,1)); title('Estado 1: u')
hold on
subplot(6,1,2); plot(t, X(:,2)); title('Estado 2: v')
hold on
subplot(6,1,3); plot(t, X(:,3)); title('Estado 3: r')
hold on
subplot(6,1,4); plot(t, X(:,4)); title('Estado 4: x')
hold on
subplot(6,1,5); plot(t, X(:,5)); title('Estado 5: y')
hold on
subplot(6,1,6); plot(t, X(:,6)); title('Estado 6: psi')
hold on
%Grafica salida y referencia
figure(2); 
subplot(2,1,1); plot(t, X(:,4),t,y1_ref,'r');title('SALIDA 1 Y REF');grid
subplot(2,1,2); plot(t, X(:,5),t,y2_ref,'r');title('SALIDA 2 Y REF');grid
hold on
%Grafica en plano cartesiano
figure(3); plot(X(:,4),X(:,5)); title('plano cartesiano')
hold on
end

function dX = Lancha_bloques_sys(t, X)

global k1 k2 b

global y1_ref y2_ref

y1_ref = 5*t.^3;
y2_ref = 5*t.^2;

x4_ref = y1_ref;
x5_ref = y2_ref;

dx4_ref = 15*t.^2;
dx5_ref = 5*t;

ddx4_ref = 30*t;
ddx5_ref = 5;

e1 =  [x4_ref;
       x5_ref] - [X(4);
                  X(5)];
d_e1 = [dx4_ref; 
        dx5_ref ] - [ cos(X(6)), -sin(X(6)); 
                      sin(X(6)), cos(X(6))];

x_ref = [ cos(X(6)), sin(X(6));
             -sin(X(6)), cos(X(6))]*(  [dx4_ref; 
                                        dx5_ref ]  - k1*e1);

dx_ref = [ -sin(X(6)), cos(X(6));
              -cos(X(6)), -sin(X(6))]*( [dx4_ref; 
                                         dx5_ref ] -e1*k1 ) + [ cos(X(6)), sin(X(6));
                                                               -sin(X(6)), cos(X(6))]*( [ddx4_ref;
                                                                                         ddx5_ref] -d_e1*k1 );
e2 = [x_ref(1);
      x_ref(2)] - [X(1);
                 X(2)];
             
u = inv([0.0185, 0;
            0, 0.0110*b])*( [dx_ref(1);
                             dx_ref(2)] - [-0.2775, 0;
                                         0.7*X(3), 0.2083]*[X(1);
                                                            X(2)] -e2*k2 );
dX = [-0.2775*X(1);0.7*X(1)*X(3) + 0.2083*X(2);0.7*X(1)*X(3) + 0.2083*X(2);X(1)*cos(X(6))-X(2)*sin(X(6));X(1)*sin(X(6)) + X(2)*cos(X(6));X(3)] + [[0.0185, 0;0,0.011*b];0, 0.011*b;0, 0;0, 0;0, 0]*u;

end
