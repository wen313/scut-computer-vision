function [H]=SingleWeakLearnerROC(X,Y,C,W,Correct)


%  Train a weak classifier wrt ONE feature given in C
%  Use 2-class Gaussian model: 
%
% Input
%      X - samples
%      Y - label of samples - 
%          1 - belong to the class,0 - otherwise
%      C - feature vector 
%      W - distribution over examples
%     
% Output:
%      H - result classifier,contains the following parameters: 
%      
%     
%
% Pietro Perona
% 17 May 2002

DEBUG = 1;

H={};
W = W(:);
Y = Y(:);
C = C(:); C = C / sqrt(sum(C.^2));


V = X * C; %compute projection on classifier
%Here should calculate all rect features for each input sample Xs



%figure(98);imagesc(X);colormap(gray);title('Samples');
%figure(99);imagesc(V);colormap(gray);title('Frojected sampples');

[V_sort,ind] = sort(V);
W_sort = W(ind);
Y_sort = Y(ind);

P_cum = cumsum(Y_sort .* W_sort); 
P_cum = P_cum/sum(W);
N_cum = cumsum((1-Y_sort) .* W_sort);
N_cum = N_cum/sum(W);




PN_cum1 = ( (max(P_cum)-P_cum) + N_cum); 
PN_cum2 = ( (max(N_cum)-N_cum) + P_cum); 

[min1,thresh_ind1]= min(PN_cum1);
[min2,thresh_ind2]= min(PN_cum2);

if (min1<min2)  
   thresh_ind=thresh_ind1;
   PN_cum=PN_cum1;
else
   thresh_ind=thresh_ind2;
   PN_cum=PN_cum2;
end;

lpn = length(PN_cum);
thresh = ( V_sort(thresh_ind));
%thresh = ( V_sort(thresh_ind)+V_sort(thresh_ind+1))/2;
p = 2 *( (P_cum(thresh_ind)>N_cum(thresh_ind)) -0.5);


H{1}=thresh;
H{2}=p;
H{3}=C;

if DEBUG

   figure(500); clf
   subplot(1,2,1);
   %X1=X(find(Y==0),:);
   %W1=W(find(Y==0));
   
   %plot(X(find(Y==0),1),X(find(Y==0),2),'bx','MarkerSize',5000*W(find(Y==0)));
   %for j=1:size(X1,1)
    %   plot(X1(j,1),X1(j,2),'bx','MarkerSize',1000*W1(j));
    %end;
   
   plot(X(find((Y==0)&(Correct==1)),1),X(find((Y==0)&(Correct==1)),2),'bx','MarkerSize',5);
   hold on;
   plot(X(find((Y==0)&(Correct==0)),1),X(find((Y==0)&(Correct==0)),2),'bx','MarkerSize',10);
   hold on;
   %X2=X(find(Y==1),:);
   %W2=W(find(Y==1));
   %for j=1:size(X2,1)
     %  plot(X2(j,1),X2(j,2),'ro','MarkerSize',1000*W2(j));
     %end;
   %plot(X(find(Y==1),1),X(find(Y==1),2),'ro','MarkerSize',5000*W(find(Y==1)));
   plot(X(find((Y==1)&(Correct==1)),1),X(find((Y==1)&(Correct==1)),2),'ro','MarkerSize',5);
   hold on;
   plot(X(find((Y==1)&(Correct==0)),1),X(find((Y==1)&(Correct==0)),2),'ro','MarkerSize',10);
   
   plot([thresh*C(1) thresh*C(1)+10*p*C(1)],[thresh*C(2) thresh*C(2)+10*p*C(2)],'g','LineWidth',1);
   plot(thresh*C(1)+10*[-C(2) C(2)], thresh*C(2)+10*[C(1) -C(1)],'k','LineWidth',2);
   plot(thresh*C(1),thresh*C(2),'.k','MarkerSize',20);
   hold off
   title(['Data and classifier.Green line away from pos. ex. p=' num2str(p)]);

   subplot(1,2,2);
   plot(max(P_cum)-P_cum,'r','LineWidth',5);
   hold on;
   plot(N_cum,'b','LineWidth',5);
   plot(PN_cum,'k','LineWidth',1);
   hold off;
  
 pause(0.1)
 
  
   %title(['Cumulative weighted errors for positive (red) and negative' ...
	 % ' (blue) examples']);

end;

%pause