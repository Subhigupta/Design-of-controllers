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

D=zeros(3,2);

% Look at open loop eigen values of system
open_loop_poles=eig(A);

%% Design a full state feedback controller
%Verify that system is controllabele

pc=ctrb(A,B(:,1));
rank(pc);

%chose desired closed loop pole location
%desired_closed_loop_poles=[-100;-110;-120]; %these gave a aggressive controller
%desired_closed_loop_poles=[-5;-30;-400]; %less aggressive controller
desired_closed_loop_poles=[-2;open_loop_poles(2);open_loop_poles(3)];%only move poles that are associated with states that are really measurable

%Compute full state feedback gain
K=place(A,B(:,1),desired_closed_loop_poles);

%% SImulate the system

t_final=2;
x0=[72*pi/180;
    2*pi;
    -1];

%sim('Full_state_feedback_control_model')

% %From model with full state feedback
% t       = sim_X.time;
% x1      = sim_X.signals.values(:,1);
% x2      = sim_X.signals.values(:,2);
% x3      = sim_X.signals.values(:,3);
% Va      = sim_Va.signals.values(:,1);
% 
% x1_tilde = sim_X_tilde.signals.values(:,1);
% x2_tilde = sim_X_tilde.signals.values(:,2);
% x3_tilde = sim_X_tilde.signals.values(:,3);
% Va_tilde = sim_Va_tilde.signals.values(:,1);
% 
% %Create plots
% figure
% subplot(3,1,1)
% plot(t, x1, t, x1_tilde, 'LineWidth', 2)
% ylabel('x_1(t)')
% grid on
% title('Response of System with Full State Feedback Controller')
% 
% subplot(3,1,2)
% plot(t, x2, t, x2_tilde, 'LineWidth', 2)
% ylabel('x_2(t)')
% grid on
% 
% subplot(3,1,3)
% plot(t, x3, t, x3_tilde, 'LineWidth', 2)
% ylabel('x_3(t)')
% grid on
% xlabel('Time (sec)')
% 
% figure
% plot(t, Va, t, Va_tilde, 'LineWidth', 2)
% ylabel('V_a(t)')
% grid on
% title('Control Signal, V_a')
% 
% disp('DONE')
% 
% 
