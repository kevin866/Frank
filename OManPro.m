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
