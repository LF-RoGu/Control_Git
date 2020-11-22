% Vector de tiempo para espacio de estados
tspan = [0 10];
% Condiciones iniciales
x0 = [10; 10; 10; 10];

Pdc = -1/5;

ex_plot(tspan,x0,Pdc);

%% Functions
function ex_plot(tspan, x0, Pdc)

global A B C D L Ke

A = [-17, 10, -12, -17;
     13, 9, 8, -15;
     16, -4, -17, 12;
     7, 6, -8, 7];
B = [0, 2;
     0, -1;
     -2, 0;
     1, 0];
C = [1, 1, 1, 1;
     0.01, 0, 0, 0];

Mc = C*B
det(Mc)

Ke = Pdc;

[t,X] = ode45(@ex_plot_sys,tspan,x0);

ref = [1000, 0];

dref = 0;

y = X*C';
e = [ref(:,1)-y(:,1), ref(:,2)-y(:,2)];
U = (dref - X*(C*A)' - Ke*e)*inv(C*B);

figure;
subplot(4,1,1);plot(t,X(:,1));title('Estado 1');
subplot(4,1,2);plot(t,X(:,2));title('Estado 2');
subplot(4,1,3);plot(t,X(:,3));title('Estado 3');
subplot(4,1,4);plot(t,X(:,4));title('Estado 4');

maxU = max(abs(U));

% figure;
% subplot(4,1,1);plot(t,y(:,1),t,ref(:,1),'red');title('SALIDA 1 Y REF');grid on
% subplot(4,1,2);plot(t,y(:,2),t,ref(:,2),'red');title('SALIDA 2 Y REF');grid on;
% subplot(4,1,3);plot(t,U(:,1));title('ENTRADA 1');grid on; 
% subplot(4,1,4);plot(t,U(:,2));title('ENTRADA 2');grid on;
end

function dX = ex_plot_sys (t,X)
global A B C D L Ke
ref = [1000; 0];

dref = 0;
    
e = [ref(1,:) - C(1,:)*X ; ref(2,:) - C(2,:)*X];

U = inv(C*B)*(dref - C*A*X - Ke*e);

dX = A*X + B*U;

end