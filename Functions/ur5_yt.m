
% copied from youbot program that illustrates the V-REP Matlab bindings.
%
% Original copyright information:
% (C) Copyright Renaud Detry 2013.
% Distributed under the GNU General Public License.
% (See http://www.gnu.org/copyleft/gpl.html)

% Modifications (C) Noah Cowan 2015
% Lab 0 Problem 4 by Ye Tiam 2016

disp('Program started');
%Use the following line if you had to recompile remoteApi
%vrep = remApi('remoteApi', 'extApi.h');
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
id = vrep.simxStart('127.0.0.1', 19997, true, true, 2000, 5);

if id < 0,
    disp('Failed connecting to remote API server. Exiting.');
    vrep.delete();
    return;
end
fprintf('Connection %d to remote API server open.\n', id);

% Make sure we close the connexion whenever the script is interrupted.
cleanupObj = onCleanup(@() cleanup_vrep(vrep, id));

% This will only work in "continuous remote API server service"
% See http://www.v-rep.eu/helpFiles/en/remoteApiServerSide.htm
% res = vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot_wait);
% We're not checking the error code - if vrep is not run in continuous remote
% mode, simxStartSimulation could return an error.
% vrchk(vrep, res);

% Retrieve all handles, and stream arm and wheel joints, the robot's pose,
% the Hokuyo, and the arm tip pose.
h = ur5_init(vrep, id);

% Let a few cycles pass to make sure there's a value waiting for us next time
% we try to get a joint angle or the robot pose with the simx_opmode_buffer
% option.
pause(.2);

% Constants:

timestep = .05;

% Min max angles for all joints (not correct and not used)
% armJointRanges = [-2*pi, 2*pi;
%     -2*pi, 2*pi;
%     -2*pi, 2*pi;
%     -2*pi, 2*pi;
%     -2*pi, 2*pi;
%     -2*pi, 2*pi];

startingJoints = zeros(1,6);

% In this demo, we move the arm through a preset  set of poses:
targetPoses = [90*pi/180,90*pi/180,185*pi/180,90*pi/180,90*pi/180,90*pi/180;
    -90*pi/180,45*pi/180,95*pi/180,135*pi/180,90*pi/180,90*pi/180;
    zeros(1,6)];



%Get all collision from V-REP:   
collision={'Collision';'Collision0';'Collision1';'Collision2';'Collision3';'Collision4';'Collision5';'Collision6';'Collision7';'Collision8';'Collision9';'Collision10';'Collision11';'Collision12';'Collision13'};

res = vrep.simxPauseCommunication(id, true);
vrchk(vrep, res);

% Set the arm to its starting configuration:
for i = 1:6,
    res = vrep.simxSetJointTargetPosition(id, h.ur5Joints(i),...
        startingJoints(i),...
        vrep.simx_opmode_oneshot);
    vrchk(vrep, res, true);
end

res = vrep.simxPauseCommunication(id, false);
vrchk(vrep, res);


% Make sure everything is settled before we start
pause(2);

[res, homeGripperPosition] = ...
    vrep.simxGetObjectPosition(id, h.ur5Gripper,...
    h.ur5Ref,...
    vrep.simx_opmode_buffer);
vrchk(vrep, res, true);


% Problem 4 (a)
for k = 1:size(targetPoses,1)
    finalJoints = targetPoses(k,:);
    pose=ones(1,6);
k
    for i = 1:6,
i
% Make sure the joints have move to the target positon
        while abs(pose(i)-finalJoints(i))>.1
            
            
        vrep.simxSetJointTargetPosition(id, h.ur5Joints(i ),...
            finalJoints(i), ...
            vrep.simx_opmode_oneshot);
     
         pause(1);
% Get the current position of joints:
    [res, pose(i)] = vrep.simxGetJointPosition(id, h.ur5Joints(i),vrep.simx_opmode_streaming);
   vrchk(vrep, res);


% Problem 4(b)
for j=1:15
   
[res,collision_h.ur5Joints(j)]=vrep.simxGetCollisionHandle(id,collision{j},vrep.simx_opmode_blocking);
vrchk(vrep, res);

[res,Boolon]=vrep.simxReadCollision(id,collision_h.ur5Joints(j),vrep.simx_opmode_streaming );
vrchk(vrep, res, true);
% Collision Position Detect
Boolon
if (Boolon>0)
    fprintf 'error';
    return

end
end


        end
    
        end
    

    
    
end        




