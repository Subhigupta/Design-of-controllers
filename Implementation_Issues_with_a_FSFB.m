clear all
clc
%This code demonstrates two major pratical implementation issues associated
%with FSFB design 1) Aggressiveness (control saturation) 2)Inability to
%measure states.
%After defining the system and the desired poles location, a simulink file
%is run to demonstrate how the FSFB design affect system dynamics.

%% Plant Model (DC Motor)

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

D=zeros(3,2);

% Look at open loop eigen values of system
open_loop_poles=eig(A);

%% Design a full state feedback controller
%Verify that system is controllabele

pc=ctrb(A,B(:,1));
rank(pc);

%chose desired closed loop pole location
%desired_closed_loop_poles=[-100;-110;-120]; %case 1 : these gave a aggressive controller
%desired_closed_loop_poles=[-5;-30;-400]; %case 2: less aggressive controller
%In case 2 we assume that all the gains are non-zero and in another case we assume k2 and k3 are zero. 
desired_closed_loop_poles=[-2;open_loop_poles(2);open_loop_poles(3)];%case 3: only move poles that are associated with states that are really measurable

%Compute full state feedback gain
K=place(A,B(:,1),desired_closed_loop_poles); % k2 and k3 values come very small so we can neglect them.

%% Simulate the system

t_final=2;
x0=[72*pi/180;
    2*pi;
    -1];
