function OutPut=Test_Print(T,ChkTab,Cwi)
%%%%%%%%%%%%%%%%%%%%%注释%%%%%%%%%%%%%%%%%%%%%
%'%6.2f %12.8f\r\n'这是浮点数输出格式，如：%6.2f表示无论结果有多少位，输出
%                  结果至少占六个制表符，即六个位置，不够的用空格补满，可以
%                  超过，且保留两位小数位。同理，%12.8f占十二个位置，八位小数
% \n 是换行，英文是New line，表示使光标到行首
% \r 是回车，英文是Carriage return，表示使光标下移一格。
% \t tab键 跳格
% rmdir('Data');  %删除Data文件夹
% delete J:/integrated scheduling optimization of YC and YT based on GA/Data
% mkdir('Data');  %创建Data文件夹
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OutPut=1;
DataFile=['Data\',num2str(T),'.txt'];   %位置在J盘文件名为T.txt
dlmwrite(DataFile,T,'delimiter','\t');
dlmwrite(DataFile,Cwi,'-append','delimiter','\t');
dlmwrite(DataFile,'      QCJinDu','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(1).Progrs,'-append','delimiter','\t');
dlmwrite(DataFile,'      YCJinDu','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(2).Progrs,'-append','delimiter','\t');
dlmwrite(DataFile,'      QCState','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(1).State,'-append','delimiter','\t');
dlmwrite(DataFile,'      YCState','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(2).State,'-append','delimiter','\t');
dlmwrite(DataFile,'      YTState','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(3).State,'-append','delimiter','\t');
dlmwrite(DataFile,'      QCWeiZhi','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(1).Positn,'-append','delimiter','\t');
dlmwrite(DataFile,'      YCWeiZhi','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(2).Positn,'-append','delimiter','\t');
dlmwrite(DataFile,'      QCYCBangDing','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(1).EqpBod{1,1},'-append','delimiter','\t');
dlmwrite(DataFile,'      QCYTBangDing','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(1).EqpBod{1,2},'-append','delimiter','\t');
dlmwrite(DataFile,'      YCYTBangDing','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(2).EqpBod,'-append','delimiter','\t');
dlmwrite(DataFile,'      YTYCQCBangDing','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(3).EqpBod,'-append','delimiter','\t');
dlmwrite(DataFile,'      YCXuQiu','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(1).EqpNeed,'-append','delimiter','\t');
dlmwrite(DataFile,'      YTXuQiu','-append','delimiter','\t');
dlmwrite(DataFile,ChkTab(2).EqpNeed,'-append','delimiter','\t');