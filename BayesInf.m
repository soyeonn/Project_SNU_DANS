r1=4; r2=38; c1=23; c2=60;

Nbin = (r2-r1+1)*(c2-c1+1); % number of bins
for k=1:1
    OCM = AllData{k,2}(r1:r2, c1:c2);  % occupancy matrix
    SPM= AllData{k,3}(r1:r2, c1:c2);  % spike matrix
    FRM= AllData{k,4}(r1:r2, c1:c2);  % firing rate matrix
    
    
    
    
    
end