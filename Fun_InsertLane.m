function result=Fun_InsertLane(object,pos,num)
tempbox=zeros(size(object,1),size(object,2)+num);
if pos==0             %如果是在第一列插入
   tempbox(:,num+1:size(object,2)+num)=object;
elseif pos==size(object,2)  %如果是在最后一列插入
   tempbox(:,1:size(object,2))=object;
else                 %如果是在中间插入
   tempbox(:,1:pos)=object(:,1:pos);
   tempbox(:,pos+num+1:size(object,2)+num)=object(:,pos+1:size(object,2));
end
result=tempbox;