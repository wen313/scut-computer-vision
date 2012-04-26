function [R,err,H]=Toy	


DEBUG = 0;
	
NumPts=100;
%generate data 
X0=0;
Y0=0;
R0=10;
X=zeros(1,NumPts);
Y=zeros(1,NumPts);
noise=0.05;
ro=R0*rand(1,NumPts);
fi=2*pi*rand(1,NumPts);
X=X0+ro.*cos(fi);
Y=Y0+ro.*sin(fi);
r=R0;

%X1=1.5*X0+(r+ro).*cos(fi);
%Y1=1.5*Y0+(r+ro).*sin(fi);

roo=R0*rand(1,3*NumPts);
fii=4*pi*rand(1,3*NumPts)/2;

X1=X0+(r+roo).*cos(fii);
Y1=Y0+(r+roo).*sin(fii);

if DEBUG 
   
   figure(15);clf;title('Original data'); plot(X,Y,'ro');axis([-100,100,-100,100]);
   hold on; plot(X1,Y1,'bx');hold off;
end;

%NumFeatures=8;
Q=1;
K=8;
for i=1:K
   Features(i,1)=Q*sin(pi*i/K);
   Features(i,2)=-Q*cos(pi*i/K);
end;

  
Features

PE=[X;Y]'
NE=[X1;Y1]'

%PE
%pause

E=[PE' , NE']';
%E
%pause

%VE=[VPE',VNE']';
YY=[ones(1,size(X,2)),zeros(1,size(X1,2))];
%VY=[ones(1,Np-Kp),zeros(1,Nn-Kn)];

Iter=15;
Iter
[R,err,H,alpha]=TestAdaBoost(E,YY,Features,Iter,E,YY,'ROC');	



figure(16);clf;
hold on
for i=1:size(X,2)
   if (R(i)==1)
      plot(X(i),Y(i),'ro');
   else
       plot(X(i),Y(i),'co');
   end;
   if (R(i+size(X,2))==0)
      plot(X1(i),Y1(i),'bx');
   else
      plot(X1(i),Y1(i),'gd');
   end;
   axis([-100,100,-100,100]);
end;

hold off;


figure(17);clf;
hold on
for i=1:size(X,2)
   if (R(i)==1)
      plot(X(i),Y(i),'ro');
   else
       plot(X(i),Y(i),'co');
   end;
   if (R(i+size(X,2))==0)
      plot(X1(i),Y1(i),'bx');
   else
      plot(X1(i),Y1(i),'gd');
   end;
   axis([-100,100,-100,100]);
end;

hold off;
%draw decision surfaces
figure (17)
hold on;

%plotting of bry
num_hyp=size(H,2)
k=30;
for i=1:num_hyp

    C=H{i}{3};
    thresh=H{i}{1};
    %plot([0 -k*C(2)], [0,k*C(1)],'k','LineWidth',2)
    ;plot(thresh*C(1)+10*[-C(2) C(2)], thresh*C(2)+10*[C(1) -C(1)],'k','LineWidth',1);
plot(thresh*C(1),thresh*C(2),'.k','MarkerSize',10);
    
end;
hold off;

%draw decision surfaces
figure (16)
hold on;
%uncomment if you want to see the decision bry, a bit slow...
%plot_bry(H,alpha,E,16);



%plot boundary
function [dec]=plot_bry(H,alpha,X,fig)

left=min(X(:,1));
right=max(X(:,1));
top=max(X(:,2));
bottom=min(X(:,2));

left=min(left,bottom);
right=max(right,top);
u=[left:0.1:right];
%u=[-2.1:0.05:2.1];%-2.1 2.1])
v=u;
dec=zeros(size(u,2),size(v,2));
for i=1:size(u,2)
    for j=1:size(v,2)
        x0=[u(i),v(j)];
        [y_res]=StrongClassify(x0,H,alpha,'ROC');	
        dec(j,i)=2*y_res-1; 
    end;
end;
figure(fig);hold on;contour(u,v,dec,[0 0]);


