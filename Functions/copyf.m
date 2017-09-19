function hnew = copyf(id,vrep,g,h,hrel)


[returnCode,hnew] = vrep.simxCopyPasteObjects(id,h,vrep.simx_opmode_blocking);


movef(id,vrep,g,hnew,hrel);

end
