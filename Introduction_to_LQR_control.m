clear
clc
%close all

%Define system
m = 1;
c = 0.2;

A = [0 1;
0 -c/m];

B = [0;
1/m];

%Choose Q and R
scenario = 3;   %1 = cheap control/aggressive controller (states will go quickly to zero)
                %2 = expensive control
                %3 = ignore position

switch scenario
    case 1
        %Cheap control
        Q = diag([1 1]);
        R = [0.01];
        
    case 2
        %Expensive control
        Q = diag([1 1]);
        R = [1000];
        
    case 3
        %Only penalize the velocity state
        Q = diag([0.001 10]);
        R = [1];
        
    otherwise
        error('Unknown method')
end

[K, S, E] = lqr(A, B, Q, R); %full LQR process is packaged into one MATLAB function
%K is full state feedback control gain matrix that corresponds to a stable system.
%S is the solution of algebraic recatti equation (ARE)
%E are the stable eigen values

disp('K computed via LQR:')
K

%Running a simulation to determine how the system respond under the
%designed controller.

%Initial condition
t_final = 30;
x0 = [pi;
    -2];