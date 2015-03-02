%% Config Page for a full processing of a library (of images).
%  Make sure you "backup" the recent project by copying it's board
%  definitions and config file (this one) at the archive folder in a folder
%  assigned the recent project name.
%
%  Board 1 = First round plastic board and so on
%
% % % KEEP ME (This manual) UPDATED !!
% Last updated: 8/1/15 - Omri Hen

%% Include Libraries - DO NOT TOUCH UNLESS THEY WERE MOVED (AND YOU KNOW
% WHAT YOU ARE DOING)

addpath 'C:\ScanLag20131201\TL_Utils'
addpath 'C:\ScanLag20131201\ScannerTimeLapse\V15'

%% Definitions

PicDir = 'C:\ScanLag\';
Foldername = '195_196_198_new_B4';
BoardNum = 4;

% Optionals
ExpTitle = 'Exp';
Plate1Description ='P1';
Plate2Description ='P2';
Plate3Description ='P3';
Plate4Description ='P4';
Plate5Description ='P5';
Plate6Description ='P6';

%% Dont touch past here unless you know what your'e upto

 plateVec = [1 2 3 4 5 6 ];
 SourceDirName = strcat(PicDir,Foldername);
 DestDirName = strcat(PicDir,Foldername);
 PreparePictures(DestDirName, BoardNum, plateVec, SourceDirName );
 fclose('all');

%% Creates Dirs for cut pictures of plates

DirVec = {...
             strcat(PicDir,Foldername,'\',num2str(BoardNum),'_1');...
     strcat(PicDir,Foldername,'\',num2str(BoardNum),'_2');...
     strcat(PicDir,Foldername,'\',num2str(BoardNum),'_3');...
     strcat(PicDir,Foldername,'\',num2str(BoardNum),'_4');...
     strcat(PicDir,Foldername,'\',num2str(BoardNum),'_5');...
     strcat(PicDir,Foldername,'\',num2str(BoardNum),'_6');...
    };

%% Describes whats up

DescriptionVec = {...
                 strcat(ExpTitle,'_Scanner_',num2str(BoardNum),'_Plate_',Plate1Description);...
      strcat(ExpTitle,'_Scanner_',num2str(BoardNum),'_Plate_',Plate2Description);...
      strcat(ExpTitle,'_Scanner_',num2str(BoardNum),'_Plate_',Plate3Description);...
      strcat(ExpTitle,'_Scanner_',num2str(BoardNum),'_Plate_',Plate4Description);...
      strcat(ExpTitle,'_Scanner_',num2str(BoardNum),'_Plate_',Plate5Description);...
      strcat(ExpTitle,'_Scanner_',num2str(BoardNum),'_Plate_',Plate6Description);...
     };
     
TLAllPlates(DirVec, DescriptionVec);
fclose('all');
close all
%% Make me some data!
disp('-----------------------------------------------------------------');
disp('Exporting Excel Data!');
ExcelExport(Foldername, BoardNum);

%% Done Message!
disp('Done!');