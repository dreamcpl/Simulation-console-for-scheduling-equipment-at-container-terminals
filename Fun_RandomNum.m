function result=Fun_RandomNum(object,mode,num)
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%mode所标示的是输入的一维数组的模式。1表示列向量，2表示行向量。
%该函数的作用是：让object的每个元素都是1到num范围内的任意整数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if mode==1
   for i=1:size(object,1)
       object(i)=ceil(rand*num);
   end
elseif mode==2
   for i=1:size(object,2)
       object(i)=ceil(rand*num);
   end
end
result=object;