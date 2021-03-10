%Setup port
parallel_port = serial('/dev/ttyUSB0','BaudRate',115200);

%Open Port
fopen(parallel_port);

%Cycle through 255 numbers
for marker = 1:255
   parallel_sendmarker(parallel_port,marker,1); %Sends the current marker 
   tic; while toc < 1; end %1 second delay
end

%Close port
fclose(parallel_port);


