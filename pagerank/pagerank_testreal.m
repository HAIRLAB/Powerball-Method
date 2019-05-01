clear all
close all
clc
format long e

%  load matlab.mat
load wb-cs.stanford.mat
N=size(Acc);
alpha = 0.1;
N=N(1);
A=Acc; % define boolean matrix A;
D=diag(ones(1,N)*A);
P=A*D^(-1);  % normalize column such that the sum of colum is one
P=(1- alpha) * P+ alpha * ones(N,1)*ones(1,N)/N;

X0 = rand(N,1);
X0 = X0/norm(X0,1);

End_Value = 50;

X1(:,1) = X0;
X2(:,1) = X0;
beta_start = .7;
beta_end = 1;

 
 alpha2_start = 2; % you can tune the initial step-size
 for k = 1:End_Value
     beta = beta_start-(beta_start-beta_end)/End_Value*k;
%       beta = beta_start;
     X1(:,k+1) = P * X1(:,k);
     alpha2 = alpha2_start;
     X2(:,k+1) = X2(:,k) + alpha2*sign((P-eye(N)) * X2(:,k)).*(abs((P-eye(N)) * X2(:,k))).^beta;
        while norm((P-eye(N))*X2(:,k+1))- norm((P-eye(N))*X2(:,k))>=10^(-40)
             alpha2 = alpha2*.5; % you can tune this 
             X2(:,k+1) = X2(:,k) + alpha2*sign((P-eye(N)) * X2(:,k)).*(abs((P-eye(N)) * X2(:,k))).^beta;
             display('adjusting step size at')
             display(k)
        end
     X2(:,k+1) = X2(:,k+1)/norm(X2(:,k+1),1);
     S1(:,k) =  norm ((P-eye(N))*X1(:,k+1));
     S2(:,k) =  norm ((P-eye(N))*X2(:,k+1));
 end
  
 
 semilogy(S1)
 hold on
 semilogy(S2)
