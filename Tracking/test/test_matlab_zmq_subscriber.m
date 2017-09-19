addpath('jsonlab')
clear all;
cnt = 1;
subscriber = zmq( 'subscribe', 'tcp', 'localhost', 5560 );

while true
    try
        idx = zmq('poll', 100);
        recv_data = zmq( 'receive', idx );
        str = char(recv_data');
        j = loadjson(str);
        disp( char(recv_data') );
    catch ME
        ;
    end
end

clear cnt;
