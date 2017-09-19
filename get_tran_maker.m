function mat=get_tran_maker (Rvec,Tvec)

g=zeros(4,4);
r = rotationVectorToMatrix(Rvec);
g(1:3,1:3)=r;
g(1:3,4)=Tvec;
g(4,4)=1;
% mat=g;
mat=inv(g);
end
