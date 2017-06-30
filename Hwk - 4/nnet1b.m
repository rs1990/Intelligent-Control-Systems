close all, 
clear all, 
clc, 
format compact
% number of samples of each class
% define inputs and outputs

x = [5 4 6 5 2 1 2 1 
    0 -1 0 -1 -1 -2 -2 -3]; % inputs
y = [0 0 0 0 1 1 1 1 ];
% outputs
% Plot input samples with PLOTPV (Plot perceptron input/target vectors)
figure(1)
plotpv(x,y);
net = perceptron;
net.layers{1}.transferFcn = 'tansig';
net = train(net,x,y);
view(net);
figure(1)
plotpc(net.IW{1},net.b{1});
y = net(x)
