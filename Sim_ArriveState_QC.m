function ChkTab=Sim_ArriveState_QC(ChkTab,Para,Static)
%%
for i=1:Para(1).Sum
    if ChkTab(1).State(i,1)==1         %行驶状态
       if ChkTab(1).Positn(i,2)>ChkTab(1).Positn(i,1)      %向右行驶
          if ChkTab(1).Positn(i,2)-ChkTab(1).Positn(i,1)-Static.BaySecYC*Static.Accu>0
             ChkTab(1).Positn(i,1)=ChkTab(1).Positn(i,1)+Static.BaySecYC*Static.Accu;
          else
             ChkTab(1).Positn(i,1)=ChkTab(1).Positn(i,2);
             ChkTab(1).State(i,1)=2;   %等待集卡
             ChkTab(1).Positn(i,3)=0;  %重置位置计时器
          end
       elseif ChkTab(1).Positn(i,2)<ChkTab(1).Positn(i,1)  %向左行驶
          if ChkTab(1).Positn(i,1)-ChkTab(1).Positn(i,2)-Static.BaySecYC*Static.Accu>0
             ChkTab(1).Positn(i,1)=ChkTab(1).Positn(i,1)-Static.BaySecYC*Static.Accu;
          else
             ChkTab(1).Positn(i,1)=ChkTab(1).Positn(i,2);
             ChkTab(1).State(i,1)=2;   %等待集卡
             ChkTab(1).Positn(i,3)=0;  %重置位置计时器
          end
       elseif ChkTab(1).Positn(i,2)==ChkTab(1).Positn(i,1) %同一位置行驶
          ChkTab(1).State(i,1)=2;   %等待集卡
          ChkTab(1).Positn(i,3)=0;  %重置位置计时器
       end
    end
end

