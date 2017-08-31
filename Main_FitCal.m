function Cmi=Main_FitCal(Cmi,Para,MLGA,Bwi,Swi,Cost,Glob)
%%%%%%%%%%%%%%%%%%程序整体思路%%%%%%%%%%%%%%%%%%
%旧染色体的适应度信息需要被清空，筛选不合格的个体，会先被填上信息，依然
%空着的个体是通过筛选，可以被计算的个体。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%将所有旧染色体的适应度值等信息清空
for i=1:MLGA(1).ChmSum
      Cmi{5,i}=[];      Cmi{6,i}=[];       Cmi{7,i}=[]; 
end
%%%%计算仿真结果 
for i=1:MLGA(1).ChmSum
     if isempty(Cmi{5,i})   %若是通过筛选的染色体，才能参与计算
        CWI=Cmi{3,i};
        QCwi=Cmi{4,i};
        %计算调度结果
        [SimRzt,RepCwi]=Main_Simulation(Para,QCwi,Bwi,Swi,CWI,Cost,Glob); %仿真模块（V1.2）
        Temp=[SimRzt.Makespan SimRzt.CostSum SimRzt.CmpSum SimRzt.QCUtRo SimRzt.YCUtRo SimRzt.YTUtRo];
        Cmi{3,i}=RepCwi;          %V1.2增加代码
        Cmi{5,i}=Temp;
        Cmi{6,i}=1/SimRzt.CmpSum;
     end
end
%%%%计算适应度和
FitSum=0;
for i=1:MLGA(1).ChmSum
    FitSum=Cmi{6,i}+FitSum;
end
%%%%计算适应度占比
for i=1:MLGA(1).ChmSum
    Cmi{7,i}=Cmi{6,i}/FitSum;
end