function ChkTab=Sim_Initializat_YC(ChkTab,Para)
%%
% global Bwi
ChkTab(2).State(:,1)=4;   %将所有YC状态初始化为4，便于解锁以及初始化
%%%%批量初始化
ChkTab(2).Positn{1,1}=zeros(Para(2).OutSum,3);
ChkTab(2).Positn{1,2}=zeros(Para(2).OutSum,3);
ChkTab(2).Positn{1,3}=zeros(Para(2).OutSum,1);
ChkTab(2).Positn{1,4}=zeros(Para(2).OutSum,1);
ChkTab(2).Positn{1,5}=zeros(Para(2).OutSum,1);