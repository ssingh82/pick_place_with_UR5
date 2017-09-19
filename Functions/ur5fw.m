function [ G ] = ur5fw( angle )

    d1 = 0.089159;
    d2 = 0;
    d3 = 0;
    d4 = 0.10915;
    d5 = 0.09465;
    d6 = 0.0823;
    a1 = 0;
    a2 = -0.425;
    a3 = -0.39225;
    a4 = 0;
    a5 = 0;
    a6 = 0;
    
    e1=[1 0 0]';
    e2=[0 1 0]';
    e3=[0 0 1]';
    w1=e3;
    w2=-e2;
    w3=-e2;
    w4=-e2;
    w5=-e3;
    w6=-e2;
    q1=[0 0 0]';
    q2=[0 0 d1]';
    q3=[a2 0 d1]';
    q4=[a2+a3 0 d1]';
    q5=[a2+a3 -d4 d1]';
    q6=[a2+a3 -d4 d1-d5]';

    
    g0 = [1,0,0,a2+a3;0,0,-1,-d4-d6;0,1,0,d1-d5;0,0,0,1];
    
    twist1=twist( w1,q1,angle(1) );
    twist2=twist( w2,q2,angle(2) );
    twist3=twist( w3,q3,angle(3) );
    twist4=twist( w4,q4,angle(4) );
    twist5=twist( w5,q5,angle(5) );
    twist6=twist( w6,q6,angle(6) );

    G = twist1 * twist2 * twist3 * twist4 * twist5 * twist6 * g0;
end