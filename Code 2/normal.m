function N=normal(X,mu,sig1,sig2,sig3,d)
[~,m]=size(X);
N=zeros(m,3);
C1=1/(((2*pi)^(1.5))*det(sig1)^(1/2));
C2=1/(((2*pi)^(1.5))*det(sig2)^(1/2));
C3=1/(((2*pi)^(1.5))*det(sig3)^(1/2));
invsig1=inv(sig1);
invsig2=inv(sig2);
invsig3=inv(sig3);
for i=1:m
p=(-0.5)*(((X(:,i)-mu(:,1))')*(invsig1)*(X(:,i)-mu(:,1)));
N(i,1)=C1*exp(p);
p=(-0.5)*(((X(:,i)-mu(:,2))')*(invsig2)*(X(:,i)-mu(:,2)));
N(i,2)=C2*exp(p);
p=(-0.5)*(((X(:,i)-mu(:,3))')*(invsig3)*(X(:,i)-mu(:,3)));
N(i,3)=C3*exp(p);
end