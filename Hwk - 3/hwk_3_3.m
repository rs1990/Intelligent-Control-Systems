clc;
clear all;
close all;

A=[0     1                                                                      % State space description of system 
   -0.89 1.8];
B=[0 
   1]; 
u=ones(100,1); 
H=[2 0]; 
x(:,1)=[0;0]; 
X_time_mes(:,1)=[10
                 15];                                                            %initial wrong estimate of states 
P=100*eye(2);                                                                    %initial guess of error covariance 
P_cov(:,1)=diag(P); 
G=eye(2);
Mean=.1*eye(2);
Var=.1; 

%% Implement DT Kalman Filter
for i=1:100 
    x(:,i+1) = A * x(:,i) + B * u(i) + 0.1*randn(2,1);                           % system at time i+1     
    z(i+1) = H * x(:,i+1) + Var * randn;                                         %measurement at i+1     
    x_copy(:,i+1) = x(:,i+1);  
    
    X_time_update(:,i+1) = A * X_time_mes(:,i) + B * u(i);                       %Time Update state at i+1     
    P = A * P * A' + Mean * (G * G)';                                            %Time Update Error Covariance      
    P_error_cov(:,i+1) = diag(P);                                                
    
    P = P - P * H' * 1/(H * P * H' + Var) * H * P;                               %Cov Measurement Update 
    P_updated_cov(:,i+1) = diag(P);                                              %track time updated dovariance 
    
    KalmanGain = P * H' * 1/(Var);                                               %Kalman Gain 
    Kalman_Gain_update(:,i)=KalmanGain;                                          %Record kalman gain 
    X_time_mes(:,i+1) = X_time_update(:,i+1) + KalmanGain * (z(i+1) - H * X_time_update(:,i+1));     %Measurement Update 
    
    x(:,i+1)=X_time_mes(:,i+1);                                                  %Feedback of updated state 
end
%% Plot the states Estimates and the Actual states
t=1:101; 
figure (1)
plot(t,X_time_mes(1,:),'b');
hold on;
plot(t,x_copy(1,:),'r')
hold on;
grid on;
legend('State 1 - Estimated','State 1 - Actual') 

figure (2)
plot(t,X_time_mes(2,:),'r');
hold on
plot(t,x_copy(2,:),'b');
grid on;
hold on;
legend('State 2 - Estimated','State 2 - Actual') 

figure(3)
plot(t(1:100),Kalman_Gain_update(1,:),'r');
hold on;
grid on;
plot(t(1:100),Kalman_Gain_update(2,:),'g');
grid on;
hold on;
legend('Kalman Gain - State 1','Kalman Gain - State 2');
title(' Kalman Gain With Iteration') 
 
[M,P,Z,E] = dlqe(A,G,H,Mean,Var);
M = 'The value of gain by Steady State Solution is' 
M
%Simulation of system 
    X_time_update(:,i+1) = A * X_time_mes(:,i) + B * u(i);                                  %Time Update state at i+1    
    X_time_mes(:,i+1) = X_time_update(:,i+1) + M * (z(i+1) - H * X_time_update(:,i+1));     %Measurement Update end 

figure (4)
plot(t,X_time_mes(1,:),'r',t,x(1,:),'b');
grid on;
hold on;
legend('State 1 - Estimated','State 1 - Actual ') 
title('Fixed Kalman Gain : State 1'); 

Figure(5)
plot(t,X_time_mes(2,:),'r');
grid on;
hold on;
plot(t,x(2,:),'b');
grid on;
hold on;
legend('State 2 - Estimated','State 2 - Actual ') 
title('Fixed Kalman Gain : State 2') 

clear P
P=1000*eye(2);
for i=1:40 %some arbitrary number of Iterations to get the solution converged
P=A*P*A'+Q*G*G';
P=P-P*H'*inv(H*P*H'+Var)*H*P;
end
KG_Iteration=P*H'*inv(Var)
