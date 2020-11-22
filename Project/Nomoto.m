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

K = -0.0032;
T1 = 118;
T2 = 7.8;
T3 = 18.5;

T = 0.4702;

a1 = -1/T;

b1 = K/T;

A = [0, 1;
     0, a1];
B = [0;
     b1];
C = eye(2);

Mc = [B A*B]

det(Mc)

Q = [3, 0;
     0, 1000];
R = 100;

K = lqr(A,B,Q,R);

%% Nomoto second order TF

% Estados son
%v_p
%r_p
syms v_p;
syms r_p;
x = [v_p;
     r_p];
 
 
%Info del barco
syms T; %d entre agua y punto mas bajo del buque / calado
syms L; %long del buque / eslora

syms m;
syms Xg;
syms Y_v_p;
syms Y_r_p;
syms N_v_p;
syms N_r_p;
syms Iz;
syms Y_v;
syms N_v;
syms Uo;
syms Y_r;
syms N_r;

syms Y_d;
syms N_d;

syms T;

a11 = m-Y_v_p;
a12 = m*Xg - Y_r_p;
a21 = m*Xg - N_v_p;
a22 = Iz-N_r_p;

b11 = -Y_v;
b12 = m*Uo - Y_r;
b21 = -N_v;
b22 = m*Xg*Uo - N_r;

u1 = Y_d;
u2 = N_d;

M = [a11, a12;
     a21, a22];
N = [b11, b12;
     b21, b22];
b = [u1;
     u2];
 
A = -inv(M)*N;
B = -inv(M)*b;
C = eye(2);

%%

% Estados son
%r_p
%r_pp
syms r_p;
syms r_pp;
x = [r_p;
     r_pp];
 
K_r = 0.1724;
T1 = 2.0875;
T2 = 0.3179;
T3 = 0.1830;

T = T1 + T2 - T3;
 
x = -(T1+T2)/(T1*T2);
y = K_r;
z = K_r*T3;

A = [1, 0;
     1, x];
B = [y;
     z];
C = eye(2);
 
Mc = [B A*B]
   
det(Mc)
