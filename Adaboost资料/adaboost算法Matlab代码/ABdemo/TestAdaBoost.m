function [Result,error,H,alpha]=TestAdaBoost(X,Y,C,T,Xver,Yver,WLearner)

%
%  Test AdaBoost
%  
%
% Input
%      X - training set
%      Y - label of samples in rtaining set
%          1 - belong to the class,0 - otherwise
%      C - array of feature vectors 
%      T - number of iterations
%      Xver - verifying dataset 
%      Yver - correct classification of verifying dataset 
%           - used to calculate error of classification
%      WLearner - weak learner type
% Output:
%      Result - result classification on verifying set
%      error  - error of classification on verifying set       
%


DEBUG = 1;

%learn

[H,alpha]=AdaBoost(X,Y,C,T,WLearner);


%classify
Result=StrongClassify(Xver,H,alpha,WLearner);

N=size(Xver,1);
error=sum(abs(Result'-Yver))/N;


if DEBUG
   
% figure(101);imagesc(Result);colormap(gray);title('classification of test set after learning');

end;

		    
		    
		    
		    
		    
		    