function f=GentleBoostClassify(X,W,aparam,bparam,cparam)
% input: design matrix X
%        the weight vectors of k weak classifiers
%        the parameters of stump of k weak classifiers
% outout: prediction f={0,1}
A = ones(size(X,1),length(aparam))*diag(aparam);
B = ones(size(X,1),length(bparam))*diag(bparam);
C = ones(size(X,1),length(cparam))*diag(cparam);
f=sum(A.*(X*W+B>0)+C,2);