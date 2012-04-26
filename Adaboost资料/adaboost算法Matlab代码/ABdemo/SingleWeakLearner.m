function [H]=SingleWeakLearner(X,Y,C,W)


%  Train a weak classifier wrt ONE feature given in C
%  Use 2-class Gaussian model: 
%
% Input
%      X - samples
%      Y - label of samples - 
%          1 - belong to the class,0 - otherwise
%      C - feature vector 
%      W - distribution over examples
%     
% Output:
%      H - result classifier,contains the following parameters: 
%       Mu=H{1}; 
%       Mu(1),Mu(2)-means of the 2 classes
%       InvSigma=H{2}     
%       InvSigma(1),InvSigma(2)- inverse of matrix of std. deviations of
%       the 2 classes
%     
%

DEBUG =1;

H={};

% Fit 2 Gaussians to positive and negative examples 
% Find the best mu,sigma for the selected model 

N=size(X,1);
% Note: N==size(Y,1)

pn=size(X,2);

for i=1:N  
   VV(i,:)=X(i,:).*C;
end;


%compute projection on the feature vector 
V = X * C'


%figure(97);imagesc(C);colormap(gray);title('Feature vector'); 
%figure(98);imagesc(X);colormap(gray);title('Samples');
%figure(99);imagesc(V);colormap(gray);title('Frojected sampples');

%find mean

Mu=V.*W

W_p=sum(W(find(Y==1)))
W_n=sum(W(find(Y==0)))
Mu(find(Y==0))

Mu_p=mean(Mu(find(Y==1)))/W_p
Mu_n=mean(Mu(find(Y==0)))/W_n

Sigma_p=mean((V(Y==1)-Mu_p)'*(V(Y==1)-Mu_p)*W(find(Y==1)))/W_p
Sigma_n=mean((V(Y==0)-Mu_n)'*(V(Y==0)-Mu_n)*W(find(Y==0)))/W_n

pause

%figure(299);imagesc(Mu_p);colormap(gray);title('Mean of target class');
%figure(300);imagesc(Mu_n);colormap(gray);title('Mean of distractor class');
%pause
%figure(199);imagesc(Sigma_p);colormap(gray);
%figure(200);imagesc(Sigma_n);colormap(gray);

InvSigma_p=pinv(Sigma_p);
InvSigma_n=pinv(Sigma_n);


H{1}={Mu_p,Mu_n};
H{2}={InvSigma_p,InvSigma_n};
%H{3}=[Sigma_p,Sigma_n];


if DEBUG 
   %this is for test -REMOVE
   [error,Result]=WeakClassifyBatch(X,Y,H,W);
   figure(101);imagesc(Result);colormap(gray);title('classification of training set after learning');
   Result
   error

   Mu_p
   Mu_n
   InvSigma_p
   InvSigma_n
end;






