function [Motion] = Resolved_Rate(Pose1, Pose2,Current_Angle)

% Pose has the (x,y) points for the markers
% Finding the intermediate points between the Pose1 and Pose2 

L= sqrt((Pose1(1)-Pose2(1))^2+(Pose1(2)-Pose2(2))^2);
m= (Pose1(2)-Pose2(2))/(Pose1(1)-Pose2(1));
theta=arctan(m);

if  L < 0.04
    Points=[Pose1(1),Pose2(1);Pose2(1),Pose2(2)];
else
    k=floor(L/0.04);
    
    for i = 1:k 
        Intermediate_Points(i,1)= Pose1(1)+i*0.4*cos(theta); 
        Intermediate_Points(i,2)= Pose1(2)+i*0.4*sin(theta);
    end
    Points=[Pose1;Intermediate_Points;Pose2];
end

Ang=Current_Angle;
%--------------------------------------------------------------------------
% Resolved Rate Control
% Ang is a row vector in this case here
     for i = 1 : size(Points,1)
          Diff_Points=[Points(i+1)-Points(i);0;0;0];
          [JS] = Spatial_Jacobian(Ang);
          Theta_Dot= inv(JS)*Diff_Points;
          % ThetaDot transposed here to get the row vector
          Ang_New = Ang + Theta_Dot';
          Motion(i,:)=Ang_New;
          Ang=Ang_New;
     end
end

