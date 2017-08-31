function [X,Y]=Fun_Num2RowLane(num,lane)
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%本模块目的在于计算出num所属的行和列。
%注意：X相当于是列，而Y才是行。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
val=floor(num/lane);
if num==val*lane
   Y=val;
   X=lane;
elseif num>val*lane
   Y=val+1;
   X=num-val*lane;
end