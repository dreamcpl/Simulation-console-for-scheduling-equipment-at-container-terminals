function ChkTab=Sim_WorkJudge_QC(ChkTab,Para)
%%
for i=1:Para(1).Sum
   if ChkTab(1).State(i,1)==2  &&   ChkTab(1).Positn(i,4)==0%岸桥处于等待状态并且没有被其它岸桥所阻碍
        YTnum=ChkTab(1).EqpBod{1,2}(i,1); %识别第一辆集卡
        if YTnum~=0
           if ChkTab(1).State(i,4)==1 &&  ChkTab(3).State(YTnum,1)==42          %如果是装船QC，且YT也在等待QC
               ChkTab(1).State(i,1)=3;           %QC变为作业状态
               ChkTab(1).State(i,2)=0;           %计时器归零
               ChkTab(1).State(i,3)=Para(1).Load;
               ChkTab(3).State(YTnum,1)=43;      %YT状态信息表更新
               ChkTab(3).State(YTnum,2)=0;
               ChkTab(3).State(YTnum,3)=Para(3).QCLoad;
           elseif ChkTab(1).State(i,4)==2   &&  ChkTab(3).State(YTnum,1)==12      %如果是卸船QC，且YT也在等待QC
               ChkTab(1).State(i,1)=3;           %QC变为作业状态
               ChkTab(1).State(i,2)=0;           %计时器归零
               ChkTab(1).State(i,3)=Para(1).Unload;
               ChkTab(3).State(YTnum,1)=13;      %YT状态信息表更新
               ChkTab(3).State(YTnum,2)=0;
               ChkTab(3).State(YTnum,3)=Para(3).QCUnload; 
           end
        end
   end
end