
function parallel_flipandmark(port,window,marker,useParallel)
if useParallel
    fwrite(port,['mh',marker,0]); %Send marker
    tic; while tic < .001; end %Delay
    fwrite(port,['mh',0,0]); %Turn off marker
    Screen(window,'Flip');
end
end