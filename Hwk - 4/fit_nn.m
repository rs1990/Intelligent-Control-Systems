x=randn(1,15)
t=x.^2+0*x+sin(x);
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.0000000000001;
net = fitnet(15)
net = train(net,x,t);
view(net)
t = net(x);
perf = perform(net,x,t)


x1=randn(1,20)
perf = perform(net,x1,t)
view(net)
