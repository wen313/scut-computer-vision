global myim;
global mypath;
global myisvalid;
global textResult;

mypath = '';
disp(mypath);

screen = get(0, 'ScreenSize');
W = screen(3); H = screen(4);
figure('Color', [1,1,1], 'Position', [0.2*W, 0.2*H, 0.5*W, 0.5*H], ...
    'Name', 'XXBoost', 'NumberTitle', 'off', 'MenuBar', 'none');

% ����ͼƬ��ť
btnLoadImg = uicontrol(gcf, 'Style', 'push', 'Position', ...
    [10,10,120,30], 'String', '����ͼƬ', ...
    'CallBack', 'OnBtnLoadImgClick');

% AdaBoost��ť
btnAda = uicontrol(gcf, 'Style', 'push', 'Position', ...
    [140,10,120,30], 'String', 'AdaBoost', ...
    'CallBack', 'OnBtnAda');

% GentleBoost��ť
btnGen = uicontrol(gcf, 'Style', 'push', 'Position', ...
    [270,10,120,30], 'String', 'GentleBoost');

% �ж��������
textResult = uicontrol(gcf, 'Style', 'text', ...
     'Position', [400,10,200,30]);


%hm = uimenu(gcf, 'Label', 'File');
%hm1 = uimenu(hm, 'Label', 'Save');

