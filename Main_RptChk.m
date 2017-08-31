function Cmi=Main_RptChk(Cmi,num)
global QCRec YCRec Bwi Swi SYwi
[~,~,Glob,Para,Cost]=Main_VarState();
YCTask=Cmi{3,num}(4,:);   %当前场桥的任务安排
QCTask=Cmi{2,num};   %当前岸桥的任务安排
CWI=Cmi{3,num};
QCwi=Cmi{4,num};
%对比岸桥重复记录
%若是空文件，则直接进行计算
if isempty(QCRec)    
     %添加新纪录
     QCRec=QCTask; 
     YCRec{1,1}=YCTask;
     %计算调度结果
     [SimRzt,RepCwi]=Main_Simulation(Para,QCwi,Bwi,Swi,CWI,Cost,Glob); %仿真模块（V1.2）
     Temp=[SimRzt.Makespan SimRzt.CostSum SimRzt.CmpSum SimRzt.QCUtRo SimRzt.YCUtRo SimRzt.YTUtRo];
     %添加计算结果
     %添加修复结果
     YCRec{1,2}=RepCwi(4,:);
     %添加计算结果
     YCRec{1,3}=Temp;
     %添加到染色体信息记录系统
     Cmi{3,num}=RepCwi;          %V1.2增加代码
     Cmi{5,num}=Temp;
     Cmi{6,num}=1/SimRzt.CmpSum;
     return
end
%若不是空文件，则进行排查
for i=1:size(QCRec,1)
     for j=1:size(QCRec,2)
          if QCRec(i,j)~=QCTask(1,j)
              if i==size(QCRec,1)  %如果是最后一行也不重复，则添加新纪录
                 QCRec=[QCRec;QCTask]; 
                 temp=YCRec{i,1};
                 temp=[temp;YCTask];
                 temp=[temp;YCTask];
                 YCRec{1,1}=temp;
                 %计算调度结果
                 [SimRzt,RepCwi]=Main_Simulation(Para,QCwi,Bwi,Swi,CWI,Cost,Glob); %仿真模块（V1.2）
                 Temp=[SimRzt.Makespan SimRzt.CostSum SimRzt.CmpSum SimRzt.QCUtRo SimRzt.YCUtRo SimRzt.YTUtRo];
                 %添加计算结果
                 %添加修复结果
                 temp2=YCRec{i,2};
                 temp2=[temp2;RepCwi(4,:)];
                 YCRec{i,2}=temp2;
                 %添加计算结果
                 temp3=YCRec{i,3};
                 temp3=[temp3;Temp];
                 YCRec{i,3}=temp3;
                 %添加到染色体信息记录系统
                 Cmi{3,num}=RepCwi;          %V1.2增加代码
                 Cmi{5,num}=Temp;
                 Cmi{6,num}=1/SimRzt.CmpSum;
                 return
              else
                 break
              end
          end
     end
     %排查场桥记录
    temp=YCRec{i,1};
    %如果场桥记录是空的，则添加新纪录
    if isempty(temp)
        %计算调度结果
         [SimRzt,RepCwi]=Main_Simulation(Para,QCwi,Bwi,Swi,CWI,Cost,Glob); %仿真模块（V1.2）
         Temp=[SimRzt.Makespan SimRzt.CostSum SimRzt.CmpSum SimRzt.QCUtRo SimRzt.YCUtRo SimRzt.YTUtRo];
         %添加计算结果
         %添加修复结果
         temp2=YCRec{i,2};
         temp2=[temp2;RepCwi(4,:)];
         YCRec{i,2}=temp2;
         %添加计算结果
         temp3=YCRec{i,3};
         temp3=[temp3;Temp];
         YCRec{i,3}=temp3;
         %添加到染色体信息记录系统
         Cmi{3,num}=RepCwi;          %V1.2增加代码
         Cmi{5,num}=Temp;
         Cmi{6,num}=1/SimRzt.CmpSum;
         return
    else %如果不是空的，查找记录
        for m=1:size(temp,1)
              for n=1:size(temp,2)
                    if temp(m,n)~=YCTask(1,n)
                          if n==size(temp,1)  %如果是最后一行也不重复，则添加新纪录
                             QCRec=[QCRec;QCTask]; 
                             temp=YCRec{i,1};
                             temp=[temp;YCTask];
                             %计算调度结果
                             [SimRzt,RepCwi]=Main_Simulation(Para,QCwi,Bwi,Swi,CWI,Cost,Glob);; %仿真模块（V1.2）
                             Temp=[SimRzt.Makespan SimRzt.CostSum SimRzt.CmpSum SimRzt.QCUtRo SimRzt.YCUtRo SimRzt.YTUtRo];
                             %添加计算结果
                             %添加修复结果
                             temp2=YCRec{i,2};
                             temp2=[temp2;RepCwi(4,:)];
                             YCRec{i,2}=temp2;
                             %添加计算结果
                             temp3=YCRec{i,3};
                             temp3=[temp3;Temp];
                             YCRec{i,3}=temp3;
                             %添加到染色体信息记录系统
                             Cmi{3,num}=RepCwi;          %V1.2增加代码
                             Cmi{5,num}=Temp;
                             Cmi{6,num}=1/SimRzt.CmpSum;
                             return
                          else
                             break
                          end
                    end
              end
              %找到重复的条目后，找出计算结果记录
              %添加计算结果
              YCChrom=[];
              for j=1:size(QCTask,2)
                   WNum=QCTask(1,j);
                   TSgCm=SYwi(:,find(SYwi(1,:)==WNum));
                   YCChrom=[YCChrom,TSgCm];
              end
              YCChrom(4,:)=YCTask;
              Cmi{3,num}=YCChrom;          %修复后的染色体
              Cmi{5,num}=YCRec{i,3}(m,:);          %调度结果
              sum=YCRec{i,3}(m,3);
              Cmi{6,num}=1/sum;
              return
         end
    end     
end
    