clc;
clear;
s=0;

%% Loading the image and storing the R,G,B values in a vector
j=imread('Assignment_list-ski_image.jpg');
r=reshape(j(:,:,1),[],1);
g=reshape(j(:,:,2),[],1);
b=reshape(j(:,:,3),[],1);
X=double([r';g';b'])/255;
clear r g b j;

%% Initializing the values

mu1=[120;120;120]/255;
mu2=[12;12;12]/255;
mu3=[180;180;180]/255;
mu=[mu1,mu2,mu3];
clear mu1 mu2 mu3;
sig1=eye(3,3);
sig2=eye(3,3);
sig3=eye(3,3);
itr =1;
pi=[1/3;1/3;1/3];
[~,m]=size(X);
gamma=zeros(154401,3);

%% Beginning the iterations

while itr<100
N1=0;newmu1=0;
N2=0;newmu2=0;
N3=0;newmu3=0;

val=normal(X,mu,sig1,sig2,sig3,3); % Calculating the normal values for R,G,B
for i=1:m
gamma(i,1)=(pi(1)*(val(i,1)))/((pi(1)*val(i,1))+(pi(2)*val(i,2))+(pi(3)*val(i,3))); % Updating the gamma values
gamma(i,2)=(pi(2)*(val(i,2)))/((pi(1)*val(i,1))+(pi(2)*val(i,2))+(pi(3)*val(i,3)));
gamma(i,3)=(pi(3)*(val(i,3)))/((pi(1)*val(i,1))+(pi(2)*val(i,2))+(pi(3)*val(i,3)));

N1=N1+gamma(i,1); % Calculating the N values
N2=N2+gamma(i,2);
N3=N3+gamma(i,3);
newmu1=newmu1+gamma(i,1)*X(:,i); % Calculating the updated means
newmu2=newmu2+gamma(i,2)*X(:,i);
newmu3=newmu3+gamma(i,3)*X(:,i);
end
newmu1=newmu1/N1;
newmu2=newmu2/N2;
newmu3=newmu3/N3;
sig1=zeros(3,3);
sig2=zeros(3,3);
sig3=zeros(3,3);
for i=1:m
sig1=sig1+gamma(i,1)*(X(:,i)-newmu1)*(X(:,i)-newmu1)'; % Calculating the covariance matrices
sig2=sig2+gamma(i,2)*(X(:,i)-newmu2)*(X(:,i)-newmu2)';
sig3=sig3+gamma(i,3)*(X(:,i)-newmu3)*(X(:,i)-newmu3)';
end
sig1=sig1/N1;
sig2=sig2/N2;
sig3=sig3/N3;

itr
mu1=newmu1;
mu2=newmu2;
mu3=newmu3;

mu=[newmu1,newmu2,newmu3];    
pi(1)=N1/m; % Updating the weights
pi(2)=N2/m;
pi(3)=N3/m;
val=normal(X,mu,sig1,sig2,sig3,3);
ls=s;
s=0;
for i=1:m
s=s+log((pi(1)*val(i,1))+(pi(2)*val(i,2))+(pi(3)*val(i,3))); % Calculating the Log-likelihood values
end
error=abs(ls-s);
plot(itr,ls,'*');
hold on;
itr=itr+1;
end

%% Clustering the points and making the segmented image

C=zeros(321,481,3);
k=0;
val(1,:)=val(1,:).*pi(1);
val(2,:)=val(2,:).*pi(2);
val(3,:)=val(3,:).*pi(3);
for i=1:481
for j=1:321
[~,n]=max(val(k+j,:));
C(j,i,n)=1;
end
k=321*i;
end
figure(2);
image(C);