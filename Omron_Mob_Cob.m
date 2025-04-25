%% Define Robot using new toolbox
% ONLY DEFINES ROBOT
% Note: UPDATED D-H PARAMETERS NO DUMMY FRAMES

clear;close all;clc;
% Dimensions (m)
L1=.1652; L2=.180; L3=.6361; L4=.5579;
L5=.0237; L6=.106; L7=.1132; Dx=.3048; Dz=.08735;


% Mass of links (kg)
m1=10; m2=10; % x and y prismatic links
m3= 148+14.5;    % rot z link -> mass of the robot base and TM12 controller(from spec sheet) 
mArm=32.8;  % TM12 total mass of arm 
% Mass of individual links unknown, loosely scale total arm mass as a
% fraction of length for each link
L=L1+L2+L3+.1297+L4+L6+L6+L7;
m4=((L1+L2)/L)*mArm;    % Arm link 1
m5=((L3+(.1297/2))/L)*mArm;         % Arm link 2
m6=((.1297/2+L4)/L)*mArm;
m7=(L6/L)*mArm;
m8=(L6/L)*mArm;
m9=(L7/L)*mArm;

% motor inertia
jm=3.3*10^-5;

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
% linkG_By.qlim=[0,1]; linkBy_Bx.qlim=[0,1]; 
linkBx_Mb.qlim=[-3.1416,3.1416]; 
linkMb_1.qlim=[-4.7124,4.7124]; link1_2.qlim=[-3.1416,3.1416]; 
link2_3.qlim=[-2.8972,2.8972];link3_4.qlim=[-3.1416,3.1416]; 
link4_5.qlim=[-3.1416,3.1416]; link5_6.qlim=[-4.7124,4.7124];

links=[linkG_By linkBy_Bx linkBx_Mb linkMb_1 link1_2 link2_3 link3_4 link4_5 link5_6];

Mob_Cob=SerialLink(links,'name','Mobile_Cobot');
Mob_Cob.n
