
function LQR_motor_cd_plot(tspan, x0, Q, R)
%Q = tiempo
%R = Amplitud
global A B C K F ref

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

Mc = [B A*B];

K = lqr(A,B,Q,R);

F = 1 / ( C*inv( -A-B*K ) * B );

ref = 5000; %rad/s

eigs(A-B*K) % Comprobamos ubicacion de los polos en lazo cerrado

[t,X] = ode45(@LQR_motor_cd_sys,tspan, x0);

figure;
subplot(2,1,1); plot(t, X(:,1)); title('ESTADO 1: i(t)'); grid;
subplot(2,1,2); plot(t, X(:,2)); title('ESTADO 2: w(t)'); grid;

figure;
plot(t, -K*X'); title('SEÑAL DE CONTROL'); grid on;

end

function dX = LQR_motor_cd_sys (t,X)

global A B C K F ref

%U = -K*X;
U = -K*X-F*ref;

dX = A*X + B*U;

end