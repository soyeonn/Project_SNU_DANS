

% crd = pwd
%  idcs   = strfind(crd, '\');
%  newdir = crd(1:idcs(end)-1);
%
%  pathadd = '\project\B'
%
%  cpath = [newdir pathadd]
%
%  infos = dir(cpath);
%  names = infos.name

A={'r463_m8_tt11_all.1',
    'r463_m8_tt11_all.11',
    'r463_m8_tt11_all.13',
    'r463_m8_tt11_all.14',
    'r463_m8_tt11_all.15',
    'r463_m8_tt11_all.16',
    'r463_m8_tt11_all.4',
    'r463_m8_tt11_all.7',
    'r463_m8_tt11_all.9',
    'r463_m8_tt7_all.1',
    'r463_m8_tt7_all.10',
    'r463_m8_tt7_all.12',
    'r463_m8_tt7_all.2',
    'r463_m8_tt7_all.6',
    'r463_m8_tt8_all.5',
    'r463_m8_tt9_all.11',
    'r463_m8_tt9_all.12',
    'r463_m8_tt9_all.13',
    'r463_m8_tt9_all.20',
    'r463_m8_tt9_all.23',
    'r463_m8_tt9_all.27'}

B={'r463_m8_tt12_all.1'
    'r463_m8_tt12_all.10'
    'r463_m8_tt12_all.11'
    'r463_m8_tt12_all.12'
    'r463_m8_tt12_all.13'
    'r463_m8_tt12_all.4'
    'r463_m8_tt12_all.9'
    'r463_m8_tt13_all.10'
    'r463_m8_tt13_all.12'
    'r463_m8_tt13_all.8'
    'r463_m8_tt13_all.9',
    'r463_m8_tt14_all.12',
    'r463_m8_tt14_all.7',
    'r463_m8_tt14_all.9',
    'r463_m8_tt15_all.4',
    'r463_m8_tt15_all.6',
    'r463_m8_tt15_all.7',
    'r463_m8_tt15_all.9',
    'r463_m8_tt19_all.6',
    'r463_m8_tt20_all.1',
    'r463_m8_tt20_all.3',
    'r463_m8_tt23_all.1',
    'r463_m8_tt2_all.1',
    'r463_m8_tt2_all.3',
    'r463_m8_tt2_all.4',
    'r463_m8_tt2_all.5',
    'r463_m8_tt3_all.1',
    'r463_m8_tt3_all.2',
    'r463_m8_tt3_all.3',
    'r463_m8_tt3_all.4',
    'r463_m8_tt4_all.1',
    'r463_m8_tt5_all.10',
    'r463_m8_tt5_all.11',
    'r463_m8_tt5_all.8',
    'r463_m8_tt5_all.9'}



home1 = 'C:\Users\JibeomChoi\Desktop\DANS\TeamProject\DANS\DANS\NeuralData\project';

AllData = cell( (numel(A)+numel(B)),6  );
an = 1;
for j=1:numel(A)
    AN = num2str(an);
    AllData{j,1}=['A' AN];
    an=an+1;
end




bn=1;
for j=(numel(A)+1):(numel(A)+numel(B))
    BN=num2str(bn);
    AllData{j,1}=['B' BN];
    bn=bn+1;
end

c=1;

for i=1:numel(A)
    spkFile = [home1 '\' 'A', '\' ];
    spkFile = [spkFile A{i}]
    
    UnitProfileSepDiv
%     AllData{c,2} = occMat_bin;
%     AllData{c,3}=spkMat_bin;
%     AllData{c,4} =rawMat;
%     AllData{c,5}= smoothMat;
%     AllData{c,6} = information;

    occMat_bin(   isnan(occMat_bin))  =0;    
    AllData{c,2} = occMat_bin;
    
    spkMat_bin(   isnan(spkMat_bin))  =0;
    AllData{c,3}=spkMat_bin;
    
    rawMat(   isnan(rawMat))  =0;
    AllData{c,4} =rawMat;
    
    smoothMat(   isnan(smoothMat))  =0;
    AllData{c,5}= smoothMat;
    
    AllData{c,6} = information;

    c=c+1;
end


for i=1:numel(B)
    spkFile = [home1 '\' 'B', '\' ];
    spkFile = [spkFile B{i}]
    
    UnitProfileSepDiv
    
    
    occMat_bin(   isnan(occMat_bin))  =0;    
    AllData{c,2} = occMat_bin;
    
    spkMat_bin(   isnan(spkMat_bin))  =0;
    AllData{c,3}=spkMat_bin;
    
    rawMat(   isnan(rawMat))  =0;
    AllData{c,4} =rawMat;
    
    smoothMat(   isnan(smoothMat))  =0;
    AllData{c,5}= smoothMat;
    
    AllData{c,6} = information;
    
    c=c+1;
end



