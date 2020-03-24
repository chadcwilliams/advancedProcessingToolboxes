% VPixx_flipandmark written by Chad C. Williams from the Krigolson Lab at 
% the University of Victoria. Sends a marker synced to a flip when using the 
% ViewPixx. June 13, 2018

function [VBLTimestamp, StimulusOnsetTime, FlipTimestamp, Missed, Beampos] = VPixx_sendmarker(window, marker,useViewPixx)

%Warning for misuse
    if marker < 1 || marker > 255
        disp('Warning: Marker should range from 1 to 255.');
    end

%These represent values in red (first three), green (next four), and blue
%(last one) which will be used to determine the pixel colour
pins = [4,16,64,1,4,16,64,1];

%Converting marker into binary
temp = de2bi(marker);

%Adding any zeros to the end (the last function only displays until the
%final '1'. This determines which of the pins will be activated
trailing_zeros = 8-length(temp);
bin_val = [temp zeros(1,trailing_zeros)];

%Pull the values of the active pins
colour_marker = pins.*bin_val;

%Determine RGB value
col_val = [sum(colour_marker(1:3)), sum(colour_marker(4:7)), colour_marker(8)];

%Draw top left pixel which ViewPixx uses as a marker trigger
Screen('FillRect', window, col_val , [0 0 1 1]);

%Display the pixel
[VBLTimestamp, StimulusOnsetTime, FlipTimestamp, Missed, Beampos] = Screen('Flip',window,[],2);

%Zero the digital out
tic; while toc < .05; end; % Wait 50 ms before zeroing

%Draw a black pixel effectively resetting the pixel
Screen('FillRect', window, [0,0,0] , [0 0 1 1]);
Screen('Flip',window,[],2);

end