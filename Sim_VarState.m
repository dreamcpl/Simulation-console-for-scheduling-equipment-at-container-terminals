function [ChkTab,Static]=Sim_VarState(Para)
%%%%%%%%1 变量声明
%%%%%%%%静态参数
Static.Accu=4;                   %时间精度(与场桥行驶一个贝位的时间相等)
Static.End=100000;           %设定结束时间(中间停止的话,就不再刷新了)
Static.BaySecYC=0.25;     %场桥每秒钟行驶贝位数
Static.BaySecQC=0.25;     %岸桥每秒钟行驶贝位数
%%%%%%%%动态参数
%%%%作业状态表
ChkTab(1).State=zeros(Para(1).Sum,4);      %岸桥状态表 【QC状态   计时器    预计状态变化时间   装卸属性】
                      %   【0待机?1行驶?2等待集卡?3作业?4完成任务】【装卸属性：1 装船；2 卸船】
ChkTab(2).State= zeros(Para(2).OutSum,4);%场桥状态表【YC状态   计时器    预计状态变化时间   装卸属性】
                      %   【0待机?1行驶?2等待集卡?3作业?4完成任务】【装卸属性：1 装船；2 卸船】
ChkTab(3).State=zeros(Para(3).Sum,3);    %集卡状态表【YT状态?计时器?预计状态变化时间】
                    %集卡|(     00岸边待机?  11向进口岸桥行驶?12进口岸桥处等待?13卸船
                    %所有|                   21向进口场桥行驶?22进口场桥处等待?23取箱?  24在进口YC待机
                    %状态|    30从岸边向出口YC行驶?  31从进口YC向出口场桥行驶?32出口场桥处等待?33装箱?
                    %信息|                   41向出口岸桥行驶?42出口岸桥处等待?43装船?                   
                    %列表| 50从进口YC向岸边行驶  6完成所有任务   ) 
%%%%设备位置表
ChkTab(1).Positn=zeros(Para(1).Sum,4); %岸桥(当前贝位,目标贝位,到达计时器,受干扰状态)
ChkTab(2).Positn=cell(1,5);                     %场桥(当前贝位号,目标贝位号,到达计时器,受干扰状态,移动模式)
                                                                 %(移动模式：1箱区内移动、2切换任务)
ChkTab(3).Positn=cell(1,6);                     %集卡（当前坐标，进口YC坐标，出口YC坐标，进口QC坐标，出口QC坐标，空车起始点）
%%%%任务进度表
ChkTab(1).Progrs=zeros(Para(1).Sum,1);       %岸桥【任务计数器】
ChkTab(2).Progrs=zeros(Para(2).OutSum,3); %场桥【任务计数器?当前栈位剩余箱数?任务量】
%%%%任务缓存表
ChkTab(2).Swi=cell(1,Para(2).OutSum);     %YC任务缓存表
%%%%设备绑定表
ChkTab(1).EqpBod=cell(1,2);               %岸桥【QC:YC:箱区;QC:YT】
ChkTab(2).EqpBod=zeros(Para(2).OutSum,2); %场桥处集卡排队表【2辆YT】
ChkTab(3).EqpBod=zeros(Para(3).Sum,3);    %集卡与场桥和岸桥绑定表【集卡:场桥:岸桥】
%%%%设备需求表
ChkTab(1).EqpNeed=[];         %QC对YC需求表[QC编号,任务号，箱区，集装箱量，场桥，装卸类型][1进口,2出口]
ChkTab(2).EqpNeed=[];         %YC对YT需求表[YC需求编号,装卸类型][1进口,2出口]
%%%%结束判定表
ChkTab(1).EndJudge=zeros(1,2);      %结束状态、状态计时器
%%%%设备状态时间统计
ChkTab(1).StaTim=zeros(Para(1).Sum,3);     %统计行驶、等待和装卸时间
ChkTab(2).StaTim=zeros(Para(2).OutSum,3);     %统计行驶、等待和装卸时间
ChkTab(3).StaTim=zeros(Para(3).Sum,4);     %统计等待、空车行驶、满载行驶、装卸时间