% Initialize the EV3 brick and connect to the motors and color sensor
myBrick = legoev3('bt'); % Connect via Bluetooth
motorLeft = motor(myBrick, 'A'); % Left motor on port A
motorRight = motor(myBrick, 'B'); % Right motor on port B
colorSensor = colorSensor(myBrick, '1'); % Color sensor on port 1

% Define color codes
RED = 5; % Color code for red
SECOND_COLOR = 6; % Change this to the code for the second color
THIRD_COLOR = 4; % Change this to the code for the third color

% Function to follow the wall using the right-hand rule
function followWall()
    while true
        % Read the color sensor
        colorValue = readColor(colorSensor);

        % Check for red tile
        if colorValue == RED
            disp('Red tile detected. Stopping and picking up the object.');
            stopMotors();
            pickUpObject();
            continue; % Continue navigating after picking up
        end

        % Wall following logic
        if isFrontBlocked()
            turnRight();
        else
            moveForward();
        end

        % Check for second color tile
        if colorValue == SECOND_COLOR
            disp('Second color tile detected. Releasing the object.');
            stopMotors();
            releaseObject();
            continue; % Continue navigating after releasing
        end

        % Check for third color tile
        if colorValue == THIRD_COLOR
            disp('Third color tile detected. Stopping.');
            stopMotors();
            break; % Stop the robot
        end
    end
end

% Function to check if the front is blocked
function blocked = isFrontBlocked()
    % Implement logic to check for obstacles (e.g., using ultrasonic sensor)
    blocked = false; % Placeholder
end

% Function to turn right
function turnRight()
    motorLeft.Speed = 50; % Set speed for left motor
    motorRight.Speed = 0; % Stop right motor
    start(motorLeft);
    start(motorRight);
    pause(1); % Adjust time for turning
    stop(motorLeft);
    stop(motorRight);
end

% Function to move forward
function moveForward()
    motorLeft.Speed = 50; % Set speed for both motors
    motorRight.Speed = 50;
    start(motorLeft);
    start(motorRight);
end

% Function to stop both motors
function stopMotors()
    stop(motorLeft);
    stop(motorRight);
end

% Function to pick up the object
function pickUpObject()
    % Implement gripper motor control to pick up the object
    disp('Picking up the object...');
end

% Function to release the object
function releaseObject()
    % Implement gripper motor control to release the object
    disp('Releasing the object...');
end

% Start the wall-following behavior
followWall();
