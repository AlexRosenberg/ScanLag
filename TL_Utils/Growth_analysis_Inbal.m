
DirName='20150201_B5\';
BoardNum=5;
FullPath = {...
'C:\ScanLag\';...
    };
dataNum=0;
%% Plates as DirVecs
% 'A' - Plate 1
dataNum = dataNum+1;

ScannerPlateVec = [...
BoardNum;... % scanner num
1 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName), ScannerPlateVec);       
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'B' - Plate 2
dataNum = dataNum+1;

ScannerPlateVec = [...
BoardNum;... % scanner num
2 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName), ScannerPlateVec);    
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'C' - Plate 3
dataNum = dataNum+1;

ScannerPlateVec = [...
BoardNum;... % scanner num
3 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName), ScannerPlateVec);           
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'D' - Plate 4
dataNum = dataNum+1;

ScannerPlateVec = [...
BoardNum;... % scanner num
4 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName), ScannerPlateVec);           
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'E' - Plate 5
dataNum = dataNum+1;

ScannerPlateVec = [...
BoardNum;... % scanner num
5 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName), ScannerPlateVec);          
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;

% 'F' - Plate 6
dataNum = dataNum+1;

ScannerPlateVec = [...
BoardNum;... % scanner num
6 ... % plate num
    ];
          
DirVec = createDirVec1(char(FullPath(1)), char(DirName), ScannerPlateVec);          
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;
%%
for plate=6

    ColoniesAppearance= {};

    DirVec1 = num2str(cell2mat(DirMat{plate}));

    % Loading data and initializations
    DirName = fullfile(DirVec1, 'Results');
    load(fullfile(DirName,'VecArea'));
    load(fullfile(DirName,'TimeAxis'));
    load(fullfile(DirName,'ExcludedBacteria.txt'));


    [Colonies,areas]= ScreenColonies(DirVec1);


    %smooth the area vectors

    sm_area=zeros(size(areas));
    for k=1:size(areas,1)
        sm_area(k,:)=smooth(areas(k,:),'moving');
    end;
    start_growth_time=zeros(k,1);
    end_growth_time=zeros(k,1);
    start_growth_ind=zeros(k,1);
    end_growth_ind=zeros(k,1);
    change_time=zeros(k,2);
    change_points=zeros(k,2);
    is_final_size=zeros(k,1);
    final_size=zeros(k,1);
    final_time=zeros(k,1);
    slope1=zeros(k,1);
    slope2=zeros(k,1);
    slope3=zeros(k,1);
    avg_slope=zeros(k,1);
    
    der1=diff(sm_area,1,2);
    der2=diff(sm_area,2,2);
    for k=1:size(areas,1)
        start_growth_ind(k)=find(der1(k,:),1,'first');
        end_growth_ind(k)=find(der1(k,:),1,'last');
        change_points=find(abs(der2(k,:))>1);
        tmp_ind=find(change_points>start_growth_ind(k),2,'first');
        if size(tmp_ind)>0 change(k,:)=change_points(tmp_ind); else change(k,:)=[1 1]; end;
        change_time(k,:)=TimeAxis(change(k,:));
        if end_growth_ind(k)<size(der1,2)
            is_final_size(k)=1;
            final_size(k)=sm_area(k,end_growth_ind(k));
            final_time(k)=TimeAxis(end_growth_ind(k));
            
        else
            is_final_size(k)=0;
            final_size(k)=sm_area(k,end_growth_ind(k));
            final_time(k)=TimeAxis(end_growth_ind(k));
 
        end;
        end_growth_time(k)=TimeAxis(end_growth_ind(k));
        start_growth_time(k)=TimeAxis(start_growth_ind(k));
        avg_slope(k)=(sm_area(k,end_growth_ind(k))-sm_area(k,start_growth_ind(k)))/...
            (end_growth_time(k)-start_growth_time(k));
        if size(change(k,2)==1) change(k,2)=change(k,1); end;
        if change(k,1)>1
             slope1(k)= (sm_area(k,change(k,1))-sm_area(k,start_growth_ind(k)))/...
                   (change_time(k,1)-start_growth_time(k));
               if change(k,2)>1
                    slope2(k)=(sm_area(k,change(k,2))-sm_area(k,change(k,1)))/...
                        (change_time(k,2)-change_time(k,1));
                    slope3(k)=(sm_area(k,end_growth_ind(k))-sm_area(k,change(k,2)))/...
                        (end_growth_time(k)-change_time(k,2));
               else
                   slope2(k)=(sm_area(k,end_growth_ind(k))-sm_area(k,change(k,1)))/...
                        (end_growth_time(k)-change_time(k,1));
                    slope3(k)=NaN;
               end;
        else
            slope1(k)=NaN;
            slope2(k)=NaN;
            slope3(k)=NaN;
            
        end;

    end;
    

    %% exmaple for excel writing with headers

    sgdatadir = [DirVec1,'\slopes_data.xls'];
    M2IR = {'Colony number','Starting growth time (appearance)','End growth time','Avg slope','1st change of slope','2nd change of slope','slope 1','slope 2','slope 3','Size plateau?','Final size','Final size time'};
    M2data = [Colonies,start_growth_time,end_growth_time,avg_slope,change_time(:,1),change_time(:,2),slope1,slope2,slope3,is_final_size,final_size,final_time];
    M2 = vertcat(M2IR, num2cell(M2data));
    xlswrite(sgdatadir,M2,'Growth data');

    %%
end;
