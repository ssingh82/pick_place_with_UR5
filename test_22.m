% function [] = inverse_main_vrep_2(s, camera_land, camera_cube, camera_marker, marker_ID)
clear all
addpath('/home/long/Desktop/Robotics_Final_Lab_1/Robotics_final_project/UR5RobotControlJoint')
addpath('/home/long/Desktop/Robotics_Final_Lab_1/Robotics_final_project/Tracking')
addpath('/home/long/Desktop/Robotics_Final_Lab_1/Robotics_final_project/lib')
addpath('/home/long/Desktop/Robotics_Final_Lab_1/Robotics_final_project/Functions')

initTracking();
s=init();

[ID,Rvec,Tvec]=rubustMarker;
R_land=rotationVectorToMatrix(Rvec(1,:));
R_grip=rotationVectorToMatrix(Rvec(2,:));
R_up=rotationVectorToMatrix(Rvec(3,:));

marker_ID = ID;
camera_marker = G(R_grip, Tvec(2,:));

camera_land = G(R_land, Tvec(1,:));

camera_cube = G(R_up, Tvec(3,:));


gtp2 = G(ROTZ(pi/4),[0, 0, 0.036]);

% from tool to gripper p3, yet tested
gtp3 = gtp2 * G(ROTX(pi),[0 0 0]) * G(eye(3),[0,0.014,0]);

% from tool to gripper p4, yet tested
gtp4 = gtp2 * G(eye(3),[0 0.014 0]);

% from cube to tool, in desired location, ?
%gp1t_calib = XF([0, 0.036, 0.1353, pi, pi/2, 0]);

% from landing to tool, in desired location
%gp2t_calib = XF([0, 0.036,   0.16, pi, pi/2, 0]);


% from camera to cube
gcp1 = camera_cube;

%from camera to landing location
gcp2 = camera_land;

% from camera to marker
gcp3 = camera_marker;


% from camera to tool
if marker_ID == 17
    gct = gcp3*inv(gtp3);
else
    gct = gcp3*inv(gtp4);
    gtp3 = gtp2 * G(ROTX(pi),[0 0 0]) * G(eye(3),[0 0.014 0]);

end

initial_joints = real2vrep(readrobotJoint(s));
k = eye(4);
k(1:3,1:3) = ROTZ(pi/2);
gbt = k * ur5fw(initial_joints)

% from base to camera
gbc = gbt * pinv(gct)

gbp3 = gbc*gcp3

%from base to cube
gbp1 = gbc*gcp1

gbp2 = gbc*gcp2

g = pinv(gbp3)*gbp1;

g_calib = G(eye(3),[0 0.2 0]);


g_final = gbp1*g_calib

% moverobotCart(s, g_final);

pause(1);