clear all 
close all

Q=25:25:700;
Q=fliplr(Q)';

%%% open file
s=[8 20 120 140];
output=[];
for i=1:length(s)
d3d_qp('openfile',['I:\David_data\Floodplain_modeling\fp_channel_development_synthetic_fp\Trench\Parameter_space_v3\90m_trench\hydrodata\trim-s',num2str(s(i)),'hydro.dat'])



%%% get depth data
d3d_qp('allm',0)
d3d_qp('alln',0)
d3d_qp('allt',1)
d3d_qp('editm',75)
d3d_qp('editn',34)
d3d_qp('selectfield','water depth')
d3d_qp('exportdata',['I:\David_data\Floodplain_modeling\fp_channel_development_synthetic_fp\Trench\Parameter_space_v3\90m_trench\hydrodata\s',num2str(s(i)),'waterdepth.mat'])

%%% GET BATHY AT DOWNSTREAM EDGE
d3d_qp('allm',1)
d3d_qp('alln',1)
d3d_qp('allm',0)
d3d_qp('editm',261)
d3d_qp('selectfield','initial bed level')
d3d_qp('exportdata',['I:\David_data\Floodplain_modeling\fp_channel_development_synthetic_fp\Trench\Parameter_space_v3\90m_trench\hydrodata\s',num2str(s(i)),'bedlevel.mat'])


wdt=load(['s',num2str(s(i)),'waterdepth.mat']);
wd=wdt.data.Val;
blt=load(['s',num2str(s(i)),'bedlevel.mat']);
avgbl=nanmean(blt.data.Val);


wd=wd(2:length(wd(2:end))/length(Q):end);
wl=wd+avgbl;

outtemp=[Q wl];
output=[output outtemp];

end

output=flipud(output);
