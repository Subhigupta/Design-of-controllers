clear all
clc
%Both examples demonstrate that with place command it is easy to design
%full state feedback control which will place the open loop poles to
%desired poles.
%% Example 1: System is controllable

A=[0 3;2 4];
B=[-2;1];

%check controllability
rank(ctrb(A,B));

%perform pole placement
p_desired=[-5+2*i, -5-2*i];

[K]=place(A,B,p_desired);

% or you can use ackar command

[K_Ackr]=acker(A,B,p_desired); % not reliable for larger order system

%check that the closed loop simulations are in the desired loacation
A_cl=A-B*K;
eig(A_cl);

%% Example 3 where system is controllable with multiple inputs.

B=[-2 1; 1 1];

%check controllability
rank(ctrb(A,B));

[K]=place(A,B,p_desired); %there are infinite solutions

eig(A-B*K); % MATLAb K values yield desired eigen values or poles.

% Check whether what we set K values does it also yield same eigen values.
K_whiteboard=[ 1/10 1/10;
    -1033/241 4471/240];

eig(A-B*K); 


