
rm(list = ls())
setwd("C:/Users/Hoyoung Park/Desktop/DANS_proj")

train.A<-read.csv("SpikeNumberTrainA.new.csv",header = F)
test.A<-read.csv("SpikeNumberTestA.new.csv",header = F)
train.B<-read.csv("SpikeNumberTrainB.new.csv",header = F)
test.B<-read.csv("SpikeNumberTestB.new.csv",header = F)

dim(train.A)

dim(test.A)

dim(train.B)

dim(test.B)
train.A[1000:1100,]
test.A[1,]
summary(train.A[,2])


poisson.den.multiple<-function(train.N,test.N){
  mult<-1
  leng2<-length(train.N)
  for(j in 1 :leng2){
    if(test.N[j]>170){
      mult<-mult* train.N[j]^test.N[j]*exp(-train.N[j])/(sqrt(2*pi*test.N[j])*(test.N[j]/2.718)^(test.N[j]))
    }else mult<-mult* train.N[j]^test.N[j]*exp(-train.N[j])/factorial(test.N[j])
  }
  return(mult)
}





max.post.den<-function( train,test){
  M<-dim(train)[1]# number of locations 
  Q<-dim(train)[2] # number of cells 
  
  result.mat<-matrix(NA,nrow=M,ncol=M)
  for( i in 1 : M){
    test.N<-as.numeric(test[i,])
    
    for(j in 1 : M ){
      train.N<-as.numeric(train[j,])
      result.mat[i,j]<-poisson.den.multiple(train.N,test.N)
    }
    if(i%%100==0) print(i)
  }
  
  
  #result.mat[1,1]
  
  return(list(result.mat=result.mat))
}

result.A<-max.post.den(train.A,test.A)$result.mat
result.B<-max.post.den(train.B,test.B)$result.mat

1329%/%38

as.vector(result.A)
result.A[1:10]

head(result.A)








### mat.A prediction
ans<-c()
for( k in 1 : dim(result.A)[1]){
  
  ans<-c(ans,which.max(result.A[k,]))
}
ans.A<-ans
ans.A


### mat.B prediction
ans<-c()
for( k in 1 : dim(result.B)[1]){
  
  ans<-c(ans,which.max(result.B[k,]))
}
ans.B<-ans
ans.B
head(ans.A)
head(ans.B)




vec<-1:1330
xycoord<-function(vec){
  val<-c()
  for( i in 1 : length(vec)){
    if(vec[i]==1330){val<-rbind(val,c(35,38))
    }else{
      q<-vec[i]%/%38
      if(vec[i]%%38==0){r<-38
      }else{
        r<-vec[i]%%38
      }
      val<-rbind(val,c((q+1),r))
    }
  }
  return(val)
}
res<-xycoord(vec)

res.A<-xycoord(ans.A)
res.B<-xycoord(ans.B)

res.T<-xycoord(1:1330)

error.A<-sum(  sqrt((res.A[,1]-res.T[,1])^2+(res.A[,2]-res.T[,2])^2) )

error.B<-sum( sqrt((res.B[,1]-res.T[,1])^2+(res.B[,2]-res.T[,2])^2) )

error.A/error.B






