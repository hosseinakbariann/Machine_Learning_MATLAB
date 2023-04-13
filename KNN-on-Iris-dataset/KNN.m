data=load('.\iris.txt');
fprintf('Please Adjust Data Path for Your System \n');
knn=input('Please Input K =>\n');
mys=0;
start=tic;
myva=zeros(1,30);
for iter=1:30
    train=data;
    g=randperm(150,30);
    for i=1:30
        test(i,:) = train(g(1,i),:);
        train(g(1,i),:)=0;
    end
    train(all(train==0,2),:)=[];
    for a=1:30
        
        testlabel(a,1)=test(a,5);
        testwlabel(a,:)=test(a,1:4);
    end
    for b=1:120
        trainlabel(b,1)=train(b,5);
        trainwlabel(b,:)=train(b,1:4);
    end
    for x = 1 : size(test,1)
        for y = 1 : size(train,1)
            dist(y,2)= sqrt(sum((testwlabel(x,:) - trainwlabel(y,:)).^2 ));
            dist(y,1) = trainlabel(y);
        end
         dist = sortrows(dist , 2);
         mylabel = dist(1:knn,:);
         Count_of_1 = sum(mylabel(:,1)==1);
         Count_of_2 = sum(mylabel(:,1)==2);
         Count_of_3 = sum(mylabel(:,1)==3);
         if Count_of_2 > Count_of_3 & Count_of_2 > Count_of_3
             hosseinlabel(x,1) = 2;
         elseif Count_of_1 > Count_of_2 & Count_of_1 > Count_of_3
             hosseinlabel(x,1) = 1;
         else
             hosseinlabel(x,1) = 3;
         end
    end
  
    mAcc = sum(testlabel == hosseinlabel);
    Acc = mAcc/size(testwlabel,1);
    myva(1,iter)=Acc;
end
    Variance=var(myva);
    MyAccuracy=mean(myva);
    Mytime=toc(start);
    fprintf('Mean Accurancy of Result in 30 Iteration is=>> %f  \n',MyAccuracy);
    fprintf('Variance of Result is=>> %f \n', Variance);
    fprintf('Time of alghorithm is=>> %f \n', Mytime);
    










