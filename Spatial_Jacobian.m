function [JS] = Spatial_Jacobian(Ang)
 % Anngles for the joints
 th1 = Ang(1);
 th2 = Ang(2); 
 th3 = Ang(3);
 th4 = Ang(4); 
 th5 = Ang(5);
 th6 = Ang(6);
 
 % Lengths of the links used 
      l1 = 89.2/1000;
      l2 = 425/1000;
      l3 = 392/1000;
      l4 = 109.3/1000; 
      l5 = 94.75/1000;
      l6=  82.5/1000;
 
 % Terms for the Spatial Jacobian Matrix
 % Column 1
JS(:,1)=[0;0;0;0;0;1];

% Column 2
JS(:,2)=[l1*sin(th1);-l1*cos(th1);0;-cos(th1);-sin(th1);0];

% Column 3
JS(:,3)=[(l1 + l2*cos(th2))*sin(th1); -cos(th1)*(l1 + l2*cos(th2)); l2*sin(th2); -cos(th1); -sin(th1); 0];

% Column 4
JS(:,4)=[(l1 + l2*cos(th2) + l3*cos(th2 + th3))*sin(th1);-cos(th1)*(l1 + l2*cos(th2) + l3*cos(th2 + th3)); l2*sin(th2) + l3*sin(th2 + th3); -cos(th1); -sin(th1);0];

% Column 5 Elements
JS(1,5)= 1/2*(l3*sin(th1-th4)+l2*sin(th1-th3-th4)+l1*sin(th1-th2-th3-th4)-l4*sin(th1-th2-th3-th4)-l3*sin(th1+th4)-l2*sin(th1+th3+th4)-l1*sin(th1+th2+th3+th4)-l4*sin(th1+th2+th3+th4));
JS(2,5)= 1/2*(-l3*cos(th1-th4)-l2*cos(th1-th3-th4)-l1*cos(th1-th2-th3-th4)+l4*cos(th1-th2-th3-th4)+l3*cos(th1+th4)+l2*cos(th1+th3+th4)+l1*cos(th1+th2+th3+th4)+l4*cos(th1+th2+th3+th4));
JS(3,5)= -l4*sin(th2+th3+th4);
JS(4,5)= -sin(th1)*sin(th2+th3+th4);
JS(5,5)= cos(th1)*sin(th2+th3+th4);
JS(6,5)= cos(th2+th3+th4);

% Column 6 Elements
JS(1,6)= (l1+l2*cos(th2)+l3*cos(th2+th3)+l5*cos(th2+th3+th4))*cos(th5)*sin(th1)+1/2*(2*l5*cos(th1)+l3*cos(th1-th4)+l2*cos(th1-th3-th4)+l1*cos(th1-th2-th3-th4)-l4*cos(th1-th2-th3-th4)+l3*cos(th1+th4)+l2*cos(th1+th3+th4)+l1*cos(th1+th2+th3+th4)+l4*cos(th1+th2+th3+th4))*sin(th5);
JS(2,6)= -1/2*cos(th1)*(l2*cos(th2-th5)+l3*cos(th2+th3-th5)-l4*cos(th2+th3+th4-th5)+l5*cos(th2+th3+th4-th5)+2*l1*cos(th5)+l2*cos(th2+th5)+l3*cos(th2+th3+th5)+l4*cos(th2+th3+th4+th5)+l5*cos(th2+th3+th4+th5))+(l5+l3*cos(th4)+l2*cos(th3+th4)+l1*cos(th2+th3+th4))*sin(th1)*sin(th5);
JS(3,6)= 1/2*(l2*sin(th2-th5)+l3*sin(th2+th3-th5)-l4*sin(th2+th3+th4-th5)+l5*sin(th2+th3+th4-th5)+l2*sin(th2+th5)+l3*sin(th2+th3+th5)+l4*sin(th2+th3+th4+th5)+ l5*sin(th2+th3+th4+th5));
JS(4,6)= -cos(th1)*cos(th5)+cos(th2+th3+th4)*sin(th1)*sin(th5);
JS(5,6)= -cos(th5)*sin(th1)-cos(th1)*cos(th2+th3+th4)*sin(th5);
JS(6,6)= sin(th2+th3+th4)*sin(th5);
end


