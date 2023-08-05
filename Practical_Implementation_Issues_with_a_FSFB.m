clear all
clc
%% Plant Model (DC Motor)
%Define constraints

R=0.05;
KV=0.09854;
KT=0.09854;
Rm=1.5398;
La=0.0015581;
c=0.00039719;
Jm=0.00137;

%State space representation
A=[0 1 0;
    0 -c/Jm KT/Jm;
    0 -KV/La -(R+Rm)/La];

B=[0 0;
    0 -1/Jm;
    1/La 0];

C=eye(3);

% Look at open loop eigen values of system
open_loop_poles=eig(A);

%% Design a full state feedback controller
%Verify that system is controllabele

pc=ctrb(A,B(:,1));
rank(pc);

%chose desired closed loop pole location
desired_closed_loop_poles=[-100;-110;-120]; %these gave a aggressive controller
desired_closed_loop_poles=[-5;-30;-400];

%Compute full state feedback gain
K=place(A,B(:,1),desired_closed_loop_poles);


