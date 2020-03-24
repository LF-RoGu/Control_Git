
function motor_cd_plot(tspan, x0, Pd)

global A B C D K F

R = 15;
L = 5*(10^-3);
Jm = 8.5*(10^-6);
B = 3.5*(10^-7);
Kt = 12*(10^-3);
Kb = 12*(10^-3);


a = R/L;
b = Kb/L;
c = Kt/Jm;
d = B/Jm;

e = 1/L;

A = [-a, -b;c, -d];
B = [e; 0];
C = [0, 1];
D = 0;

Mc = [B A*B];

H = ( A - Pd(1)*eye(2) )*( A - Pd(2)*eye(2) );

K = -[0 1]*inv(Mc)*H;

F = 1 / ( C*inv( -A-B*K ) * B );

[t,X] = ode45(@motor_cd_sys,tspan, x0);

ref = 5000; %rad/s

U = X*K' + F*ref;

maxU = max( abs(U) )

figure;
subplot(2,1,1); plot(t, X(:,1)); title('ESTADO 1: i(t)'); grid;
subplot(2,1,2); plot(t, X(:,2)); title('ESTADO 2: w(t)'); grid;

end

function dX = motor_cd_sys (t,X)

global A B C D K F

ref = 5000; %rad/s

U = K*X + F*ref;

dX = A*X + B*U;

end