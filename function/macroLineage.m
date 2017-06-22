% Initialize
import java.awt.Robot;
import java.awt.event.*;
import java.awt.MouseInfo;
C = Robot;

% variables
time_mPauseS = 0.02;
time_mPauseM = 1;
time_mPuaseL = 300;

time_green = 300; % sec
time_shield = 1800;
time_armor = 1800;

% string list
click = ['C.mousePress(InputEvent.BUTTON1_MASK);', ...
         'pause(time_s);', ...
         'C.mouseRelease(InputEvent.BUTTON1_MASK);'];

 for iCycle = 1:nCycle
     % Boost
     C.mouseMove();
     eval(click);
     pause(time_mPauseM);
     
     % Shield
     C.mouseMove();
     eval(click);
     pause(time_mPauseM);
     
     % Armor
     C.mouseMove();
     eval(click);
     pause(time_mPauseM);     
 end

