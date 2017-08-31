function [ChkTab,Cwi]=Sim_AssignTask_QC(ChkTab,Para,Bwi,Cwi,QCwi,Swi)
%%
for i=1:Para(1).Sum
    if ChkTab(1).State(i,1)==4
       continue
    elseif ChkTab(1).State(i,1)==0    %状态0直接变为状态2
       ChkTab(1).State(i,1)=2; 
    elseif ChkTab(1).State(i,1)==2
       %如果既没有YC与当前QC绑定，也没有YT与当前QC绑定，就需要考虑给当前QC安排任务了。
       if isempty(find(ChkTab(1).EqpBod{1,1}(:,1)==i)) && isempty(find(ChkTab(3).EqpBod(:,3)==i))
           %对YC的需求表里面也没有当前QC的需求登记，那就说明当前任务已经完成了，需要切换到下一个任务了。
           if isempty(ChkTab(1).EqpNeed) || isempty(find(ChkTab(1).EqpNeed(:,1)==i))
              ChkTab(1).Progrs(i,1)=ChkTab(1).Progrs(i,1)+1;    %任务读取计数器+1
              jobnum=QCwi(i,ChkTab(1).Progrs(i,1));                  %读取任务编号              
           else %如果对YC的需求表里面有当前QC的需求登记，那就等着到Sim_AssignTask_YC模块里面安排YC了。
              continue
          end
          if jobnum==0   %如果编号是0，说明是截止符，已经完成了所有既定任务
             ChkTab(1).State(i,1)=4;
             ChkTab(1).State(i,4)=0;
          else
              %变为行驶状态
              ChkTab(1).State(i,1)=1;     %行驶状态
              ChkTab(1).State(i,2)=0;     %状态变化计时器归零
              %目标位置改变
              tempinfo=Bwi(find(Bwi(:,1)==jobnum),:);
              ChkTab(1).Positn(i,2)=tempinfo(1,2);
              ChkTab(1).Positn(i,3)=0;   %到达计时器归零
          end
       end
    end
end