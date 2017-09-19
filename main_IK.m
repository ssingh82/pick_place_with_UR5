clear all
% clc
addpath('/home/long/Desktop/Robotics_Final_Lab_2/Robotics_final_project/UR5RobotControlJoint')
addpath('/home/long/Desktop/Robotics_Final_Lab_2/Robotics_final_project/Tracking')
addpath('/home/long/Desktop/Robotics_Final_Lab_2/Robotics_final_project/lib')
addpath('/home/long/Desktop/Robotics_Final_Lab_2/Robotics_final_project/Functions')

initTracking();
s=init();
threshold = 0.5;

% Get data from camera
[ID,Rvec,Tvec]=rubustMarker;
% Get rotation matrix
R_land=rotationVectorToMatrix(Rvec(1,:));
R_grip=rotationVectorToMatrix(Rvec(2,:));
R_up=rotationVectorToMatrix(Rvec(3,:));

gcl=G(R_land,Tvec(1,:));
gcg=G(R_grip,Tvec(2,:));
gcu=G(R_up,Tvec(3,:));
% Transfer to world frame
gl0 = matCamToRobo(gcg,gcl,s);
gu0 = matCamToRobo(gcg,gcu,s);


% add the gripper position
g_tool_cube=gu0*G(eye(3),[3.6 27.6 0]*10^-2) * G(ROTY(-pi/2),[0 0 0]) * G(ROTZ(-pi/2),[0 0 0]); % Transformation matrix from the gripper to the cube
g_tool_landing=gl0*G(eye(3),[3.6 27.6 0]*10^-2) * G(ROTY(-pi/2),[0 0 0]) * G(ROTZ(-pi/2),[0 0 0]);  % Transformation matrix from the gripper to the landing position



closegripper = false;

% Inverse kinemics
while ~closegripper
    theta = ur5inv(g_tool);
    offset = [0; pi/2; 0; pi/2; 0; 3*pi/4];
    for i = 1:size(theta,2)
        theta(:,i) = theta(:,i) + offset;
    end
    solution_num = 1;
    theta_ur5 = vrep2real(theta(:,solution_num));
    moverobotJoint(s,theta_ur5);
    currentjoints = readrobotJoint(s);
    diffJoints = theta_ur5' - currentjoints;
    if max(abs(diffJoints)) < threshold
        closegripper = true;
    end
end
pause(1);


g_down = g_tool * G(eye(3),[10 -10 0]);
theta = ur5inv(g_down);
    offset = [0; pi/2; 0; pi/2; 0; 3*pi/4];
    for i = 1:size(theta,2)
        theta(:,i) = theta(:,i) + offset;
    end
    solution_num = 1;
    theta_ur5 = vrep2real(theta(:,solution_num));
    moverobotJoint(s,theta_ur5);


% trans = gl0(1:3,4)-gu0(1:3,4)

% theta = ur5inv(gu0);
% offset = [pi/2; pi/2; 0; pi/2; 0; 0];
% for i = 1:size(theta,2)
%     theta(:,i) = theta(:,i) + offset;
% end
% solution_num = 1;
% theta_ur5 = vrep2real(theta(:,solution_num));
% moverobotJoint(s, theta_ur5);
