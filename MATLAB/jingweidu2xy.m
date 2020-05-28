clear;
clc;
AA=[];
mstruct=defaultm('mercator');
mstruct.geoid=[ 6378137,0.0818191908426215];
mstruct.origin=[0,0,0];
mstruct=defaultm(mstruct);
X=xlsread('Cardellina_canadensis.xlsx','Cardellina_canadensis','Z2:Z6192'); 
y=xlsread('Cardellina_canadensis.xlsx','Cardellina_canadensis','AA2:AA6192');  
N = size(X,1);
for i=1:N   
lat=X(i,1);
lon=y(i,1);
[xx,yy] =projfwd(mstruct,lat,lon);
AA(i,1)=xx;
AA(i,2)=yy;
%[lat,lon]=projinv(mstruct,x,y)
end