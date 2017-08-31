function SimRzt=Sim_Output(ChkTab,Para,T,Finval,Cost)
%%
%SimRzt is a structure array. It is used to store the results outputed by
%the evaluation. 
%(*)SimRzt.Makespan
%(*)SimRzt.CostSum
%(*)SimRzt.CmpSum
%(*)SimRzt.QCUtRo
%(*)SimRzt.YCUtRo
%(*)SimRzt.YTUtRo
%%
%%%%%%%%计算成本结果
%%%%浮动成本=等待惩罚成本+移动行驶成本
CostSum=0;
%%统计QC成本
for i=1:Para(1).Sum
    CostSum=CostSum+Cost(1).Wait*ChkTab(1).StaTim(i,1)+Cost(1).Travel*ChkTab(1).StaTim(i,2);
end
%%统计YC成本
for i=1:Para(2).Sum
   CostSum=CostSum+Cost(2).Wait*ChkTab(2).StaTim(i,1)+Cost(2).Travel*ChkTab(2).StaTim(i,2);
end
%%统计YT成本
for i=1:Para(3).Sum
   CostSum=CostSum+Cost(3).Wait*ChkTab(3).StaTim(i,1)+Cost(3).Travel*ChkTab(3).StaTim(i,2);
end
%%%%固定成本
%%设备使用数量折算
CostFixEqp=Para(1).Sum*Cost(1).UitFix+Para(2).OutSum*Cost(2).UitFix+Para(3).Sum*Cost(3).UitFix;
% CostFixEqp=Para(3).Sum*Cost(3).UitFix;
% CostFixEqp=0;
%%集装箱服务数量折算
CostFixCon=(Cost(1).LCon+Cost(2).LCon)*213;
%%总成本计算
SimRzt.CostSum=CostSum+CostFixEqp+CostFixCon;
% SimRzt.CostSum=CostSum+CostFixEqp;
%%
%设备利用率计算
SimRzt.QCUtRo=floor(1000*sum(ChkTab(1).StaTim(:,3))/(sum(ChkTab(1).StaTim(:,1))+sum(ChkTab(1).StaTim(:,2)) ...
    +sum(ChkTab(1).StaTim(:,3))))/10;
SimRzt.YCUtRo=floor(1000*sum(ChkTab(2).StaTim(:,3))/(sum(ChkTab(2).StaTim(:,1))+sum(ChkTab(2).StaTim(:,2)) ...
    +sum(ChkTab(2).StaTim(:,3))))/10;
SimRzt.YTUtRo=floor(1000*(sum(ChkTab(3).StaTim(:,3))+sum(ChkTab(3).StaTim(:,4)))/(sum(ChkTab(3).StaTim(:,1)) ...
    +sum(ChkTab(3).StaTim(:,2))+sum(ChkTab(3).StaTim(:,3))+sum(ChkTab(3).StaTim(:,4))))/10;
%%
%%%%计算时间结果
if Finval==2
   SimRzt.Makespan=80000;
   SimRzt.CostSum=100000000;
   SimRzt.QCUtRo=0;
   SimRzt.YCUtRo=0;
   SimRzt.YTUtRo=0;
else
   SimRzt.Makespan=T;
end
%%
%%%%多目标结果求和
SimRzt.CmpSum=(1-Cost(1).Rate)*SimRzt.Makespan+Cost(1).Rate*SimRzt.CostSum;
