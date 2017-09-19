% function []=ur5_gradient(s)
% ur5_gradient
s = init();

addpath('Control');
% UR5 home configuration
Home = [0,-pi/2,0,-pi/2,0,0];
startingConfig=[-40 -105 127 -119 -95 -48]*(pi/180);
% Send control command
% moverobotJoint(s, Home);
% currentjoints = readrobotJoint(s);
% threshold = 0.1;
% while max(abs((currentjoints - Home))) > threshold
%     moverobotJoint(s, Home);
%     currentjoints = readrobotJoint(s);
% end
moverobotJoint(s, startingConfig);
currentjoints = readrobotJoint(s);
threshold = 0.1;
while max(abs((currentjoints - startingConfig))) > threshold
    moverobotJoint(s, startingConfig);
    currentjoints = readrobotJoint(s);
end

% Read the current joint angles
intialAngle=readrobotJoint(s);
R_trans = ROTX(pi/2)*ROTZ(-pi/4);
T_trans = [17.6 - 5.08 0,3.6];
g_trans1 = G(R_trans, T_trans);

pRot=g_trans1;

intialPose=g_trans1*ur5fw(startingConfig);
intialCoord=intialPose(1:2,4);


% get rubust figure matrix in camera
[ID,Rvec,Tvec]=rubustMarker();
Glc=get_tran_maker (Rvec(1,:),Tvec(1,:));
Ggc=get_tran_maker (Rvec(2,:),Tvec(2,:));
Gfc=get_tran_maker (Rvec(3,:),Tvec(3,:));

% transfer these matrix in spatial coordinate
Gl0=matCamToRobo(Ggc,Glc,s); % landing to spatial
Gg0=matCamToRobo(Ggc,Ggc,s); % grapper to spatial
Gf0=matCamToRobo(Ggc,Gfc,s); % face to spatial

landCoord=Gl0(1:2,4);
gripCoord=Gg0(1:2,4);
faceCoord=Gf0(1:2,4);

% The distance above the cube
aboveDist=0.02;
% get movement angles for picking
motionToCube = Gradient_Descent(intialCoord(1:2), faceCoord,intialAngle);

% Move to the up of cube
for i = 1:size(motionToCube,1)

    moverobotJoint(s, motionToCube(i,:));
end
% move down
for i = 1:10
    pEnd = [faceCoord,0.0508+aboveDist]+0.1*i*[0,0,-aboveDist-0.03];
    GEnd = G(pRot, pEnd);
    moverobotCart(s, GEnd);
end

pEndDown=pEnd;
openGripper(s);
pause(1);
closeGripper(s);
% move up again
for i = 1:10
    pEnd = pEndDown+0.1*i*[0,0,aboveDist+0.03];
    GEnd = G(pRot, pEnd);
    moverobotCart(s, GEnd);
end
% Get the movemrnt to landing
currentAngle=readrobotJoint(s);
motionToLand = Gradient_Descent(faceCoord, landCoord,currentAngle);
% move to landing position
for i = 1:size(motionToLand,1)

    moverobotJoint(s, motionToLand(i,:));
end
% get down
for i = 1:10
    pEnd = [landCoord,aboveDist]+0.1*i*[0,0,-aboveDist+0.01];
    GEnd = G(pRot, pEnd);
    moverobotCart(s, GEnd);
end

openGripper(s);
pause(1);
closeGripper(s);

% 
% end 



