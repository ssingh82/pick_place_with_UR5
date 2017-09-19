function vector = eulerzyxinv(m)

beta = atan2(m(1,3),sqrt(m(1,1)^2+m(1,2)^2));
alpha = atan2(-m(1,2)/cos(beta),m(1,1)/cos(beta));
phi = atan2(-m(2,3)/cos(beta),m(3,3)/cos(beta));
vector = [phi; beta; alpha];
end