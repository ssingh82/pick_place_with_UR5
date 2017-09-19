function [ theta ] = ur5inv( gd )

d1 = 0.089159;
d2 = 0;
d3 = 0;
d4 = 0.10915;
d5 = 0.09465;
d6 = 0.0823;
a1 = 0;
a2 = -0.425;
a3 = -0.39225;
a4 = 0;
a5 = 0;
a6 = 0;
alpha1 = pi/2;
alpha2 = 0;
alpha3 = 0;
alpha4 = pi/2;
alpha5 = -pi/2;
alpha6 = 0;
theta = zeros(6, 8);

% theta1
p05 = gd * [0, 0, -d6, 1]'  - [0, 0, 0, 1]';
angle1 = atan2(p05(2), p05(1));
angle2 = acos(d4 / sqrt(p05(2)*p05(2) + p05(1)*p05(1)));
solution1=pi/2 + angle1 + angle2;
solution2=pi/2 + angle1 - angle2;
%
%     if solution1 < 0
%         solution1 = solution1 + 2*pi;
%     elseif solution1 > 2*pi
%         solution1 = solution1 - 2*pi;
%     end
%     if solution2 < 0
%         solution2 = solution2 + 2*pi;
%     elseif solution2 > 2*pi
%         solution2 = solution2 - 2*pi;
%     end

% Use function range() to keep the angles in right range
theta(1, 1:4) = range(solution1);
theta(1, 5:8) = range(solution2);
theta = real(theta);



% theta5
for i=1:4:5
    T01=trans(1,theta(1,i));
    T10 = inv(T01);
    T16 = T10 * gd;
    p16z = T16(3,4);
    theta(5, i) = range(acos((p16z-d4)/d6));
    theta(5, i+1) = range(acos((p16z-d4)/d6));
    theta(5, i+2) = range(-acos((p16z-d4)/d6));
    theta(5, i+3) = range(-acos((p16z-d4)/d6));
end
theta = real(theta);



% theta6
for i=1:8
    T01 = trans(1, theta(1,i));
    T61 = inv(inv(T01)*gd);
    T61zy = T61(2, 3);
    T61zx = T61(1, 3);
    t5 = theta(5, i);
    theta6 = atan2(-T61zy/sin(t5), T61zx/sin(t5));
    theta(6,i)=range(theta6);
end
theta = real(theta);

% theta3
for i=1:2:8
    T01 = trans(1, theta(1,i));
    T56 = trans(6, theta(6,i));
    T45 = trans(5, theta(5,i));
    T16 = (inv(T01))*gd;
    T14 = T16*(inv(T45*T56));
    p13 = T14 * [0, -d4, 0, 1]' - [0,0,0,1]';
    
    t3p = acos(((norm(p13).^2)-a2*a2-a3*a3)/(2*a2*a3));
    theta(3, i) = range(t3p);
    theta(3, i+1) = range(-t3p);
end
theta = real(theta);

% theta2 and theta4
for i=1:8
    % theta2
    T01 = trans(1, theta(1,i));
    T56 = trans(6, theta(6,i));
    T45 = trans(5, theta(5,i));
    T16 = (inv(T01))*gd;
    T14 = T16*(inv(T45*T56));
    p13 = T14 * [0, -d4, 0, 1]' - [0,0,0,1]';
    
    theta(2, i) = range(-atan2(p13(2), -p13(1))+asin(a3*sin(theta(3,i))/norm(p13)));
    % theta4
    T23 = trans(3, theta(3,i));
    T12 = trans(2, theta(2,i));
    T34 = (inv(T12*T23))*T14;
    theta(4, i) = range(atan2(T34(2,1), T34(1,1)));
    
end
theta = real(theta);




end