%=====================================================
%Coplyleft, Jan. 28 2019
%Lee Suk-Ho M.D. Ph.D.
%Department of Physiology, Seoul National Univ. College of Medicine
%=====================================================

clear;
% Load the training pattern
img1 = imread('s', 'bmp');
img1(img1>250)=255;
img1(img1<10)=0;

img1 = img1(:,:,1)
Npc = numel(img1); % # of PCs = 3600
img1 = min(1,-1*(double(img1)-255));


img2 = imread('D','bmp')
img2 = img2(:,:,1)

img2(img2>250)=255;
img2(img2<10)=0;

Npc = numel(img2); % # of PCs = 3600
img2 = min(1,-1*(double(img2)-255));

% Constants
time = 100; % in ms: (initial = 30)
c = 0.26; % connectivity btwn PCs, initial value 0.25
g1 = 0.5; % network activity-dependence of threshold 
b1 = 0.3; % partial cue to the original one

%Izhs param
vrest = -65; vret = -58;
v = vrest*ones(Npc,1); 
aiz=0.02;  biz = 0.25;  ud = 4; 
WtHigh = 2;
WtLow = WtHigh/2;

% W = structural connection matrix
W = rand(Npc,Npc);
W = ceil(W + (c-1));   % connectiviy should be greater than 1-c to be 1, otherwise 0.



Z=zeros(Npc,1);  %training pattern
Z1(:,1)=img1(:);
Z2(:,1)=img2(:);
Zc=Z1(:,1).*Z2(:,1);  % common region
ZT = Z1+Z2;
ZT(ZT>0)=1;

Z1=Z1-Zc;  % specific to img1
Z2=Z2-Zc; % specific to img2

IDs1 = find(Z1>0);
IDs2 = find(Z2>0);

IDc = find(Zc>0);  % common region

IDs = union(IDs1, IDs2);
IDb = setdiff(1:Npc, IDs); % background 

% Jh = Hebbian connectivity
Jh = ZT*ZT';
Jh = min(1,Jh);

% for i=IDs
%     for j=IDc
%         Jh(i,j)=0;
%     end
% end
% 
% for i=IDs
%     for j=IDb
%                 Jh(i,j)=0;
%     end
% end
%               

%Disable autaptic connections
for idx=1:Npc
    Jh(idx,idx) = 0;
end

%Syn Wt matrix
%WJ = SynWt*W.*Jh;
WJ = max(WtLow*W, WtHigh*W.*Jh);

for i=IDs
    for j=IDc
        WJ(i,j)=0;
    end
end

for i=IDs
    for j=IDb
        WJ(i,j)=0;
    end
end

for i=IDs1
    for j=IDs1
        if rand<0.5
        WJ(i,j)=2;
        end
    end
end

for i=IDs2
    for j=IDs2
        if rand<0.5
        WJ(i,j)=2;
        end
    end
end

for i=IDs2
    for j=IDs1
        WJ(i,j)=0;
    
    end
end

for i=IDs1
    for j=IDs2 
        WJ(i,j)=0;
     end
end


for idx=1:Npc
    WJ(idx,idx) = 0;
end


Isyn = zeros(Npc,time); % h(i,t): exc synaptic inputs to i-th PC at t 
Inet = zeros(Npc, time);
Iinh = zeros(time,1); % Inh. synaptic inputs at t

%Make initial cue
X0 = double(img1(:)).*rand(Npc, 1);
X0 = max(0,ceil(X0+(b1-1))); %initial cue

X = zeros(Npc,time); % X(i,t) = 1, if ith PC fired at t.
X(:,1) = X0;

% plot initial partial cue
fx0 = find(X0(:)>0);
nrow = size(img2,1); ncol = size(img2,2); np = ncol*nrow;
figure(1); clf; axis tight equal  
col = ceil(fx0/nrow);    row = mod(fx0, nrow);    plot(col, row, '.r');  axis([0 60 0 60]); 
pause(1); 
% clear fx0;

v(:,1) = vrest; uiz = biz.*v;
Iinh(:,1) = 0; Inet(:,1) = 0; Isyn(:,1) = 0;

% Simulation Main
for t = 1:time-1
	Isyn(:,t) = WJ*X(:,t);  % Isyn(i,t): exc. synaptic inputs to i-th PC at t 
	Iinh(t) = g1*sum(X(:,t));  % Inh. synaptic inputs  
    Inet(:,t) = max(0, Isyn(:,t) - Iinh(t)); 
        
    fired=find(v>=30);   
    v(fired)=vret;       % reset of fired
	uiz(fired)=uiz(fired)+ud; 
    X(fired,t+1) = 1;
    
    v=v+0.5*((0.04*v+5).*v+140-uiz+ Inet(:,t));
  
    uiz=uiz+aiz.*(biz*v-uiz);
    
    hold on
    if mod(t,5)==1       
       pause(0.1)
    end
    col = ceil(fired/nrow);    row = mod(fired, nrow);    plot(col, row, '.k');   axis([0 60 0 60]);      
end
set(gca,'xtick',[])
set(gca,'ytick',[])