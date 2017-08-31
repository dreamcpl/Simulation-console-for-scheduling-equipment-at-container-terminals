function [ChkTab,Cwi]=Sim_Initializat_QC(ChkTab,Para,Swi,Bwi,Cwi,QCwi)
%%
ChkTab(1).EqpBod{1,1}=zeros(1,3);                    %不让QC:YC表为空，方便后来作业判定
ChkTab(1).EqpBod{1,2}=zeros(Para(1).Sum,1);  %不让QC:YT表为空，方便后来作业判定
for i=1:Para(1).Sum
      ChkTab(1).Progrs(i,1)=1;
      jobnum=QCwi(i,1); %这里不考虑QC的第一个任务就是0的情况，因为这明显是差解。
      tempinfo=Bwi(find(Bwi(:,1)==jobnum),:);
      %位置直接更新到第一个任务的贝位处（以后可以考虑出场位置）
      ChkTab(1).Positn(i,2)=tempinfo(1,2);
      ChkTab(1).Positn(i,1)=ChkTab(1).Positn(i,2);
      %装卸属性更新
      ChkTab(1).State(i,4)=tempinfo(1,4);
end