function [ Ret ] = Genarate_Network
network=0;
S=0;
wb=0;
traindata=load('.\zipTrain.txt');
for I=1:10
for L=1:size(traindata,1)
    target(L,1)=traindata(L,1);
    input(L,:)=traindata(L,2:end);
end
inputs = input';
targets = target';
hiddenLayerSize =50;
net=patternnet(hiddenLayerSize);
net.trainParam.goal = 0;
net.trainParam.epochs = 200;
[net,tr] = train(net,inputs,targets);
wb = getwb(net);
network=network+wb;
target=[];
input=[];
inputs=[];
targets=[];
end

network=network/10;
Ret = network;
end