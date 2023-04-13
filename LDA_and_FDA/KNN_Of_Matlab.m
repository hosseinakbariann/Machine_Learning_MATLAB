function   KNN( )
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
hosseinlabel = knnclassify( testwlabel, trainwlabel , trainlabel, k);

mAcc = mean(testlabel == hosseinlabel);
MissclassificationRate=mean(testlabel ~= hosseinlabel);
fprintf('Mean Accurancy of Result in 30 Iteration is=>> %f  \n',mAcc);
fprintf('Mean MissclassificationRate of my algorithm is=>> %f  \n',MissclassificationRate);
end








