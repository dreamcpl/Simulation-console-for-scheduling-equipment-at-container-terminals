function ChkTab=Sim_EqipComb_YC(ChkTab,Para)
%%
for i=1:Para(2).OutSum
    if ChkTab(2).EqpBod(i,1)==0 && ChkTab(2).EqpBod(i,2)~=0
       ChkTab(2).EqpBod(i,1)=ChkTab(2).EqpBod(i,2);
       ChkTab(2).EqpBod(i,2)=0;
    end
end

       