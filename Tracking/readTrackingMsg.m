% Read the most recent message from aruco_tracking.py
% with 100ms timeout. Return as a list of structs or 
% empty list
%
% Author: Long Qian
% Date: Nov 2016

function infoList = readTrackingMsg()
    infoList = [];
    try
        idx = zmq('poll', 100);
        recv_data = zmq( 'receive', idx );
        str = char(recv_data');
        obj = loadjson(str);
        fields = fieldnames(obj);
        for i = 1:numel(fields)
            infoList = [infoList, obj.(fields{i})];
        end
    catch
        
    end
end
