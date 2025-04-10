%% Define Robot using new toolbox
% DEFINE ROBOT + PLOT 
% Note: UPDATED D-H PARAMETERS NO DUMMY FRAMES
% Note: download matlab optimization toolbox for robot.ikcon 
clear;close all;clc;
format shortG

% must be in capstone work folder or add the folder to path 
run Omron_Mobile_Cobot_Parameters.m


% "Joint Angles" for mobile robot
dy=.5; dx=.5; thz=deg2rad(0);
% "Joint Angles" for Arm
th1=deg2rad(0); th2=deg2rad(0);
th3=deg2rad(0); th4=deg2rad(0); 
th5=deg2rad(0); th6=deg2rad(0);

% preset joint angles
q0=[0,0,0,0,0,0,0,0,0];
qcobot=[dy,dx,thz,th1,th2,th3,th4,th5,th6];

% Robot
linkG_By=Link([-pi/2 0 0 -pi/2 1 0],'modified',"Jm",jm);
linkBy_Bx=Link([-pi/2 0 0 -pi/2 1 0],'modified');
linkBx_Mb=Link([0 0 0 -pi/2 0 -pi/2],'modified');
linkMb_1=Link([0 L1+Dz Dx 0 0 0],'modified');
link1_2=Link([0 -L2 0 -pi/2 0 -pi/2],'modified');
link2_3=Link([0 0 L3 0 0 0],'modified');
link3_4=Link([0 L5 L4 0 0 -pi/2],'modified');
link4_5=Link([0 L6 0 -pi/2 0 pi],'modified');
link5_6=Link([0 L7 0 pi/2 0 pi/2],'modified');

% link mass
linkG_By.m=m1; linkBy_Bx.m=m2; linkBx_Mb.m=m3; 
linkMb_1.m=m4; link1_2.m=m5; link2_3.m=m6;
link3_4.m=m7; link4_5.m=m8; link5_6.m=m9;

% motor inertia jm
linkG_By.Jm=jm; linkBy_Bx.Jm=jm; linkBx_Mb.Jm=jm; 
linkMb_1.Jm=jm; link1_2.Jm=jm; link2_3.Jm=jm;
link3_4.Jm=jm; link4_5.Jm=jm; link5_6.Jm=jm;

% link joint limits rad for R links m for P links according to spec sheet
%linkG_By.qlim=[0,1]; linkBy_Bx.qlim=[0,1]; 
linkBx_Mb.qlim=[-3.1416,3.1416]; 
linkMb_1.qlim=[-4.7124,4.7124]; link1_2.qlim=[-3.1416,3.1416]; 
link2_3.qlim=[-2.8972,2.8972];link3_4.qlim=[-3.1416,3.1416]; 
link4_5.qlim=[-3.1416,3.1416]; link5_6.qlim=[-4.7124,4.7124];

links=[linkG_By linkBy_Bx linkBx_Mb linkMb_1 link1_2 link2_3 link3_4 link4_5 link5_6];

Mob_Cob=SerialLink(links,'name','Mobile_Cobot');

TG_By=[0 1 0 0; 0 0 1 dy; 1 0 0 0; 0 0 0 1];
TBy_Bx=[0 1 0 0; 0 0 1 dx; 1 0 0 0; 0 0 0 1];
TBx_Mb=[sin(thz) cos(thz) 0 0; 0 0 1 0; cos(thz) -sin(thz) 0 0; 0 0 0 1];
TMb_1=[cos(th1) -sin(th1) 0 Dx; sin(th1) cos(th1) 0 0; 0 0 1 L1+Dz; 0 0 0 1];
T1_2=[sin(th2) cos(th2) 0 0; 0 0 1 -L2; cos(th2) -sin(th2) 0 0; 0 0 0 1];
T2_3=[cos(th3) -sin(th3) 0 L3; sin(th3) cos(th3) 0 0; 0 0 1 0; 0 0 0 1];
T3_4=[sin(th4) cos(th4) 0 L4; -cos(th4) sin(th4) 0 0; 0 0 1 L5; 0 0 0 1];
T4_5=[-cos(th5) sin(th5) 0 0; 0 0 1 L6; sin(th5) cos(th5) 0 0; 0 0 0 1];
T5_6=[-sin(th6) -cos(th6) 0 0; 0 0 -1 -L7; cos(th6) -sin(th6) 0 0; 0 0 0 1];

format shortG
Tee_qcobot=TG_By*TBy_Bx*TBx_Mb*TMb_1*T1_2*T2_3*T3_4*T4_5*T5_6;
Tee_q0=[0 -1 0 Dx; 0 0 -1 (L5-L2-L7);1 0 0 (Dz+L1+L3+L4+L6); 0 0 0 1];
Ree_qcobot=Tee_qcobot(1:3,1:3);

% plot 
Mob_Cob.plot(q0,'workspace',[-1.5, 1.5, -1.5, 1.5,0,2],'scale',0.4)
pause
Mob_Cob.plot(qcobot,'workspace',[-1.5, 1.5, -1.5, 1.5,0,2],'scale',0.4)
pause
% Path Planning q0 to qcobot
t=0:0.05:2;

qtraj=mtraj(@tpoly,q0,qcobot,t');

Mob_Cob.plot(qtraj,'workspace',[-1.5, 1.5, -1.5, 1.5,0,2],'scale',0.4)
