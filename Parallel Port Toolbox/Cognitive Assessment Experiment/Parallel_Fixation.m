%% Fixation Task for Parallel Port Markering
% Written by Chad C. Williams at the University of Victoria, 2021
% www.chadcwilliams.weebly.com

%% User Input
length_of_fixation = 180; %Determine how long the fixation is in seconds

%% Markers
%1: Start fixation
%2: End fixation

%% Setup Display
if ~exist('win')
    Screen('Preference', 'SkipSyncTests', 1);
    Screen('Preference', 'ConserveVRAM', 64);
    [win, rec] = Screen('OpenWindow', 0  , [166 166 166],[], 32, 2);
    Screen('TextFont',win,'Arial');
end

%Setup Parameters
Screen(win,'TextSize', 24);
ListenChar(2); %Stop typing in Matlab
HideCursor();		% hide the cursor
xmid = rec(3)/2;
ymid = rec(4)/2;
ExitKey = KbName('ESCAPE');

%% Run Experiment
DrawFormattedText(win, 'Resting State Task','center', 'center', [255 255 255],[],[],[],2);
Screen('Flip', win);
WaitSecs(5);

if length_of_fixation < 60
    DrawFormattedText(win, ['Please stare at the fixation cross for ', num2str(length_of_fixation), ' seconds'],'center', 'center', [255 255 255],[],[],[],2);
else
    DrawFormattedText(win, ['Please stare at the fixation cross for ', num2str(length_of_fixation/60), ' minutes'],'center', 'center', [255 255 255],[],[],[],2);
end
DrawFormattedText(win, 'Press the F key to continue','center', ymid+100, [255 255 255],[],[],[],2);
Screen('Flip',win);

Wait_for_Response = 1;
while Wait_for_Response
    [keypressed, ~, keyCode] = KbCheck();
    if keypressed
        if keyCode(KbName('F'))
            Wait_for_Response = 0;
        end
    end
end
WaitSecs(.25)

DrawFormattedText(win, '+','center', 'center', [255 255 255],[],[],[],2);
parallel_flipandmark(parallel_port,win,1,use_parallel); %Sends the current marker 

tic;
while toc < length_of_fixation
    [keypressed, ~, keyCode] = KbCheck();
    if keypressed
        if keyCode(ExitKey)
            break;
        end
    end
end
parallel_flipandmark(parallel_port,win,2,use_parallel); %Sends the current marker 
