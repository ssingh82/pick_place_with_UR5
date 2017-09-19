function matrix = eulerzyx(m)

matrix_x = ROTX(m(1));
matrix_y = ROTY(m(2));
matrix_z = ROTZ(m(3));

matrix = matrix_x * matrix_y * matrix_z;
end