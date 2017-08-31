function result=Fun_SpecialOrder(object,line,pattern)
result=object;
%%%%ÉýÐò»¹ÊÇ½µÐò
if pattern==0
   [~,link]=sort(object(:,line));
elseif pattern==1
   [~,link]=sort(object(:,line),'descend');
end
for i=1:size(object,1);
    result(i,:)=object(link(i),:);
end