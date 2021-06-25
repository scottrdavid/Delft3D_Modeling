clear all 
close all

Q=25:25:1500;
Q=fliplr(Q)';
cd('I:\David_data\Floodplain_modeling\fp_channel_development_synthetic_fp\Trench\Parameter_space_v3\Detailed_Hydro\Model_Runs\Trench90m\')
%%% open file
%s=[8 20 120 140];
% s=[4:1:10 20:10:100 200]';
s=[4:1:10 20:10:50]';
% s=4;
output=[];
for i=1:length(s)
d3d_qp('openfile',['trim-S',num2str(s(i)),'Tw90.dat'])



%%% get depth data
d3d_qp('allm',0)
d3d_qp('alln',0)
d3d_qp('allt',1)
d3d_qp('editm',78)
d3d_qp('editn',34)
d3d_qp('selectfield','water depth')
d3d_qp('exportdata',['s',num2str(s(i)),'waterdepth.mat'])

%%% GET BATHY AT DOWNSTREAM EDGE
% d3d_qp('allm',1)
d3d_qp('alln',1)
% d3d_qp('allm',0)
d3d_qp('editm',261)
d3d_qp('selectfield','initial bed level')
d3d_qp('exportdata',['s',num2str(s(i)),'bedlevel.mat'])


wdt=load(['s',num2str(s(i)),'waterdepth.mat']);
wd=wdt.data.Val;
blt=load(['s',num2str(s(i)),'bedlevel.mat']);
avgbl=nanmean(blt.data.Val);


wd=wd(2:length(wd(2:end))/length(Q):end);
wl=wd+avgbl;

outtemp=[Q wl wd];
output=[output outtemp];

end

output=flipud(output);
