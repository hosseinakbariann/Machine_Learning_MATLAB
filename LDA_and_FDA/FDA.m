function   FDA( )
clear all;
pr=fisherfunc();
test = load('.\voweltest.txt');
train = load('.\voweltrain.txt');


% delete first index
test(:,1)=[];
train(:,1)=[];



% split test and train label

train=sortrows(train,1);
test=sortrows(test,1);
unq =unique(train(:,1));


testlabel=test(:,1);
ntest=test(:,2:end);

trainlabel=train(:,1);
ntrain=train(:,2:end);


% project matrix

train=[];
test=[];
train=ntrain*pr;
test=ntest*pr;


test(:,3)=testlabel;
train(:,3)=trainlabel;


% calculate mu of each class

for f=1:size(unq,1)
    srta=find(train(:,3)==f);
    
    for k=1:size(srta,1)
        
        s(k,:)=train(srta(k,1),:);
    end
    
    mysum(f,:)=sum(s)/size(s,1);
    s(:,:)=[];
    
end

mysum(:,3)=[];


% calculate cov matrix

cnt=0;
for p=1:size(unq,1)
    srtkh=find(train(:,3)==p);
    pi_hat(p,1)=size(srtkh,1)/size(train,1);
    for j=1:size(srtkh,1)
        
        R(j,:)=train(srtkh(j,1),2:end);
        
    end
    
    for t=1:size(R,2)
        R(:,t)=  R(:,t)-(mysum(p,t));
    end
    B=transpose(R);
    cov=B*R;
    cnt=cov+cnt;
end
sigma=cnt/(size(train,1)-size(unq,1));

% %calculate descriminant function

mysum1=transpose(mysum);
for tst=1:size(test,1)
    for u=1:size(unq,1)
         delta(u,1)= ((test(tst,2:end))*(inv(sigma))*(mysum1(:,u))) - ((1/2)*(mysum(u,:)*(inv(sigma))*(mysum1(:,u))))+log( pi_hat(u,1)) ;
         [~,la]=max(delta);   
         label(tst,1)=la;
    end
end
mAcc =mean(label == testlabel);
MissclassificationRate=mean(label ~= testlabel);;
fprintf('Mean Accurancy of Result is=>> %f  \n',mAcc);
fprintf('Mean MissclassificationRate of my algorithm is=>> %f  \n',MissclassificationRate);
end
