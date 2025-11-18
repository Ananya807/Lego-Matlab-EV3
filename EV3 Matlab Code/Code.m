% Title: EV3 Robot Sensor-Guided Navigation Loop
global key
color = brick.ColorCode(4);
while true
    distanceRight = brick.UltrasonicDist(1);  % Get distance to the right wall
    distanceForward = brick.UltrasonicDist(3);  % Get distance forward
    display("Distance Forward: " + distanceForward);
    display("Distance to the Right: " + distanceRight);
    pause(0.1);
    brick.MoveMotor('BC', 20);
    color = brick.ColorCode(4);
    display(color);
    if distanceForward < 25
        brick.MoveMotor('BC', -35);
        pause(1);
        brick.MoveMotor('B', -25);
        brick.MoveMotor('C', 26);
        pause(1);
        brick.StopMotor('BC');
    elseif distanceRight > 40
        brick.MoveMotor('C', -20);
        brick.MoveMotor('B', 20);
        pause(0.5);
        brick.MoveMotor('BC', 20);
        pause(2.5);
        brick.StopMotor('BC');
    elseif distanceRight < 15
        brick.MoveMotor('C', 20);
        brick.MoveMotor('B', -20);
        pause(0.5);
        brick.MoveMotor('BC', 20);
        pause(2);
        brick.StopMotor('BC');
    end
    if color == 5           % red
        brick.StopMotor('BC', 0);
        pause(1);
        brick.MoveMotor('BC', 20);
    elseif color == 6 || color == 2   % Green or Blue
        InitKeyboard();
        while true
        brick.StopMotor('BC', 'brake');
            pause(0.1);
            switch key
                case 'uparrow'
                    disp('Up Arrow Pressed!');
                    brick.MoveMotor('BC', 50);
                    pause(0.5);
                    brick.MoveMotor('BC', 0);
                    pause(0.25);
                case 'downarrow'
                    disp('Down Arrow Pressed!');
                    brick.MoveMotor('BC', -20);
                    pause(0.75);
                    brick.MoveMotor('BC', 0);
                    pause(0.25);
                case 'leftarrow'
                    disp('Left Arrow Pressed!');
                    brick.MoveMotor('B', -10);
                    brick.MoveMotor('C', 10);
                    pause(0.75);
                    brick.MoveMotor('BC', 0);
                    pause(0.25);
                case 'rightarrow'
                    disp('Right Arrow Pressed!');
                    brick.MoveMotor('B', 10);
                    brick.MoveMotor('C', -10);
                    pause(0.75);
                    brick.MoveMotor('BC', 0);
                    pause(0.25);
                case '1'
                    brick.MoveMotor('A', 30);
                    pause(0.5);
                    brick.MoveMotor('A', 0);
                    pause(0.25);
                case '2'
                    brick.MoveMotor('A', -10);
                    pause(0.25);
                    brick.MoveMotor('A', 0);
                    pause(0.25);
                case '3'
                    brick.MoveMotor('A', 999);
                    pause(0.2);
                    brick.MoveMotor('A', -100);
                    pause(0.2);
                    brick.MoveMotor('A', 999);
                    pause(0.2);
                    brick.MoveMotor('A', -100);
                    pause(0.2);
                    brick.MoveMotor('A', 999);
                    pause(0.2);
                    brick.MoveMotor('A', -100);
                    pause(0.2);
                    brick.MoveMotor('ABC', 0);                    
                case 0 % No key is being pressed.
                    disp('No Key Pressed!');
                case 'q' % Press "q" to quit.
                    break;
            end
            brick.MoveMotor('BC', 0);
        end
        CloseKeyboard();
    end
end
