close all, clear all, clc, format compact
% number of samples of each class
K = 30;
% define classes
q=0.5;

% text labels for classes
text(.5-q,.5+2*q,'Class A')
text(.5+q,.5+2*q,'Class B')
text(.5+q,.5-2*q,'Class C')
text(.5-q,.5-2*q,'Class D')
hold on
grid on

%define input coding for classes
load breastcancer.mat 

%define output coding for classes
a = [0 1]';
b = [1 1]';
c = [1 0]';
d = [0 0]';

%define inputs (combine samples from all four classes)
P = [A B C D];
%define targets
T= [repmat(a,1,length(A)) repmat(b,1,length(B)) ...
    repmat(c,1,length(C)) repmat(d,1,length(D)) ];
plotpv(P,T);

net = perceptron;
E = 1;
net.adaptParam.passes = 1;
linehandle = plotpc(net.IW{1},net.b{1});
n = 0;
while (sse(E) & n<1000)
n = n+1;
[net,Y,E] = adapt(net,P,T);
linehandle = plotpc(net.IW{1},net.b{1},linehandle);
drawnow;
end
% show perceptron structure
view(net);
