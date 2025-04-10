


% kinematicModel = differentialDriveKinematics

diffDrive = differentialDriveKinematics(VehicleInputs="VehicleSpeedHeadingRate");
diffDrive.WheelSpeedRange = [-10 10]*2*pi;

waypoints = [0 0; 0 10; 10 10; 5 10; 11 9; 4 -5];
% Define the total time and the sample rate
sampleTime = 0.05;               % Sample time [s]
tVec = 0:sampleTime:20;          % Time array
initPose = [waypoints(1,:)'; 0]; % Initial pose (x y theta)

% Define a controller. Each robot requires its own controller
controller3 = controllerPurePursuit(Waypoints=waypoints,DesiredLinearVelocity=3,MaxAngularVelocity=3*pi);

goalPoints = waypoints(end,:)';
goalRadius = 1;

[tDiffDrive,diffDrivePose] = ode45(@(t,y)derivative(diffDrive,y,exampleHelperMobileRobotController(controller3,y,goalPoints,goalRadius)),tVec,initPose);

diffDriveTranslations = [diffDrivePose(:,1:2) zeros(length(diffDrivePose),1)];
diffDriveRot = axang2quat([repmat([0 0 1],length(diffDrivePose),1) diffDrivePose(:,3)]);

figure
plot(waypoints(:,1),waypoints(:,2),"kx-",MarkerSize=20);
hold all
plotTransforms(diffDriveTranslations(1:10:end,:),diffDriveRot(1:10:end,:),MeshFilePath="groundvehicle.stl",MeshColor="g");
axis equal
view(0,90)
