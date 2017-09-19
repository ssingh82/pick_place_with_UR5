function R = rotationVectorToMatrix(Rvec)

theta = norm(Rvec);
r = Rvec / theta;
R = cos(theta) * eye(3) + (1 - cos(theta))*(r'*r) +...
    sin(theta) * [0 -r(3) r(2); r(3) 0 -r(1); -r(2) r(1) 0];
end