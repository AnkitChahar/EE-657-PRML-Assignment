function d = MAP(X,MU,SIG,type)
    d=zeros(100,3,3);
% Function to calculate the posterior probabilites
if type ==1
    
for j=1:3
    for i=1:100
    d(i,1,j)=((X(:,i,j)-MU(:,1,1))')*(X(:,i,j)-MU(:,1,1));
    d(i,2,j)=((X(:,i,j)-MU(:,1,2))')*(X(:,i,j)-MU(:,1,2));
    d(i,3,j)=((X(:,i,j)-MU(:,1,3))')*(X(:,i,j)-MU(:,1,3));
    end
end
end
for j=1:3
   d(:,:,j)=d(:,:,j).*(-1);
  
end 

if type ==2
    
    k=0.7; 
    SIG=SIG+k*eye(1024);
    SIG=inv(SIG);
 for j=1:3
    for i=1:100
    d(i,1,j)=((X(:,i,j)-MU(:,1,1))')*SIG*(X(:,i,j)-MU(:,1,1));
    d(i,2,j)=((X(:,i,j)-MU(:,1,2))')*SIG*(X(:,i,j)-MU(:,1,2));
    d(i,3,j)=((X(:,i,j)-MU(:,1,3))')*SIG*(X(:,i,j)-MU(:,1,3));
    end
 end
for j=1:3
   d(:,:,j)=d(:,:,j).*(-0.5);
  
end 
 
end


if type==3
    k=0.7;
    SIG(:,:,1)=SIG(:,:,1)+k*eye(1024);
    SIG(:,:,2)=SIG(:,:,2)+k*eye(1024);
    SIG(:,:,3)=SIG(:,:,3)+k*eye(1024);

    l=[log(det(SIG(:,:,1)));
    log(det(SIG(:,:,2)));
    log(det(SIG(:,:,3)))];
    SIG(:,:,1)=inv(SIG(:,:,1));
    SIG(:,:,2)=inv(SIG(:,:,2));
    SIG(:,:,3)=inv(SIG(:,:,3));
    for j=1:3
    for i=1:100
        d(i,1,j)=((X(:,i,j)-MU(:,1,1))')*(SIG(:,:,1))*(X(:,i,j)-MU(:,1,1));
        d(i,2,j)=((X(:,i,j)-MU(:,1,2))')*(SIG(:,:,2))*(X(:,i,j)-MU(:,1,2));
        d(i,3,j)=((X(:,i,j)-MU(:,1,3))')*(SIG(:,:,3))*(X(:,i,j)-MU(:,1,3));
    end
    end
    for j=1:3
        d(:,:,j)=d(:,:,j).*(-0.5);
        d(:,:,j)=d(:,:,j)-(0.5*l(j));
    end
end
    
end