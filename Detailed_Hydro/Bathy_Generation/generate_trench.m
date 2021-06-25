function trench=generate_trench(tdepth, twidth, fpwidth, cellsize)


ntcell=round(twidth/cellsize);
nfcell=round(fpwidth/cellsize);

xsect1trench=linspace(0,tdepth,round(ntcell/2));
xsect2trench=fliplr(xsect1trench);

if mod(ntcell,2)==0 %% Even number of cells
xsecttrenct=[ xsect1trench xsect2trench];
else %% odd number of cells
xsect1trench(end)=[];
xsecttrenct=[ xsect1trench xsect2trench];
end

trench=repmat(xsecttrenct,round(fpwidth/cellsize),1);


