% this function uses cross validation to select best iteration k for gentle
% boosting
function [bestParam, bestCVError,CVErrors] = GentleBoostCrossValidation(Xtrain,Ytrain)
% input: training data Xtrain, Ytrain
% outout: best parameters which have mininal cross validation error
%         bestParam
CountFolds = 5; % the number of folds which used in cross validation
allparams = 10:10:1000;
FoldSize = size(Xtrain,1)/CountFolds;
CVErrors = zeros(size(allparams,2),1);
for k=1:CountFolds
    % create index of fold
    TestFoldIndex = (k-1)*FoldSize+1:k*FoldSize;
    TrainFoldIndex1 = 1:(k-1)*FoldSize;
    TrainFoldIndex2 = k*FoldSize+1:size(Xtrain,1);
    TrainFoldIndex = [TrainFoldIndex1 TrainFoldIndex2];
    % create folds
    XTrainFold = Xtrain(TrainFoldIndex,:);
    XTestFold = Xtrain(TestFoldIndex,:);
    YTrainFold = Ytrain(TrainFoldIndex);
    YTestFold = Ytrain(TestFoldIndex);
    counter = 1; % compute the error for each k
    for m=1:size(allparams,2)
        % learn parameters on the training fold
        [W,aparam,bparam,cparam] = GentleBoostTrain(XTrainFold,YTrainFold,allparams(m));
        % apply the learner on the test fold
        f = GentleBoostClassify(XTestFold,W,aparam,bparam,cparam);
        % compute the Zero-One error
        CVErrors(counter) = CVErrors(counter) + 0.5*sum(abs(YTestFold-sign(f)));
        counter = counter + 1;
    end
    disp(k);
end
CVErrors = CVErrors/size(Xtrain,1);
[bestCVError Idx]= min(CVErrors);
bestParam = allparams(Idx);
