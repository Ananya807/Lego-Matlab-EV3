
%0	No color (Unknown color) 
%1	Black 
    %2	Blue 
    %6	Green 
    %4	Yellow 
    %5	Red 
%3	White 
%7	Brown

% Set desired distance from the wall
closeDistance = 15;   % cm (too close)
farDistance = 30;   % cm (too far)
distance1 = brick.UltrasonicDist(1);
distance2 = brick.UltrasonicDist(3);
color = brick.ColorCode(4);
while true
    brick.MoveMotor('BC', 25);
    if distance1 < closeDistance
        % If too close to the wall, steer left
        brick.MoveMotor('BC', 0);
        pause(0.5);
        brick.MoveMotor('B', 5);
        brick.MoveMotor('C', 25);
        pause(1);
        brick.MoveMotor('C', 5);
        brick.MoveMotor('B', 25);
        pause(1);
        distance1 = brick.UltrasonicDist(1);
    elseif distance1 > farDistance && distance1 < 55
        % If too far from the wall, steer right
        brick.MoveMotor('BC', 0);
        pause(0.5);
        brick.MoveMotor('C', 5);
        brick.MoveMotor('B', 25);
        pause(1);
        brick.MoveMotor('B', 5);
        brick.MoveMotor('C', 25);
        pause(1);
        distance1 = brick.UltrasonicDist(1);
    elseif distance1 > 55
        while distance1 > 55
        brick.MoveMotor('BC', 0);
        pause(1);
        brick.MoveMotor('B', 50);
        brick.MoveMotor('C', 20)
        pause(2);
        brick.MoveMotor('BC', 25)
        pause(2.5);
        end
    else
        % If at the desired distance, continue moving forward
        brick.MoveMotor('BC', 25); % Move forward
        distance1 = brick.UltrasonicDist(1); % Update distance
        pause(0.5); % Short pause to allow for distance measurement
    end

    display(distance2);
    distance2 = brick.UltrasonicDist(3);
    if distance2 < 25 && distance2 > 15
        brick.MoveMotor('BC', 0);
        pause(1)
        display(distance2);
        brick.MoveMotor('B', -10); % Rotate
        brick.MoveMotor('C', 10); % Rotate
        pause(3.3);
        brick.MoveMotor('BC', 0); % Stop rotation
        pause(1);
    end
    if distance2 < 15
        brick.MoveMotor('BC', -15);
        pause(2);
    end
       
end