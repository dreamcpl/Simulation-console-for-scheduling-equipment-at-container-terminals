function ChkTab=Sim_EqipNeed_YC(ChkTab,Para)
%%
global Bwi
temp=ChkTab(2).EqpNeed;
for i=1:Para(2).OutSum
    %%若为状态4，则排除
    if ChkTab(2).State(i,1)==4
       continue
    end
    %%不重复登记
    if ~isempty(ChkTab(2).EqpNeed)  %判断需求表是否为空
       if ~isempty(find(ChkTab(2).EqpNeed (:,1)==i)) %如果已经登记过,就不重复登记
          continue
       end
    end
    %%根据需求的紧急程度，将YC编号插入前面还是后面
    if ChkTab(2).EqpBod(i,:)==0      %没有绑定的YT
       if ChkTab(2).Progrs(i,1)==ChkTab(2).Progrs(i,3) && ChkTab(2).Progrs(i,2)<=1     
           %若是最后一栈，没有了箱子，就不安排了。
           continue
       else
          %读取当前任务的任务编号
          TaskNum=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1));
          %读取当前任务所属的装卸属性
          LDC=Bwi(find(Bwi(:,1)==TaskNum),4);
          LDC=LDC(1,:);
          %将当前需求进行登记
          temp=[ i,LDC;temp];
       end
    elseif ChkTab(2).EqpBod(i,1)~=0 && ChkTab(2).EqpBod(i,2)==0  %只绑定了一辆YT
       if ChkTab(2).State(i,2)==3       %正在执行任务的状态
          if ChkTab(2).Progrs(i,1)==ChkTab(2).Progrs(i,3) && ChkTab(2).Progrs(i,2)<=2  
              %若是最后一栈，还有一个箱子，就不安排了
             continue
          else
              %读取当前任务的任务编号
              TaskNum=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1));
              %读取当前任务所属的装卸属性
              LDC=Bwi(find(Bwi(:,1)==TaskNum),4);
              LDC=LDC(1,:);
              %将当前需求进行登记
              temp=[temp;i,LDC];
          end
       end
    end    
end
ChkTab(2).EqpNeed=temp;