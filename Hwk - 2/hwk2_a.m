clear all;close all;clc


FileName = ('homework 2 data 1.xls')
samples = xlsread(FileName);


x(:,4)=ones(4,1);
P=800*eye(4);
out=zeros(4,601);
sigv=1;


for i=4:601
    out(:,i)=diag(P);
    y(i)=samples((i),4)';
    T1=[-samples((i-1),4) -samples((i-2),4)];
    T2=[samples((i-2),3) samples((i-3),3)];
    H(:,i)=[T1';T2'];
    A = pinv(H(:,i)'*P*H(:,i)+sigv)
    B = H(:,i)'*P;
    P=P-P*H(:,i)*A*B;
    x(:,i+1)=x(:,i)+P*H(:,i)*(y(i)-H(:,i)'*x(:,i))/sigv
   
end
t=1:602;
plot(t,x(1,:),'r',t,x(2,:),'g',t,x(3,:),'b',t,x(4,:),'y');
grid on;
title('Convergence of coefficients')
figure(4)
plot(t(1:601),out(1,:),'r',t(1:601),out(2,:),'g',t(1:601),out(3,:),'b',t(1:601),out(4,:),'y');
grid on;
title('Convergence of error covariance');
clear y;
% The model is
coef=x(:,end)
y=zeros(601,1);
for i=40:250
    if i < 4
        y(i)=[-y(i) -y(i-1) samples((i-1),1) 0]*coef;
    else
        y(i)=[-y(i) -y(i-2) samples((i-2),1) samples((i-3),1)]*coef;
    end
end
figure(5)
plot (t(1:601),y,'r');
hold on;
plot(t(1:601),samples(:,2),'--');
hold on;
title('Simulated output and Actual output');

