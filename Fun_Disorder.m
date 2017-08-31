function result=Fun_Disorder(object)
temp1=object;
temp2=randperm(length(object));
for i=1:length(object)
    temp1(i)=object(temp2(i));
end
result=temp1;
