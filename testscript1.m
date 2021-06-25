
clear all
[S,D,Q,Tau] = textread('inputdata.txt', '%s %s %s %s', 'delimiter', ',');



for T=60:15:90
for Si=20
    
folderid=['I:\David_data\Floodplain_modeling\fp_channel_development_synthetic_fp\Trench\Parameter_space_v3\',num2str(T),'m_trench\S',num2str(Si)];
cd(folderid) 

sit=num2str(Si);
index = find(strcmp(S, sit));



for ii=min(index):max(index)
 
Tout=Tau{ii};
Qout=Q{ii};

%%% Values in base data;
Qin='1.0000000e+002';
Tin='1.1230000E+00';
%%% Naming convention for base data
basename='base';
basesed=[basename,'.sed'];
basetce=[basename,'.tce'];
basebct=[basename,'.bct'];
basemdf=[basename,'.mdf'];

%%% creat output filenames
filename=['T',num2str(T),'S',S{ii},'D',D{ii}];
sedout=[filename,'.sed'];
tceout=[filename,'.tce'];
bctout=[filename,'.bct'];
mdfout=[filename,'.mdf'];


%%% create tce file
filein=basetce;
fileout=tceout;
str = fileread(filein);               %# read contents of file into string
str = strrep(str, Tin, Tout);        %# Replace basename with inputdata

fid = fopen(fileout, 'w');
fwrite(fid, str, '*char');              %# write characters (bytes)
fclose(fid);


%%% Create Sed File

filein=basesed;
fileout=sedout;
str = fileread(filein);               %# read contents of file into string
str = strrep(str, basetce, tceout);        %# Replace basename with inputdata

fid = fopen(fileout, 'w');
fwrite(fid, str, '*char');              %# write characters (bytes)
fclose(fid);




%%% Create bct File

filein=basebct;
fileout=bctout;
str = fileread(filein);               %# read contents of file into string
str = strrep(str, Qin, Qout);        %# Replace basename with inputdata

fid = fopen(fileout, 'w');
fwrite(fid, str, '*char');              %# write characters (bytes)
fclose(fid);

%%% Create mdf File

filein=basemdf;
fileout=mdfout;
str = fileread(filein);               %# read contents of file into string
str = strrep(str, basename, filename);        %# Replace basename with inputdata

fid = fopen(fileout, 'w');
fwrite(fid, str, '*char');              %# write characters (bytes)
fclose(fid);

end
end
end