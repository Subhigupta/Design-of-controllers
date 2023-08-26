%In the earlier codes we have seen what C matrix makes the inverted
%pendulum state observable.
% Now we will develop Kalman Filter to estimate the full states.
%% System Parameters for inverted Pendulum in downward position.
clear all
clc

m=1;
M=5;
L=2;
g=-10;
d=1;

s=-1; %(pendulum down(s=1))

A=[0 1 0 0;
    0 -d/M -m*g/M 0;
    0 0 0 1;
    0 -s*d/(M*L) -s*(m+M)*g/(M*L) 0];

B=[0;1/M;0;s*1/(M*L)];

C=[1 0 0 0]; %scalar position is observable.

D=zeros(size(C,1),size(B,1));

%% Augment system with disturbances and noise.
%Here we are not using feedback i.e. no LQR. We are simply passing y and u
%to Kalman Filter to estimate ful state.

Vd=0.1*eye(4); %disturbance covariance
Vn=1; % noise covariance

%Vd and Vn work as tuning parameters now like Q and R matrices.
%If model uncertainity is high then Vd is made larger.
%If the sensors used are noisy then Vn is made larger.

BF=[B Vd 0*B]; % augments inputs with disturbances and noise.So In total now there are 6 control inputs.
DF=[zeros(size(C,1),size(B,1)) 0 Vn]; % augments inputs with disturbances and noise.

sysC=ss(A,BF,C,DF); %build state space system when one measurement is done.
sysFullOutput=ss(A,BF,eye(4),zeros(4,size(BF,2))); %system with full state output, disturbance is there through BF but zero noise through DF.

%% Build Kalman Filter
[Kf,P,E]=lqe(A,Vd,C,Vd,Vn); %Calculating kalman filter gain.
Kf=(lqr(A',C',Vd,Vn))';

sysKF=ss(A-Kf*C, [B Kf], eye(4), 0*[B Kf]); % Linear dynamical system of kalman filter.

%In real world we have only y and u available.
%% Estimate Linearised system in "down" position
dt=0.01;
t=dt:dt:50; % 5000 columns

uDIST=randn(4,size(t,2));
uNOISE=randn(size(t));
u=0*t; % I will start with zero input
u(100:120)=100; %big positive impulse
u(1500:1520)=-100; %big negative impulse

uAUG=[u; Vd*Vd*uDIST; uNOISE];

[y,t]= lsim(sysC,uAUG,t);%simulating the system. The one measurement from sysC has noise in measuremet.
plot(t,y,'b','LineWidth',2);
hold on
[xtrue,t]=lsim(sysFullOutput,uAUG,t); %Considering all states are measurable.
plot(t,xtrue(:,1),'r','LineWidth',2) %Same disturbance but zero noise. This is true measurement y without measurement noise.
hold on
%% Kalman filter estimate
[x_hat,t]=lsim(sysKF,[u;y'],t);
plot(t,x_hat(:,1),'k-','LineWidth',2)
%SO Kalman filter is doing a graet job squashing the noise and really
%estimating the true state as we know the model, disturbances and input.

%% 
figure(2)
plot(t,xtrue,'-',t,x_hat,'--','LineWidth',2) %Plotting true states and estimated states together.

Q = diag([1 1 1 1]);
R = 1000;
[K, S, E] = lqr(A, B, Q, R);
x0=[0;-2;-pi/2;2];
x_hat0=[0;0;0;0];

