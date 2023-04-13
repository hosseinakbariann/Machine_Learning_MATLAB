function   KNN_after_projection( )
pr=fisherfunc();
train=load('.\voweltrain.txt');
test=load('.\voweltest.txt');
test(:,1)=[];
train(:,1)=[];
k=input('Please Input K =>\n');
for i=1:size(train,1)
    trainlabel(i,:)=train(i,1);
    trainwlabel(i,:)=train(i,2:end);
end
for j=1:size(test,1)
    testlabel(j,:)=test(j,1);
    testwlabel(j,:)=test(j,2:end);
    
end
test(:,1)=[];
train(:,1)=[];


train=[];
test=[];
train=trainwlabel*pr;
test=testwlabel*pr;


hosseinlabel = knnclassify( test, train , trainlabel, k);
mAcc = mean(testlabel == hosseinlabel);
MissclassificationRate=mean(testlabel ~= hosseinlabel);
fprintf('Mean Accurancy of my algorithm is=>> %f  \n',mAcc);
fprintf('Mean MissclassificationRate of my algorithm is=>> %f  \n',MissclassificationRate);
end
