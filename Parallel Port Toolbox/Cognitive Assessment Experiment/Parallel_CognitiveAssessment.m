%% Cognitive Assessment for Parellel Port Markering
% Written by Chad C. Williams at the University of Victoria, 2021
% Adapted from Chad C. Williams' CognitiveAssessmentMuseLSL code (2018)
% www.chadcwilliams.weebly.com

%Supporting scripts include: 'Parallel_Fixation.m', Parallel_Oddball.m',
%'Parallel_DecisionMaking.m', 'Parallel_flipandmark.m', 'Parallel_sendmarker.m'

%% Initial parameters
clear all; clc; Shuffle(rng);

%% User input
use_parallel = 1; %1 if using parallel markers, 0 for behavioural only

run_fixation = 1; %Determine whether to run this task. 1 = yes, 0 = no.
run_oddball = 1; %Determine whether to run this task. 1 = yes, 0 = no.
run_decisionmaking = 1; %Determine whether to run this task. 1 = yes, 0 = no.

%Note: There are additional user inputs at the top of each task that may be
%changed (e.g., number of blocks/trials)

%% Opening devices
if use_parallel == 1
    %Setup port
    parallel_port = serial('/dev/ttyUSB0','BaudRate',115200); %Note, the serial path may need to change
    %Open Port
    fopen(parallel_port);
end

%% Subject Number
subject_number = input('Enter the subject number:\n','s');  % get the subject number
ListenChar(2);

%% Experiments
if run_fixation
    Parallel_Fixation
end

if run_oddball == 1 && run_decisionmaking == 1 %Run both in random order
    if rand < .5
        Parallel_Oddball
        Parallel_DecisionMaking
    else
        Parallel_DecisionMaking
        Parallel_Oddball
    end
elseif run_oddball == 1 && run_decisionmaking == 0 %Run Oddball only
    Parallel_Oddball
elseif run_oddball == 0 && run_decisionmaking == 1 %Run Decision Making only
    Parallel_DecisionMaking
else
    %Run neither
end

%% Shutdown

DrawFormattedText(win, 'Thank you for participating','center', 'center', [255 255 255],[],[],[],2);
Screen('Flip', win);
WaitSecs(5);

if use_parallel
    %Close port
    fclose(parallel_port);
end

ListenChar();
sca;