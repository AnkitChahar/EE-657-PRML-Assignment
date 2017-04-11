clc;
clear;
x=zeros(1024,200,3);

%% Loading the training images in a vector
for i=1:200
    current1=imread(strcat('TrainCharacters/1/',int2str(i),'.jpg'));
    current1=imresize(current1,[32 nan]);
    current1=double(current1);
    current1=reshape(current1,[],1);
    x(:,i,1)=current1;
    current3=imread(strcat('TrainCharacters/3/',int2str(i),'.jpg'));
    current3=imresize(current3,[32 nan]);
    current3=double(current3);
    current3=reshape(current3,[],1);
    x(:,i,3)=current3;
    current2=imread(strcat('TrainCharacters/2/',int2str(i),'.jpg'));
    current2=imresize(current2,[32 nan]);
    current2=double(current2);
    current2=reshape(current2,[],1);
    x(:,i,2)=current2;
end

mu=(sum(x,2))/200; %The mean of images
sig=zeros(1024,1024,3);

%% Calculating the sigmas

for i=1:200
    sig(:,:,1)=sig(:,:,1)+(x(:,i,1)-mu(:,:,1))*(x(:,i,1)-mu(:,:,1))';
    sig(:,:,2)=sig(:,:,2)+(x(:,i,2)-mu(:,:,2))*(x(:,i,2)-mu(:,:,2))';
    sig(:,:,3)=sig(:,:,3)+(x(:,i,3)-mu(:,:,3))*(x(:,i,3)-mu(:,:,3))';
end
sig2=zeros(1024);

for i=1:200
    sig2=sig2+(x(:,i,1)-mu(:,:,1))*(x(:,i,1)-mu(:,:,1))';
    sig2=sig2+(x(:,i,2)-mu(:,:,2))*(x(:,i,2)-mu(:,:,2))';
    sig2=sig2+(x(:,i,3)-mu(:,:,3))*(x(:,i,3)-mu(:,:,3))';
end

sig=sig/200;
sig2=sig2/600;

save('parameters.mat','mu','sig','sig2'); %% Saving the parameters in a file
