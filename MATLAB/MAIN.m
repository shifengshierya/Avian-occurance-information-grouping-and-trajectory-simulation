clear;
clc;
x=xlsread('Calcarius_pictus.xlsx','Calcarius_pictus','Z2:Z312');      
y=xlsread('Calcarius_pictus.xlsx','Calcarius_pictus','AA2:AA312'); 
z=xlsread('Calcarius_pictus.xlsx','Calcarius_pictus','AB2:AB312'); 
N = size(z);
N=N(1,1);
zz1=z(1,1);
zz2=zz1+365;
zz3=1;
for i=zz1:zz2
    zz4=0;
    for i1=1:N
        if i==z(i1,:)
            aa(zz3,1)=x(i1,:);
            aa(zz3,2)=y(i1,:);
            aa(zz3,3)=z(i1,:);
            zz3=zz3+1;
            zz4=zz4+1;
        end
    end
    if zz4==0
        aa(zz3,3)=i;
        zz3=zz3+1;
    end
    
end
aa1=aa;        
N1 = size(aa1);
N1=N1(1,1);     
zz5=0;
for i2=1:N1
    if aa1(i2,1)==0
        zz5=zz5+1;
    end
    if aa1(i2,1)~=0&zz5>0
      
        zz6=i2;
        for i3=1:zz5
            qq1=(aa1(i2,1)-aa1(i2-(zz5+1),1))/(zz5+1);
            qq2=(aa1(i2,2)-aa1(i2-(zz5+1),2))/(zz5+1);
            aa1(i2-(zz5+1)+i3,1)=aa1(i2-(zz5+1),1)+qq1*i3;
            aa1(i2-(zz5+1)+i3,2)=aa1(i2-(zz5+1),2)+qq1*i3;
            
        end
        zz5=0;
    end
    
end
x=aa1(:,1); 
y=aa1(:,2); 
z=aa1(:,3); 
N = size(z);
AA=[];
AA(1,:)=[x(1),y(1)];
h=1;
L=1;

for i=1:N-1
if z(i+1)==z(i)
AA(h,2*L+1:2*L+2)=[x(i+1),y(i+1)];
L=L+1;
else
h=h+1;
L=1;
AA(h,L:L+1)=[x(i+1),y(i+1)];
end
end
AA(all(AA==0,2),:)=[] 
N1= size(AA,2);
N1=N1/2;
N2=size(AA,1);
a1=1;a2=1,a3=1; A1=[];A2=[];A3=[];
%Change the value of bb to loop
for bb=1:N2-7
    AAA=[];
    new=1; 
for gg=bb:bb+6
for ii=1:N1
if AA(gg,2*ii-1)~=0&&AA(gg,2*ii)~=0
    AAA(new,1)=AA(gg,2*ii-1);
    AAA(new,2)=AA(gg,2*ii);
    new=new+1;
end
end
end
x=AAA;
n= size(AAA,1);; 
% figure(1)
% scatter(x(:,1),x(:,2));

%% Normalization processing
x_min=min(min(x));
x_max=max(max(x));
x=(x-x_min)/(x_max-x_min);
% figure(2)
% scatter(x(:,1),x(:,2));
%% Divide the grid, cluster and crop the data
%% Devide the grid
k=50;
len=1/k;
position_x=zeros(n,2);
position_x(:,1)=ceil(x(:,1)/len);
position_x(:,2)=ceil(x(:,2)/len);
position_x(find(position_x==0))=1;
[A,B]=sortrows(position_x);
%% Count the number of points in each grid.
count=zeros(k,k);
for i=1:n
    count(A(i,1),A(i,2))=count(A(i,1),A(i,2))+1;
end
%% Crop the data
% design the threshold
% threshold = maximum number * ratio
q=1;
max_count=max(max(count));
q=q*max_count;
jishu=1;
for i=1:n
    if count(A(i,1),A(i,2))>=q
        xx(jishu,1)=x(B(i),1);
        xx(jishu,2)=x(B(i),2);
        x(B(i),1)=-1;
        x(B(i),2)=-1;
        jishu=jishu+1;
    end
end
x=x(find(x(:,1)~=-1),1:2);
%% Cropped view of the data
% figure
% scatter(x(:,1),x(:,2));
%% Calculate the distance of space object with weight (Euclidean distance in this case)
[n,~]=size(x);
w=[0.5,0.5];
% w=rand(1,2);
% w=w/sum(w);
dist=zeros(n,n);
for i=1:n
    dist(:,i)= w(1)*( (x(:,1)-x(i,1)) .^2 )  + w(2)*( (x(:,2)-x(i,2)).^2 ) ;
end
dist=sqrt(dist);
%% Calculates the spatial neighborhood of each object
max_dist=max(max(dist));
k=1;   
k=k*max_dist; 
[N_i,N_j]=find(dist<=k);
N=[N_i,N_j];
%% Calculate the SLDR for each object
u=zeros(1,n);
SLDR=zeros(1,n);
for i=1:n
   % disp(i);
    tmp=find(N_j==i);
    tmp_E=max(tmp);
    tmp_S=min(tmp);
    tmp=dist( N(tmp_S:tmp_E,1:2)) ;
    tmp_ji=(tmp_E-tmp_S+1);
    u(i)=sum(tmp(:,1))/tmp_ji;
    tmp_c=(tmp(:,1)-u(i)).^2;
    SLDR(i)=sum(tmp_c)/tmp_ji;
end
%% Gets the candidate set of outliers 
%% Calculate the SLDIR for each object
 SLDIR=zeros(1,n);
for i=1:n
   % disp(i)
    tmp=find(N_j==i);
    tmp_E=max(tmp);
    tmp_S=min(tmp);
    tmp=SLDR( N_i(tmp_S:tmp_E) ) ;
    tmp_ji=(tmp_E-tmp_S+1);
    SLDIR(i)=sum(tmp)/tmp_ji;
end
%% Calculate the SLDF for each object
SLDF=SLDIR./SLDR;
%% Draw the result
k=1; 
[SLDF_1,B]=sort(SLDF);
% figure
% scatter(x(B(1:n-k),1),x(B(1:n-k),2));
% hold on;
% scatter(x(B(n-k+1:n),1),x(B(1+n-k:n),2),'r');
% hold on; 
BB=[x(B(1:n-k),1),x(B(1:n-k),2)];
BB=BB*(x_max-x_min)+x_min;
% scatter(xx(:,1),xx(:,2));
x=BB';
bandwidth = 500000;
%% Clustering
tic
[clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(x,bandwidth);
% clustCent£ºThe clustering center,D*K, point2cluster£ºClustering results  class labels, 1*N
toc
%% Drawing
numClust = length(clustMembsCell);
figure(3),clf,hold on
cVec = 'bgrcmykbgrcmykbgrcmykbgrcmyk';%, cVec = [cVec cVec];
for k = 1:min(numClust,length(cVec))
    myMembers = clustMembsCell{k};
    myClustCen = clustCent(:,k);
    plot(x(1,myMembers),x(2,myMembers),[cVec(k) '.'])
    plot(myClustCen(1),myClustCen(2),'o','MarkerEdgeColor','k','MarkerFaceColor',cVec(k), 'MarkerSize',10)
    AAA1= size(myMembers,2);
    A1(:,a1)=myClustCen;
    a1=a1+1;
    if AAA1>1
    for aaa=1:AAA1
    A2(aaa,2*a2-1:2*a2)=[x(1,myMembers(aaa)),x(2,myMembers(aaa))];
    end
    a2=a2+1;
    end
    if AAA1==1
    A2(AAA1,2*a2-1:2*a2)=[x(1,myMembers(AAA1)),x(2,myMembers(AAA1))];
    a2=a2+1;
    end
end
A3(:,a3)=numClust;
a3=a3+1;
title(['no shifting, numClust:' int2str(numClust)])
%Data storage
A3(find(A3==0))=[];
end
%Data comparison
NMAX= size(AAA,1);
A3(:,NMAX)=0;
A3(find(A3==0))=[];
p2=0;
N3=size(A3,2);
for p1=1:N3
    PP=A3(1,p1);
    p2=PP+p2;
    A3(2,p1)=p2;
end    
LL4=0;dddd=0;LL5=0;LL6=0;
for b1=2:N3-1
if LL6>0
LL1=A3(2,b1-1);
LL2=A3(2,b1);
LL3=A3(2,b1+1);
O1=A3(1,b1-1);
O2=new2;
O3=A3(1,b1+1);
KK1=A1(:,LL4+1:LL1);
KK2=new1;
KK3=A1(:,LL2+1:LL3);
DD1=A2(:,2*LL4+1:2*LL1);
DD2=A2(:,2*LL1+1:2*LL2);
DD3=A2(:,2*LL2+1:2*LL3);
LL4=LL1;
LL5=LL5+1;
end
if LL6==0
LL1=A3(2,b1-1);
LL2=A3(2,b1);
LL3=A3(2,b1+1);
O1=A3(1,b1-1);
O2=A3(1,b1);
O3=A3(1,b1+1);
KK1=A1(:,LL4+1:LL1);
KK2=A1(:,LL1+1:LL2);
KK3=A1(:,LL2+1:LL3);
DD1=A2(:,2*LL4+1:2*LL1);
DD2=A2(:,2*LL1+1:2*LL2);
DD3=A2(:,2*LL2+1:2*LL3);
LL4=LL1;
LL5=LL5+1;
end
        
    
%Large
jl=[];shuju0=[];
if O3>O2
new2=O3;
dddd=dddd+1;  
    for t1=1:O2
        for t2=1:O3
        jl(t1,t2)=sqrt((KK2(1,t1)-KK3(1,t2))^2+(KK2(2,t1)-KK3(2,t2))^2);
        end
    end
    [min_a,index]=min(jl,[],2);
   for t3=1:O2
       aaa=index(t3);
       if dddd==1
       shuju1=[DD2(:,t3*2-1:t3*2);DD3(:,aaa*2-1:aaa*2)];
       new1(:,t3)=KK3(:,aaa);
       LL6=LL6+1;
       end
       if dddd>1
       shuju1=[];
       shuju1=[guiji{t3};DD3(:,aaa*2-1:aaa*2)];
       new1(:,t3)=KK3(:,aaa);
       end
       zhongjian{t3}=shuju1;
       zhongjian{t3}(all(shuju1==0,2),:)=[];  
   end
   

     jl=[];
     for t1=1:O3
        for t2=1:O2
        jl(t1,t2)=sqrt((KK3(1,t1)-KK2(1,t2))^2+(KK3(2,t1)-KK2(2,t2))^2);
        end
     end
    [min_a,index]=min(jl,[],2);
    XX=unique(index);
    nnp=O3-O2;
    nnn=1;
for i=1:length(XX)
[m n]=find(index==XX(i));
if length(m)>=2
abc(nnn,1)=XX(i) ;
abc(nnn,2)=length(m);
nnn=nnn+1;
end  
if length(m)>=2
    for nnc=1:nnp
        if nnn-1>0
aaa=index(abc(nnn-1,1));
        end
        if nnn-1>1
          aaa=index(abc(nnn-1,1)); 
          nnn=nnn-1;
        end
 if dddd>1      
shuju1=[guiji{abc(nnn-1,1)};DD3(:,aaa*2-1:aaa*2)];
 end
 if dddd==1 
shuju1=[DD2(:,abc(nnn-1,1)*2-1:abc(nnn-1,1)*2);DD3(:,aaa*2-1:aaa*2)];   
 end
new1(:,O2+nnc)=KK3(:,aaa);    
zhongjian{O2+nnc}=shuju1;
zhongjian{O2+nnc}(all(shuju1==0,2),:)=[];  

    end  
    
end

end
    for   t10=1:O3 
    guiji{t10}= zhongjian{t10};
    end
end
 %shuju2(all(shuju2==0,2),:)=[];

%Small
if O3<=O2
new2=O2;
dddd=dddd+1;
     for t1=1:O2
        for t2=1:O3
        jl(t1,t2)=sqrt((KK2(1,t1)-KK3(1,t2))^2+(KK2(2,t1)-KK3(2,t2))^2);
        end
     end
     [min_a,index]=min(jl,[],2);
     

for t3=1:O2
    aaa=index(t3);   
       if dddd==1
       shuju1=[DD2(:,t3*2-1:t3*2);DD3(:,aaa*2-1:aaa*2)];
       new1(:,t3)=KK3(:,aaa);
       LL6=LL6+1;
       end
       if dddd>1
       shuju1=[];
       shuju1=[guiji{t3};DD3(:,aaa*2-1:aaa*2)];
       new1(:,t3)=KK3(:,aaa);
       LL6=LL6+1;
       end
       guiji{t3}=shuju1;
       guiji{t3}(all(shuju1==0,2),:)=[];  
       
end
end  
end
mstruct=defaultm('mercator');
mstruct.geoid=[ 6378137,0.0818191908426215];
mstruct.origin=[0,0,0];
mstruct=defaultm(mstruct);
for xin=1:t3
AAbb=[];
Xzhong=guiji{xin}; 
NN2=size(Xzhong,1);
X=Xzhong(:,1);
y=Xzhong(:,2); 
N = size(X,1);
for i=1:NN2    
xx=X(i,1);
yy=y(i,1);
[lat,lon]=projinv(mstruct,xx,yy);
AAbb(i,1)=lat;
AAbb(i,2)=lon;
end
guiji2{xin}=AAbb;
end