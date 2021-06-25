clear all
close all

%%%%Booleans
dosaveoutput=1;
doaddroughness=1;
doaddtrench=0;

%%%% Parameters
cellsize=15;
roughness=.01;
roughnessdist=200;
slope=0.0006;
dlength=5000;
dwidth=1500;
uselev=10;
trenchdepth=2;
trenchwidth=300;
trenchcenter=3750; 


dselev=uselev-(dlength*slope);
vect=linspace(uselev,dselev,ceil(dlength/cellsize));
mat=repmat(vect',[1 ceil(dwidth/cellsize)]);
mat=mat';
[m n]=size(mat);

trenchindex=ceil(trenchcenter/cellsize);
trenchwind=ceil(trenchwidth/cellsize);


base=mat(m/2,trenchindex);
basetmp=base-trenchdepth;
xmax=2*sqrt(trenchdepth);
x=linspace(-1*xmax,xmax,trenchwind);
y=((x/2).^2)+basetmp;
tmp=trenchindex-(0.5*trenchwind);
tmp2=trenchindex+(0.5*trenchwind);

figure
plot(x,y)

roughlength=ceil(roughnessdist/cellsize);
roughvect=-roughness+(roughness+roughness)*rand(m,1);

if doaddtrench==1
for i=1:m
    k=1;
        for j=tmp:tmp2-1
        mat(i,j)=y(k);
        k=k+1;
        end 
    

end
else
end


    if doaddroughness==1
        for l=tmp-roughlength:tmp-1
            mat(:,l)=mat(:,l)+roughvect;
        end
        else
    end

figure
contourf(mat,50)
mat=rot90(rot90(rot90(mat)));


[r s]=find(mat==mat);
matvect=mat(:);

if dosaveoutput==1
output=[r*cellsize s*cellsize matvect];
save('bathyroughness.xyz','output','-ascii')
else
end




