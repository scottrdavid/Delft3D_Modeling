function oxbow=generate_oxbow(oxdepth, oxwidth, oxlength, oxchanwidth, cellsize,orientation)
%%%variables
% oxdepth=1;
% oxwidth=5000;
% oxlength=5000;
% oxchanwidth=200;
% cellsize=15;


%%%Make channel width divisible by two
ncellchan=round(oxchanwidth/cellsize);
if mod(ncellchan,2)==0
    else
    ncellchan=ncellchan+1;
    newwidth=ncellchan*cellsize;
    sprintf('Note channel width was increased to %d meters', newwidth)
end
chancent=ncellchan/2;

m=round(oxlength/cellsize);
n=round(oxwidth/cellsize);

%%%%%%%%%%% Create Oxbow Skeleton%%%%%%%%%%%%%%%%%%%%%%
%%%% set centerline of max depth
oxmat=ones(m,n)*NaN;
%%%% Set outer edge of oxbow 
oxmat(1,:)=0;
oxmat(end,:)=0;
oxmat(:,1)=0;
oxmat(:,end)=0;


%%%top leg
oxmat(chancent+1,chancent+1:end-chancent)=oxdepth;
oxmat(chancent+2,chancent+1:end-chancent)=oxdepth;
%%%left leg
oxmat(chancent+1:end-chancent,chancent+1)=oxdepth;
oxmat(chancent+1:end-chancent,chancent+2)=oxdepth;
%%%right leg
oxmat(chancent+1:end-chancent,end-chancent)=oxdepth;
oxmat(chancent+1:end-chancent,end-chancent-1)=oxdepth;

%%%% Set inner edge
oxmat(ncellchan+2:end,ncellchan+2:end-ncellchan-1)=0;


%%%%%%%%%Interpolate nans%%%%%%%%%%%%%%
oxbow=inpaint_nans(oxmat,1);


%%%%% oxbow orientation
if orientation==1
    
    elseif orientation==2
    oxbow=rot90(oxbow);
    elseif orientation==3
    oxbow=rot90(rot90(oxbow));
    else
    oxbow=rot90(rot90(rot90((oxbow))));
end


%% Scratch section from precious tests

%%%%%%% vectorizing oxbow skeleton for interpolation
% [m,n]=size(oxmat);
% [x,y]=meshgrid(1:m,1:n);
% xyz=[x(:),y(:),oxmat(:)];%%% make xyz data from oxbow skeleton
% xyz(any(isnan(xyz),2),:)=[];%% remove nans
% 
% [xq,yq]=meshgrid(1:m,1:n);
% oxbow=griddata(xyz(:,1),xyz(:,2),xyz(:,3),xq,yq)

% [m,n]=size(oxmat);
% xchanprof=linspace(0,oxdepth,ncellchan/2);
% xchanprof=[xchanprof fliplr(xchanprof)];
% 
% for i=ncellchan/2:m-ncellchan/2
% oxmat(i,1:length(xchanprof))=xchanprof;
% oxmat(i,n-length(xchanprof)+1:n)=fliplr(xchanprof);
% 
% end
% 
% for j=ncellchan/2:n-ncellchan/2
%    oxmat(1:ncellchan,j)=xchanprof;
%   
% end

% oxmat(ncellchan/2:end+1-round(ncellchan/2),round(ncellchan/2))=oxdepth;
% 
% oxmat(ncellchan/2:end+1-round(ncellchan/2),end+1-round(ncellchan/2))=oxdepth;
% % oxmat(end+1-round(ncellchan/2),round(ncellchan/2):end+1-round(ncellchan/2))=oxdepth;


% oxmat(ncellchan:end,end-ncellchan+1)=0;
% oxmat(ncellchan,ncellchan:end+1-ncellchan)=0;
% oxmat(ncellchan:end,ncellchan)=0;

% Mf = fillmiss(oxmat);