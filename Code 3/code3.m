clc;
clear;
x=zeros(10304,200);
k=0;

%% Loading the images into a vector

for i=1:40
    for j=1:5
    current1=imread(strcat('gallery/s',int2str(i),'/',int2str(j),'.pgm'));
    current1=double(current1);
    current1=reshape(current1,[],1);
    x(:,k+j)=current1;
    end
k=k+5;    
end
mu=zeros(10304,1); 
for i=1:200
mu=mu+x(:,i);
end
mu=mu/200; % Calculating the mean
sig=zeros(10304,200);


for i=1:200
sig(:,i)=(x(:,i)-mu);
end
sig=sig'*sig;
sig=sig/200; % Calculating the covariance matrix

[W,D]=eig(sig); % Calculating the eigen values and eigen vectors
A=diag(D);
W=x*W;
colormap gray;
for i=1:5
subplot(2,3,i);
imagesc(reshape(W(:,201-i),112,92)); % The eigenfaces
end
figure(2);
count=0;
 for i=200:-1:1
     plot(201-i,(sum(abs(A(i:200)))/sum(abs(A)))*100,'*');
     if (sum(abs(A(i:200)))/sum(abs(A)))*100<95 
     count=count+1;
     end
     hold on;
 end
 
count % The number of dimensions required to get 95% accuracy

%% Loading the input images

I1=imread(strcat('Assignment_list-face_input_1.pgm'));
I1=double(I1);
I1=reshape(I1,[],1);
I1=I1-mu;
  
I2=imread(strcat('Assignment_list-face_input_2.pgm'));
I2=double(I2);
I2=reshape(I2,[],1);
I2=I2-mu;     
figure(3);
colormap gray;
  %% Reconstructing Images
v=(W(:,200))/norm((W(:,200)));
Y1=((I1'*(v))*(v))+mu;
error=sum((Y1-(I1+mu)).^2)/10304

subplot('Position',[0.03,0.3,0.3,0.5]);
imagesc(reshape(Y1,112,92)); % Reconstructed Image from the top eigenvector

    
for i=2:15
v=(W(:,201-i))/norm((W(:,201-i)));
Y1=Y1+(I1'*(v))*(v);  
end
   
    error=sum((Y1-(I1+mu)).^2)/10304

subplot('Position',[0.36,0.3,0.3,0.5]);
colormap gray;
imagesc(reshape(Y1,112,92)); % Reconstructed Image from the top 15 eigenvectors

for i=16:200
v=(W(:,201-i))/norm((W(:,201-i)));
Y1=Y1+ (I1'*(v))*(v);  
end

subplot('Position',[0.69,0.3,0.3,0.5]);
colormap gray;
imagesc(reshape(Y1,112,92)); % Reconstructed Image from all the eigenvectors

figure(4);
colormap gray;
i=1;
v=(W(:,201-i))/norm((W(:,201-i)));
Y1=((I2'*(v))*(v))+mu; 
error=sum((Y1-(I2+mu)).^2)/10304

subplot('Position',[0.03,0.3,0.3,0.5]);
imagesc(reshape(Y1,112,92));

    
for i=2:15
v=(W(:,201-i))/norm((W(:,201-i)));
Y1=Y1+(I2'*(v))*(v);  
end
   
error=sum((Y1-(I2+mu)).^2)/10304

subplot('Position',[0.36,0.3,0.3,0.5]);
colormap gray;
imagesc(reshape(Y1,112,92));

for i=16:200
v=(W(:,201-i))/norm((W(:,201-i)));
Y1=Y1+ (I2'*(v))*(v);  
end
   
error=sum((Y1-(I2+mu)).^2)/10304
colormap gray;
subplot('Position',[0.69,0.3,0.3,0.5]);
imagesc(reshape(Y1,112,92));

figure(6);

%% Calculating Mean Squared Error for Image1

squareMeanError=zeros(200,1);
Y1=mu;
for i=1:200
    v=(W(:,201-i))/norm((W(:,201-i)));
Y1=((I1'*(v))*(v))+Y1; 
squareMeanError(i,1)=sum((Y1-(I1+mu)).^2)/10304;
end
plot(1:200,squareMeanError,'black');
hold on;
xlabel('Number of Eigen Faces');
ylabel('Mean Squared Error');

%% Calculating Mean Squared Error for Image2


squareMeanError=zeros(200,1);
Y1=mu;
for i=1:200
    v=(W(:,201-i))/norm((W(:,201-i)));
Y1=((I2'*(v))*(v))+Y1; 
squareMeanError(i,1)=sum((Y1-(I2+mu)).^2)/10304;
end
plot(1:200,squareMeanError','g');
