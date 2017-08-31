function allot=Fun_BalaDis(num,sum,base)
%%%%参数
allot=zeros(num,1);              %用来存储结果
origin=randperm(sum+num-1);      %总数加上间隔数
addition=zeros(sum+num+1,1);     %在origin前后各添加一个0，共分成了num个小段
%%%%生成num-1个0
origin(find(origin<=num-1))=0;
addition(2:sum+num)=origin;      %从1：sum+num-1都还要加上1
%%%%统计每个数的值，即每个小段所包含的元素的个数
zeropos=find(addition==0);
for i=1:num
    allot(i)=zeropos(i+1)-zeropos(i)-1;  %需要掐头去尾，比如1和4之间只有4-1-1=2个数，不包括4
end                                      %【【注意】】虽然此处没有避免0个元素小段的出现，但是在后面会进行修复
%%%%将结果修正到得到满意解（对两个极值动刀）
cycle=1;
while cycle==1
    [maxvalue,maxpos]=max(allot);
    [minvalue,minpos]=min(allot);
    if maxvalue-minvalue<=base && minvalue>0 %两个极值的差不超过底线，而且最小值也不能是0
       cycle=0;
    else                                 %如果base=1，那么两个奇数最终相差为1，偶数最终会相等。
       allot(maxpos)=allot(maxpos)-1;
       allot(minpos)=allot(minpos)+1;
    end
end
%%%%对最终结果进行随机排序（因为极大极小值都是从第一个值开始搜索）
temp1=allot;                  
temp2=randperm(num);          
for j=1:num                  
    allot(j)=temp1(temp2(j));
end