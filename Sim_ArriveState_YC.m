function ChkTab=Sim_ArriveState_YC(ChkTab,Para,Static)
%%
for i=1:Para(2).OutSum
    if ChkTab(2).State(i,1)==1         %行驶状态
      if ChkTab(2).Positn{1,5}(i,1)==1   %场桥在箱区内移动（即任务内移动）
           if ChkTab(2).State(i,1)==1 && ChkTab(2).Positn{1,4}(i,1)==0     %处于行驶状态  并且  没有被其他YC干扰
             if ChkTab(2).Positn{1,2}(i,2)>ChkTab(2).Positn{1,1}(i,2)      %向右行驶
                if ChkTab(2).Positn{1,2}(i,2)-ChkTab(2).Positn{1,1}(i,2)-Static.BaySecYC*Static.Accu>0
                   ChkTab(2).Positn{1,1}(i,2)=ChkTab(2).Positn{1,1}(i,2)+Static.BaySecYC*Static.Accu;
                else
                   ChkTab(2).State(i,1)=2;            %等待集卡
                   ChkTab(2).Positn{1,3}(i,1)=0;  %重置位置计时器
                end
             elseif ChkTab(2).Positn{1,2}(i,2)<ChkTab(2).Positn{1,1}(i,2)  %向左行驶
                if ChkTab(2).Positn{1,1}(i,2)-ChkTab(2).Positn{1,2}(i,2)-Static.BaySecYC*Static.Accu>0
                   ChkTab(2).Positn{1,1}(i,2)=ChkTab(2).Positn{1,1}(i,2)-Static.BaySecYC*Static.Accu;
                else
                   ChkTab(2).State(i,1)=2;   %等待集卡
                   ChkTab(2).Positn{1,3}(i,1)=0;  %重置位置计时器
                end
             elseif ChkTab(2).Positn{1,2}(i,2)==ChkTab(2).Positn{1,1}(i,2) %同一位置行驶
                      ChkTab(2).State(i,1)=2;   %等待集卡
                      ChkTab(2).Positn{1,3}(i,1)=0;  %重置位置计时器
             end
          elseif ChkTab(2).State(i,1)==2     %等待YT状态
                   ChkTab(2).Positn{1,3}(i,1)=ChkTab(1).Positn{1,3}(i,1)+Static.Accu;                   
          end
      elseif ChkTab(2).Positn{1,5}(i,1)==2    %场桥在箱区间移动（即任务间移动）
           if ChkTab(2).State(i,2)>=ChkTab(2).State(i,3)   %预计时间已经到达
               %%设备位置信息更新（目标箱区最左贝位）
               ChkTab(2).Positn{1,1}(i,1)=ChkTab(2).Positn{1,2}(i,1);
               ChkTab(2).Positn{1,1}(i,2)=ChkTab(2).Positn{1,2}(i,2);  %直接按到达了目标贝位进行处理，但并不是等待YT状态
               ChkTab(2).Positn{1,3}(i,1)=0;  %重置位置计时器
               ChkTab(2).Positn{1,5}(i,1)=1;  %移动模式变为箱区内移动
           end
      end
    end
end

