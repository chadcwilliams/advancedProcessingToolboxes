%% Decision Making Task for LSL Port Markering
% Written by Chad C. Williams at the University of Victoria, 2021
% www.chadcwilliams.com

%% User Input
num_of_blocks = 6; %Determine how many blocks (6) now 3
num_of_trials = 20; %Determine how many trials per block (20)

%% Marker List
%7: Draw squares for side 1 (where left side is correct answer)
%8: Draw squares for side 2 (where right side is correct answer)
%9: Go cue for side 1 (where left side is correct answer)
%10: Go cue for side 2 (where right side is correct answer)
%11: Win when got correct
%12: Win when got incorrect
%13: Loss when got incorrect
%14: Loss when got correct
%15: Too slow

%% Setup Behavioural
if ~exist('subject_number');
    clc;
    subject_number = input('Enter the subject number:\n','s');  % get the subject number
end
pname = strcat('LSL_DecMakBeh_',subject_number);

%% Setup Display
if ~exist('win');
    Screen('Preference', 'SkipSyncTests', 1);
    Screen('Preference', 'ConserveVRAM', 64);
    [win, rec] = Screen('OpenWindow', 0  , [166 166 166],[], 32, 2);
end

%Setup Parameters
Screen(win,'TextSize', 24);
ListenChar(2); %Stop typing in Matlab
HideCursor();		% hide the cursor
xmid = rec(3)/2;
ymid = rec(4)/2;
ExitKey = KbName('ESCAPE');
Left_Key = KbName('F');
Right_Key = KbName('H');
beh_data = [];

%% Run Instructions and Practice
num_practice_blocks = 2;
num_practice_trials = 10;

DrawFormattedText(win, 'Decision Making Task','center', 'center', [255 255 255],[],[],[],2);
Screen('Flip', win);
WaitSecs(5);

DrawFormattedText(win, 'On each trial you are going to see two coloured squares. Try to keep your eyes on the cross in the middle of the display at all times.\nWhen the cross colour darkens, choose a square by pressing either the\n F key for the left square or the H key for the right square.\nEach choice results in either a "WIN" or a "LOSS". One of the colours is better than the other\n- choosing it is more likely to produce a "WIN". Sometimes the colours of the squares will change and\nthe better square will have a new colour.\nYour goal: win as often as possible.\n\nThe experimenter will make sure you understand these instructions.\nPress F to continue.','center', 'center', [255 255 255],[],[],[],2);
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
    WaitSecs(.25);

for a = 1:num_practice_blocks
    
    instruction_colour = [randi(255) randi(255) randi(255)];
    instruction_colour(2,:) = [255-instruction_colour];

    square_colour = [randi(255) randi(255) randi(255)];
    square_colour(2,:) = [255-square_colour];
    
    if a == 1 % easy practice, 100% vs 0%.
        practice_win_1 = 1.0;
        practice_win_2 = 0.0;
    else % second block will be slightly harder
        practice_win_1 = 0.75;
        practice_win_2 = 0.10;
    end

    Screen('FillRect', win , instruction_colour(1,:), [xmid-200 ymid-50 xmid-100 ymid+50]);
    Screen('FillRect', win , instruction_colour(2,:), [xmid+100 ymid-50 xmid+200 ymid+50]);
    DrawFormattedText(win,'+','center','center',[255 255 255]);
    if a == 1
        DrawFormattedText(win, 'Before you start, become familiar with the task with some practice.\nYou will see two coloured squares like below (however, they will be different colours). \nOne will lead to a win 100% of the time while the other will lead to a win 0% of the time.\nRemember: your goal is to win as much as possible.','center', ymid-400, [255 255 255],[],[],[],2);
        DrawFormattedText(win, 'Press F to begin.','center', ymid+300, [255 255 255],[],[],[],2);
        Screen(win,'TextSize',35);
        DrawFormattedText(win, '100%',xmid-200+4, ymid+50-35, [255 255 255],[],[],[],2);
        DrawFormattedText(win, '0%',xmid+100+24, ymid+50-35, [255 255 255],[],[],[],2);
    else
        DrawFormattedText(win, 'Here is another practice block. A little more difficult.\nYou will see two coloured squares like below (however, they will be different colours). \nOne colour will lead to a win 75% of the time while the other will lead to a win 10% of the time.\nRemember: your goal is to win as much as possible.','center', ymid-400, [255 255 255],[],[],[],2);
        DrawFormattedText(win, 'Press F to begin.','center', ymid+300, [255 255 255],[],[],[],2);
        Screen(win,'TextSize',35);
        DrawFormattedText(win, '10%',xmid-200+4, ymid+50-35, [255 255 255],[],[],[],2);
        DrawFormattedText(win, '75%',xmid+100+24, ymid+50-35, [255 255 255],[],[],[],2);        
    end
    Screen('Flip', win);
    Screen(win,'TextSize', 24);
    
    Wait_for_Response = 1;
    while Wait_for_Response
        [keypressed, ~, keyCode] = KbCheck();
        if keypressed
            if keyCode(KbName('F'))
                Wait_for_Response = 0;
            end
        end
    end
    
    DrawFormattedText(win, 'Practice will begin in 3 seconds.','center', 'center', [255 255 255],[],[],[],2);
    Screen('Flip', win);
    WaitSecs(3);
    
    % Practice trial loop
    for i = 1:num_practice_trials
        
        % Draw crosshairs for 500 ms
        DrawFormattedText(win,'+','center','center',[255 255 255]);
        Screen('Flip', win);
        fixation_interval = rand()*.2 + .3;
        WaitSecs(fixation_interval);
        
        % Randomize the order of square presentation
        if rand < 0.5
            colour_side = [1,2];
        else
            colour_side = [2,1];
        end
        
        % Draw the squares for 500 ms
        Screen('FillRect', win , square_colour(colour_side(1),:), [xmid-200 ymid-50 xmid-100 ymid+50]);
        Screen('FillRect', win , square_colour(colour_side(2),:), [xmid+100 ymid-50 xmid+200 ymid+50]);
        DrawFormattedText(win,'+','center','center',[255 255 255]);
        Screen('Flip',win);
        WaitSecs(.5);
        
        % Change the colour of the fixation cross ("go cue")
        Screen('FillRect', win , square_colour(colour_side(1),:), [xmid-200 ymid-50 xmid-100 ymid+50]);
        Screen('FillRect', win , square_colour(colour_side(2),:), [xmid+100 ymid-50 xmid+200 ymid+50]);
        DrawFormattedText(win,'+','center','center',[75 75 75]);        
        Screen('Flip', win);
        
        %Wait for Response
        keypressed = 0;
        Wait_for_Response = 1;
        tic;
        while Wait_for_Response
            [keypressed, ~, keyCode] = KbCheck();
            if keypressed
                RT = toc;
                if keyCode(Left_Key)
                    Wait_for_Response = 0;
                    Response_Side = 1;
                end
                if keyCode(Right_Key)
                    Wait_for_Response = 0;
                    Response_Side = 2;
                end
                if keyCode(ExitKey)
                    break;
                end
            end
            if toc > 2
                RT = 2;
                Wait_for_Response = -1;
                Response_Side = 0;
                break
            end
        end
        WaitSecs(.1);
        
        %Draw fixation for 300 - 500ms
        DrawFormattedText(win,'+','center','center',[255 255 255]);
        Screen('Flip',win);
        fixation_interval = rand()*.2 + .3;
        WaitSecs(fixation_interval);
        
        %Feedback
        if Wait_for_Response == 0
            if colour_side(Response_Side) == 1
                WinLoss = 1;
                if rand < practice_win_1
                    Feedback_Msg = 'WIN';
                else
                    Feedback_Msg = 'LOSS';
                end
            else
                WinLoss = 0;
                if rand > practice_win_2
                    Feedback_Msg = 'LOSS';
                else
                    Feedback_Msg = 'WIN';
                end
            end
        else
            WinLoss = -1;
            Feedback_Msg = 'TOO SLOW!';
        end
        
        DrawFormattedText(win,Feedback_Msg,'center','center',[255 255 255]);
        Screen('Flip',win);
        WaitSecs(1);
        
        %Crash out of experiment (trials)
        [~, ~, keyCode] = KbCheck();
        if keyCode(ExitKey)
            break;
        end
        
    end
end

%% Run Experiment
DrawFormattedText(win, ['We will now begin the experiment.\nYou will see two coloured squares like before (however, they will be different colours). \nOne colour will lead to a win 60% of the time while the other will lead to a win 10% of the time. \nYou will complete ' num2str(num_of_blocks) ' blocks of ' num2str(num_of_trials) ' trials \nRemember: your goal is to win as much as possible.\nPress F to begin.'],'center', 'center', [255 255 255],[],[],[],2);
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
WaitSecs(.25);

for block = 1:num_of_blocks
    %Block message
    DrawFormattedText(win,['Block ' num2str(block)],'center','center',[255 255 255]);
    Screen('Flip',win);
    WaitSecs(2);
    
    square_colour = [randi(255) randi(255) randi(255)];
    square_colour(2,:) = [255-square_colour];
    
    for trial = 1:num_of_trials
        
        %Determine whether oddball or control
        if rand < .5
            colour_side = [1,2];
            marker = 7;
        else
            colour_side = [2,1];
            marker = 8;
        end
        
        %Draw fixation for 300 - 500ms
        DrawFormattedText(win,'+','center','center',[255 255 255]);
        Screen('Flip', win)
        fixation_interval = rand()*.2 + .3;
        WaitSecs(fixation_interval);
        
        %Draw Squares and Fixation
        Screen('FillRect', win , square_colour(colour_side(1),:), [xmid-200 ymid-50 xmid-100 ymid+50]);
        Screen('FillRect', win , square_colour(colour_side(2),:), [xmid+100 ymid-50 xmid+200 ymid+50]);
        DrawFormattedText(win,'+','center','center',[255 255 255]);
        LSL_flipandmark(marker,win,outlet,use_LSL); %Sends the current marker 
        WaitSecs(.5);
        
        %Change Fixation Colour (Go Cue)
        Screen('FillRect', win , square_colour(colour_side(1),:), [xmid-200 ymid-50 xmid-100 ymid+50]);
        Screen('FillRect', win , square_colour(colour_side(2),:), [xmid+100 ymid-50 xmid+200 ymid+50]);
        DrawFormattedText(win,'+','center','center',[75 75 75]);
        LSL_flipandmark(marker+2,win,outlet,use_LSL); %Sends the current marker 

        %Wait for Response
        keypressed = 0;
        Wait_for_Response = 1;
        tic;
        while Wait_for_Response
            [keypressed, ~, keyCode] = KbCheck();
            if keypressed
                RT = toc;
                if keyCode(Left_Key)
                    Wait_for_Response = 0;
                    Response_Side = 1;
                end
                if keyCode(Right_Key)
                    Wait_for_Response = 0;
                    Response_Side = 2;
                end
                if keyCode(ExitKey)
                    break;
                end
            end
            if toc > 2
                RT = 2;
                Wait_for_Response = -1;
                Response_Side = 0;
                break
            end
        end
        WaitSecs(.1)
        
        %Draw fixation for 300 - 500ms
        DrawFormattedText(win,'+','center','center',[255 255 255]);
        Screen('Flip', win);
        fixation_interval = rand()*.2 + .3;
        WaitSecs(fixation_interval);
        
        %Feedback
        if Wait_for_Response == 0
            if colour_side(Response_Side) == 1
                WinLoss = 1;
                if rand < .6
                    Feedback_Msg = 'WIN';
                    feedback_marker = 11;
                else
                    Feedback_Msg = 'LOSS';
                    feedback_marker = 14;
                end
            else
                WinLoss = 0;
                if rand < .9
                    Feedback_Msg = 'LOSS';
                    feedback_marker = 13;
                else
                    Feedback_Msg = 'WIN';
                    feedback_marker = 12;
                end
            end
        else
            WinLoss = -1;
            Feedback_Msg = 'TOO SLOW!';
            feedback_marker = 15;
        end
        
        DrawFormattedText(win,Feedback_Msg,'center','center',[255 255 255]);
        LSL_flipandmark(feedback_marker,win,outlet,use_LSL); %Sends the current marker 
        WaitSecs(1);
        
        %Store Behavioural Data
        beh_data = [beh_data; block trial marker colour_side Wait_for_Response Response_Side WinLoss RT];
        
        %Crash out of experiment (trials)
        [~, ~, keyCode] = KbCheck();
        if keyCode(ExitKey)
            break;
        end
    end
    
    %Crash out of experiment (blocks)
    [~, ~, keyCode] = KbCheck();
    if keyCode(ExitKey)
        break;
    end
end

%% End Experiment
dlmwrite([pname '.txt'],beh_data,'\t');
