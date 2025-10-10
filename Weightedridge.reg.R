

#buna input icin ornek w vektor u mu uretsek ?


#weighted ridge regression file
Weightedridge.reg <- function(x,y,W) {
  alpha=0.05
  a=0
  b=1
  if(is.data.frame(W)) W=as.vector(t(W))
  if(is.vector(W)) W=diag(W,nrow=length(W))
  
  m=sum(diag(W))
  
  if (is.vector(x)){
    n=length(x)
    p=1
    x<-matrix(x)
    
  } else {
    n=dim(x)[1]
    p=dim(x)[2]
    
    if(p==1) {
      
      x<-matrix(x)
      
    } else {
      
      colind=2
      xx=cbind(x[,1],x[,2])
      while(colind<p) {
        colind=colind+1
        xx=cbind(xx,x[,colind])
      }
      x=xx }
  }
  
  if (is.vector(y)){
    
    y<-matrix(y)
    
    
  } else {
    cy=dim(y)[2]
    if(cy==1) {
      
      y<-matrix(y)
      
    } else {
      
      colind=2
      yy=cbind(y[,1],y[,2])
      while(colind<cy) {
        colind=colind+1
        yy=cbind(yy,y[,colind])
      }
      y=yy }
  }
  
  ridgeregc= ridgereg_k(x,y,a,b)
  cc=ridgeregc$ridge_reg_results$k
  
  xw <- W^0.5%*%x
  yw <- W^0.5%*%y
  yr <- scale(y)/sqrt(n-1)
  xr <- scale(x)/sqrt(n-1)
  yrw=W^0.5%*%yr
  xrw=W^0.5%*%xr
  X <- xr
  XpX <- t(X)%*%W%*%xr
  XpXplusc <- XpX+cc*diag(p)
  
  Xpy <- t(X)%*%W%*%yr
  invXpXplusc <- solve(XpXplusc)
  beta <- invXpXplusc%*%Xpy
  
  tsdx <- apply(xw,2,sd)
  betaor <- sd(yw)*beta/as.matrix(tsdx)
  beta0 <- c(mean(yw),apply(xw,2,mean))%*%rbind(1,-betaor)
  betaor <- rbind(beta0,betaor)
  yhator <- cbind(matrix(1,n),x)%*%betaor
  
  yhat <- xr%*%beta
  yhatw <- xrw%*%beta
  
  e <- yr-yhat
  ew <- W^(1/2)%*%e
  SSE <- t(ew)%*%ew
  SSE <- as.numeric(SSE)
  MSE <- SSE/(n-(p+1))
  
  s <- 0
  for (i in 1:n) {
    s <- s+W[i,i]*yr[i]
  }
  
  ymeanw <- s/m
  
  SST <- t(yrw)%*%yrw-m*ymeanw^2
  SST <- as.numeric(SST)
  MST <- SST/(n-1)
  
  SSR <- SST-SSE
  SSR <- as.numeric(SSR)
  
  R2 <- SSR/SST
  MSR <- SSR/p
  F <- MSR/MSE
  R2adj <- 1-MSE/MST
  
  sig <- 1-pf(F,p,n-(p+1))
  
  varbeta <- invXpXplusc*MSE
  stdbeta <- sqrt(diag(varbeta))
  #print(cc)
  confint <- rbind(t(beta)-qt(1-alpha/2,n-(p+1))*stdbeta,t(beta)+qt(1-alpha/2,n-(p+1))*stdbeta)
  anovatable <- data.frame("s.v."=c("Regression","Error","Total"),
                           "S.S."=c(SSR,SSE,SST),
                           "d.f."=c(p,n-(p+1),n-1),
                           "M.S."=c(MSR,MSE,MST),
                           "F"=c(F,NA,NA),
                           "sig."=c(sig,NA,NA))
  
  
  z <- list(cc=cc,beta=beta,betaor=betaor,e=e,ew=ew,yhat=yhat,yhatw=yhatw,yhator=yhator,MSE=MSE,F=F,sig=sig,varbeta=varbeta,stdbeta=stdbeta,
            R2=R2,R2adj=R2adj,anovatable=anovatable,confint=confint)
  
  return(z)
}

