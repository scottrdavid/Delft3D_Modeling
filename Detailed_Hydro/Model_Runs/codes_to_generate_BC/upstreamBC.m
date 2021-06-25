

Q=25:25:1500;
Q2=sort([Q';Q'],'descend');

m=length(Q2);
dt=60*8;

t=0:dt:(m/2)*dt;
t2=t+1;
t3=t2(2:end-1);
t4=[t3';t'];
time=sort(t4,'ascend');


% dQ=500


output=[time Q2]