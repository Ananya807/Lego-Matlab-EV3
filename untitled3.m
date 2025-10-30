% Set desired distance from the wall
desiredDistance = 5; % cm
closeDistance = 8;   % cm (too close)
farDistance = 18;     % cm (too far)
distance1 = brick.UltrasonicDist(1);
distance2 = brick.UltrasonicDist(2);
% Step 1: Move forward for 1 second
while true
    if distance1 < closeDistance
        % If too close to the wall, steer left
        brick.MoveMotor('B',20)
        brick.MoveMotor('C',25)
        pause(3)
        brick.MoveMotor('C',20)
        brick.MoveMotor('B',25)
        pause(2)
    elseif distance1 > farDistance
        % If too far from the wall, steer right
        brick.MoveMotor('B',25)
        brick.MoveMotor('C',20)
        pause(4)
    else 
        % If at the desired distance, move straight
        brick.MoveMotor('B',25)
        brick.MoveMotor('C',25)
        pause(2)
    end
end
        
