clear all
close all
clc

FileName = ('homework 2 data 1.xls');
data = xlsread(FileName); %Reading the file name
 
x(:,4)=ones(4,1);
p=1000*eye(4); %1000*(4*4) identity matrix
out=zeros(4,601); %Matrix of zeros
sv=1;

for i=4:601
    out(:,i)=diag(p);
    y(i)=data((i),4)';
    temp1=[-data((i-1),4) -data((i-2),4)]; %Storing temporary data
    temp2=[data((i-2),3) data((i-3),3)];
    h(:,i)=[temp1' ;temp2'];
    A = pinv(h(:,i)'*p*h(:,i)+sv)
    B = h(:,i)'*p;
    p=p-p*h(:,i)*A*B; 
    x(:,i+1)=x(:,i)+p*h(:,i)*(y(i)-h(:,i)'*x(:,i))/sv
    
end
t=1:602;
plot(t,x(1,:),'r',t,x(2,:),'g',t,x(3,:),'b',t,x(4,:),'y');
grid on;
figure:plot(t(1:601),out(1,:),'r',t(1:601),out(2,:),'g',t(1:601),out(3,:),'b',t(1:601),out(4,:),'y');
grid on;
clear y;
co=x(:,end); %coefficients
y=zeros(601,1);
for i=30:400
    if i<4
        y(i)=[-y(i) -y(i-1) data((i-1),1) 0]*co;
    else
        y(i)=[-y(i) -y(i-2) data((i-2),1) data((i-3),1)]*co;
    end
end
figure(5)
plot(t(1:601),y,'r');
hold on;
plot(t(1:601),data(:,2),'--');

