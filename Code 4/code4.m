clc;
clear;

%% Loading the patterns and storing them in vectors

load('Pattern1.mat');
load('Pattern2.mat');
load('Pattern3.mat');
load('Test1.mat');
load('Test2.mat');
load('Test3.mat');

X=zeros(200,120);
Y=zeros(200,120);
Z=zeros(200,120);

X1=zeros(100,120);
Y1=zeros(100,120);
Z1=zeros(100,120);

for i=1:200
X(i,:)=train_pattern_1{1,i};
Y(i,:)=train_pattern_2{1,i};
Z(i,:)=train_pattern_3{1,i};
end
for i=1:100
X1(i,:)=test_pattern_1{1,i};
Y1(i,:)=test_pattern_2{1,i};
Z1(i,:)=test_pattern_3{1,i};
end


A=[X;Y;Z];
B=[X1;Y1;Z1];
 
%% Assigning Class labels

C1=ones(600,1);
C1(201:600)=2;
C2=ones(600,1);
C2(1:200)=2;
C2(401:600)=2;
C3=ones(600,1);
C3(1:400)=2;
j=0.05;

avgAcc=zeros(20,20);

%% Training the SVM models using One Versus All method

for i = 1:20
    k=0;
   for j = 0.05:0.05:1
       k=k+1;
        model1=fitcsvm(A,C1,'KernelFunction','RBF','BoxConstraint' ,j,'KernelScale',i); % BoxConstraint is Penalty Factor and KernelScale is Gamma
        model2=fitcsvm(A,C2,'KernelFunction','RBF','BoxConstraint' ,j,'KernelScale',i);
        model3=fitcsvm(A,C3,'KernelFunction','RBF','BoxConstraint' ,j,'KernelScale',i);
        Q1=predict(model1,B); % Predicting using the trained models
        Q2=predict(model2,B);
        Q3=predict(model3,B);
        Acc1= 200-sum(Q1(1:100));
        Acc2= 200-sum(Q2(101:200));
        Acc3= 200-sum(Q3(201:300));
        avgAcc(i,k)=(Acc1+Acc2+Acc3)/3;
   end
end

%% Plotting the meshgrid to show accuracy variations with 2 variables

sigma=1:20;
box_constraint=0.05:0.05:1;
[Sigma,Box_constraint]=meshgrid(sigma,box_constraint);
surf(Sigma,Box_constraint,avgAcc(1:20,:)');
xlabel('Sigma');
ylabel('Penalty Factor');
zlabel('Average Accuracy');