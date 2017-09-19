
function matrix = ROTX(r)


matrix = zeros(3,3);

matrix(1,1) = 1;
matrix(1,2) = 0; 
matrix(1,3) = 0;
matrix(2,1) = 0; 
matrix(2,2) = cos(r); 
matrix(2,3) = -sin(r);
matrix(3,1) = 0;
matrix(3,2) = sin(r);
matrix(3,3) = cos(r);
end