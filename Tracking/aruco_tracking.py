'''
Marker tracking for robotics project
Powered by opencv, aruco, swig, zmq, json

Author: Long Qian
'''
import sys
import cv2
import numpy as np
import aruco
import zmq
import json

DEBUG = True
PORT = 5560
if len(sys.argv) > 1:
    PORT =  int(sys.argv[1])

if __name__ == '__main__':
    
    # load camera parameters
    camparam = aruco.CameraParameters()
    camparam.readFromXMLFile("logitech.yaml")
    print 'MT: camera parameter loaded'

    # marker size in meters
    msize = 0.042

    # create detector and set parameters
    detector = aruco.MarkerDetector()
    detector.setMinMaxSize(0.01)
    print 'MT: aruco detector initiated'

    # init zmq ipc
    context = zmq.Context()
    socket = context.socket(zmq.PUB)
    socket.bind('tcp://*:%s' % PORT)
    print 'MT: zmq socket bound to port %d' % PORT

    # load video
    cap = cv2.VideoCapture(0)
    ret, frame = cap.read()
    print 'MT: video capture starts'
    
    if not ret:
        print("MT: can't open video!")
        sys.exit(-1)

    while ret:        
        markers = detector.detect(frame, camparam)
    
        message = {}
        for marker in markers:
            marker.draw(frame, np.array([255, 255, 255]), 2)
            marker.calculateExtrinsics(msize, camparam)

            if DEBUG:
                print("cornerpoints for marker {:d}:".format(marker.id))
                for i, point in enumerate(marker):
                    print("\t{:d} {}".format(i, str(point)))
            message[marker.id] = {'Tvec': marker.Tvec.ravel().tolist(),
                                    'Rvec': marker.Rvec.ravel().tolist(),
                                    'ID': marker.id}
        if message.keys().__len__() != 0:
            message_data = json.dumps(message)
            if DEBUG: print message
            socket.send(message_data)

        # show frame
        cv2.imshow("Marker Tracking", frame)
        cv2.waitKey(10)
        
        # read next frame
        ret, frame = cap.read()
