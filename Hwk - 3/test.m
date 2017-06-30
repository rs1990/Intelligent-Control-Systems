% Q # 2
close all
clear all
clc

A=[0 1;-0.89 1.8];B=[0 ;1];
u=ones(100,1);
H=[1 0];
x(:,1)=[0;0];
xhatM(:,1)=[4;8]; %initial wrong estimate of states
P=500*eye(2); %initial guess of error covariance
PkMinus(:,1)=diag(P);
G=eye(2);Q=.1*eye(2);R=.1;
for i=1:100
x(:,i+1)=A*x(:,i)+B*u(i)+0.1*randn(2,1); % system at time i+1
temp(:,i+1)=x(:,i+1);
z(i+1)=H*x(:,i+1)+R*randn; % measurement at i+1
xhatT(:,i+1)=A*xhatM(:,i)+B*u(i); % Time Update state at i+1
P=A*P*A'+Q*G*G'; %Time Update Error Covariance
PkMinus(:,i+1)=diag(P); %Record Covariance updated
P=P-P*H'*inv(H*P*H'+R)*H*P; %Cov Measurement Update
PkPlus(:,i+1)=diag(P); %track time updated dovariance
KG=P*H'*inv(R); %Kalman Gain
KgRec(:,i)=KG; %Record kalman gain
xhatM(:,i+1)=xhatT(:,i+1)+KG*(z(i+1)-H*xhatT(:,i+1)); %Measurement Update
% x(:,i+1)=xhatM(:,i+1); %Feedback of updated state
end
t=1:101;
figure
subplot(2,1,1) ,plot(t,xhatM(1,:),'r',t,temp(1,:),'b');grid;legend('Estimated State 1','Actual State 1')
subplot(2,1,2) ,plot(t,xhatM(2,:),'r',t,temp(2,:),'b');grid;legend('Estimated State 2','Actual State 2')
% Q#3
figure:plot(t(1:100),KgRec(1,:),'r',t(1:100),KgRec(2,:),'g');grid;title('Trace Of Kalman Gain With Iteration')
legend('Kalman Gain for State 1','Kalman Gain for State 2');KG
[M,P,Z,E] = dlqe(A,G,H,Q,R);'The value of gain by Steady State Solution is'
M
%Simulation of system with steady state kalman gain
for i=1:100
xhatT(:,i+1)=A*xhatM(:,i)+B*u(i); %Time Update state at i+1
xhatM(:,i+1)=xhatT(:,i+1)+M*(z(i+1)-H*xhatT(:,i+1)); %Measurement Update
end

figure(11)

plot(t,xhatM(1,:),'r',t,x(1,:),'b');grid on ;
legend('State 1 - Estimated','State 1 - Actual')
title('Fixed Kalman Gain : State 1');

figure (12)
plot(t,xhatM(2,:),'r',t,x(2,:),'b');grid on ;legend('State 2 - Estimated','State 2 - Actual')
title('Fixed Kalman Gain : State 2')
% Confirmation of Part (a) Q # 3 , Reiterating the P equation
clear P
P=1000*eye(2);
for i=1:40 %some arbitrary number of Iterations to get the solution converged
P=A*P*A'+Q*G*G';
P=P-P*H'*inv(H*P*H'+R)*H*P;
end
KG_Iteration=P*H'*inv(R);