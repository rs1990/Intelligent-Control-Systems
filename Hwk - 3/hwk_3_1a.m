clc;
clear all;
close all;

X=zeros(2,100);
Xn=zeros(2,100); 
A=[0    1
  -0.89 1.8];
B=[0 
   1]; 
u=ones(100,1);
t=1:100; 
for i=1:99 
X(:,i+1)=A*X(:,i)+B*u(i); 
y(i,:) = X(:,i+1)'
hold on
end 
figure(1)
plot(t,X(1,:));
hold on;
grid on;
plot(t,X(2,:),'r');
legend t X
grid on; 
title('System States Without Noise') 
max_overshoot = max(y(:,1))
SteadyState_value = max(y(i,:))
peak_overshoot = (max_overshoot(1) - SteadyState_value)/SteadyState_value *100