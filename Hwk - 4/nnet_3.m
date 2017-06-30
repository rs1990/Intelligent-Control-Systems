clc;clear all;close all;
%Breast-cance data classification using Self-Organizing Map
data=open('breastcancer.mat');
P=data.data(:,2:10)'; %Input matrix
T=data.data(:,11)'; %Target values
benign=0;
malignant=0;
for i=1:length(T)
    if T(i)==2
        %T(i)=1; %Benign cell
        benign=benign+1;
    else
        %T(i)=0; %Malignant cell
        malignant=malignant+1;
    end
end
SOM=selforgmap([8 8],478); %Building SOM
SOM=train(SOM,P); %Train the NN
%output=sim(cancerSOM,P);
output=SOM(P);
classes=vec2ind(output);