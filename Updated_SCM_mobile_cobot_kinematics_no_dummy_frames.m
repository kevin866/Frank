%% Updated Frames and D-H Parameters to avoid dummy frames
% CHECK D-H PARAMETERS + FRAMES (KINEMATICS ONLY)
% Order: Global frame-> mobile y translation (By frame) -> mobile x 
% translation (Bx frame) -> mobile z rotation (Mb frame)-> Arm link 1
% (frame 1)->-> Arm link 6 (frame 6 at end effector)
clear; clc;

% Dimensions (mm)
L1=165.2; L2=180; L3=636.1; L4=557.9;
L5=23.7; L6=106; L7=113.2; Dx=304.8; Dz=87.35;

% syms L1 L2 L3 L4 L5 L6 L7 Dx Dz
% syms dx dy thz th1 th2 th3 th4 th5 th6

% Input Variables for mobile robot
dx=0; dy=0; thz=deg2rad(0);
% Input Variables for Arm
th1=deg2rad(0); th2=deg2rad(0);
th3=deg2rad(0); th4=deg2rad(0); 
th5=deg2rad(0); th6=deg2rad(0);

qcobot=[dy,dx,thz,th1,th2,th3,th4,th5,th6];

% Transformation Matrices
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
Tee=TG_By*TBy_Bx*TBx_Mb*TMb_1*T1_2*T2_3*T3_4*T4_5*T5_6;

%% Define Robot 

% Robot
linkG_By=Link([-pi/2 0 0 -pi/2 1 0],'modified');
linkBy_Bx=Link([-pi/2 0 0 -pi/2 1 0],'modified');
linkBx_Mb=Link([0 0 0 -pi/2 0 -pi/2],'modified');
linkMb_1=Link([0 L1+Dz Dx 0 0 0],'modified');
link1_2=Link([0 -L2 0 -pi/2 0 -pi/2],'modified');
link2_3=Link([0 0 L3 0 0 0],'modified');
link3_4=Link([0 L5 L4 0 0 -pi/2],'modified');
link4_5=Link([0 L6 0 -pi/2 0 pi],'modified');
link5_6=Link([0 L7 0 pi/2 0 pi/2],'modified');

links=[linkG_By linkBy_Bx linkBx_Mb linkMb_1 link1_2 link2_3 link3_4 link4_5 link5_6];

Mob_Cob=SerialLink(links,'name','Mobile_Cobot');

Tee_fkine=Mob_Cob.fkine(qcobot);

