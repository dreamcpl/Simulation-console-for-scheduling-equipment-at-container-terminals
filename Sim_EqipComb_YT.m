function ChkTab=Sim_EqipComb_YT(ChkTab,QCwi)
%%
global TskCod JobCod Swi
sta00YT=find(ChkTab(3).State(:,1)==00);  %状态是00的集卡
sta24YT=find(ChkTab(3).State(:,1)==24);  %状态是24的集卡
%%情景一：有集卡完成进口任务，在进口YC处等待。并且也有出口YC需要集卡.
while ~isempty(sta24YT) && ~isempty(ChkTab(2).EqpNeed) && ~isempty(find(ChkTab(2).EqpNeed(:,2)==1))
      %%%%%将第一辆YT安排给第一台进口YC
      LoadNeed=ChkTab(2).EqpNeed(find(ChkTab(2).EqpNeed(:,2)==1),:);
      YCnum=LoadNeed(1,1);
      YTnum=sta24YT(1,1);
      if ChkTab(2).EqpBod(YCnum,1)==0
         ChkTab(2).EqpBod(YCnum,1)=YTnum;
      else
         ChkTab(2).EqpBod(YCnum,2)=YTnum;
      end
      %绑定关系信息更新
      ChkTab(3).EqpBod(YTnum,2)=YCnum;
      ChkTab(3).EqpBod(YTnum,3)=ChkTab(1).EqpBod{1,1}(find(ChkTab(1).EqpBod{1,1}(:,2)==YCnum),1);
      %坐标信息存储
               %场桥坐标信息存储(出口YC)
      JobInfo=ChkTab(2).Swi{1,YCnum}; %读取存储在 YC任务缓存表 中对应的任务信息
      Cood=JobCod(find(Swi(:,1)==JobInfo(1,1) & Swi(:,2)==JobInfo(1,2) & Swi(:,3)==JobInfo(1,3) & Swi(:,4)==JobInfo(1,4)),:);
      ChkTab(3).Positn{1,3}(YTnum,:)=Cood;
               %岸桥坐标信息存储(出口QC)
      QCNum=ChkTab(3).EqpBod(YTnum,3);
      TskNum=QCwi(QCNum,ChkTab(1).Progrs(QCNum,1));
      Cood=TskCod(TskNum,:);
      ChkTab(3).Positn{1,5}(YTnum,:)=Cood;
      %YT作业状态更新
      ChkTab(3).State(YTnum,1)=31; %状态变为向出口YC行驶【起点是进口YC】
      ChkTab(3).State(YTnum,2)=0;  %状态变化计时器清零
      TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
      ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
      %从原有信息中消除记录
      sta24YT(1,:)=[];
      temp=find(ChkTab(2).EqpNeed(:,2)==1);
      temp=temp(1,1);
      ChkTab(2).EqpNeed(temp,:)=[]; 
end
%%情景二：有集卡完成进口任务，在进口YC处等待。但是没有出口YC需要集卡。直接让集卡去岸边，避免影响场内交通。
while ~isempty(sta24YT) && ~isempty(ChkTab(2).EqpNeed) && isempty(find(ChkTab(2).EqpNeed(:,2)==1))
      YTnum=sta24YT(1,1);
      %YT作业状态更新--相当于一次只让一辆YT驶向岸边，并非所有放下进口箱子的YT都驶向岸边
      ChkTab(3).State(YTnum,1)=50; %状态变为向岸边行驶
      ChkTab(3).State(YTnum,2)=0;  %状态变化计时器清零
      TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
      ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
      %从原有信息中消除记录
      sta24YT(1,:)=[];
end
%%情景三：有集卡在岸边等待，并且有进口YC需要集卡。直接让集卡去该YC对应的岸桥处等待。邱版本简化为直接在岸桥处执行任务。
while ~isempty(sta00YT) && ~isempty(ChkTab(2).EqpNeed) && ~isempty(find(ChkTab(2).EqpNeed(:,2)==2))
      %%%%%将第一辆YT安排给第一台YC
       UnloadNeed=ChkTab(2).EqpNeed(find(ChkTab(2).EqpNeed(:,2)==2),:);
      YCnum=UnloadNeed(1,1);
      YTnum=sta00YT(1,1);
      if ChkTab(2).EqpBod(YCnum,1)==0
         ChkTab(2).EqpBod(YCnum,1)=YTnum;
      else
         ChkTab(2).EqpBod(YCnum,2)=YTnum;
      end
      %绑定关系信息更新
      ChkTab(3).EqpBod(YTnum,2)=YCnum;
      ChkTab(3).EqpBod(YTnum,3)=ChkTab(1).EqpBod{1,1}(find(ChkTab(1).EqpBod{1,1}(:,2)==YCnum),1);
      %坐标信息存储
               %场桥坐标信息存储(进口YC)
      JobInfo=ChkTab(2).Swi{1,YCnum}; %读取存储在 YC任务缓存表 中对应的任务信息
      Cood=JobCod(find(Swi(:,1)==JobInfo(1,1) & Swi(:,2)==JobInfo(1,2) & Swi(:,3)==JobInfo(1,3) & Swi(:,4)==JobInfo(1,4)),:);
      ChkTab(3).Positn{1,2}(YTnum,:)=Cood;
               %岸桥坐标信息存储(进口QC)
      QCNum=ChkTab(3).EqpBod(YTnum,3);
      TskNum=QCwi(QCNum,ChkTab(1).Progrs(QCNum,1));
      Cood=TskCod(TskNum,:);
      ChkTab(3).Positn{1,4}(YTnum,:)=Cood;
      %YT作业状态更新
      ChkTab(3).State(YTnum,1)=11; %状态变为向进口QC行驶
      ChkTab(3).State(YTnum,2)=0;   %状态变化计时器清零
      TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
      ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
      %从原有信息中消除记录
      sta00YT(1,:)=[];
      temp=find(ChkTab(2).EqpNeed(:,2)==2);
      temp=temp(1,1);
      ChkTab(2).EqpNeed(temp,:)=[]; 
end
%%情景四:有集卡在岸边等待,并且有出口YC需要集卡?直接让集卡去该YC处等待
while ~isempty(sta00YT) && ~isempty(ChkTab(2).EqpNeed) && ~isempty(find(ChkTab(2).EqpNeed(:,2)==1))
      %%%%%将第一辆YT安排给第一台YC
      LoadNeed=ChkTab(2).EqpNeed(find(ChkTab(2).EqpNeed(:,2)==1),:);
      YCnum=LoadNeed(1,1);
      YTnum=sta00YT(1,1);
      if ChkTab(2).EqpBod(YCnum,1)==0
         ChkTab(2).EqpBod(YCnum,1)=YTnum;
      else
         ChkTab(2).EqpBod(YCnum,2)=YTnum;
      end
      %%绑定关系信息更新
      ChkTab(3).EqpBod(YTnum,2)=YCnum;
      ChkTab(3).EqpBod(YTnum,3)=ChkTab(1).EqpBod{1,1}(find(ChkTab(1).EqpBod{1,1}(:,2)==YCnum),1);
      %坐标信息存储
               %场桥坐标信息存储(出口YC)
      JobInfo=ChkTab(2).Swi{1,YCnum}; %读取存储在 YC任务缓存表 中对应的任务信息
      Cood=JobCod(find(Swi(:,1)==JobInfo(1,1) & Swi(:,2)==JobInfo(1,2) & Swi(:,3)==JobInfo(1,3) & Swi(:,4)==JobInfo(1,4)),:);
      ChkTab(3).Positn{1,3}(YTnum,:)=Cood;
               %岸桥坐标信息存储(出口QC)
      QCNum=ChkTab(3).EqpBod(YTnum,3);
      TskNum=QCwi(QCNum,ChkTab(1).Progrs(QCNum,1));
      Cood=TskCod(TskNum,:);
      ChkTab(3).Positn{1,5}(YTnum,:)=Cood;
      %%作业状态信息更新
      ChkTab(3).State(YTnum,1)=30; %状态变为向出口YC行驶【起点是岸边】
      ChkTab(3).State(YTnum,2)=0;  %状态变化计时器清零
      TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum);
      ChkTab(3).State(YTnum,3)=TT; %预计状态切换时间
      %%设备需求信息更新
      sta00YT(1,:)=[];
      temp=find(ChkTab(2).EqpNeed(:,2)==1);
      temp=temp(1,1);
      ChkTab(2).EqpNeed(temp,:)=[]; 
end
