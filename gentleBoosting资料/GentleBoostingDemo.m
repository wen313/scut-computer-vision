% this script is a demo of implementing gentle boosting, using k-th fold
% cross validation to select best iteration k
clear all
load diabetes
[num dim]=size(Xtrain);
ExpLoss = zeros(2,1);
ZeroOneLoss = zeros(2,1);
% using cross-validation to select best parameter 
[bestParam, bestCVError,CVErrors] = GentleBoostCrossValidation(Xtrain,Ytrain);
% training learner with best parameter on the whole training set
[W,aparam,bparam,cparam] = GentleBoostTrain(Xtrain,Ytrain,bestParam);
% apply the learner on test set
Fout1 = GentleBoostClassify(Xtest,W,aparam,bparam,cparam);
% compute the error
ExpLoss(1) = sum(exp(-Ytest.*Fout1))/size(Xtest,1);
ZeroOneLoss(1) = sum(Ytest.*Fout1<0)/size(Xtest,1);
% compare the result with a weak learner
w = rand(dim,1); w = w/norm(w); gamma = 1/num * ones(num,1);
% train the weak learner
[a,b,c,loss] = FitStump(Xtrain,Ytrain,w,gamma);
% apply the weak learner on test set
Fout2 = a.*(Xtest*w+b>0)+c;
% compute the error
ExpLoss(2) = sum(exp(-Ytest.*Fout2))/size(Xtest,1);
ZeroOneLoss(2) = sum(Ytest.*Fout2<0)/size(Xtest,1);