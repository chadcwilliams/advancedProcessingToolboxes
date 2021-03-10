
useViewPixx = 1;
if useViewPixx
    Datapixx('Open');
    Datapixx('StopAllSchedules');
end

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'ConserveVRAM', 64);
[win, rec] = Screen('OpenWindow', 0  , [166 166 166],[0 0 400 300], 32, 2);

for counter = 1:255
    VPixx_flipandmark(win,counter,1);
end

% flip = 10;
% for counter = 1:255
%     
%     if flip == 10
%         Screen('FillRect', win, [randi(255),randi(255),randi(255)], [100 100 200 200]) % Add the pixel
%         Screen('Flip',win)
%         flip = 0;
%     end
%     VPixx_sendmarker(win,counter,1);
%     flip = flip+1;
%     WaitSecs(.2);
% end

if useViewPixx
   Datapixx('Close'); 
end
sca;