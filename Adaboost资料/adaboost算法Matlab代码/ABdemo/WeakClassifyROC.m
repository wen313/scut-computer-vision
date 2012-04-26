function [Result]=WeakClassifyROC(X,H)

%
% Input
%      X - vector to be classified
%      H - a hypothesis/claassifier used
%      H is a stucture of parameters characteristic of the hypothesis
%           parameters depend on the learning procedure  
%      
%     in particular use 2-class Gaussian model: 
%       Mu=H{1}; 
%       Mu(1),Mu(2)-means of the 2 classes
%       InvSigma=H{2}
%       InvSigma(1),InvSigma(2)-invserse if  std. deviation matrices of
%       the 2 classes
%
% Output:
%      Result - 0 if X does not belong to the class(class 1),1 else 
%


thresh=H{1};
p=H{2};
C=H{3};

C = C(:); C = C / sqrt(sum(C.^2));
Z = X * C; %compute projection on classifier
Result=(p*Z<p*thresh);






