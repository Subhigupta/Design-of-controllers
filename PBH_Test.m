%Illustrate various spaces needed for the PBH test.
clear 
clc
close all
%% Example 6:PBH Test
A=[1 2 3;
    2 1 0;
    0 2 4];
% Get the eigen vectors and eigen values
[V,D]=eig(A);

lambda1=D(1,1);
lambda2=D(2,2);
lambda3=D(3,3);

v1=V(:,1);
v2=V(:,2);
v3=V(:,3);

%Check the eigenvalues/eigenvector pairs
%The eigen vector should lie in the null space of (A-lambda*eye(3))
(A-lambda1*eye(3))*v1;
(A-lambda2*eye(3))*v2;
(A-lambda3*eye(3))*v3;

% Compute the range of (A-lambda_iI)
rank(A-lambda1*eye(3)) %Eigen values make the matrix rank deficient
%Rank is coming 2 so two vectors will span the vector space.
rangeAminuaLambda1I=orth(A-lambda1*eye(3));
rangeAminuaLambda2I=orth(A-lambda2*eye(3));
rangeAminuaLambda3I=orth(A-lambda3*eye(3));

%Plotting vector space apanned by vectors of rangeAminuaLambda1I
vec1_1=rangeAminuaLambda1I(:,1);
vec2_1=rangeAminuaLambda1I(:,2);
normal_1 = cross(vec1_1, vec2_1);%Calculate the normal vector of the plane using cross product
[x1, y1] = meshgrid(-1:1, -1:1);% Create a grid of points for the plane
z1 = -(normal_1(1)*x1 + normal_1(2)*y1) / normal_1(3);
surf(x1,y1,z1,'Facecolor','blue','FaceAlpha', 0.5)
hold on

%Plotting vector space apanned by vectors of rangeAminuaLambda2I
vec1_2=rangeAminuaLambda2I(:,1);
vec2_2=rangeAminuaLambda2I(:,2);
normal_2 = cross(vec1_2, vec2_2);%Calculate the normal vector of the plane using cross product
[x2, y2] = meshgrid(-1:1, -1:1);% Create a grid of points for the plane
z2 = -(normal_2(1)*x2 + normal_2(2)*y2) / normal_2(3);
surf(x2,y2,z2,'Facecolor','green','FaceAlpha', 0.5)
hold on

%Plotting vector space apanned by vectors of rangeAminuaLambda3I
vec1_3=rangeAminuaLambda3I(:,1);
vec2_3=rangeAminuaLambda3I(:,2);
normal_3 = cross(vec1_3, vec2_3);%Calculate the normal vector of the plane using cross product
[x3, y3] = meshgrid(-1:1, -1:1);% Create a grid of points for the plane
z3 = -(normal_3(1)*x2 + normal_3(2)*y2) / normal_3(3);
surf(x3,y3,z3,'Facecolor','yellow','FaceAlpha', 0.5)
hold on

% Lets make B uncontrollable
B_uncontrollable=-0.8*rangeAminuaLambda1I(:,1)+...
    1.2*rangeAminuaLambda1I(:,2);
rank(ctrb(A,B_uncontrollable));

%Lets make B controllable (random vector)
B_controllable=[0.1;-0.25;1]; %according to PBH test this vector should be controllable
%quiver3(0,0,0,B_controllable(1),B_controllable(2),B_controllable(3), 'r', 'LineWidth', 2);
rank(ctrb(A,B_controllable))% checking it with controllability test

%Check the rank-nullity theorem
rank([A-lambda1*eye(3) v1])%Rank and null space space respectively 
%combined should have a full rank
rank([A-lambda2*eye(3) v2])
rank([A-lambda3*eye(3) v3])

%Plot eigen vector
quiver3(0,0,0,v1(1),v1(2),v1(3), 'b', 'LineWidth', 4)%uncontrollable as it lies in yellow and green plane
rank(ctrb(A,v1))
hold on
quiver3(0,0,0,v2(1),v2(2),v2(3), 'g', 'LineWidth', 4)%uncontrollable as it lies in blue and yellow plane
hold on
quiver3(0,0,0,v3(1),v3(2),v3(3), 'y', 'LineWidth', 2)%uncontrollable as it lies in blue and grren plane
%eigen vector is not be going to in blue plane and so on.

%make a composite vector
v1v2v3=v1 + v2+ v3; %controllable
rank(ctrb(A,v1v2v3))
quiver3(0,0,0,v1v2v3(1),v1v2v3(2),v1v2v3(3), 'k', 'LineWidth', 2)

