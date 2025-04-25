mdl = "OpenManipulatorPro";

% Motor inertias (guessed based on actuator size and gear ratio)
J_motor = [3e-5, 2e-5, 1.5e-5, 1e-5, 8e-6, 5e-6];  % kg*m^2

L(1) = Revolute('d', 0.1519, 'a', 0,     'alpha', pi/2,  'I', [0 0 0 0 0 J_motor(1)], 'B', 1e-3, 'Tc', [0.03 -0.03]);
L(2) = Revolute('d', 0,      'a', 0.132, 'alpha', 0,     'offset', pi/2, 'I', [0 0 0 0 0 J_motor(2)], 'B', 8e-4, 'Tc', [0.025 -0.025]);
L(3) = Revolute('d', 0,      'a', 0.124, 'alpha', 0,     'I', [0 0 0 0 0 J_motor(3)], 'B', 6e-4, 'Tc', [0.02 -0.02]);
L(4) = Revolute('d', 0.126,  'a', 0,     'alpha', pi/2,  'I', [0 0 0 0 0 J_motor(4)], 'B', 4e-4, 'Tc', [0.01 -0.01]);
L(5) = Revolute('d', 0,      'a', 0,     'alpha', -pi/2, 'I', [0 0 0 0 0 J_motor(5)], 'B', 2e-4, 'Tc', [0.008 -0.008]);
L(6) = Revolute('d', 0.055,  'a', 0,     'alpha', 0,     'I', [0 0 0 0 0 J_motor(6)], 'B', 1e-4, 'Tc', [0.005 -0.005]);

robot = SerialLink(L, 'name', mdl);
robot.tool = transl(0, 0, 0.027);

% Optional gravity direction
robot.gravity = [0, 0, -9.81];
