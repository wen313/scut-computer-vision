disp('......')
load('W.mat')
load('B.mat')
load('LowDimFacesFeature.mat')
rr = 0;
rw = 0;
for j = 1 : 1: 50
    for i = 1:1:200
         if( 1 == Sign(W(j,:), LowDimFacesFeature(i,:), B(j,:)) && i <= 35 && i >= 31 )
             %display('�Ե��ж϶��ˣ�����');
             rr = rr + 1;
             disp('���ű�ʶ��');
             disp(i);
         elseif(-1 == Sign(W(j,:), LowDimFacesFeature(i,:), B(j,:)) && (i > 35 || i < 31))
            %display('����ж϶��ˣ�����');
            rw = rw + 1;
         end
    end
str = 'No:';
str = strcat(str, num2str(j)); 
disp(str);
disp(rw);
disp(rr);
str = '';
disp('...........')
rw = 0;
rr = 0;
end
