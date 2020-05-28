clear;
clc;
AA=[];
mstruct=defaultm('mercator');
mstruct.geoid=[ 6378137,0.0818191908426215];
mstruct.origin=[0,0,0];
mstruct=defaultm(mstruct);
X=xlsread('Arenaria_melanocephala1.xlsx','pred1','B1:B1272'); 
y=xlsread('Arenaria_melanocephala1.xlsx','pred1','C1:C1272');  
N = size(X,1);
for i=1:N    
xx=X(i,1);
yy=y(i,1);
[lat,lon]=projinv(mstruct,xx,yy);
AA(i,1)=lat;
AA(i,2)=lon;
end