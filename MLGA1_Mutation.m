function Cmi=MLGA1_Mutation(MLGA,Para,Cmi)
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
    %%%%%%%%变异染色体选择
for i=1:MLGA(1).ChmSum
    pick=rand;
    while pick==0
          pick=rand;
    end
    index=ceil(pick*MLGA(1).ChmSum);
    %%%%%%%%判断是否进行变异
    pick=rand;
    if pick>MLGA(1).MutPro
       continue;
    end
    %%%%%%%%变异
    QCnum=ceil(rand*Para(1).Sum);  %随机选一台岸桥
    JA=Cmi{4,i}(QCnum,:);          %挑出岸桥任务编码 
    JA(JA==0)=[];                  %去掉里面的0
    pick=rand(1,2);                %随机选两个变异点
    index=ceil(pick.*size(JA,2));  %换算成染色体编号
    Object=Fun_ChangePos(JA,index(1),index(2));%交换元素位置
    Cmi{4,i}(QCnum,1:size(JA,2))=Object;        %岸桥任务安排放回去
end