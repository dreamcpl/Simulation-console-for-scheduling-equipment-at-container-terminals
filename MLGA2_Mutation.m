function Cmi=MLGA2_Mutation(MLGA,Para,Cmi)
%%%%%%%%%%%%%%%%%%模块整体思路%%%%%%%%%%%%%%%%%%
%●随机选择变异染色体，概率对比是否进行变异操作。
%●变异过程：随机选择一个岸桥的所有任务，从这些任务中随机选择两个任务，调换
%  位置后，即生成新的染色体。
%●变异后会有解码工作，因为下一步就是仿真过程了。
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%1.选择变异染色体：用随机数选择两个父代染色体，参与变异操作。
%2.变异概率对比。
%3.解码
%4.变异
%5.编码。
%6.结果存储。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%1 变异染色体选择
for i=1:MLGA(1).ChmSum
    %%%%%%%%判断是否进行变异
    pick=rand;
    if pick>MLGA(2).MutPro
       continue;
    end
    %%%%%%%%选择变异个体
    pick=rand;
    while pick==0
          pick=rand;
    end
    index=ceil(pick*MLGA(1).ChmSum);
    Ftr=Cmi{3,index}(4,:);
    %%%%%%%%选择变异位点
    val=ceil(rand*size(Ftr,2));
    %%%%%%%%变异
    Ftr(1,val)=ceil(rand*Para(2).OutSum);
    %%%%%%%%存储
    Cmi{3,index}(4,:)=Ftr;
end