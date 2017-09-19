function movef(id,vrep,g,h,hrel)


rotation = g((1:3),(1:3));


eulerAngles = eulerzyxinv(rotation);


position = g((1:3),4);

[number_returnCode] = vrep.simxSetObjectPosition(id,h,hrel,position,vrep.simx_opmode_oneshot);

[number_returnCode] = vrep.simxSetObjectOrientation(id,h,hrel,eulerAngles,vrep.simx_opmode_oneshot);

end