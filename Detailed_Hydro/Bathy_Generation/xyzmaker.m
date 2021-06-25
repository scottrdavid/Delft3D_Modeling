function xyzdata=xyzmaker(data,origin)

[m,n]=size(data);
[x,y]=meshgrid(1:n,1:m);

x=x*15;
x=x-min(min(x))+origin;
y=y*15;
y=y-min(min(y))+origin;
xyzdata=[x(:),y(:),data(:)];