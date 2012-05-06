function OnBtnLoadImgClick()
%FuncInfo None
%NARGINCHK(0,7,nargin,'struct')

global myim;
global mypath;

%╪стьм╪ф╛
[filename, pathname] = uigetfile({'*.pgm;*.jpg;*.bmp;*.png;*.gif', 'м╪ф╛нд╪Ч'});
if isequal(filename, 0)
    disp('Fuck Empty');
    return
end
mypath = [pathname filename];
myim = imread(mypath);
imshow(myim);