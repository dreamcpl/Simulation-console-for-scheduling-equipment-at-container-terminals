function JugRst=Main_YCJobJudge(CWI)
%%%%%%%%本模块功能是审查YC任务量，对于任务量差距明显偏大的情况进行剔除
global SYwi
[~,~,~,Para,~]=Main_VarState();
JobMax=max(SYwi(3,:));     %选出单箱区单任务最大值
JobMin=min(SYwi(3,:));      %选出单箱区单任务最小值
JobLine=JobMax*2;
JobAmt=zeros(1,Para(2).OutSum);     %创建各场桥任务量统计数组
for i=1:size(SYwi,2)
      JobAmt(1,CWI(4,i))=JobAmt(1,CWI(4,i))+SYwi(3,i);
end
YCJobMax=max(JobAmt);   %选出作业量最大的场桥
YCJobMin=min(JobAmt);     %选出作业量最小的场桥
YCJobGap=YCJobMax-YCJobMin;
if YCJobGap>JobLine
    JugRst=1;
else
    JugRst=0;
end