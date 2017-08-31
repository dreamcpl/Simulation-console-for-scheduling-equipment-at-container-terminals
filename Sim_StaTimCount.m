function ChkTab=Sim_StaTimCount(ChkTab,Para,Static)
%%%%%%%%%%%%%%%%%%程序整体思路%%%%%%%%%%%%%%%%%%
%本模块用于统计各设备处于各状态的时间，间接服务于设备作业成本的计算过程。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%统计各岸桥个状态时间
for i=1:Para(1).Sum
     %%状态0和状态2算是等待
     if ChkTab(1).State(i,1)==0 || ChkTab(1).State(i,1)==2
        ChkTab(1).StaTim(i,1)=ChkTab(1).StaTim(i,1)+Static.Accu;
      %%状态1算是行驶
     elseif ChkTab(1).State(i,1)==1
        ChkTab(1).StaTim(i,2)=ChkTab(1).StaTim(i,2)+Static.Accu;
     %%状态3算是执行任务
     elseif ChkTab(1).State(i,1)==3
        ChkTab(1).StaTim(i,3)=ChkTab(1).StaTim(i,3)+Static.Accu;
     end
end
%%%%统计各场桥个状态时间
for i=1:Para(2).OutSum
     %%状态4和状态2算是等待
     if ChkTab(2).State(i,1)==4 || ChkTab(2).State(i,1)==2
        ChkTab(2).StaTim(i,1)=ChkTab(2).StaTim(i,1)+Static.Accu;
      %%状态1算是行驶
     elseif ChkTab(2).State(i,1)==1
        ChkTab(2).StaTim(i,2)=ChkTab(2).StaTim(i,2)+Static.Accu;
     %%状态3算是执行任务
     elseif ChkTab(2).State(i,1)==3
        ChkTab(2).StaTim(i,3)=ChkTab(2).StaTim(i,3)+Static.Accu;
     end
end
%%%%统计各集卡各状态时间
for i=1:Para(3).Sum
     %%统计等待时间
     if ChkTab(3).State(i,1)==0 || ChkTab(3).State(i,1)==12 || ChkTab(3).State(i,1)==22 || ChkTab(3).State(i,1)==24 ...
                 || ChkTab(3).State(i,1)==32 || ChkTab(3).State(i,1)==42 || ChkTab(3).State(i,1)==6
        ChkTab(3).StaTim(i,1)=ChkTab(3).StaTim(i,1)+Static.Accu;
      %%统计空车行驶时间
     elseif ChkTab(3).State(i,1)==11 || ChkTab(3).State(i,1)==30 || ChkTab(3).State(i,1)==31 || ChkTab(3).State(i,1)==50
        ChkTab(3).StaTim(i,2)=ChkTab(3).StaTim(i,2)+Static.Accu;
     %%统计满载行驶时间
     elseif ChkTab(3).State(i,1)==21 || ChkTab(3).State(i,1)==41
        ChkTab(3).StaTim(i,3)=ChkTab(3).StaTim(i,3)+Static.Accu;
        %%统计装卸作业时间
     elseif ChkTab(3).State(i,1)==13 || ChkTab(3).State(i,1)==23 || ChkTab(3).State(i,1)==33 || ChkTab(3).State(i,1)==43
        ChkTab(3).StaTim(i,4)=ChkTab(3).StaTim(i,4)+Static.Accu;
     end
end