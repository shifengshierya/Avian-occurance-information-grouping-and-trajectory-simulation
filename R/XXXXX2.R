library(mgcv)      #����mgcv����������Ϊgam�������������
Data <- read.csv("guiji1.csv", header = TRUE)
#�鿴Data���ݣ�Data���鿴��2�У�Data[,2]����2�У�Data[2,]<br>
X<-Data[,3]
Y<-Data[,2]
result1 <- gam(Y ~ s(X))     #��ʱ��AdultΪ��Ӧ������DayΪ���ͱ���

y_pred<-predict(result1)
pred<-data.frame( X=X,Y=y_pred)
write.csv(pred, "pred11.csv")

#��ͼ
plot(result1,se=T,resid=T,pch=16)