function ComputerFeature( d )
% ����ͼ������������ұ���Ϊdά��������
%
% ���룺d --- ���� d ά
global imgRow;
global imgCol;

% ����ÿ���˵�ǰ5��ͼ��
nPerson=40;
nFacesPerPerson = 5;
display('������������...');
[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson,nPerson);
display('..............................');

nFaces=size(FaceContainer,1);%��������������Ŀ
display('PCA��ά...');
% LowDimFaces��200*20�ľ���, ÿһ�д���һ�����ɷ���(��40�ˣ�ÿ��5��)��ÿ����20��ά����
% W�Ƿ���任����, 10304*20 �ľ���
[W1, LowDimFaces1, a] = princomp(FaceContainer);
[LowDimFaces2, W2] = fastPCA(FaceContainer, 20); % ���ɷַ���PCA
visualize_pc(W2);%��ʾ���ɷ���

display('���������');