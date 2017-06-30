clear all
close all
clc

% input for training
%x=[5 -1 -5 10 3 10 5 4 5 6 7 8 9];
x=[5 -1 -5 10 3 10 5 4 5 6 7 8 9];
y=x.^2+0*x+sin(x);


x1=-15:1:15;
y1=x1.^2+0*x1+sin(x1);

%Define parameters and setup neural network
net = newff([-15 15],[5 5 1],{'logsig' 'logsig' 'purelin'});
newff([-15 15],[10 1], {'logsig' 'purelin' } )
newff([-15 15],[5 5 5 1], {'logsig' 'logsig' 'logsig' 'purelin' } )
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.0000000000001;
net = train(net,x1,y1);

%Test neural net with test value
Test=-30:1:50;
Output=sim(net,Test);

%Plot results or desired output and test output.
figure(1);
plot(x,y,'b*',x1,y1,'b',Test,Output,'r')
title('Testing MLP Network');
xlabel('Input Vector');
ylabel('Output');
legend({'Input point','Desired output y = x.^2+0*x+sin(x)','Test output'})


