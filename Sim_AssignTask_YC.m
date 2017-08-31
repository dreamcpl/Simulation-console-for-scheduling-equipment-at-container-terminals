function ChkTab=Sim_AssignTask_YC(ChkTab,Para,Swi)
%%
for i=1:Para(2).OutSum
   if ChkTab(2).State(i,1)==0        %未安排过任务的状态      
     if ChkTab(2).Progrs(i,2)>1              %任务计数器若大于1
       ChkTab(2).Progrs(i,2)=ChkTab(2).Progrs(i,2)-1;   %则减1
       ChkTab(2).State(i,1)=2;
     else
       ChkTab(2).Progrs(i,1)=ChkTab(2).Progrs(i,1)+1;
       if ChkTab(2).Progrs(i,1)>ChkTab(2).Progrs(i,3)  %已经执行完了所有已有任务
         ChkTab(2).State(i,1)=4;       %状态变为完成任务
         ChkTab(2).State(i,4)=0;       %装卸状态清除
         ChkTab(2).Progrs(i,1)=ChkTab(2).Progrs(i,1)-1;
         %%绑定关系信息更新
         ChkTab(1).EqpBod{1,1}(find(ChkTab(1).EqpBod{1,1}(:,2)==i),:)=[]; %删除与QC绑定关系
         continue
       else 
         tempinfo=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1),:);  %从当前YC的全体任务中摘取出当前栈位任务的信息
         %%作业进度信息更新
         ChkTab(2).Progrs(i,2)=tempinfo(1,5);      %转移当前栈位集装箱层数
         %%作业状态信息更新
         ChkTab(2).State(i,1)=1;    %(正在行驶)
         ChkTab(2).State(i,4)=tempinfo(1,6);         %更新装卸属性
         %%设备位置信息更新
         ChkTab(2).Positn{1,2}(i,1)=tempinfo(1,2);
         ChkTab(2).Positn{1,2}(i,2)=tempinfo(1,3);
         ChkTab(2).Positn{1,2}(i,3)=tempinfo(1,4);
         if ChkTab(2).State(i,1)==4  %如果完成了当前所有任务，就让行驶状态变为2
           ChkTab(2).Positn{1,3}(i,1)=0;  %位置计时器清零
           ChkTab(2).Positn{1,4}(i,1)=0;  %干扰状态归零
           ChkTab(2).Positn{1,5}(i,1)=2;  %行驶模式变为2
         else
           ChkTab(2).Positn{1,5}(i,1)=1;
         end
       end
     end
   end
end
%%%%参考YC需求表，对状态为4的YC进行处理（以下为对YC进行新任务分配时进行的处理）
for i=1:Para(2).OutSum
    %%如果YC不是状态4，或者需求表上并没有该YC，则跳过该YC
    if ChkTab(2).State(i,1)~=4 || isempty(ChkTab(1).EqpNeed)  || isempty(find(ChkTab(1).EqpNeed(:,5)==i)) 
       continue
    end
    %%通过审查后，即可安排YC
    %%设备绑定信息变化
    val=find(ChkTab(1).EqpNeed(:,5)==i);    %找到需求条目(可能找到多个)
    row=ChkTab(1).EqpNeed(val(1),:);         %只要找到的第一条登记记录（把这条记录的所有信息进行迁移）
    temp=[row(1,1),row(1,5),row(1,2)];        %登记到QC:YC绑定表
    ChkTab(1).EqpBod{1,1}=[ChkTab(1).EqpBod{1,1};temp];
    %%任务缓存信息变化(把任务信息迁移到YC任务信息表中)
    TWI=Swi(find(Swi(:,1)==row(1,2) & Swi(:,2)==row(1,3)),:);
    ChkTab(2).Swi{1,i}=[ChkTab(2).Swi{1,i};TWI];
    %%任务进度信息变化
    ChkTab(2).Progrs(i,1)=ChkTab(2).Progrs(i,1)+1;
    ChkTab(2).Progrs(i,2)=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1),5);
    ChkTab(2).Progrs(i,3)=size(ChkTab(2).Swi{1,i},1);
    %%设备位置信息变化(目标位置变化，干扰状态等变化，移动模式变化)
    ChkTab(2).Positn{1,2}(i,1)=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1),2);    %目标箱区变化
    ChkTab(2).Positn{1,2}(i,2)=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1),3);    %目标贝位变化
    ChkTab(2).Positn{1,2}(i,3)=ChkTab(2).Swi{1,i}(ChkTab(2).Progrs(i,1),4);    %目标栈位变化
    ChkTab(2).Positn{1,3}(i,1)=0;     %到达位置计时器清零
    ChkTab(2).Positn{1,4}(i,1)=0;     %被阻碍状态重置
    ChkTab(2).Positn{1,5}(i,1)=2;     %任务间切换模式
    if ChkTab(2).Progrs(i,1)==1
        ChkTab(2).Positn{1,1}(i,1)=ChkTab(2).Positn{1,2}(i,1);
        ChkTab(2).Positn{1,1}(i,2)=ChkTab(2).Positn{1,2}(i,2);
        ChkTab(2).Positn{1,1}(i,3)=ChkTab(2).Positn{1,2}(i,3);
    end
    %%当前YC状态信息变化 （找到后，就可以让当前YC出发执行任务了）
    ChkTab(2).State(i,1)=1;
    ChkTab(2).State(i,2)=0;
    MovTim=Sim_Cite_MvTmCl_YC(ChkTab,i);  %输出YC的移动模式还有移动时间
    ChkTab(2).State(i,3)=MovTim;     
    ChkTab(2).State(i,4)=row(1,6);
    %%设备需求信息变化(把需求表中的信息删除掉)
    ChkTab(1).EqpNeed(val(1),:)=[];
end