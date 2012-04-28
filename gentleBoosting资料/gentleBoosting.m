% this script is to implement the gentle boosting
clear all;
load diabetes
k = [5 10 20 40 80 160];
ExpLoss = zeros(length(k),1);
ZeroOneLoss = zeros(length(k),1);
for i=1:length(k)
    [W,aparam,bparam,cparam] = GentleBoostTrain(Xtrain,Ytrain,k(i));
    f = GentleBoostClassify(Xtest,W,aparam,bparam,cparam);
    % compute the exponential loss and zero-one loss
    ExpLoss(i) = sum(exp(-Ytest.*f))/size(Xtest,1);
    ZeroOneLoss(i) = sum(Ytest.*f<0)/size(Xtest,1);
end
figure;
hold on
plot(k,ExpLoss,'linestyle','-','linewidth',2,'color','r');
plot(k,ZeroOneLoss,'linestyle','-','linewidth',2,'color','b');
xlabel('k');
ylabel('error');
legend('Exponential Loss','Zero-One Loss');
title('error against the number of iteration k');
axis([k(1),k(end),min(min(ExpLoss),min(ZeroOneLoss)),max(max(ExpLoss),max(ZeroOneLoss))]);
hold off
