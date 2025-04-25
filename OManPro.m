clear;close all;clc;
% not modified DH
DH_table = [[-pi/2 0 0 0];
    [0 265.69 0 0];
    [-pi/2 30 0 0];
    [-pi/2 0 258 0];
    [-pi/2 0 0 0];
    [0 0 0 0]];
linkMb_1=Link(DH_table(1,:),'standard');
link1_2=Link(DH_table(2,:),'standard');
link2_3=Link(DH_table(3,:),'standard');
link3_4=Link(DH_table(4,:),'standard');
link4_5=Link(DH_table(5,:),'standard');
link5_6=Link(DH_table(6,:),'standard');




links=[linkMb_1 link1_2 link2_3 link3_4 link4_5 link5_6];
% links=[linkMb_1 link1_2 link2_3];
% Define robot link properties for OpenManipulator-Pro

% Each link contains: length (m), mass (kg), and inertia tensor (3x3 matrix)

links(1).r = 0.0625; % Link 1 length (example, replace with accurate value)
links(1).m = 0.9436;
links(1).inertia = [1.5684e-03, 0, 0;
                    0, 4.5498e-04, 0;
                    0, 0, 1.5561e-03];

links(2).length = 0.147;
links(2).mass = 0.7107;
links(2).inertia = [1.0144e-03, 0, 0;
                    0, 2.2465e-04, 0;
                    0, 1.0101e-03, 0];

links(3).length = 0.300;
links(3).mass = 1.1435;
links(3).inertia = [1.4521e-03, 0, 0;
                    0, 3.7852e-04, 0;
                    0, 0, 1.3556e-03];

links(4).length = 0.024;
links(4).mass = 0.4664;
links(4).inertia = [1.0747e-04, 0, 0;
                    0, 2.7101e-05, 0;
                    0, 0, 9.9022e-05];

links(5).length = 0.072;
links(5).mass = 0.4664;
links(5).inertia = [1.1016e-04, 0, 0;
                    0, 2.5311e-05, 0;
                    0, 0, 9.2793e-05];

links(6).length = 0.100; % Estimated for end-effector
links(6).mass = 1.0022;
links(6).inertia = [6.0159e-04, 0, 0;
                    0, 1.0787e-03, 0;
                    0, 0, 7.1491e-04];

OpenManPro = SerialLink(links,'name','OMPro');
n = OpenManPro.n;
q0 = [0 0 pi/2 pi/5 0 0];
qn = rand(1,6)
OpenManPro.plot(qn);
% Mob_Cob.plot(q0,'workspace',[-1.5, 1.5, -1.5, 1.5,0,2],'scale',0.4)

% Get the transforms of each joint
T = OpenManPro.fkine(qn); % end-effector pose
hold on

% Get individual transforms for all joints
Ts = OpenManPro.fkine(qn, 1:OpenManPro.n); % 1 through n

for i = 1:OpenManPro.n
    % Extract the translation (x, y, z) of each joint
    pos = transl(Ts(i));
    % Display joint number as text at the joint position
    text(pos(1), pos(2), pos(3), ['J' num2str(i)], ...
         'FontSize', 12, 'FontWeight', 'bold', 'Color', 'r');
end

% Optional: label the base as J0
base_pos = [0, 0, 0];
text(base_pos(1), base_pos(2), base_pos(3), 'J0', ...
     'FontSize', 12, 'FontWeight', 'bold', 'Color', 'b');

hold off
