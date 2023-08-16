%Demostrate controllability
clear all
clc

%In both the cases cntrol input has been applied at 45 degree to the block.
%% Example 4: System is controllable with a single input

m=1;
%the horizontal and vertical spring coefficients are different.
k1=1;
k2=4;

A=[0 1 0 0;
    -k1/m 0 0 0;
    0 0 0 1;
    0 0 -k2/m 0];

B=[0;
    1/m;
    0;
    1/m];

Pc=ctrb(A,B);
rank(Pc) % the rank came out be 4
%All the states are controllable and hence on ruuning the simulation of the
%system the states should reach the arbitrary state independently

[V,D]=eig(A)

%% Example 5: System is uncontrollable with a single input

m=1;
%the horizontal and vertical spring coefficients are same.
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
rank(Pc) %Rank is two.

[V,D]=eig(A)
%If we run the dynamics in simulink then we see that only two state are
%able to reach an arbitrary state independently.