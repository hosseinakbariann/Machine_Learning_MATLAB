% function [ Ret ] = PCA
clear all
clc
traindata=load('zipTrain.txt');

% calculate mu

unq =unique(traindata(:,1));
for f=0:9
    class_observation=find(traindata(:,1)==f);
    
    for k=1:size(class_observation,1)
        s(k,:)=traindata(class_observation(k,1),:);
    end
    
    mu(f+1,:)=sum(s)/size(s,1);
    s(:,:)=[];
    
end
mu(:,1)=[];

%split trainlabel and data

for L=1:size(traindata,1)
    trainlabel(L,1)=traindata(L,1);
    train(L,:)=traindata(L,2:end);
end


% calculate sigma covariance

covariancematrix=0;
for p=0:9
    classobserv=find(traindata(:,1)==p);
    pi_hat(p+1,1)=size(classobserv,1)/size(train,1);
    for j=1:size(classobserv,1)
        cl(j,:)=train(classobserv(j,1),:);
    end
    for t=1:size(cl,2)
        cl(:,t)=  cl(:,t)-(mu(p+1,t));
    end
    cov=(cl')*cl;
    covariancematrix=cov+covariancematrix;
end
sigma=covariancematrix/((size(traindata,1)-size(unq,1)));


% calcaulate eig


[egvector egvalue]=eig(sigma);

% 
% calcaulate variance

egproj=0;
sumegval=0;

for K=0:255
    sumegval= egvalue(256-K,256-K)+ sumegval;
end

for K=0:49
    egproj= egvalue(256-K,256-K)+ egproj;
 
    
end
datavar=egproj/sumegval;

for G=0:50
projection(:,G+1)= egvector (:,256-G);
end

% Ret = projection;

% end