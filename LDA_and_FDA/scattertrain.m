function   ScatterTest( )
clear all;
pr=fisherfunc();
test = load('.\voweltest.txt');
nTrain = load('.\voweltrain.txt');


% delete first index
test(:,1)=[];
nTrain(:,1)=[];



% split test and train label

nTrain=sortrows(nTrain,1);
test=sortrows(test,1);
unq =unique(nTrain(:,1));


testlabel=test(:,1);
ntest=test(:,2:end);

trainlabel=nTrain(:,1);
ntrain=nTrain(:,2:end);


% project matrix

nTrain=[];
test=[];
ntrain=ntrain*pr;
test=ntest*pr;


test(:,3)=testlabel;
ntrain(:,3)=trainlabel;


for a=1:size(find(ntrain(:,3)==1))
    srta=find(ntrain(:,3)==1);
    A(a,:)=ntrain(srta(a,1),:);
end

for b=1:size(find(ntrain(:,3)==2))
    srta=find(ntrain(:,3)==2);
    B(b,:)=ntrain(srta(b,1),:);
end

for c=1:size(find(ntrain(:,3)==3))
    srta=find(ntrain(:,3)==3);
    C(c,:)=ntrain(srta(c,1),:);
end

for d=1:size(find(ntrain(:,3)==4))
    srta=find(ntrain(:,3)==4);
    D(d,:)=ntrain(srta(d,1),:);
end

for e=1:size(find(ntrain(:,3)==5))
    srta=find(ntrain(:,3)==5);
    E(e,:)=ntrain(srta(e,1),:);
end
for f=1:size(find(ntrain(:,3)==6))
    srta=find(ntrain(:,3)==6);
    F(f,:)=ntrain(srta(f,1),:);
end

for g=1:size(find(ntrain(:,3)==7))
    srta=find(ntrain(:,3)==7);
    G(g,:)=ntrain(srta(g,1),:);
end

for h=1:size(find(ntrain(:,3)==8))
    srta=find(ntrain(:,3)==9);
    H(h,:)=ntrain(srta(h,1),:);
end

for i=1:size(find(ntrain(:,3)==10))
    srta=find(ntrain(:,3)==10);
    I(i,:)=ntrain(srta(i,1),:);
end

for j=1:size(find(ntrain(:,3)==11))
    srta=find(ntrain(:,3)==11);
    J(j,:)=ntrain(srta(j,1),:);
end

for k=1:size(find(ntrain(:,3)==9))
    srta=find(ntrain(:,3)==9);
   K(k,:)=ntrain(srta(k,1),:);
end

scatter(A(:,1),A(:,2),6,'r');hold on;
scatter(G(:,1),G(:,2),6,'b');,hold on;
scatter(B(:,1),B(:,2),6,'g');hold on;
scatter(D(:,1),D(:,2),6,'y');,hold on;
scatter(E(:,1),E(:,2),6,'d');hold on;
scatter(F(:,1),F(:,2),6,'filled');,hold on;
scatter(G(:,1),G(:,2),6,'k');hold on;
scatter(H(:,1),H(:,2),6,'c');,hold on;
scatter(I(:,1),I(:,2),6,'m');hold on;
scatter(J(:,1),J(:,2),6,'y');,hold on;
scatter( K(:,1),K(:,2),6,'o');
end