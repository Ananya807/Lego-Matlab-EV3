display('PUSH button to start the tone.')
while brick.TouchPressed(1) == 1
 brick.playTone(100);
 display('RELEASE button to turn tone OFF.')
 pause(0.75);
end
display('Done!') 