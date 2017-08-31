function [SimRzt,RepCwi]=Main_Simulation(Para,QCwi,Bwi,Swi,Cwi,Cost,Glob)
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%详细内容请见说明文档
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%输入部分
RepCwi=Cwi;                            %待修复染色体为RepCwi（V1.2增加语句）
%%%%%%%%1.变量声明
[ChkTab,Static]=Sim_VarState(Para);
%%%%%%%%2.设备初始化
[ChkTab,Cwi]=Sim_Initializat_QC(ChkTab,Para,Swi,Bwi,Cwi,QCwi); %（V1.2修改模块）
ChkTab=Sim_Initializat_YC(ChkTab,Para);
ChkTab=Sim_Initializat_YT(ChkTab,Para);
%%
%%%%%%%%3.仿真过程
for T=0:Static.Accu:Static.End      %计时
%     T
    %%%%调试区域
%     if T>10000 & floor(T/200)==T/200
%        OutPut=Test_Print(T,ChkTab,Cwi);
%     end
    %%%%任务分配模块
    [ChkTab,Cwi]=Sim_AssignTask_QC(ChkTab,Para,Bwi,Cwi,QCwi,Swi); %（V1.2修改模块）
    ChkTab=Sim_AssignTask_YC(ChkTab,Para,Swi);
    %%%%设备绑定模块
    ChkTab=Sim_EqipComb_YC(ChkTab,Para);
    ChkTab=Sim_EqipComb_YT(ChkTab,QCwi);
    %%%%到达状态模块
    ChkTab=Sim_ArriveState_QC(ChkTab,Para,Static);
    ChkTab=Sim_ArriveState_YC(ChkTab,Para,Static);
    ChkTab=Sim_ArriveState_YT(ChkTab,Para);    
    %%%%作业惩罚模块
%     ChkTab=Sim_Punishment_QC(ChkTab,Para); %
    [ChkTab,Finval]=Sim_Punishment_YC(ChkTab,Para,Glob);
    if Finval~=0
       break
    end  
    %%%执行判定模块
    ChkTab=Sim_WorkJudge_QC(ChkTab,Para);
    ChkTab=Sim_WorkJudge_YC(ChkTab,Para);
    %%%%进度更新模块
    ChkTab=Sim_ScheduleRenew_QC(ChkTab,Para,Static);
    ChkTab=Sim_ScheduleRenew_YC(ChkTab,Para,Static);
    ChkTab=Sim_ScheduleRenew_YT(ChkTab,Para,Static);
    %%%%需求登记模块
    [ChkTab,Cwi]=Sim_EqipNeed_QC(ChkTab,Para,Cwi,QCwi); %（V1.2修改模块）
    ChkTab=Sim_EqipNeed_YC(ChkTab,Para);
    %%%%染色体修复（V1.2新增模块--YC动态调度）
    [ChkTab,RepCwi]=Sim_YCDSS(ChkTab,RepCwi);  %（V1.2动态调度修复模块）
    %%%%设备状态统计（V1.3新模块），用于计算成本
    ChkTab=Sim_StaTimCount(ChkTab,Para,Static);
    %%%%结束判定模块
    Finval=Sim_EndJudge(ChkTab,Para,T,Static);    
    if Finval~=0
       break
    end    
end
%%
%%%%结果输出
SimRzt=Sim_Output(ChkTab,Para,T,Finval,Cost);