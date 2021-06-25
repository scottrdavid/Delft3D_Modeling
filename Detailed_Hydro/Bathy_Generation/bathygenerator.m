function [ fpmat, fpdata] = bathygenerator( fplength,fpwidth, cellsize,fpslope,upstreamelev,rivwidth,rivdepth, rfactor)
%%% creating bathy with river down the middle, river is square and same slope as the floodplain, also rfactor adds in a random roughness to the floodplain 

%% Create the floodplain
%%%% Create initial grided domain of all ones
fpmat=ones(round(fpwidth/cellsize),round(fplength/cellsize));%%% creates inital grided data
[m,n]=size(fpmat);

%%%% create a vector of elevations
downstreamelev=upstreamelev-(fpslope*fplength);
tempvect=linspace(upstreamelev,downstreamelev,n);

%%%% multiply vector by each row to generate uniform fp

for i=1:m
        fpmat(i,:)=fpmat(i,:).*tempvect;
end


%% Create a square uniform river
%%%% Find location and number of cells for river
numrivcell=round(rivwidth/cellsize);%%% find number of cells needed
p=mod(numrivcell,2);%%% find if number is odd or even 1 for odd 0 for even
domaincenter=round(m/2);


if p==0
%%%% make the river if numrivcellls is odd, river will be centered in
%%%% domain
    for j=1:numrivcell/2;
        fpmat(domaincenter+j,:)=fpmat(domaincenter,:)-rivdepth; 
    end
     for j=0:numrivcell/2;
        fpmat(domaincenter-j,:)=fpmat(domaincenter-j,:)-rivdepth; 
    end
else %%% if p==1 then odd so river isn't perfectly centered
    
%%%% make lower half of the river river
    for j=1:round(numrivcell/2)-1;
        fpmat(domaincenter+j,:)=fpmat(domaincenter+j,:)-rivdepth; 
    end

%%%% make upper half of the river
    for j=0:round(numrivcell/2)+1;
        
        fpmat(domaincenter-j,:)=fpmat(domaincenter-j,:)-rivdepth;
        
    end
end


%% Add random roughness
%%%% Create roughness matrix
randscalefactor=rfactor/0.5; %%% matrix goes from -0.5 to 0.5 so need to find what scaler to multiply by to get disired upper and lower bounds
roughness=randscalefactor*(rand(m,n)-0.5); %%% compute random matrix of plus minus rfacor

%%%% Add roughness to flooplain
fpmat=fpmat+roughness;

  


end

