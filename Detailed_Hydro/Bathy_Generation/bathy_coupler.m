function fpmat=bathy_coupler(fpmat,oxbow,dist,cellsize)
Idist=round(dist/cellsize);%%% index for right edge of oxbow

[mfp nfp]=size(fpmat);
fpcenter=round(mfp/2); %%% find centerline of fp

[mox nox]=size(oxbow);
oxflo=floor(mox/2); %%% find centerline of fp
oxcil=ceil(mox/2);

fpmat(fpcenter-oxflo+1:fpcenter+oxcil,nfp-Idist-nox:nfp-Idist-1)=fpmat(fpcenter-oxflo+1:fpcenter+oxcil,nfp-Idist-nox:nfp-Idist-1)-oxbow(:,:);

