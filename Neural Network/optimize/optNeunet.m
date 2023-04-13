clear all
clc
traindata=load('.\zipTrain.txt');
testdata=load('.\zip.txt');
for L=1:size(traindata,1)
    target(L,1)=traindata(L,1);
    input(L,:)=traindata(L,2:end);
end
for F=1:size(testdata,1)
    testtarget(F,1)=testdata(F,1);
    testinput(F,:)=testdata(F,2:end);
end
testlabel=testtarget';
testfeature=testinput';
inputs = input';
targets = target';
hiddenLayerSize =50;

net = patternnet(hiddenLayerSize);
net = configure(net,inputs);
MY_net = optGenarate_Network();
net = setwb(net,MY_net);


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(testfeature);
errors = gsubtract(testlabel,outputs);
performance = perform(net,testlabel,outputs);
outputs = floor(outputs);
mAcc = sum(testlabel == outputs)/size(testdata,1);

fprintf('Accurancy of Result is=>> %f  \n',mAcc);
