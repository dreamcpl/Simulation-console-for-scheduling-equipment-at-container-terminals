function Cmi=MLGA1_Cross(MLGA,Para,Cmi)
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
    QCnum=ceil(rand*Para(1).Sum);                %选择一台岸桥
    f1=Cmi{4,index(1)}(QCnum,:); f2=Cmi{4,index(2)}(QCnum,:);      %挑出岸桥任务编码
    f1(f1==0)=[];         f2(f2==0)=[];            %去掉里面的0
    %如果去掉0之后，只剩下一个基因位，则无法交叉，直接到下一个染色体
    if size(f1,2)==1
        continue
    end
    val=ceil(rand(size(f1,2)-pl));                     %交叉片段起始点
    f1cp=f1(val:val+pl-1);   f2cp=f2(val:val+pl-1);        %取出交叉片段
    for i=1:pl                                   %删除对方重复片段
        f1(f1==f2cp(i))=[];
        f2(f2==f1cp(i))=[];
    end
    %插入片段
    object=f1;pos=val;num=pl;
    result=Fun_InsertLane(object,pos,num);
    f1=result;   f1(val+1:val+pl)=f2cp;
    object=f2;pos=val;num=pl;
    result=Fun_InsertLane(object,pos,num);
    f2=result;   f2(val+1:val+pl)=f1cp;
    %任务安排结果存储
    Cmi{4,index(1)}(QCnum,1:size(f1,2))=f1;
    Cmi{4,index(2)}(QCnum,1:size(f2,2))=f2;
    %染色体编码结果存储
    Cmi{2,index(1)}=MLGA_Encode(Cmi{4,index(1)});
    Cmi{2,index(2)}=MLGA_Encode(Cmi{4,index(2)});
end