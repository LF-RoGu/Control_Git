ref = 20;
%Polo controlador
Pdc = [-2, -2, -2];
%Polo observador
Pdo = [-4, -4, -4];

%Matrices del sistema
A = [0, 0, 2;
     2, 1, -1;
     0, 0, 2];
B = [3;
     0;
     1];
C = [1, 1, 0];

Dc = [0;
      0;
      0];
Do = [0, 0;
      0, 0;
      0, 0];

%Ganancias Observador
Mo = [C;
      C*A;
      C*(A^2)];
rank(Mo)
Ho = (A - Pdo(1)*eye(3))*(A - Pdo(2)*eye(3))*(A - Pdo(3)-eye(3));
L = -Ho*inv(Mo)*[0;0;1];

%Ganancias Controlador
Mc = [B, A*B, (A^2)*B];
rank(Mc)
Hc = (A - Pdc(1)*eye(3))*(A - Pdc(2)*eye(3))*(A - Pdc(3)-eye(3));
Kc = -[0, 0, 1]*inv(Mc)*Hc;
Fc = 1 / ( C*inv(-A-B*Kc)*B );