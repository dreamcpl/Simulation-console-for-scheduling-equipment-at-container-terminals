function tempinfo=Main_Record(Cmi,i)
%%%%%%%%%%%%%%%%%%程序整体思路%%%%%%%%%%%%%%%%%%
%1.记录最佳染色体信息，并输出。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if i==1
%    tempbox=Cmi(4,:)
%    [val1,pos1]=min(tempbox);
%    tempinfo=Cmi(:,pos1);
% else
%    tempbox=Cmi(4,:);
%    [val2,pos2]=min(tempbox);
%    if val2<val1
%       tempinfo=Cmi(:,pos2);
%    end
% end
tempinfo=0
