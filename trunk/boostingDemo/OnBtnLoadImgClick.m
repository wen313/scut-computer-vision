function OnBtnLoadImgClick()
%FuncInfo None
%NARGINCHK(0,7,nargin,'struct')

global myim;
global mypath;

%����ͼƬ
[filename, pathname] = uigetfile({'*.pgm;*.jpg;*.bmp;*.png;*.gif', 'ͼƬ�ļ�'});
if isequal(filename, 0)
    disp('Fuck Empty');
    return
end
mypath = [pathname filename];
myim = imread(mypath);
imshow(myim);