function Cmi=MLGA2_Cross(MLGA,Cmi)
%%%%%%%%%%%%%%%%%%模块整体思路%%%%%%%%%%%%%%%%%%
%随机选择两个父代染色体，把两个父代染色体中的0取出后，随机选择相同位置的
%片段进行互换，生成两个心个体。
%%%%%%%%%%%%%各步骤作用及其注意事项%%%%%%%%%%%%%
%1.设定交叉片段长度。
%2.选择父代染色体：用随机数选择两个父代染色体，参与交叉操作。
%3.交叉操作。
%4.结果存储。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%交叉片段长度
pl=1;
%%%%%%%%1 轮盘赌选择交叉染色体
for k=1:MLGA(1).ChmSum
    %%%%%%1.1 随机选择两个染色体
    pick=rand(1,2);
    while prod(pick)==0       %两个随机值里不能有0
          pick=rand(1,2);
    end
    index=ceil(pick.*MLGA(1).ChmSum); %换算成染色体编号
    %%%%%%1.2 判断是否进行交叉
    pick=rand;                %有多少个染色体就要进行多少次轮盘赌
    while pick==0
          pick=rand;
    end
    if pick>MLGA(2).CroPro
       continue
    end
    %%%%%%%%2 进行交叉操作
    f1=Cmi{3,index(1)}(4,:);   f2=Cmi{3,index(2)} (4,:);      %选两个染色体
    val=ceil(rand(size(f1,2)-pl));                               %交叉片段起始点
    f1cp=f1(val:val+pl-1);   f2cp=f2(val:val+pl-1);    %取出交叉片段
    f1(val:val+pl-1)=[];     f2(val:val+pl-1)=[];      %删除对应位置片段
    %插入片段
    object=f1;pos=val;num=pl;
    result=Fun_InsertLane(object,pos,num);
    f1=result;   f1(val+1:val+pl)=f2cp;
    object=f2;pos=val;num=pl;
    result=Fun_InsertLane(object,pos,num);
    f2=result;   f2(val+1:val+pl)=f1cp;
    %存储结果
    Cmi{3,index(1)}(4,:)=f1;  Cmi{3,index(2)}(4,:)=f2;    
end

