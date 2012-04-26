function [error,Result]=WeakClassifyBatch(X,Y,H,W,WLearner)

% Same as WeakClassify but classifies an array of inputs X
% also finds the error of classification ,
% assumes correct classification is given (Y)
% Input
%      X - array of vector to be classified
%      Y correct classification
%      H - a hypothesis/claassifier used
%      H is a stucture of parameters characteristic of the hypothesis
%           parameters depend on the learning procedure  
%        in particular use 2-class Gaussian model: 
%           Mu=H{1};
%           Mu(1),Mu(2)-means of the 2 classes
%           InvSigma=H{2} 
%           InvSigma(1),InvSigma(2)- std. deviations of 2 classes
%      W - distribution over the input samples 
%
%     
%
% Output:
%      error  - error of classification
%      Result - 0 if X does not belong to the class(class 1),1 else 
%

N=size(X,1);
error=0;

for i=1:N
   
    switch (WLearner)
     case  {'Gauss','Gaussian'}
       Result(i)=WeakClassifyGauss(X(i,:),H);
     case 'ROC' 
       Result(i)=WeakClassifyROC(X(i,:),H);
     otherwise
       %no weak learner available
       return;
   end;
   
 %%%%%  Result(i)=WeakClassify2(X(i,:),H);
   
   
   
   error=error+abs(Result(i)-Y(i))*W(i);
end;











