function[angle_proper]=range(angle)
if angle < -pi
    angle_proper = angle + 2*pi;
elseif angle > pi
    angle_proper = angle - 2*pi;
else
    angle_proper=angle;
end
end