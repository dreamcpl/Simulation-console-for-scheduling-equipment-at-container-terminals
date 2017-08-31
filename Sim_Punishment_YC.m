function [ChkTab,Finval]=Sim_Punishment_YC(ChkTab,Para,Glob)
%%
%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%本模块除了标记YC是否为被阻碍状态以外，还要检查是否一个箱区同时存在3台以上场桥
%ChkTab(2).Positn=cell(1,5);            %场桥(当前贝位号,目标贝位号,到达计时器,受干扰状态,移动模式)
                                                                    %(移动模式是指：1箱区内移动、2切换任务)
%%%%%注意%%%%%：由于场桥在切换任务的时候，当前位置将会改变为0号箱区0号贝位和0号栈
%%%以方便进行转移。因此，在判断场桥间是否产生干扰的时候，一定要审查是否箱区编号为0。若
%%%是，则不判断是否干扰；否则，进行干扰状态判断。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%先把所有YC都标记为没有被阻碍的状态，然后再开始标记谁被阻碍，每次都要刷新
%%%%由于是在workjudge模块来进行惩罚的，所以当前模块最好是放在workjudge模块前面起作用
ChkTab(2).Positn{1,4}=zeros(Para(2).OutSum,1);
Finval=0;    %先赋值，否则提示该值未定义，输出会出错
%%%%以下是正式标记过程
for i=1:Glob.BloSum       %按箱区编号审查，可避免出现0号箱区干扰的情况出现
     Num=[];
      for j=1:Para(2).OutSum
          %%%%ChkTab(2).Positn{1,1}记录所有YC当前位置（箱区，贝位，栈）（j，1）表示当前YC的箱区
           if ChkTab(2).Positn{1,1}(j,1)==i && ChkTab(2).State(j,1)~=4 %除了位置在当前箱区外，行驶模式也应该是1（任务内切换）
               Num=[Num,j];
           end
           YCnum=size(Num,2);
           %%%%若有超过2个YC同在某箱区，则染色体失效
           %%%%若刚好2个YC同在某箱区，则判定是否干扰
           %%%先看到达时间，再看二者距离
           if YCnum>2
               Finval=2;
               return
           elseif YCnum==2
               %%%%如果两台YC之间距离的绝对值<=3，那就一定有一个被阻碍了，被阻碍的一定是靠左边的那台
               BayGap=abs(ChkTab(2).Positn{1,1}(Num(1,1),2)-ChkTab(2).Positn{1,1}(Num(1,2),2));
               if  BayGap<=3    %第一台YC标记为被阻碍状态
                   %不考虑穿越的情况，只有阻碍和等待，没有穿越
                   if ChkTab(2).Positn{1,1}(Num(1,1),2)<ChkTab(2).Positn{1,1}(Num(1,2),2)
                       ChkTab(2).Positn{1,4}(Num(1,1),1)=1;
                   elseif ChkTab(2).Positn{1,1}(Num(1,1),2)>ChkTab(2).Positn{1,1}(Num(1,2),2)
                       ChkTab(2).Positn{1,4}(Num(1,2),1)=1;
                   end
               end
           end
      end
end