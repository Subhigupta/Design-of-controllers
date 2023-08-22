%Inverted pendulum on a cart
%System has four states [x,x_dot,theta,theta_dot]
%If system is observable then we can estimate full state using the measurements.
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

s=1; %(pendulum up(s=1))

A=[0 1 0 0;
    0 -d/M -m*g/M 0;
    0 0 0 1;
    0 -s*d/(M*L) -s*(m+M)*g/(M*L) 0];

B=[0;1/M;0;s*1/(M*L)];
%% Case 1: When measurable state is only position of the cart.

C=[1 0 0 0]; %Just measures the scalar position of the cart

%Now we will check whether with x measurement are we able to estimate other
%states or not.
obsv(A,C) %Observability matrix [C;CA;CA^2;CA^3]
det(obsv(A,C)) %System is observable.

%% Case 2: When measurable state is only angular position of the pendulum.

C=[0 0 1 0]; %Just measures the angular position of the pendulum. 

%Now we will check whether with theta measurement are we able to estimate other
%states or not. (We will not be able to estimate the scalar position state).
obsv(A,C) %Observability matrix [C;CA;CA^2;CA^3]
det(obsv(A,C)) %System is not observable.

%% Case 3: When measurable states are position of the cart and angular position of the pendulum.

C=[1 0 1 0];

%Now we will check whether with two measurements are we able to estimate other
%states or not. (We will not be able to estimate the scalar position state).
obsv(A,C) %Observability matrix [C;CA;CA^2;CA^3]
det(obsv(A,C)) %System is observable.

%% Case 4: When measurable states are position of the cart and angular velocity of the pendulum.

C=[1 0 0 1];

%Now we will check whether with two measurements are we able to estimate other
%states or not. (We will not be able to estimate the scalar position state).
obsv(A,C) %Observability matrix [C;CA;CA^2;CA^3]
det(obsv(A,C)) %System is observable.

%% Results/Conclusion

%If see the dynamics equations then we can see that the scalar position
%cannot be inferred from othe states as there is no equation for it (translationally invariant).
%Only x_dot,theta, theta_dot appear in the dynamics.
%Hence we need to measure position then only system can be observable as
%there is no way that we can infer position using other states.


