% function   LDA( )
clear all;
test = load('.\voweltest.txt');
train = load('.\voweltrain.txt');

% delete first index

test(:,1)=[];
train(:,1)=[];


train=sortrows(train,1);
test=sortrows(test,1);
% sort data

unq =unique(train(:,1));

% calculate mu

for el=1:size(test,1)
    tstlabel(el,1)=test(el,1);
end


for f=1:size(unq,1)
    class_observation=find(train(:,1)==f);
    
    for k=1:size(class_observation,1)    
        s(k,:)=train(class_observation(k,1),:);
    end   
    
    mu(f,:)=sum(s)/size(s,1);
    s(:,:)=[];
    
end
mu(:,1)=[];

% calculate sigma covariance

covariancematrix=0;
for p=1:size(unq,1)
    classobserv=find(train(:,1)==p);
    pi_hat(p,1)=size(classobserv,1)/size(train,1);
    for j=1:size(classobserv,1)        
        cl(j,:)=train(classobserv(j,1),2:end);       
    end  
    for t=1:size(cl,2)
        cl(:,t)=  cl(:,t)-(mu(p,t));
    end
    cov=(cl')*cl;
    covariancematrix=cov+covariancematrix;
end
sigma=covariancematrix/((size(train,1)-size(unq,1)));

%calculate descriminant function

trmu=transpose(mu);
for tst=1:size(test,1)
    for u=1:size(unq,1)
         delta(u,1)= ((test(tst,2:end))*(inv(sigma))*(trmu(:,u))) - ((1/2)*(mu(u,:)*(inv(sigma))*(trmu(:,u))))+log( pi_hat(u,1)) ;
         [~,la]=max(delta);   
         label(tst,1)=la;
    end
end
mAcc =mean(label == tstlabel);
MissclassificationRate=mean(label ~= tstlabel);;
fprintf('Mean Accurancy of Result is=>> %f  \n',mAcc);
fprintf('Mean MissclassificationRate of my algorithm is=>> %f  \n',MissclassificationRate);
% end
