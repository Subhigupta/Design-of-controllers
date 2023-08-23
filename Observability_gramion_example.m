%Inverted pendulum on a cart
%System has four states [x,x_dot,theta,theta_dot]
%Now we do not care about the translational position of the car.
%I am only concerned whether my pendulum is stabilized or not.
%That may be achieved by estimating only [x_dot,theta,theta_dot].

%% 
clear all
clc
close all
%% System parameters

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

%% Redefining the system, considering subsystem 3*3 that omits x(1) state.
% The state can be dropped if we do not need them.

A=A(2:end,2:end);
B=B(2:end);
D=zeros(1,size(B,2));

%% Case 1 : When state X_dot is measurable

C=[1 0 0]; 
rank(obsv(A,C)) % system is observable
sys=ss(A,B,C,D); 
gram1=gram(sys,'o');%calculates the observability Gramian matrix (3*3)
det1=det(gram1); %Determinant will give the volume of the observable ellipsoid.
% So in short we are considering state x_dot direction and we are seeing
% the volume of ellipsoid formed in that direction. 
fprintf('The observability gramian of case study 1 %f is', det1)

%% Case 2: When state theta is measurable

C=[0 1 0];
rank(obsv(A,C))
sys=ss(A,B,C,D);
gram2=gram(sys,'o');%calculates the observability Gramian matrix (3*3)
det2=det(gram2);%Determinant will give the volume of the observable ellipsoid.
% So in short we are considering state theta direction and we are seeing
% the volume of ellipsoid formed in that direction. 
fprintf('The observability gramian of case study 2 %f is', det2)

%% Case 3: When state theta_dot is measurable

C=[0 0 1];
rank(obsv(A,C))
sys=ss(A,B,C,D);
gram3=gram(sys,'o'); %calculates the observability Gramian matrix (3*3)
det3=det(gram3); %Determinant will give the volume of the observable ellipsoid.
% So in short we are considering state theta_dot direction and we are seeing
% the volume of ellipsoid formed in that direction. 
fprintf('The observability gramian of case study 3 %f is', det3)

%% So it is easier to observe my system (estimate full state) if x_dot is measured.
% It may be easy to observe in one of the eigenvalue-eigenvector pair
% direction.

%[V,D]=eig(gram1)
[U,S,V] = svd(gram1,'econ')
