%% Cognitive Assessment for LSL Markering
% Written by Chad C. Williams at the University of Victoria, 2021
% Adapted from Chad C. Williams' Parallel Port Toolbox code (2021)
% www.chadcwilliams.com

%Supporting scripts include: 'LSL_Fixation.m', LSL_Oddball.m',
%'LSL_DecisionMaking.m', 'LSL_flipandmark.m', 'LSL_sendmarker.m'

%% Initial parameters
clear all; clc; Shuffle(rng);

%% User input
use_LSL = 1; %1 if using LSL markers, 0 for behavioural only

run_fixation = 1; %Determine whether to run this task. 1 = yes, 0 = no.
run_oddball = 1; %Determine whether to run this task. 1 = yes, 0 = no.
run_decisionmaking = 1; %Determine whether to run this task. 1 = yes, 0 = no.

%Note: There are additional user inputs at the top of each task that may be
%changed (e.g., number of blocks/trials)

%% Opening devices
if use_LSL == 1
    % Initiate marker stream
    lib = lsl_loadlib();
    info = lsl_streaminfo(lib,'Markers','Markers',1,0,'cf_string','myuniquesourceid23443');
    outlet = lsl_outlet(info);
end

%% Subject Number
subject_number = input('Enter the subject number:\n','s');  % get the subject number
ListenChar(2);

%% Experiments
if run_fixation
    LSL_Fixation
end

if run_oddball == 1 && run_decisionmaking == 1 %Run both in random order
    if rand < .5
        LSL_Oddball
        LSL_DecisionMaking
    else
        LSL_DecisionMaking
        LSL_Oddball
    end
elseif run_oddball == 1 && run_decisionmaking == 0 %Run Oddball only
    LSL_Oddball
elseif run_oddball == 0 && run_decisionmaking == 1 %Run Decision Making only
    LSL_DecisionMaking
else
    %Run neither
end

%% Shutdown

DrawFormattedText(win, 'Thank you for participating','center', 'center', [255 255 255],[],[],[],2);
Screen('Flip', win);
WaitSecs(5);

ListenChar();
sca;