% this function finds the parameters of best superplane <w,x>+b>0, which
% has the minimal loss
function [a,b,c,minLoss]=FitStump(X,Y,w,gamma)
LinOut = X*w;
Product = Y.*gamma;
%order the product data in descending order
[SortLinOut,Idx] = sort(LinOut,'descend');
%reorder the product Y.*gamma as well as the weights gamma as LinOut
Product = Product(Idx);
Gamma = gamma(Idx);
%calculate the cumulative sum of product and gamma
CumProduct = cumsum(Product); CumProduct = CumProduct(1:end-1);
CumGamma = cumsum(Gamma); CumGamma = CumGamma(1:end-1);
%compute optimal coefficients a and c for every possible threshold
% there are at most n-1 threshold for we have n training data
c = (sum(Product)-CumProduct)./(sum(Gamma)-CumGamma);
a=CumProduct./CumGamma - c;
%compute the error for the optimal parameters for all thresholds
error = (1+c.^2).*sum(Gamma) + (a.^2 + 2.*a.*c).*CumGamma...
    -2*a.*CumProduct - 2*c.*sum(Product);
% find index which achieves the mininal error
minLoss = min(error);
thresh = find(error == minLoss);
%if there is more than one, then take the middle one
NumThresh = length(thresh);
IdxThresh = ceil(NumThresh/2);
thresh = thresh(IdxThresh);
% threshold is placed in the middle of two data
b = -(SortLinOut(thresh)+SortLinOut(thresh+1))/2;
a = a(thresh); c = c(thresh);