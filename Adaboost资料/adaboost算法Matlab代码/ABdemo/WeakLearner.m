function [H,epsilon,R]=WeakLearner(X,Y,C,W,WLearner,Y_predict)


%  Train weak classifiers for every feature and select the one that
%  performs best i.e. correspondent ot the best feature to use for
%  discrimination 
%  Use 2-class Gaussian model: 
%
% Input
%      X - samples
%      Y - label of samples - 
%          1 - belong to the class,0 - otherwise
%      C - array of feature vectors 
%      W - distribution over examples
%      WLearner - Weak learner type
%      
%
%     
% Output:
%      H - result classifier,contains the following parameters: 
%       Mu=H{1}; 
%       Mu(1),Mu(2)-means of the 2 classes
%       InvSigma=H{2}     
%       InvSigma(1),InvSigma(2)- inverse of matrix of std. deviations of
%       the 2 classes
%      epsilon - classification error of the best weak classifier selected
%      R - result of current classification



N=size(X,1);
% min error of classification - init with max possible error
epsilon=1.0000000001; 

%number of features
K=size(C,1);

%Select the classifier with min error of classification
for i=1:K
   
   %dispatch the weak learner
   switch (WLearner)
    case  {'Gauss','Gaussian'}
     Hyp=SingleWeakLearnerGauss(X,Y,C(i,:),W,Y_predict);
    case 'ROC' 
      Hyp=SingleWeakLearnerROC(X,Y,C(i,:),W,Y_predict);
    otherwise
     %no weak learner available
     return;
   end;
   
   
   
   
   [error,Res]=WeakClassifyBatch(X,Y,Hyp,W,WLearner);
    if (error<epsilon)
      epsilon=error;
      H=Hyp;
      R=Res;
   end;   
end;   
