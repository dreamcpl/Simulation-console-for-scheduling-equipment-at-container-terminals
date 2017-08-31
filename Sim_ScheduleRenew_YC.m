function ChkTab=Sim_ScheduleRenew_YC(ChkTab,Para,Static)
%%
for i=1:Para(2).OutSum
    ChkTab(2).State(i,2)=ChkTab(2).State(i,2)+Static.Accu;                        %状态计时器增加时间步长
    ChkTab(2).Positn{1,3}(i,1)=ChkTab(2).Positn{1,3}(i,1)+Static.Accu;   %位置计时器增加时间步长
    if ChkTab(2).State(i,1)==3            %当前YC处于作业状态
        if ChkTab(2).State(i,2)>=ChkTab(2).State(i,3)  %若作业时间满足了规定要求
           ChkTab(2).State(i,1)=0;          %状态变为0，即准备状态
           ChkTab(2).State(i,2)=0;          %计时器归0
           ChkTab(2).State(i,3)=0;          %预计状态变化所需时间也为0
        end 
    end    
end




    
    
    