Ra = 1.19;
Jm = 0.8;
La = 0.013;
Bm = 0.1;
Kb = 0.78;
Kt = 0.78;

A = [-Ra/La, -Kb/La;
     Kt/Jm, -Bm/Jm];
B = [1/La;
     0];
C = [0, 1];

Pdo = [-40, -40];

%Ganancias Observador
Mo = [C;
      C*A];

rank(Mo)

Ho = (A - Pdo(1)*eye(2)) * (A - Pdo(2)*eye(2));
L = -Ho*inv(Mo)*[0;1];