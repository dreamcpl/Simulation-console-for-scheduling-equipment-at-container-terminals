function ChkTab=Sim_ScheduleRenew_YT(ChkTab,Para,Static)
%%%本模块只负责集卡作业过程的结束判定，集卡行驶过程有没有到达是在ArriveState_YT中执行的。
%%
for i=1:Para(3).Sum
    YTnum=i;
   ChkTab(3).State(i,2)=ChkTab(3).State(i,2)+Static.Accu;  %状态计时器增加时间步长
   %由于暂时未涉及位置的变动影响，因此没有位置计时器
    if ChkTab(3).State(i,2)>=ChkTab(3).State(i,3)
        if  ChkTab(3).State(i,1)==13            %进口QC处装箱
            %%作业状态信息更新
            ChkTab(3).State(i,1)=21;             %向进口YC处行驶
            ChkTab(3).State(i,2)=0;
            TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
            ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
            %%设备绑定关系更新（解除与QC关系）
            QCnum=ChkTab(3).EqpBod(i,3);
            ChkTab(1).EqpBod{1,2}(QCnum,1)=0;    %QC:YT表 
            temp=ChkTab(1).EqpBod{1,2}(QCnum,:); %把YT从QC处的排队表中移除
            temp=temp(find(temp~=0));
            if ~isempty(temp)
               ChkTab(1).EqpBod{1,2}(QCnum,:)=0;
               ChkTab(1).EqpBod{1,2}(QCnum,1:size(temp,2))=temp;
            end
            ChkTab(3).EqpBod(i,3)=0;          %YT:YC:QC表
        elseif ChkTab(3).State(i,1)==23            %进口YC处装箱
            %%作业状态信息更新
            ChkTab(3).State(i,1)=24;                  %进口YC待机
            ChkTab(3).State(i,2)=0;
            ChkTab(3).State(i,3)=10;
            %%设备绑定关系更新（解除与YC关系）
            YCnum=ChkTab(3).EqpBod(i,2); 
            ChkTab(2).EqpBod(YCnum,1)=0;    %YC:YT表
            if ChkTab(2).EqpBod(YCnum,2)~=0
              ChkTab(2).EqpBod(YCnum,1)=ChkTab(2).EqpBod(YCnum,2);
              ChkTab(2).EqpBod(YCnum,2)=0;
            end
            ChkTab(3).EqpBod(i,2)=0;          %YT:YC:QC表
        elseif ChkTab(3).State(i,1)==24       %进口YC处等待
            %%作业状态信息更新
            ChkTab(3).State(i,1)=50;             %从进口YC向岸边行驶
            ChkTab(3).State(i,2)=0;
            TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
            ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
        elseif ChkTab(3).State(i,1)==33      %出口场桥处装箱
            %%作业状态信息更新
            ChkTab(3).State(i,1)=41;             %向出口岸桥行驶
            ChkTab(3).State(i,2)=0;
            TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
            ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
            %%设备绑定关系更新（解除与YC关系）
            YCnum=ChkTab(3).EqpBod(i,2); 
            ChkTab(2).EqpBod(YCnum,1)=0;    %YC:YT表
            if ChkTab(2).EqpBod(YCnum,2)~=0
              ChkTab(2).EqpBod(YCnum,1)=ChkTab(2).EqpBod(YCnum,2);
              ChkTab(2).EqpBod(YCnum,2)=0;
            end
            ChkTab(3).EqpBod(i,2)=0;          %YT:YC:QC表
        elseif ChkTab(3).State(i,1)==43       %出口岸桥处装船
            %%作业状态信息更新
            ChkTab(3).State(i,1)=0;               %作业状态
            ChkTab(3).State(i,2)=0;
            ChkTab(3).State(i,3)=0;
            %%设备绑定关系更新（解除与QC关系）
            QCnum=ChkTab(3).EqpBod(i,3);
            ChkTab(1).EqpBod{1,2}(QCnum,1)=0;    %QC:YT表 
            temp=ChkTab(1).EqpBod{1,2}(QCnum,:); %把YT从QC处的排队表中移除
            temp=temp(find(temp~=0));
            if ~isempty(temp)
               ChkTab(1).EqpBod{1,2}(QCnum,:)=0;
               ChkTab(1).EqpBod{1,2}(QCnum,1:size(temp,2))=temp;
            end
            ChkTab(3).EqpBod(i,3)=0;          %YT:YC:QC表
        end
    end
end



    
    
    