function Finval=Sim_EndJudge(ChkTab,Para,T,Static)
%%
%%如果时间到了还没结束，就按情况2处理
if T>=Static.End-Static.Accu
    Finval=2;
end
%%YC是否不符合安全距离约束
for i=1:Para(2).Sum
    if ChkTab(1).Positn(i,4)==2
       Finval=2;
       break
    end
end
%%QC是否不符合安全距离约束
% for i=1:Para(1).Sum
%     if ChkTab(1).Positn(i,4)==2
%        Finval=2;
%        break
%     end
% end
%%QC是否符合结束条件
for i=1:Para(1).Sum
    if ChkTab(1).State(i,1)~=4
       Finval=0;
       break
    elseif ChkTab(1).State(i,1)==4 && i==Para(1).Sum
       Finval=1;
       break
    end
end

    
    
    