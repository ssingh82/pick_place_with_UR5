function[G]=trans(i, theta)
% i is the larger frame number
    d1 = 0.089159;
    d2 = 0;
    d3 = 0;
    d4 = 0.10915;
    d5 = 0.09465;
    d6 = 0.0823;
    d=[d1 d2 d3 d4 d5 d6];
    a1 = 0;
    a2 = -0.425;
    a3 = -0.39225;
    a4 = 0;
    a5 = 0;
    a6 = 0;
    a=[a1 a2 a3 a4 a5 a6];
    
    alpha1 = pi/2;
    alpha2 = 0;
    alpha3 = 0;
    alpha4 = pi/2;
    alpha5 = -pi/2;
    alpha6 = 0;
    alpha=[alpha1 alpha2 alpha3 alpha4 alpha5 alpha6];
    
R=ROTX(alpha(i));
g0=eye(4);
g0(1:3,1:3)=R;
g0(1:3,4)=[a(i) 0 d(i)]';
G=twist([0;0;1],[0;0;0],theta)*g0;
end
