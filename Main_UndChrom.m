function Cmi=Main_UndChrom(Cmi,MLGA,Para,SYwi)
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%●SYwi有3行，分别是任务编号、箱区编号、某任务在某箱区内的集装箱数量
%●YCChrom在SYwi（简化场桥任务信息）的基础上添加第4行，随机场桥编码。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:MLGA(1).ChmSum
    YCChrom=[];
    for j=1:size(Cmi{2,i},2)
         WNum=Cmi{2,i}(1,j);
         TSgCm=SYwi(:,find(SYwi(1,:)==WNum));
         YCChrom=[YCChrom,TSgCm];
    end
    YCChrom(4,:)=zeros(1,size(SYwi,2));
    YCChrom(4,:)=Fun_RandomNum(YCChrom(3,:),2,Para(2).OutSum);
    Cmi{3,i}=YCChrom;
end
    
