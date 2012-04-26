function [Result]=StrongClassify(X,H,alpha,WLearner)	


%
% Input
%      X - vector to be classified
%      H - array of selected best hypotheses
%      H(i) is a stucture of parameters characteristic of i-th hypothesis
%           parameters depend on the learning procedure  
%      alpha - array of weights for every hypothesis 
%           determined by the learning procedure
%
% Output:
%      Result - 0 if X does not belong to the class,1 else 
%

% NOTE: Before doing classification you need to have called AdaBoost learner to
% learn hypotheses H and get their weights (measure of importance) alpha




%number of hypotheses finally selected
T=size(H,2);

if (T~=size(alpha))
   return;
end;

N=size(X,1);
Result=zeros(N,1);

for j=1:N
   accum_result=0;
   thresh=0;

   for i=1:T
      accum_result=accum_result+alpha(i)*WeakClassify(X(j,:),H{i},WLearner);
      thresh=thresh+alpha(i);
   end;
   res=accum_result>thresh/2;
   Result(j)=res;
end;

		    
		    


		    
		    
		    
		    
		    
		    