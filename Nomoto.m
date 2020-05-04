close all;
clear;
clc;

%% Nomoto second order TF

% (yaw / d) = ( K*(1+T3*s) ) / ( (1 + T1*s)*(1 + T2*s) );
% 
% dx1 = d_yaw;
% dx2 = dd_yaw;
% dx3 = dd_yaw - b0-d;

%%

K = 0.185;
T1 = 118;
T2 = 7.8;
T3 = 18.5;

a1 = (T1 + T2) / (T1*T2);
a2 = 1 / (T1*T2);

b1 = K / (T1*T2);
b0 = (T3*K) / (T1*T2);

A = [0, 1, 0;
     0, 0, 1;
     0,-a2,-a1];
B = [0;
     b0;
     b1 - (a1*b0)];
C = eye(3);

%% Nomoto first order TF

K = 0.185;
T1 = 118;
T2 = 7.8;
T3 = 18.5;

T = T1 + T2 - T3;

a1 = -1/T;

b1 = K/T;

A = [0, 1;
     0, a1];
B = [0;
     b1];
C = eye(2);