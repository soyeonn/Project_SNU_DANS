% Spike
Spike=[];
for i = 1 : 56
    
    Spik = sum(sum(AllData{i,3}));
    Spike = [Spike; Spik];
end

% Smooth firing rate
Fire=[];
for i = 1 : 56
    
    Fir = sum(sum(AllData{i,5}));
    Fire = [Fire; Fir];
end
    