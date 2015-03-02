function ShowColony(ColonyNum,TimeMin)
DirName='20150105_B5\';
BoardNum=5;
PlateNum=1;
FullPath = 'C:\ScanLag\';
SubDir=sprintf('%d_%d',BoardNum,PlateNum);
FullDir=[FullPath DirName SubDir];
LFile=sprintf('L%d_0%d.mat',PlateNum,TimeMin);
load(fullfile(FullDir,'\Results','VecBBox'));
LFile=fullfile(FullDir,'\LRGB',LFile);
if ~exist(LFile) error('Time error'); end;
load(LFile);
Lrgb = label2rgb(L, 'jet', 'k', 'shuffle');
figure; imagesc(Lrgb);
hold on;
frame_num=(TimeMin-1)/30+1;
if (frame_num<1 || frame_num>size(VecBBox,3)) error('Time error'); end;
if (ColonyNum<1 || ColonyNum>size(VecBBox,1)) error('Colony number error');end;
    
rec=VecBBox(ColonyNum,:,frame_num);
rec(1:2)=rec(1:2)-2; rec(3:4)=rec(3:4)+4;
rectangle('Position',rec,'EdgeColor','w');
