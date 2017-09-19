%% ur5_read_tracking_example
% Sample code to read tracking information from aruco_tracking.py
% Display the attributes of each marker information
% Author: Long Qian
% Date: Nov 2016

%% Program
clear all;
addpath('Control');
addpath('Tracking');

% Init communication
% aruco_tracking.py should be started before this
initTracking();

% Receive and print messages
while 1
    % A list of marker informations
    % For each marker information, there are three attributes:
    % marker.ID:    the ID of marker
    % marker.Rvec:  the rotation vector
    % marker.Tvec:  the translation vector
    markerList = readTrackingMsg();
    for i = 1:length(markerList)
        marker = markerList(i);
        disp( marker.ID );
        disp( marker.Rvec );
        disp( marker.Tvec );
    end
end
