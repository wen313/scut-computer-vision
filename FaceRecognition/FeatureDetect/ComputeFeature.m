function ComputeFeature(k)
% ORL 人脸数据集的主成分分析
%
% 输入：k --- 降至 k 维

% 定义图像高、宽的全局变量 imgRow 和 imgCol，它们在 ReadFaces 中被赋值
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
[LowDimFacesFeature, W] = fastPCA(FaceContainer, k); % 主成分分析PCA
%visualize_pc(W);%显示主成分脸
save('Mat/LowDimFacesFeature.mat', 'LowDimFacesFeature');
display('计算结束。');

