% Vector de tiempo para espacio de estados
tspan = [0 10];
% Condiciones iniciales
x0 = [100, 100, 100, 100]';

Pd = [-20;-40;-20;-10];

motor_cd_plot(tspan,x0,Pd);

%% Functions
function motor_cd_plot(tspan, x0, Pd)

global A B C D K F

A = [-17, 10, -12, -17;
     13, 9, 8, -15;
     16, -4, -17, 12;
     7, 6, -8, 7];

% B = [0;
%      0;
%      -2;
%      1];
B = [2;
     -1;
     0;
     0];
% B = [0, 2;
%      0, -1;
%      -2, 0;
%      1, 0];
C = [1, 1, 1, 1];
D = 0;

Mc = [B A*B A^2*B A^3*B]; rank(Mc)

H = ( A - Pd(1)*eye(4) )*( A - Pd(2)*eye(4) )*( A - Pd(3)*eye(4) )*( A - Pd(4)*eye(4) );

K = -[0 0 0 1]*inv(Mc)*H;

F = 1 / ( C*inv( -A-B*K ) * B );

[t,X] = ode45(@motor_cd_sys,tspan, x0);

ref = 1000; %rad/s

U = X*K' + F*ref;

maxU = max( abs(U) )

figure;
subplot(4,1,1); plot(t, X(:,1)); title('ESTADO 1'); grid;
subplot(4,1,2); plot(t, X(:,2)); title('ESTADO 2'); grid;
subplot(4,1,3); plot(t, X(:,3)); title('ESTADO 3'); grid;
subplot(4,1,4); plot(t, X(:,4)); title('ESTADO 4'); grid;

end

function dX = motor_cd_sys (t,X)

global A B C D K F

ref = 1000; %rad/s
    
U = K*X + F*ref;

dX = A*X + B*U;

end