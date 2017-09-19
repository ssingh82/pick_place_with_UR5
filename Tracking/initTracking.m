% Init the ZMQ subsriber to listen for tracking
% data sent from aruco_tracking.py
%
% Author: Long Qian
% Date: Nov 2016

function initTracking()
    % start ZMQ subscriber
    % make sure the port number is same as aruco_tracking.py
    zmq( 'subscribe', 'tcp', 'localhost', 5560 );
end

