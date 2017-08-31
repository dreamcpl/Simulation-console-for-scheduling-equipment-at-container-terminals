function MovTim=Sim_Cite_MvTmCl_YC(ChkTab,i)
%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%本模块作用是计算场桥在不同箱区间进行切换时所需时间
%注意：本程序暂时不考虑YC在切换任务时可能遭受的挡路情况，相当于交换YC的任务。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,~,Glob,Para,~]=Main_VarState();
OgBlk=ChkTab(2).Positn{1,1}(i,1);
AmBlk=ChkTab(2).Positn{1,2}(i,1);
lane=Glob.BloLine;
[X1,Y1]=Fun_Num2RowLane(OgBlk,lane);    %初始箱区坐标
[X2,Y2]=Fun_Num2RowLane(AmBlk,lane);   %目标箱区坐标
%%
%情况1：若初始箱区和目标箱区是同一个箱区
%方案一：直接变为行驶模式1，即任务内切换，但会引发两个YC相向而行，始终处于纠缠状态。
%方案二：保持行驶模式2，但是时间到了的话，直接变为相应贝位。
if  AmBlk==OgBlk
    MovTim=abs(ChkTab(2).Positn{1,1}(i,2)-ChkTab(2).Positn{1,2}(i,2))*Para(2).MovBay;
%情况2：若目标箱区所在列在目标箱区所在列的左侧
elseif   X2<X1
     MovTim=(X1-X2-1)*(Para(2).MovHDB+Glob.BaySum*Para(2).MovBay)+Para(2).MovHDB+abs(Y1-Y2)*Para(2).MovVDB+(ChkTab(2).Positn{1,1}(i,2)+Glob.BaySum-ChkTab(2).Positn{1,2}(i,2))*Para(2).MovBay;
%情况3：若目标箱区与目标箱区在同列
elseif   X2==X1  &&   AmBlk~=OgBlk
     MovTim=abs(Y1-Y2)*Para(2).MovVDB+(ChkTab(2).Positn{1,1}(i,2)+ChkTab(2).Positn{1,2}(i,2))*Para(2).MovBay;
%情况4：若目标箱区所在列在目标箱区所在列的右侧
elseif   X2>X1
     MovTim=(X2-X1-1)*(Para(2).MovHDB+Glob.BaySum*Para(2).MovBay)+Para(2).MovHDB+abs(Y1-Y2)*Para(2).MovVDB+(ChkTab(2).Positn{1,2}(i,2)+Glob.BaySum-ChkTab(2).Positn{1,1}(i,2))*Para(2).MovBay;
end