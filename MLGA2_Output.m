function OutPut=MLGA2_Output(Cmi,MLGA,FG,SG,Bwi,Swi,Para,Cost,Glob)
%%%%%%%%%%%%%%%%%%%%%注释%%%%%%%%%%%%%%%%%%%%%
%！！！！！！！！具体函数用法等内容，请滑动到最下面进行查看！！！！！！！
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global LastBestTime
OutPut=1;
% LastBestTime=0;             %记录最佳纪录产生的时间
LastBestGeneration=1;    %记录最佳纪录产生的代
%%
%%%%选出最佳染色体
ObVal=zeros(1,MLGA(1).ChmSum);
for i=1:MLGA(1).ChmSum
     ObVal(1,i)=Cmi{5,i}(1,3);
end
[~,pos]=min(ObVal);
BestInfo=Cmi(:,pos); %转移最佳染色体所有信息
%%
%%%%%%%%对第一代进行处理
if FG==1 && SG==1 %另建一个txt记录每代最佳值
    LastBestTime=toc; %记录最佳纪录产生的时间
    dlmwrite('OutputResult\BestQCwi.txt',BestInfo{4,1},'delimiter','\t');
    dlmwrite('OutputResult\BestYCwi.txt',BestInfo{3,1},'delimiter','\t');
    TBest=[FG,SG,BestInfo{5,1},floor(toc)];
    dlmwrite('OutputResult\BestQbjVal.txt',TBest,'delimiter','\t');
    dlmwrite('OutputResult\Output.txt',TBest,'delimiter','\t');
    return
end
%%
BestObjVal=textread('OutputResult\BestQbjVal.txt');
BestSumVal=BestObjVal(1,3);
NewBestSumVal=BestInfo{5,1}(1,3);
if NewBestSumVal<BestSumVal
    LastBestTime=toc; %记录最佳纪录产生的时间
    LastBestGeneration=FG;
    dlmwrite('OutputResult\BestQCwi.txt',BestInfo{4,1},'delimiter','\t');
    dlmwrite('OutputResult\BestYCwi.txt',BestInfo{3,1},'delimiter','\t');
    TBest=[FG,SG,BestInfo{5,1},floor(toc)];
    dlmwrite('OutputResult\BestQbjVal.txt',TBest,'delimiter','\t');
    dlmwrite('OutputResult\Output.txt',TBest,'-append','delimiter','\t');
else
    TBest=[FG,SG,BestObjVal(1,3:end-1),floor(toc)];
    dlmwrite('OutputResult\Output.txt',TBest,'-append','delimiter','\t');
    PresentTime=toc;
    if PresentTime-LastBestTime>=10800     %如果连续3个小时不进化到更好结果
        OutPut=2;                                             %没有产生更好的结果，就让程序结束
        return
    end
end