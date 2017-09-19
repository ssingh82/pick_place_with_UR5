function g = getf(id,vrep,h,hrel)

[returnCode_1,eulerAngles] = vrep.simxGetObjectOrientation(id,h,hrel,vrep.simx_opmode_blocking);


[returnCode_2,position] = vrep.simxGetObjectPosition(id,h,hrel,vrep.simx_opmode_blocking);


r_matrix = eulerzyx(eulerAngles);


g(1:3,1:3) = r_matrix;
g(1:3,4) = position;
g(4,4) = 1; g(4,1:3) = 0;

end
