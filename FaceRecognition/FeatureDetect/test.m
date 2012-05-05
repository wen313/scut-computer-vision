function ComputerFeature( d )
% 计算图像的特征，并且保存为d维特征向量
%
% 输入：d --- 降至 d 维
global imgRow;
global imgCol;

% 读入每个人的前5副图像
nPerson=40;
nFacesPerPerson = 5;
display('读入人脸数据...');
[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson,nPerson);
display('..............................');

nFaces=size(FaceContainer,1);%样本（人脸）数目
display('PCA降维...');
% LowDimFaces是200*20的矩阵, 每一行代表一张主成分脸(共40人，每人5张)，每个脸20个维特征
% W是分离变换矩阵, 10304*20 的矩阵
[W1, LowDimFaces1, a] = princomp(FaceContainer);
[LowDimFaces2, W2] = fastPCA(FaceContainer, 20); % 主成分分析PCA
visualize_pc(W2);%显示主成分脸

display('计算结束。');