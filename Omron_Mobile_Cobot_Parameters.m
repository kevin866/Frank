% ALL THE PARAMETERS 
% Dimensions (m)
L1=.1652; L2=.180; L3=.6361; L4=.5579;
L5=.0237; L6=.106; L7=.1132; Dx=.3048; Dz=.08735;


% Mass of links (kg)
m1=0; m2=0; % x and y prismatic links
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