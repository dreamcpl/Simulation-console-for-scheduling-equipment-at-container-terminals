function [ChkTab,RepCwi]=Sim_YCDSS(ChkTab,RepCwi)
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%%%新版DSS，实现以行驶时间为依据的YC动态调度策略
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(ChkTab(1).EqpNeed) && ~isempty(find(ChkTab(2).State(:,1)==4))
   S4YCnum=find(ChkTab(2).State(:,1)==4);         %找到所有状态为4的YC编号YCnum
   for i=1:size(S4YCnum,1)
        YCnum=S4YCnum(i,1);          %读取第i台状态为4的YC编号
        MovTim=Sim_Cite_MvTmCl_YC(ChkTab,YCnum);  %计算行驶时间
        S4YCnum(i,2)=MovTim;         %存储行驶时间的计算结果
   end
   [~,seq]=min(S4YCnum(:,2));        %输出最大值对应的行数
   BestYC=S4YCnum(seq,1);            %最好的场桥编号
   ChkTab(1).EqpNeed(1,5)=BestYC;                %把第一台有需求的QC的需求对象修改为BestYC
   NeedInfo=ChkTab(1).EqpNeed(1,:);               %在染色体中查找到对应的条目
   LineNum=find(RepCwi(1,:)==NeedInfo(1,2) & RepCwi(2,:)==NeedInfo(1,3));
   RepCwi(4,LineNum)=BestYC;                        %将对应条目中的YC需求对象修改为BestYC
end

    
    