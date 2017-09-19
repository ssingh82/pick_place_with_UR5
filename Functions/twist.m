function [ G ] = twist( w, q, theta )

    G = eye(4);
    w_hat = zeros(3,3);
    w_hat(1,2) = -w(3);
    w_hat(2,1) = w(3);
    w_hat(1,3) = w(2);
    w_hat(3,1) = -w(2);
    w_hat(2,3) = -w(1);
    w_hat(3,2) = w(1);
    v = -w_hat * q;
    G(1:3, 1:3) = eye(3) + w_hat * sin(theta) + (1-cos(theta)) * w_hat * w_hat;
    G(1:3, 4) = (eye(3)*theta + (1-cos(theta))*w_hat + (theta-sin(theta))*w_hat*w_hat) * v;
end