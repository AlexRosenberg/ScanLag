function ExcelExport(ProjectFolder,scannernum)
% ExcelExport(ProjectFolder,scannernum)
% -------------------------------------------------------------------------
%  
%   
%   bin is a default of 30 (minutes).
% -------------------------------------------------------------------------

addpath 'C:\ScanLag20131201\TL_Utils'
addpath 'C:\ScanLag20131201\ScannerTimeLapse\V15'


%%
TimeLimit = 6000;
TimeAxis = {};
TotalDistr = {};
Time = {};
DC = {};
dataNum = 0;
bin=30;
ShowPlot=0;

FullPath = {...\
'C:\ScanLag\';...
    };

DirName = {...
strcat(ProjectFolder,'\');...
% If there is NO input (ProjectFolder), it needs to look like this:
% '20140702_gal_1_2_12';...
% ENDING SLASH IS NOW AUTOMATICALLY ADDED.
    };

% DO NOT FORGET FOR I AM THE ALMIGHTY BOARD NUMBER - 1=1, 2=4!

% expDesc = {'A';'B';'C';...
%    'D';'E';'F';...
%};

%% Plates as DirVecs
% 'A' - Plate 1
dataNum = dataNum+1;

ScannerPlateVec = [...
scannernum;... % scanner num
1 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);       
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'B' - Plate 2
dataNum = dataNum+1;

ScannerPlateVec = [...
scannernum;... % scanner num
2 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);    
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'C' - Plate 3
dataNum = dataNum+1;

ScannerPlateVec = [...
scannernum;... % scanner num
3 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);           
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'D' - Plate 4
dataNum = dataNum+1;

ScannerPlateVec = [...
scannernum;... % scanner num
4 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);           
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'E' - Plate 5
dataNum = dataNum+1;

ScannerPlateVec = [...
scannernum;... % scanner num
5 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);          
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'F' - Plate 6
dataNum = dataNum+1;

ScannerPlateVec = [...
scannernum;... % scanner num
6 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);          
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

%% Generate data for each DirVec

lb = 20;
ub = 80;

     TotalAppearenceTime = [];

for k=1:6
     ColoniesAppearance= {};

    DirVec1 = num2str(cell2mat(DirMat{k}));

% Loading data and initializations
DirName = fullfile(DirVec1, 'Results');
load(fullfile(DirName,'VecArea'));
load(fullfile(DirName,'TimeAxis'));
load(fullfile(DirName,'ExcludedBacteria.txt'));

% Colonies Growth Time from 20 to 80 pixels
             [ColoniesIndices,ColoniesGrowth,AreaGap,...
                              NotBigEnough,MergedBeforUpper] =...
                                    getColoniesGrowthRate(DirVec1, lb, ub);
        coloniesNum=size(ColoniesIndices,1);
        for j=1:coloniesNum
            AppearenceIndex1 = find(VecArea(ColoniesIndices(j),:),1,'first');
            ColoniesAppearance=...
                            [ColoniesAppearance;TimeAxis(AppearenceIndex1)];
        end


%% Data Analysis output
[TimeAxis,Histogram]=AddHistograms(DirVec,30);
M1IR = {'Time [min]','New colony appearance'};
TDE=cell2mat(TotalDistr(k));
vectorize(TDE);
    if isrow(TDE)
    TDE= rot90(rot90(rot90(TDE)));
    end
M1data= [TimeAxis,TDE];
M1 = vertcat(M1IR, num2cell(M1data));
%ipeak(M1data);
%% OLD export segment
%csv1dir = {'\appearance.growth.data.csv'};
%csv2dir = {['\sizegrowthdata.',num2str(coloniesNum),'.csv'];};
%    foldername=[DirVec1,char(csv1dir(1))];
%    foldername1=[DirVec1,char(csv2dir(1))];
%    fid = fopen(foldername,'w');
%    fid1 = fopen(foldername1,'w');
%     fprintf(fid,'Growth Time[min]\n%s\n',cell2mat(DataOut)); 
%     fclose(fid);
%     fprintf(fid1,'%g\r\n',ColoniesIndices,cell2mat(ColoniesAppearance)); 
%     fclose(fid1);
%     successnotice = ['File:',csv2dir,'was exported!'];
%     disp(successnotice);
%% NEW EXPORT SEGMENT
sgdatadir = [DirVec1,'\data.xls'];
M2IR = {'Colony indice','Appearance time','Growth time from 20px to 80px','Area gap between the first time above 80px and 20px'};
M2data = [ColoniesIndices, cell2mat(ColoniesAppearance), ColoniesGrowth, AreaGap];
M2 = vertcat(M2IR, num2cell(M2data));
xlswrite(sgdatadir,M2,'Growth data');
xlswrite(sgdatadir,M1,'Colony distribution');

end