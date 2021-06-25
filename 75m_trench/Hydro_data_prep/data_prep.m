clear all; close all


s=20:20:100;
analysisrange=100:150;
% Q=25:25:1000;
output=[];
for i=1:length(s)
    fid=[num2str(s(i)),'d.mat'];
    fib=[num2str(s(i)),'b.mat'];
    fis=[num2str(s(i)),'bs.mat'];
    
    depth=load(fid);
    bed=load(fib);
    bss=load(fis);
    [time, m, n]=size(depth.data.Val);
    c=1;
    
    for t=13:12:time
     bl=bed.data.Val;
%     contourf(bl,100)
%     plot(bed.data.X(1:end-1,34),bl(:,34))
%     m=find(bed.data.X(1:end-1,34)==3050)
     avgbl=nanmean(bl(end-1,:));%%average bedlevel at downstream boundary
     
     bedshear=squeeze(bss.data.Val(t,:,:));
     maxbss=max(max(bedshear(analysisrange,:)));
     
     d=squeeze(depth.data.Val(t,:,:));
     dmean=nanmean(nanmean(d(analysisrange,:)));
     wl=dmean+avgbl;
     
     outputtemp=horzcat(s(i),wl,dmean,maxbss);
     output=vertcat(output,outputtemp);
     c=c+1;
    end
%     output=sort(output,'ascend');
    fout=['hydrodata.txt'];
    save(fout,'output','-ascii')
end
