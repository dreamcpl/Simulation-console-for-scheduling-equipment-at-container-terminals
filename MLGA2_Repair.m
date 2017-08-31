function Cmi=MLGA2_Repair(Cmi,MLGA,Para)
%%%%%%%%%%%%%%%%%%程序整体思路%%%%%%%%%%%%%%%%%%
%不同于以往修复操作规定：将每条染色体都进行修复，直达满足特定范围要求即可，
%此次所提出修复操作借鉴遗传算法遗传操作所规定的遗传操作概率，对存在问题的个
%体按照一定的概率进行修复，一直修复到不能更加均衡为之。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:MLGA(1).ChmSum
        %%%%%%%%判断是否进行变异
        pick=rand;
        if pick>MLGA(2).RepPro
           continue;
        end
        %%%%%%%%选择修复个体
        pick=rand;
        while pick==0
              pick=rand;
        end
        index=ceil(pick*MLGA(1).ChmSum);
        %%%%%%%%修复操作
        RId=Cmi{3,index};
        NRId=RId;
        Gap=10000;
        while 1
              %%%%统计各场桥的作业量
              JobSum=zeros(Para(2).OutSum,1);
              for j=1:size(RId,2)
                   JobSum(RId(4,j),1)=JobSum(RId(4,j),1)+RId(3,j);
              end
              NGap=max(JobSum)-min(JobSum);
              %%%%如果修复操作减小了作业量差，则用新的结果替代旧的结果
              if NGap<Gap
                 Gap=NGap;
                 RId=NRId;
                 [~,MinYCNum]=min(JobSum);
                 [~,MaxYCNum]=max(JobSum);
                 %%%%从染色体中随机读列
                 order=randperm(size(RId,2));
                 %%%%找到第一个作业最多的YC的列，就替换成最少的YC的列
                 for k=1:size(RId,2)
                       if RId(4,order(1,k))==MaxYCNum
                           RId(4,order(1,k))=MinYCNum;
                           break
                       end
                 end
                 NRId=RId;
              else
                  break
              end
        end
        %%%%%%%%存储修复结果
        Cmi{3,index}=RId;
end