function Exam_sys_plot(tspan,x0)

%Evaluando las ODE's definidas en sys
[t,X] = ode23s(@Exam_sys,tspan,x0);

%Graficando
subplot(6,1,1);plot(t,X(:,1)); title('Estado 1: ~i(t)'); grid;
subplot(6,1,2);plot(t,X(:,2)); title('Estado 2: i(t)'); grid;
subplot(6,1,3);plot(t,X(:,3)); title('Estado 3: p(t)'); grid;
subplot(6,1,4);plot(t,X(:,4)); title('Estado 4: q(t)'); grid;
subplot(6,1,5);plot(t,X(:,5)); title('Estado 5: p`(t)'); grid;
subplot(6,1,6);plot(t,X(:,6)); title('Estado 6: q`(t)'); grid;

end

function dX = Exam_sys(t,X)

L = 2*(10^-3);
C = 1*(10^-6);
R = 1*(10^3);
k1 = 0.3;
k2 = k1;
b1 = 0.1;
b2 = b1;
kl = 500;
M1 = 10;
M2 = 5;

alpha = -k1 / M1;
beta = k1 / M1;
gamma = -b1 / M1;
delta = b1 / M1;
phi = k1 / M2;
sigma = -(k1 + k2) / M2;
ro = b1 / M2;
teta = -(b1 + b2) / M2;

u = -1 / (L*C);
n = -R / L;
lambda = -1 / L;

miu = kl / M1;

A1 = [0, 1;
      u, n];
B1 = [0;
      lambda];
C1 = [0, kl];

A2 = [0, 0, 1, 0;
      0, 0, 0, 1;
      alpha, beta, gamma, delta;
      phi, sigma, ro, teta];
B2 = [0, 0;
      0, 0;
      0, miu;
      0, 0];
C2 = [0, 1, 0, 0];

z0 = zeros(2,4);

A = [A1, z0;
     B2.*C1, A2];
B = [B1; 
     0;
     0;
     0;
     0;];

U = 1;
dX = A*X + B*U;
end