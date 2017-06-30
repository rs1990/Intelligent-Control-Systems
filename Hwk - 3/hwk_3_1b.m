clc;
clear all;
close all;

x=zeros(2,100);
xn=zeros(2,100); 
A=[0    1
  -0.89 1.8];
B=[0 
   1]; 
u=ones(100,1);
t=1:100; 
w = 0.2*rand(2,100);
for i=1:99 
x(:,i+1)=A*x(:,i)+B*u(i)+w(i);
y(i,:) = x(:,i+1)'
hold on
end 
figure (1)
plot(t,x(1,:),t,x(2,:));
hold on;
plot(t,x(2,:),'r');
grid; 
title('System States With Noise') 
max_overshoot = max(y())
min_overshoot = max(y(i,:))
peak_overshoot = (max_overshoot(1) - min_overshoot)/min_overshoot *100
