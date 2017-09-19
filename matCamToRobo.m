function g= matCamToRobo(Ggrap,Gcam,s)

currentAngle=readrobotJoint(s);

%  fw = ur5fwdtrans(currentAngle) * G(ROTX(pi),[0 0 0]);
fw = ur5fwdtrans(currentAngle);
g1 = G(ROTZ(-3*pi/4),[0 0 0]);
g2 = G(ROTY(pi),[0 0 0]);

g3=G(eye(3),[0; 0; -3.6] * 10^-2);
g4=G(eye(3),[0; 1.4; 0] * 10^-2);
 

gt3 = fw  * g1  *g2* g3  * g4; % from base to gripper marker

% gT17_FK16=[0, 0, 1, -3.6*10^-2;
%     sqrt(2)/2,sqrt(2)/2,0,1.4*(sqrt(2)/2)*10^-2;
%     -sqrt(2)/2,sqrt(2)/2,0,1.4*(sqrt(2)/2)*10^-2;
%     0, 0, 0, 1];
% gt3_jisng=fw*gT17_FK16
% gc0=Ggrap*gt3;
gc0=gt3 * pinv(Ggrap);
% g=pinv(Gcam)*gc0;
g=gc0*Gcam;
end