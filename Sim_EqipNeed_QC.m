function [ChkTab,Cwi]=Sim_EqipNeed_QC(ChkTab,Para,Cwi,QCwi)
%%
global Bwi
for i=1:Para(1).Sum
   %%若能从需求表中找到当前QC编号，说明已经登记上了
   if ~isempty(ChkTab(1).EqpNeed) && ~isempty(find(ChkTab(1).EqpNeed(:,1)==i))
      continue
   end
   %%若不能从染色体中找到任务编号，说明已经登记过对YC的需求表了
   jobnum=QCwi(i,ChkTab(1).Progrs(i,1));
   if isempty(find(Cwi(1,:)==jobnum))
      continue
   end
   %%如果还能够在染色体中找到任务编号，说明还有需要登记到YC需求表中的信息
    temp=Cwi(:,find(Cwi(1,:)==jobnum));
    temp=temp';
    temp=temp(1,:); %有时会因为一台岸桥两个箱区都对应某台场桥，结果出现重复登记的现象，必须限制一次登记一条信息
    LDC=Bwi(find(Bwi(:,1)==jobnum),4);
    LDC=LDC(1,:);
    QCnum=i;
    temp=[QCnum,temp,LDC];
    ChkTab(1).EqpNeed=[ChkTab(1).EqpNeed;temp];
    Cwi(:,find(Cwi(1,:)==temp(1,2) & Cwi(2,:)==temp(1,3)))=[]; %避免一次删除过多任务（任务号和箱区号能够唯一确定一条任务信息）
end