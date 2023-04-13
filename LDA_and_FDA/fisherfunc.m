function [ Ret ] = fisherfunc
clear all;
nTest = load('C:\Users\hossein\Desktop\HW3\voweltest.txt');
nTrain = load('C:\Users\hossein\Desktop\HW3\voweltrain.txt');

% delete first index
for a=1:size(nTrain,1)
    train=nTrain(:,2:end);
end

for a=1:size(nTest,1)
    test=nTest(:,2:end);
end

% sort rows

train=sortrows(train,1);
test=sortrows(test,1);
unq =unique(train(:,1));

%  split test labels

for el=1:size(test,1)
    tstlabel(el,1)=test(el,1);
end
for el=1:size(train,1)
    trainlabel(el,1)=train(el,1);
end


%  calculate mu for each class and total mu

for f=1:size(unq,1)
    class_observation=find(train(:,1)==f);
    
    for k=1:size(class_observation,1)
        
        s(k,:)=train(class_observation(k,1),:);
    end
    
    mu(f,:)=sum(s)/size(s,1);
    s(:,:)=[];
    
end
mu(:,1)=[];
totalmu=mean(mu);


% center data

train(:,1)=[];
for kl=1:size(unq,1)
    classobser=find(trainlabel(:,1)==kl);

    for sl=1:size(classobser,1)

        for sc=1:10
          train(classobser(sl,1),sc)=train(classobser(sl,1),sc) - (mu(kl,sc));
        end
    end
end


% %  calculate SB

for i=1:size(mu,2)
    mu(:,i)=(mu(:,i))-totalmu(1,i);
end
trmu=(transpose(mu));
SB=0;
for z=1:size(unq,1)
    class_observation=find(trainlabel(:,1)==z);
    sbsum=(trmu(:,1))*(mu(1,:))*( size(class_observation,1));
    SB =((SB+sbsum));
end

 %  calculate SW

SW=0;
for p=1:size(unq,1)
    classindex=find(trainlabel(:,1)==p);
    for j=1:size(classindex,1)
        
        tempvar(j,:)=train(classindex(j,1),:);
        
    end
    
    for t=1:size(tempvar,2)
        tempvar(:,t)=  tempvar(:,t)-(mu(p,t));
    end
    B=transpose(tempvar);
    cov=B*tempvar;
    SW=cov+SW;
end


%  calculate JW


JW=(inv(SW))*(SB);
[evec,eval]=eig(JW);

project(:,1) = evec (:,3);
project(:,2) = evec (:,4);

    Ret=project;
end

