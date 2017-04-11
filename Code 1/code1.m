clc;
clear;
load parameters.mat;
y=zeros(1024,100,3);

%% Loading the testing images in a vector

for i=201:300
    current1=imread(strcat('TestCharacters/1/',int2str(i),'.jpg'));
    current1=imresize(current1,[32 nan]);
    current1=double(current1);
    current1=reshape(current1,[],1);
    y(:,(i-200),1)=current1;
    current3=imread(strcat('TestCharacters/3/',int2str(i),'.jpg'));
    current3=imresize(current3,[32 nan]);
    current3=double(current3);
    current3=reshape(current3,[],1);
    y(:,(i-200),3)=current3;
    current2=imread(strcat('TestCharacters/2/',int2str(i),'.jpg'));
    current2=reshape(double(imresize(current2,[32 nan])),[],1);
    y(:,(i-200),2)=current2;
    c=zeros(100,3);
end

%% The Classificaton Code

for k=1:3
    if k==2
        P= MAP(y,mu,sig2,k); % Function to calculate the bayesian probabilities 
    else
        P= MAP(y,mu,sig,k);
    end
for i=1:100

for j=1:3
[~,c(i,j,k)]=max(P(i,:,j)); % Checking the class of images
end
end

counter=zeros(3,1);

for i=1:100
for j=1:3
if c(i,j,k)==j
    counter(j)=counter(j)+1; % Counter to track correctly classified images.
end
end
end
if k==1
s= 'Case1: When sigma is I';
end
if k==2
s= 'Case2: When sigma is constant';
end
if k==3
s= 'Case3: When sigma is arbitary';
end
disp(s)

accuracy=sum(counter)/3
end

%% Code to show the incorrectly classified images
for k=1:3
    for j=1:3
        for i=1:100
            if (c(i,j,k)~=j)
                s=strcat({'For the case '},{num2str(k)},{' the image TestCharacters/'},{num2str(j)},{'/'},{num2str(200+i)},{'.jpg'},{' is incorrectly classified to '},{num2str(c(i,j,k))},{'. The correct class is '},{num2str(j)});
                disp(s);
            end
        end
    end
end