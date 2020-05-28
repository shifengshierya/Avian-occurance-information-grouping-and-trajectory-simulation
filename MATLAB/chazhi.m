clear;
clc;
x=xlsread('Calidris_subruficollis.xlsx','Calidris_subruficollis','Z2:Z1234');      
y=xlsread('Calidris_subruficollis.xlsx','Calidris_subruficollis','AA2:AA1234'); 
z=xlsread('Calidris_subruficollis.xlsx','Calidris_subruficollis','AB2:AB1234'); 
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
 
    
    