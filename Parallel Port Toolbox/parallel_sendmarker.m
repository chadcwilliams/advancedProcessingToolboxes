
function parallel_sendmarker(port,marker,use_parallel)
if use_parallel
    fwrite(port,['mh',marker,0]); %Send marker
    tic; while tic < .001; end %Delay
    fwrite(port,['mh',0,0]); %Turn off marker
end
end