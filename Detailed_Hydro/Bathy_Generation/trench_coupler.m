function fpmat=trench_coupler(fpmat,trench,dist,cellsize)

Idist=round(dist/cellsize);%%% index for right edge of oxbow
[mfp nfp]=size(fpmat);
[mt nt]=size(trench);
htif=floor(nt/2);
htic=ceil(nt/2);
istart=htif+Idist;
ifin=Idist-htic;
fpmat(:,end-istart:end-ifin-1)=fpmat(:,end-istart:end-ifin-1)-trench;

