function P = ML(X,MU,SIG)
    SIG=SIG+0.7*eye(1024);
    l=zeros(1024,1);
    l(:,1)=log(det(SIG));
    for i=1:100
    d=((X(:,i)-MU)')*(inv(SIG))*(X(:,i)-MU);
    P=(-0.5).*(l)-0.5.*(d);
    end
end