% this function is to generate the set of weak classifiers interatively 
function [W,aparam,bparam,cparam]=GentleBoostTrain(X,Y,k)
% input: Design matrix X
%        Output labels Y
%        Maximum iterations k
% outout: an array of weight vectors W
%         the parameters of decision stumps a*(X*w+b>0)+c
[num dim] = size(X);
W = zeros(dim,k);
gamma = 1/num * ones(num,1);
ExpLoss = zeros(k,1); ZeroOneLoss = zeros(k,1);
CurF = zeros(num,1);
for i=1:k
    %generate random weight vector
    w = rand(dim,1); w = w/norm(w); W(:,i) = w;
    [aparam(i),bparam(i),cparam(i),loss] = FitStump(X,Y,w,gamma);
    % the decision stump
    Fout = aparam(i)*(X*w+bparam(i)>0)+cparam(i);
    % updata gamma
    gamma = gamma .* exp(-Y.*Fout);
    gamma = gamma/sum(gamma);
    CurF =CurF+Fout;
    % compute the exponential and zero-one loss
    ExpLoss(i) = sum(exp(-Y.*CurF))/num;
    ZeroOneLoss(i) = sum(Y.*CurF<0)/num;
end