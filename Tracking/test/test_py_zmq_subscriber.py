'''
Test of zmq pub/sub channel

Author: Long Qian
'''
import zmq
import sys
import cv2
import numpy as np
import json

PORT = 5560
if len(sys.argv) > 1:
    PORT =  int(sys.argv[1])

context = zmq.Context()
socket = context.socket(zmq.SUB)
socket.connect ("tcp://localhost:%s" % PORT)
socket.setsockopt(zmq.SUBSCRIBE, '')

while True:
    message_data = socket.recv()
    message = json.loads(message_data)

    print message['2']





