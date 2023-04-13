function [ Ret ] = Genarate_Network
clear all
clc
network=0;
S=0;
wb=0;
traindata=load('.\zipTrain.txt');
proj = PCA();
for L=1:size(traindata,1)
    TRinput(L,:)=traindata(L,2:end);
end

TRinput=TRinput*proj;

for I=1:10
for J=1:729
    J=J*I;
    target(J,1)=traindata(J,1);
    input(J,:)=TRinput(J,:);
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