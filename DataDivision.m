r1=4; r2=38; c1=23; c2=60;
Nbin = (r2-r1+1)*(c2-c1+1); % number of bins
NR = r2-r1+1;
NC = c2-c1+1;

indx = zeros(NR*NC, 2);
res = zeros(NR*NC, 21);

c=1;

for i=r1:r2
    for j=c1:c2
        indx(c,1:2) = [i j];
        
        for n=22:56
            res(c,n) = AllData{n, 3}(i,j);        
        end
        c=c+1;
    end    
end