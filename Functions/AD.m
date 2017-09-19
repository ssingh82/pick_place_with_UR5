function Ad = Ad(g)
R = g(1:3,1:3);
p = g(1:3,4);
pHat = [0,-p(3),p(2);p(3),0,-p(1);-p(2),p(1),0];
Ad = [R,pHat*R;zeros(3),R];