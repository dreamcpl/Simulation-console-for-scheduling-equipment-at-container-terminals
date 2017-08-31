function ChkTab=Sim_ArriveState_YT(ChkTab,Para)
%%%本模块只负责集卡行驶过程的到达判定，集卡作业过程有没有结束是在ScheduleRenew中执行的。
%%
for i=1:Para(3).Sum
   if ChkTab(3).State(i,2)>=ChkTab(3).State(i,3)
        if ChkTab(3).State(i,1)==11              %到达进口QC处
               ChkTab(3).State(i,1)=12;               %将到达信息登记并进行整理
               QCnum=ChkTab(3).EqpBod(i,3);
               temp=ChkTab(1).EqpBod{1,2}(QCnum,:);
               temp=temp(find(temp~=0));
               temp=[temp,i];
               ChkTab(1).EqpBod{1,2}(QCnum,:)=0;
               ChkTab(1).EqpBod{1,2}(QCnum,1:size(temp,2))=temp;
        elseif ChkTab(3).State(i,1)==21       %到达进口YC处
               ChkTab(3).State(i,1)=22;            
        elseif ChkTab(3).State(i,1)==30       %到达出口YC(从岸边出发)
               ChkTab(3).State(i,1)=32; 
        elseif ChkTab(3).State(i,1)==31       %到达出口YC处（从进口YC出发）
               ChkTab(3).State(i,1)=32;                   
        elseif ChkTab(3).State(i,1)==41       %到达出口QC处
               ChkTab(3).State(i,1)=42;               %将到达信息登记并进行整理
               QCnum=ChkTab(3).EqpBod(i,3);
               temp=ChkTab(1).EqpBod{1,2}(QCnum,:);
               temp=temp(find(temp~=0));
               temp=[temp,i];
               ChkTab(1).EqpBod{1,2}(QCnum,:)=0;
               ChkTab(1).EqpBod{1,2}(QCnum,1:size(temp,2))=temp;
        elseif ChkTab(3).State(i,1)==50            %从进口YC向岸边行驶
                %%作业状态信息更新
                ChkTab(3).State(i,1)=00;        
                ChkTab(3).State(i,2)=0;
                ChkTab(3).State(i,3)=0; %预计状态切换时间
         end
   end
end

