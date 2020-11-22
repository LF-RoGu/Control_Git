function tarea_21_plot(tspan, x0, Pd)
   

%syms R;
%syms L;
%syms Kb;
%syms Jm;
%syms Kt;
%syms B;

R = 1.1648;
L = 0.0068;
Kb = 0.82;
Kt = 0.55;
Jm = 0.0271;
B = 0.00776;

a = R/L;
b = Kb/L;
c = Kt/Jm;
d = B/Jm;

e = 1/L;

A1 = [-a, -b;c, -d];
B1 = [e; 0];
C1 = [0, 1];
D1 = 0;

M = 1;
m = 0.1;
l = 0.3;
g = 9.81;

alpha = (m/M)*g;
beta = (m+M)*(g/M);
sigma = 1 / M;
phi = 1 / (M*l);

A2 = [0, 0, 1, 0; 0, 0, 0, 1; 0, -alpha, 0, 0; 0, beta, 0, 0];
B2 = [0; 0; -sigma; -phi];
C2 = [0, 1, 0, 0];
D2 = 0;

z0 = zeros(2,4);

A = [A1, z0; B2*C1, A2];
B = [B1; 0; 0; 0; 0];
C = C2;R = 1.1648;
L = 0.0068;
Kb = 0.82;
Kt = 0.55;
Jm = 0.0271;
B = 0.00776;

a = R/L;
b = Kb/L;
c = Kt/Jm;
d = B/Jm;

e = 1/L;

A1 = [-a, -b;c, -d];
B1 = [e; 0];
C1 = [0, 1];
D1 = 0;

M = 1;
m = 0.1;
l = 0.3;
g = 9.81;

alpha = (m/M)*g;
beta = (m+M)*(g/M);
sigma = 1 / M;
phi = 1 / (M*l);

A2 = [0, 0, 1, 0; 0, 0, 0, 1; 0, -alpha, 0, 0; 0, beta, 0, 0];
B2 = [0; 0; -sigma; -phi];
C2 = [0, 1, 0, 0];
D2 = 0;

z0 = zeros(2,4);

A = [A1, z0; B2*C1, A2];
B = [B1; 0; 0; 0; 0];
C = C2;

end