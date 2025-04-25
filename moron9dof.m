% MDL_MY9DOF Create model of a 9-DOF mobile manipulator with dynamics

clear L
deg = pi/180;

% --- Base Links (3 DOF Mobile Base) ---
L(1) = Link('theta', 0, 'a', 0, 'alpha', 0, 'sigma', 1, 'qlim', [-1 1]);
L(1).m = 5;                      % light base translation
L(1).r = [0 0 0];                % center of mass at origin
L(1).I = [0.01 0.01 0.01 0 0 0]; % low inertia

L(2) = Link('theta', 0, 'a', 0, 'alpha', 0, 'sigma', 1, 'qlim', [-1 1]);
L(2).m = 5;
L(2).r = [0 0 0];
L(2).I = [0.01 0.01 0.01 0 0 0];

L(3) = Link('d', 0, 'a', 0, 'alpha', 0, 'sigma', 0, 'qlim', [-pi pi]);
L(3).m = 3;
L(3).r = [0 0 0];
L(3).I = [0.02 0.02 0.02 0 0 0];

% --- Manipulator Links (6 DOF Arm) ---
L(4) = Link('d', 0.1, 'a', 0,    'alpha', pi/2, 'qlim', [-160 160]*deg);
L(4).m = 6;
L(4).r = [0 0 0.05];
L(4).I = [0.02 0.02 0.01 0 0 0];

L(5) = Link('d', 0,   'a', 0.3,  'alpha', 0, 'qlim', [-90 90]*deg);
L(5).m = 8;
L(5).r = [0.15 0 0];
L(5).I = [0.05 0.05 0.02 0 0 0];

L(6) = Link('d', 0,   'a', 0.2,  'alpha', -pi/2, 'qlim', [-90 90]*deg);
L(6).m = 6;
L(6).r = [0.1 0 0];
L(6).I = [0.03 0.03 0.015 0 0 0];

L(7) = Link('d', 0.2, 'a', 0,    'alpha', pi/2, 'qlim', [-90 90]*deg);
L(7).m = 4;
L(7).r = [0 0 0.1];
L(7).I = [0.02 0.02 0.01 0 0 0];

L(8) = Link('d', 0,   'a', 0,    'alpha', -pi/2, 'qlim', [-180 180]*deg);
L(8).m = 3;
L(8).r = [0 0 0];
L(8).I = [0.01 0.01 0.005 0 0 0];

L(9) = Link('d', 0,   'a', 0,    'alpha', 0, 'qlim', [-180 180]*deg);
L(9).m = 2;
L(9).r = [0 0 0.05];
L(9).I = [0.005 0.005 0.002 0 0 0];

% --- Robot Assembly ---
my9dof = SerialLink(L, 'name', 'My9DOF Robot');

% --- Configurations ---
qz = zeros(1,9);               % Zero config
qr = [0 0 0 pi/2 0 0 0 0 0];   % Ready pose
qs = [0 0 0 0 -pi/2 0 0 0 0];  % Stretched out
qn = [0.1 0.1 pi/4 pi/4 -pi/4 pi/4 0 pi/4 0];  % Nominal pose



clear L
