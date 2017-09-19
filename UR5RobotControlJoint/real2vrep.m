function tv = real2vrep(tr)
% Conversion from real robot joint space 
% to vrep joint space
% Long Qian 2016
    tv = tr;
    tv(2) = tv(2) + pi/2;
    tv(4) = tv(4) + pi/2;
end