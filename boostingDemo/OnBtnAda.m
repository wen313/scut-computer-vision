function OnBtnAda()
%lala

global myim;
global mypath;
global myisvalid;
global textResult;

disp(mypath);
o1 = regexp(mypath, '\\s[0-9]+\','match');
%o1 = regexp(o1[0], '[0-9]+', 'match');
disp(o1);

if (isequal(mypath,''))
    myisvalid = 1;
    set(textResult, 'String', 'ʶ��ɹ�');
else
    myisvalid = 0;
    set(textResult, 'String', 'ʶ��ʧ��');
end
