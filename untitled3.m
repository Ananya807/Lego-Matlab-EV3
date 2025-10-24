%brick = ConnectBrick("EV3L");

% Define motors
leftMotor = motor(ev3, 'A');  % Left motor connected to port A
rightMotor = motor(ev3, 'B'); % Right motor connected to port B

% Reset motor angles for accurate positioning
resetMotorAngle(leftMotor);
resetMotorAngle(rightMotor);

% Set color sensor mode (assuming it's connected to port 1)
myColorSensor = colorSensor(brick, 1); % Create a color sensor object
brick.SetColorMode(1, 4); % Set Color Sensor connected to Port 1 to Color RGB Mode

% Function to move forward
function moveForward(leftMotor, rightMotor)
    start(leftMotor);
    start(rightMotor);
end

% Function to move backward
function moveBackward(leftMotor, rightMotor)
    start(leftMotor, -50); % Negative speed for backward
    start(rightMotor, -50);
end

% Function to turn left
function turnLeft(leftMotor, rightMotor)
    start(leftMotor, -50); % Left motor backward
    start(rightMotor);      % Right motor forward
end

% Function to turn right
function turnRight(leftMotor, rightMotor)
    start(leftMotor);       % Left motor forward
    start(rightMotor, -50); % Right motor backward
end

% Example usage
moveForward(leftMotor, rightMotor);
pause(2); % Move forward for 2 seconds

moveBackward(leftMotor, rightMotor);
pause(2); % Move backward for 2 seconds

turnLeft(leftMotor, rightMotor);
pause(1); % Turn left for 1 second

turnRight(leftMotor, rightMotor);
pause(1); % Turn right for 1 second

% Read color sensor values
color = readColor(myColorSensor); % Read detected color
intensity = readLightIntensity(myColorSensor); % Read light intensity
disp(['Detected Color: ', num2str(color), ', Intensity: ', num2str(intensity)]);

% Stop the motors
stop(leftMotor);
stop(rightMotor);

% Main loop for distance checking
while true
    distance = brick.UltrasonicDist(3);
    brick.MoveMotor('BC', 25); % Move motors B and C at speed 25
    fprintf('Distance: %.2f cm\n', distance);
    if distance < 7
        brick.StopMotor('BC', 'Brake');
        disp('Object detected within 5 cm. Motor stopped.');
        break; % Exit the loop if an object is detected
    end
    pause(0.1); % Short pause to avoid overwhelming the sensor
end
% Lower arm to pick up position
brick.MoveMotorAngleRel('A', 30, -90, 'Brake');  % Lower arm down
pause(1);
% Close grip or lift the object
brick.MoveMotorAngleRel('A', 50, 180, 'Brake');  % Lift or grab object
pause(1);
disp('Item lifted.');
% Optional: back up after picking
brick.MoveMotorAngleRel('B', 30, -200, 'Brake'); % Back up motor B
brick.MoveMotorAngleRel('C', 30, -200, 'Brake'); % Back up motor C
pause(1);
disp('Backed up with item.');
disp('Task complete.');

% Disconnect from the brick
DisconnectBrick(brick); % Disconnect from the EV3 brick
