clc;clear;tic
%%
%%%%%%%%%%%%%%%%%%程序假设条件%%%%%%%%%%%%%%%%%%
%1.假设各岸桥要处理的任务信息（任务数量、任务编号、集装箱数量）已知。
%2.假设出口箱堆存位置信息已知。
%3.假设岸桥移动不需要时间。
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%1.防重模块：防止相同染色体再次计算，因此应当包含染色体记录功能
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%一、变量声明
global Bwi Swi SYwi TskCod JobCod QCRec YCRec
dlmwrite('OutputResult\AverageResultSum.txt',0,'delimiter','\t');
QCRec=[];
YCRec=cell(1,3);
[Cmi,MLGA,Glob,Para,Cost]=Main_VarState();
Bwi=textread('船舶任务信息.txt');
EX=importdata('岸桥任务信息.txt');  QCwi=EX.data;
TskCod=textread('船舶任务坐标.txt');
Swi=textread('堆场任务信息.txt');
JobCod=textread('堆场任务坐标.txt');
SYwi=textread('简化堆场任务信息.txt');
%%%%%%%%二、调度作业流程
Cmi=Main_Firgen(Cmi,MLGA,Para,QCwi); %生成初始种群
% for i=1:MLGA(1).Iter  %模式1：规定迭代次数
i=0;  while 1 ;  i=i+1;       %模式2：配合MLGA2_Output，形成规定不收敛迭代时间
        Cmi=Main_UndChrom(Cmi,MLGA,Para,SYwi); %下层染色体生成
        for j=1:MLGA(2).Iter
                Cmi=Main_FitCal(Cmi,Para,MLGA,Bwi,Swi,Cost,Glob);
                OutPut=MLGA2_Output(Cmi,MLGA,i,j,Bwi,Swi,Para,Cost,Glob);
                if OutPut==2               %如果难以收敛，那就提前结束
                    return
                end
                Cmi=MLGA2_Select(MLGA,Cmi);
                Cmi=MLGA2_Cross(MLGA,Cmi);              %下层交叉模块
                Cmi=MLGA2_Mutation(MLGA,Para,Cmi); %下层变异模块
        end
        Cmi=MLGA1_Select(MLGA,Cmi);           %选择模块
        Cmi=MLGA1_Cross(MLGA,Para,Cmi);    %上层交叉模块
        Cmi=MLGA1_Mutation(MLGA,Para,Cmi); %上层变异模块       
        Cmi=MLGA1_Encode(Cmi,MLGA);          %变化后的岸桥任务重新编码
end