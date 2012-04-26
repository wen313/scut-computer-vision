function [Y]=AdaBoostClassify(H,alpha,X)





%  AdaBoost classify
T=size(alpha,2);

Thresh=sum(alpha)/2;
Yres=0;
for t=1:T

   %find weak classifier decision  
   Label=WeakClassify(X,H{t},'ROC');
   Yres=Yres+alpha(t)*Label;
end;

Y=(Yres>=thresh);











