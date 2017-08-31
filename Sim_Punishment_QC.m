function ChkTab=Sim_Punishment_QC(ChkTab,Para)
%%
ChkTab(1).Positn(:,4)=0;    %受干扰状态每次都先恢复，然后再进行评估
for i=1:Para(1).Sum-1
    %%如果根本就没有QC处于绑定YC的状态，说明当前QC都还没有工作，直接跳出去
    if isempty(ChkTab(1).EqpBod{1,1})
        return
    end
    %%编号为i和i+1的QC中，只要有一个不在工作，就不用考虑惩罚(没有被绑定，就是还没有在工作)
    if isempty(find(ChkTab(1).EqpBod{1,1}(:,1)==i)) || isempty(find(ChkTab(1).EqpBod{1,1}(:,1)==i+1))
       continue
    end
    %%小编号QC应当在大编号QC左边，否则染色体无效，即不允许QC跨越现象出现。
    if ChkTab(1).Positn(i+1,1)-ChkTab(1).Positn(i,1)<=0
       ChkTab(1).Positn(i,4)=2;    %受干扰状态为2,即无效染色体
       return
    elseif ChkTab(1).Positn(i+1,1)-ChkTab(1).Positn(i,1)>0 && ChkTab(1).Positn(i+1,1)-ChkTab(1).Positn(i,1)<=Para(2).SfDs
       if ChkTab(1).State(i,1)==2 && ChkTab(1).State(i+1,1)==2
         if ChkTab(1).Positn(i+1,3)-ChkTab(1).Positn(i,3)>0
           ChkTab(1).Positn(i,4)=1;
           ChkTab(1).Positn(i+1,4)=0;
         elseif ChkTab(1).Positn(i+1,3)-ChkTab(1).Positn(i,3)<0
           ChkTab(1).Positn(i,4)=0;
           ChkTab(1).Positn(i+1,4)=1;
         elseif ChkTab(1).Positn(i+1,3)-ChkTab(1).Positn(i,3)==0
           if rand>=0.5
              ChkTab(1).Positn(i,4)=1;
              ChkTab(1).Positn(i+1,4)=0;
           elseif rand>0.5
              ChkTab(1).Positn(i,4)=0;
              ChkTab(1).Positn(i+1,4)=1;
           end
         end
       end
    elseif ChkTab(1).Positn(i+1,1)-ChkTab(1).Positn(i,1)>Para(2).SfDs
       ChkTab(1).Positn(i,4)=0;
       ChkTab(1).Positn(i+1,4)=0;
    end
end

