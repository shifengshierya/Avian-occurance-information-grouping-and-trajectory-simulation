library(mgcv)      #Load the MGCV package because the gam function is in the package
Data <- read.csv("guiji1.csv", header = TRUE)
#View DataX<-Data[,3]
Y<-Data[,1]
result1 <- gam(Y ~ s(X))     
y_pred<-predict(result1)
pred<-data.frame( X=X,Y=y_pred)
write.csv(pred, "pred1.csv")

#Plot
plot(result1,se=T,resid=T,pch=16)
par(new=TRUE)
