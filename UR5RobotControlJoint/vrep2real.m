function tr = vrep2real(tv)
% Conversion from vrep joint space 
% to real robot joint space
% Long Qian 2016
    tr = tv;
    tr(2) = tr(2) - pi/2;
    tr(4) = tr(4) - pi/2;
end