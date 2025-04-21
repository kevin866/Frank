clear; clc;

jm = 1e-4;

L1 = Link([0     0.3   0.0   -pi/2   0   0], 'modified', 'Jm', jm);
disp(L1)
L = [L1, Link([0 0 0.3 0 0 0], 'modified'), ...
         Link([0 0 0.2 -pi/2 0 0], 'modified'), ...
         Link([0 0.4 0 pi/2 0 0], 'modified'), ...
         Link([0 0 0 -pi/2 0 0], 'modified'), ...
         Link([0 0.1 0 0 0 0], 'modified')];

myRobot = SerialLink(L, 'name', 'TestBot', 'mdh', true);

myRobot
