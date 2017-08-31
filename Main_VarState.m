function [Cmi,MLGA,Glob,Para,Cost]=Main_VarState()
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%请留意加★符号的变量，可能每次改变场景时，都需要专门进行调节。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%一、基本参数设置
Cmi=cell(7,1);
%1染色体编号、QC任务编码、染色体编码、4QC任务安排、染色体目标值、染色体适应度值、7染色体适应度占比
%%
%%%%%%1.全局参数
MLGA(1).ChmSum=20;         %染色体总数
MLGA(1).Iter=2000;               %父代算法迭代次数
MLGA(1).CroPro=0.7;          %父代交叉概率
MLGA(1).MutPro=0.1;         %父代变异概率
MLGA(2).Iter=10;                  %子代算法迭代次数
MLGA(2).CroPro=0.7;          %子代交叉概率
MLGA(2).MutPro=0.1;         %子代变异概率
% MLGA(2).RepPro=1;            %染色体修复概率
%%%%%%2.堆场参数
Glob.JobSum=12;                 %任务总数★
Glob.BloSum=8;                   %箱区总数★
Glob.BloLine=2;                   %箱区列数★
Glob.BloRow=4;                   %箱区排数★
Glob.BaySum=10;                %贝位数★
Glob.RowSum=6;                 %每箱区集装箱排数★
Glob.QyYdDc=30;                %岸边到堆场边缘的距离
Glob.BayWidth=7;                %单个贝位折算宽度
Glob.BLKHW=Glob.BaySum*Glob.BayWidth; %单个箱区横向长度
Glob.BLKVW=20;                %单个箱区纵向宽度block vertical width
Glob.RoadWidth=10;            %道路宽度
Glob.VSPX=-80;                  %首贝位折算横坐标，单位：米★
%%%%%%3.设备作业参数
%%%3.1岸桥参数
Para(1).Sum=3;                    %岸桥数目★
Para(1).Load=30;                 %岸桥装一个集装箱所用的时间
Para(1).Unload=30;              %岸桥卸一个集装箱所用的时间
Para(1).LUN=50;                 %岸桥先装后卸一个集装箱所用的时间
Para(1).MovBay=10;           %岸桥行驶一个贝位平均所用时间（此版本忽略QC行驶时间）★
% Para(1).StaLoc=20;          %岸桥启动和定位平均所用时间
%%%3.2场桥参数
Para(2).OutSum=6;               %场桥总数★
Para(2).Load=60;                  %场桥装一个集装箱所用的时间(往YT身上装)
Para(2).Unload=60;               %场桥卸一个集装箱所用的时间(从YT身上卸)
Para(2).MovBay=4;              %场桥横向跨越一个贝位的时间
Para(2).MovHDB=15;           %场桥横向跨越两个箱区之间的空隙的时间
Para(2).MovVDB=30;           %场桥纵向跨越两个箱区之间的空隙的时间
Para(2).MovTurn=30;           %场桥两次转弯所用的时间
Para(2).SfDs=3;                     %场桥安全距离为3个贝位
Para(2).Wldl=100;                 %YC任务最大不均衡量暂定为100
%%%3.3集卡参数
Para(3).StartPoint=[200,150];%集卡存放位置坐标
Para(3).Sum=18;                    %集卡总数★
Para(3).FLSpeed=3;               %集卡满载行驶速度（m/s）
Para(3).ULSpeed=5;               %集卡空载行驶速度（m/s）
Para(3).QCLoad=15;              %岸桥卸一个集装箱所用的时间(从YT身上卸)
Para(3).QCUnload=15;           %岸桥装一个集装箱所用的时间(往YT身上装)
Para(3).YCLoad=15;              %场桥卸一个集装箱所用的时间(从YT身上卸)
Para(3).YCUnload=15;           %场桥装一个集装箱所用的时间(往YT身上装)
%%
%%%%%%4.设备成本参数
Cost(1).Rate=0;                      %成本在计算中所占比值★
%%%4.1岸桥成本参数
Cost(1).UitFix=400;                %单台岸桥固定使用成本
Cost(1).LCon=25;                  %单次提箱/卸箱成本
Cost(1).LUNCon=20;             %单次先装后卸成本
Cost(1).Wait=10;                    %等待一秒钟的成本
Cost(1).Travel=0;                   %行驶一秒钟的成本
%%%4.2场桥成本参数
Cost(2).UitFix=150;                %单台场桥固定使用成本
Cost(2).LCon=20;                   %单次提箱/卸箱成本
Cost(2).LUNCon=20;             %单次先装后卸成本
Cost(2).Wait=5;                      %等待一秒钟的成本
Cost(2).Travel=3;                    %行驶一秒钟的成本
%%%4.3集卡成本参数
Cost(3).UitFix=35;                  %单辆集卡固定使用成本
Cost(3).Wait=1.5;                    %等待一秒钟的成本
Cost(3).Travel=1;                    %行驶一秒钟的成本