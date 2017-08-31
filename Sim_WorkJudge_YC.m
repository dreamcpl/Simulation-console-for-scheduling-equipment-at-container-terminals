function ChkTab=Sim_WorkJudge_YC(ChkTab,Para)
%%
%%%%当前模块最好是放在punishment_YC模块后面起作用，因为punishment_YC模块实时标记YC被阻碍状态
for i=1:Para(2).OutSum
    %只有当   YC已经在等待YT了  并且  YC不是被阻碍状态   才能执行作业    
        if ChkTab(2).State(i,1)==2 && ChkTab(2).Positn{1,4}(i,1)==0   %场桥已经在等待YT，并且没有受到干扰
           YTnum=ChkTab(2).EqpBod(i,1);     %读取绑定的第一辆YT的编号
               if YTnum~=0                    %若YC绑定了YT
                      if ChkTab(2).State(i,4)==1 && ChkTab(3).State(YTnum,1)==32       %若是装船YC且YT在等待YC
                         ChkTab(2).State(i,1)=3;                        %YC开始执行作业
                         ChkTab(2).State(i,2)=0;                                  
                         ChkTab(2).State(i,3)=Para(2).Load;
                         ChkTab(3).State(YTnum,1)=33;           %YT开始执行作业
                         ChkTab(3).State(YTnum,2)=0;
                         ChkTab(3).State(YTnum,3)=Para(3).YCUnload;
                      elseif ChkTab(2).State(i,4)==2 && ChkTab(3).State(YTnum,1)==22    %若是卸船YC且YT在等待YC
                         ChkTab(2).State(i,1)=3;                        %YC开始执行作业
                         ChkTab(2).State(i,2)=0;                               
                         ChkTab(2).State(i,3)=Para(2).Unload;
                         ChkTab(3).State(YTnum,1)=23;           %YT开始执行作业
                         ChkTab(3).State(YTnum,2)=0;
                         ChkTab(3).State(YTnum,3)=Para(3).YCLoad;
                      end
               end
        end
end



    
    
    