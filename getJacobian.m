function J = getJacobian(theta)
th1 = theta(1);
th2 = theta(2);
th3 = theta(3);
th4 = theta(4);
th5 = theta(5);
th6 = theta(6);

e1 = [[cos(th1) -sin(th1) 0;sin(th1) cos(th1) 0;0 0 1],[0;0;0];0 0 0 1];
e2 = [[1 0 0;0 cos(th2) sin(th2);0 -sin(th2) cos(th2)],[0;-0.0892*sin(th2);0.0892*(1-cos(th2))];0 0 0 1];
e3 = [[1 0 0;0 cos(th3) sin(th3);0 -sin(th3) cos(th3)],[0;-0.5143*sin(th3);0.5143*(1-cos(th3))];0 0 0 1];
e4 = [[1 0 0;0 cos(th4) sin(th4);0 -sin(th4) cos(th4)],[0;-0.9064*sin(th4);0.9064*(1-cos(th4))];0 0 0 1];
e5 = [[cos(th5) -sin(th5) 0;sin(th5) cos(th5) 0;0 0 1],[0.11*(cos(th5)-1);0.11*sin(th5);0];0 0 0 1];
e6 = [[1 0 0;0 cos(th6) sin(th6);0 -sin(th6) cos(th6)],[0;-1.0051*sin(th6);1.0051*(1-cos(th6))];0 0 0 1];

t1 = [0;0;0;0;0;1];
t2 = [0;-0.0892;0;-1;0;0];
t3 = [0;-0.5143;0;-1;0;0];
t4 = [0;-0.9064;0;-1;0;0];
t5 = [0;0.11;0;0;0;1];
t6 = [0;-1.0012;0;-1;0;0];

t2Prime = Ad(e1)*t2;
t3Prime = Ad(e1*e2)*t3;
t4Prime = Ad(e1*e2*e3)*t4;
t5Prime = Ad(e1*e2*e3*e4)*t5;
t6Prime = Ad(e1*e2*e3*e4*e5)*t6;
J = [t1,t2Prime,t3Prime,t4Prime,t5Prime,t6Prime];