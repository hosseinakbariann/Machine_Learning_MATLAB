function   MyNaiveBayes( )

data=load('.\student-por.txt');


for iter =1:30
    train=data;
    train=sortrows(train , 33);
    prcl(1,:)=1:5;
    for L=1:size(train,1)
        if train(L,33)<4 && train(L,33)>=0
            train(L,33)=1;
        end
        if train(L,33)<8 && train(L,33)>=4
            train(L,33)=2;
        end
        if train(L,33)<12 && train(L,33)>=8
            train(L,33)=3;
        end
        if train(L,33)<16 && train(L,33)>=12
            train(L,33)=4;
        end
        if train(L,33)<=20 && train(L,33)>=16
            train(L,33)=5;
        end
    end
    
%     seperate test and train data randomly
    
    g=randperm(649,130);
    for L=1:size(g,2)
        test(L,:) = train(g(1,L),:);
        train(g(1,L),:)=0;
    end
    train(all(train==0,2),:)=[];
    
    % splitt test label and train label from feature
    
    test=sortrows(test , 33);
    for L=1:size(test,1)
        
        testlabel(L,1)=test(L,33);
        testwlabel(L,:)=test(L,1:32);
    end
    for L=1:size(train,1)
        trainlabel(L,1)=train(L,33);
        trainwlabel(L,:)=train(L,1:32);
    end
    
    
    % seperate row of each class
    
    for A=1:size(find(train(:,33)==1),1)
        Acl(A,:)=train(A,:);
        prcl(2,1)=size(Acl,1)/size(train,1);
    end
    
    for B=1:size(find(train(:,33)==2),1)
        Bcl(B,:)=train((B+A),:);
        prcl(2,2)=size(Bcl,1)/size(train,1);
    end
    for C=1:size(find(train(:,33)==3),1)
        Ccl(C,:)=train((A+B+C),:);
        prcl(2,3)=size(Ccl,1)/size(train,1);
    end
    for D=1:size(find(train(:,33)==4),1)
        Dcl(D,:)=train((A+B+C+D),:);
        prcl(2,4)=size(Dcl,1)/size(train,1);
    end
    for E=1:size(find(train(:,33)==5),1)
        Ecl(E,:)=train((A+B+C+D+E),:);
        prcl(2,5)=size(Ecl,1)/size(train,1);
    end
    
    % calculate mu matrix
    
    
    for tstrow=1:size(test,1)
        for tstcolumn=1:size(testwlabel,2)
            F(tstrow,tstcolumn)=(size(find(Acl(:,tstcolumn)==test(tstrow,tstcolumn)),1))/size(train,1);
            G(tstrow,tstcolumn)=(size(find(Bcl(:,tstcolumn)==test(tstrow,tstcolumn)),1))/size(train,1);
            H(tstrow,tstcolumn)=(size(find(Ccl(:,tstcolumn)==test(tstrow,tstcolumn)),1))/size(train,1);
            I(tstrow,tstcolumn)=(size(find(Dcl(:,tstcolumn)==test(tstrow,tstcolumn)),1))/size(train,1);
            J(tstrow,tstcolumn)=(size(find(Ecl(:,tstcolumn)==test(tstrow,tstcolumn)),1))/size(train,1);
        end
    end
    F(F==0) = 0.01;
    G(G==0) = 0.01;
    H(H==0) = 0.01;
    I(I==0) = 0.01;
    J(J==0) = 0.01;
    
    % calculate  matrix multiplication
    
    for tstrow=1:size(test,1)
        tmp1=1;
        tmp2=1;
        tmp3=1;
        tmp4=1;
        tmp5=1;
        for tstcolumn=1:size(testwlabel,2)
            tmp1 = F(tstrow,tstcolumn)*tmp1;
            tmp2=  G(tstrow,tstcolumn)*tmp2;
            tmp3=  H(tstrow,tstcolumn)*tmp3;
            tmp4=  I(tstrow,tstcolumn)*tmp4;
            tmp5=  J(tstrow,tstcolumn)*tmp5;
            
        end
        mytmp1(tstrow,1)=tmp1;
        M=tmp1;
        mytmp2(tstrow,1)=tmp2;
        M=tmp2;
        mytmp3(tstrow,1)=tmp3;
        M=tmp3;
        mytmp4(tstrow,1)=tmp4;
        M=tmp4;
        mytmp5(tstrow,1)=tmp5;
        M=tmp5;
    end
    
    
    % calculate probabiliy of each class for each row of test
    
    for tstrow=1:size(test,1)
        tp(1,1) = mytmp1(tstrow,1)*prcl(2,1);
        tp(1,2) = mytmp2(tstrow,1)*prcl(2,2);
        tp(1,3) = mytmp3(tstrow,1)*prcl(2,3);
        tp(1,4) = mytmp4(tstrow,1)*prcl(2,4);
        tp(1,5) = mytmp5(tstrow,1)*prcl(2,5);
        
        [val idx] = max(tp);
        if idx == 1
            NewLabel(tstrow,1)=1;
        end
        if idx == 2
            NewLabel(tstrow,1)=2;
        end
        if idx == 3
            NewLabel(tstrow,1)=3;
        end
        if idx == 4
            NewLabel(tstrow,1)=4;
        end
        if idx == 5
            NewLabel(tstrow,1)=5;
        end
    end
    mAcc = sum(testlabel == NewLabel)/size(test,1);
    iterationAcc(iter,1)=mAcc;
    clearvars Acl Bcl Ccl Dcl Ecl Kcl
end


VarAcc=var(iterationAcc);
meanAcc= sum(iterationAcc)/iter;

fprintf('My Accuracy is %f \n',meanAcc);
fprintf('My Variance is %f \n',VarAcc);

end

