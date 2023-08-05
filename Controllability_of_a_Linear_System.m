%Demostrate controllability
clear all
clc
%% Example 5: System is uncontrollable with a single input

m=1;
k1=1/3;
k2=1/3;

A=[0 1 0 0;
    -k1/m 0 0 0;
    0 0 0 1;
    0 0 -k2/m 0];

B=[0;
    1/m;
    0;
    1/m];

Pc=ctrb(A,B);
rank(Pc)

[V,D]=eig(A)

