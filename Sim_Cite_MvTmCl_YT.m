function TT=Sim_Cite_MvTmCl_YT(ChkTab,YTnum)
%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%本模块作用是计算集卡在不同箱区间，以及岸边和堆场间行驶的时间
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,~,Glob,Para,~]=Main_VarState();
%集卡|(     00岸边待机?  11向进口岸桥行驶?12进口岸桥处等待?13卸船
                    %所有|                   21向进口场桥行驶?22进口场桥处等待?23取箱?  24在进口YC待机
                    %状态|    30从岸边向出口YC行驶?  31向出口场桥行驶?32出口场桥处等待?33装箱?
                    %信息|                   41向出口岸桥行驶?42出口岸桥处等待?43装船?                   
                    %列表| 50从进口YC向岸边行驶  6完成所有任务   ) 

if ChkTab(3).State(YTnum,1)==11  %从岸边向进口岸桥行驶
    SP=ChkTab(3).Positn{1,6}(YTnum,:);  %起始坐标
    TP=ChkTab(3).Positn{1,4}(YTnum,:);  %终止坐标
    X1=SP(1,1); Y1=SP(1,2);
    X2=TP(1,1); Y2=TP(1,2);
    %计算行驶距离
    TDx=abs(X1-X2);
    TDy=abs(Y1-Y2);
    TD=TDx+TDy;
    %计算行驶时间
    TT=TD/Para(3).ULSpeed; %此处应当使用空载行驶速度
elseif ChkTab(3).State(YTnum,1)==21  %从进口岸桥向进口场桥行驶
    SP=ChkTab(3).Positn{1,4}(YTnum,:);  %起始坐标
    TP=ChkTab(3).Positn{1,2}(YTnum,:);  %终止坐标
    X1=SP(1,1); Y1=SP(1,2);
    X2=TP(1,1); Y2=TP(1,2);
    %找出路口坐标
    for i=1:Glob.BloLine
         if X1>=(i-1)*(Glob.BLKHW+Glob.RoadWidth) && X1<i*(Glob.BLKHW+Glob.RoadWidth)
            XM=(i-1)*(Glob.BLKHW+Glob.RoadWidth);
         elseif X1<0
             XM=0;
         elseif X1>=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth)
             XM=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth);
         end
    end
    %计算行驶距离
    TDx=abs(X1-XM)+abs(X2-XM);
    TDy=abs(Y1-Y2);
    TD=TDx+TDy;
    %计算行驶时间
    TT=TD/Para(3).FLSpeed; %此处应当使用满载行驶速度
elseif ChkTab(3).State(YTnum,1)==30  %从岸边向出口场桥行驶
    SP=ChkTab(3).Positn{1,6}(YTnum,:);  %起始坐标
    TP=ChkTab(3).Positn{1,3}(YTnum,:);  %终止坐标
    X1=SP(1,1); Y1=SP(1,2);
    X2=TP(1,1); Y2=TP(1,2);
    %找出路口坐标
    for i=1:Glob.BloLine
         if X1>=(i-1)*(Glob.BLKHW+Glob.RoadWidth) && X1<i*(Glob.BLKHW+Glob.RoadWidth)
            XM=(i-1)*(Glob.BLKHW+Glob.RoadWidth);
         elseif X1<0
             XM=0;
         elseif X1>=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth)
             XM=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth);
         end
    end
    %计算行驶距离
    TDx=abs(X1-XM)+abs(X2-XM);
    TDy=abs(Y1-Y2);
    TD=TDx+TDy;
    %计算行驶时间
    TT=TD/Para(3).ULSpeed; %此处应当使用空载行驶速度
elseif ChkTab(3).State(YTnum,1)==31 %从进口场桥向出口场桥行驶
    SP=ChkTab(3).Positn{1,2}(YTnum,:);  %起始坐标
    TP=ChkTab(3).Positn{1,3}(YTnum,:);  %终止坐标
    X1=SP(1,1); Y1=SP(1,2);
    X2=TP(1,1); Y2=TP(1,2);
    %找出路口坐标
    for i=1:Glob.BloLine
         if X1>=(i-1)*(Glob.BLKHW+Glob.RoadWidth) && X1<i*(Glob.BLKHW+Glob.RoadWidth)
            XM=i*(Glob.BLKHW+Glob.RoadWidth);
         elseif X1<0
             XM=0;
         elseif X1>=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth)
             XM=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth);
         end
    end
    %计算行驶距离
    TDx=abs(X1-XM)+abs(X2-XM);
    TDy=abs(Y1-Y2);
    TD=TDx+TDy;
    %计算行驶时间
    TT=TD/Para(3).ULSpeed; %此处应当使用空载行驶速度
elseif ChkTab(3).State(YTnum,1)==41 %从出口场桥向出口岸桥行驶
    SP=ChkTab(3).Positn{1,3}(YTnum,:);  %起始坐标
    TP=ChkTab(3).Positn{1,5}(YTnum,:);  %终止坐标
    X1=SP(1,1); Y1=SP(1,2);
    X2=TP(1,1); Y2=TP(1,2);
    %找出路口坐标
    for i=1:Glob.BloLine
         if X1>=(i-1)*(Glob.BLKHW+Glob.RoadWidth) && X1<i*(Glob.BLKHW+Glob.RoadWidth)
            XM=i*(Glob.BLKHW+Glob.RoadWidth);
         elseif X1<0
             XM=0;
         elseif X1>=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth)
             XM=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth);
         end
    end
    %计算行驶距离
    TDx=abs(X1-XM)+abs(X2-XM);
    TDy=abs(Y1-Y2);
    TD=TDx+TDy;
    %计算行驶时间
    TT=TD/Para(3).FLSpeed; %此处应当使用满载行驶速度
elseif ChkTab(3).State(YTnum,1)==50 %从进口场桥向岸边行驶
    
    SP=ChkTab(3).Positn{1,2}(YTnum,:);  %起始坐标
    TP=ChkTab(3).Positn{1,6}(YTnum,:);  %终止坐标
    X1=SP(1,1); Y1=SP(1,2);
    X2=TP(1,1); Y2=TP(1,2);
    %找出路口坐标
    for i=1:Glob.BloLine
         if X1>=(i-1)*(Glob.BLKHW+Glob.RoadWidth) && X1<i*(Glob.BLKHW+Glob.RoadWidth)
            XM=i*(Glob.BLKHW+Glob.RoadWidth);
         elseif X1<0
             XM=0;
         elseif X1>=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth)
             XM=Glob.BloLine*(Glob.BLKHW+Glob.RoadWidth);
         end
    end
    %计算行驶距离
    TDx=abs(X1-XM)+abs(X2-XM);
    TDy=abs(Y1-Y2);
    TD=TDx+TDy;
    %计算行驶时间
    TT=TD/Para(3).ULSpeed; %此处应当使用空载行驶速度
end