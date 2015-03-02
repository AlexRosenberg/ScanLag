%% Config Page for a full graphic analysis of a library (of images).

% % % KEEP ME (This manual) UPDATED !!
% Last updated: 2/7/14 - Omri Hen

%% Include Libraries - DO NOT TOUCH UNLESS THEY WERE MOVED (AND YOU KNOW
% WHAT YOU ARE DOING)

addpath 'D:\ScanLag20131201\TL_Utils'
addpath 'D:\ScanLag20131201\ScannerTimeLapse\V15'

%%

TimeLimit = 6000;

FullPath = {...
'D:\ScanLag\';... 
%  'F:\Scans\Ir20130530\';... 
    };

DirName = {...
'20140702_gal_1_2_12\';...
% 'Ir20130530';... 
    };

expDesc = {'A';'B';'C';...
%    'D';'E';'F';...
};

colour_ = {[0 0 1];[1 0 0];[0 1 0];[0.7 0.2 0.7];[0.8 0.4 0.3];[0.5 0.1 0.8];....    
};

Marker_ = {'x';'x';'x';'x';'x';'x';...   
};

lineStyle_ = {'-';'-';'-';'-';'-';'-';...  
};

% number of plates * dilution
NumberOfPlates = [ 2*0.005; 2*0.005; 2*0.005; 10/10];

%%

numDirs = length(DirName);
TimeAxis = {};
TotalDistr = {};
Time = {};
DC = {};
dataNum = 0;
bin=30;
ShowPlot=0;


% 'A' - 12
dataNum = dataNum+1;

ScannerPlateVec = [...
1,1;... % scanner num
1,6 ... % plate num
    ];
          
DirVec = createDirVec(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);       
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;


% 'B' - 2
dataNum = dataNum+1;

ScannerPlateVec = [...
1,1;... % scanner num
2,4 ... % plate num
    ];
          
DirVec = createDirVec(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);      
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;



% 'C' - 1
dataNum = dataNum+1;

ScannerPlateVec = [...
1,1;... % scanner num
3,5 ... % plate num
    ];
          
DirVec = createDirVec(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);  
[TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
    getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
DirMat{dataNum} = DirVec;


% % 'D'
% dataNum = dataNum+1;
% 
% ScannerPlateVec = [...
% 14,15,16,28,30;... % scanner num
% 2,3,4,5,1 ... % plate num
%     ];
%           
% DirVec = createDirVec(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);       
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
% DirMat{dataNum} = DirVec;
% 
% 
% 
% % 'E'
% dataNum = dataNum+1;
% 
% ScannerPlateVec = [...
% 15,16,28,30;... % scanner num
% 4,3,6,2 ... % plate num
%     ];
%           
% DirVec = createDirVec(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);       
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
% DirMat{dataNum} = DirVec;
% 
% 
% 
% % 'F'
% dataNum = dataNum+1;
% 
% ScannerPlateVec = [...
% 14,15,16,28,30;... % scanner num
% 6,5,2,1,3 ... % plate num
%     ];
%           
% DirVec = createDirVec(char(FullPath(1)), char(DirName(1)), ScannerPlateVec);       
% [TimeAxis{dataNum}, TotalDistr{dataNum}, Time{dataNum} ,DC{dataNum}, Stat{dataNum}] = ...
%     getExperimentResults(DirVec, TimeLimit, ShowPlot, bin);
% DirMat{dataNum} = DirVec;



%% Plot Ira

% Norm Hist
figure;
% subplot(2,1,1);
hold on;
numConditions = size(TotalDistr,2);
leg={};
TotalBact = zeros(1, numConditions);
for k=1:numConditions
    TotalBact(k) = sum(TotalDistr{k});
    plot(TimeAxis{k}, TotalDistr{k}/TotalBact(k)/bin, ...
        'Color',colour_{k},'Marker',Marker_{k},'LineStyle',lineStyle_{k});
    leg(k) = {sprintf('%s, total %4.1f',expDesc{k}, sum(TotalDistr{k}))};
end
legend(leg);
xlim([400 2200])
ylim([0 0.02])
title('Normalized Histograms');
xlabel('Appearance Time [minutes]');
ylabel('Normalized number of appearences');
hold off;

% Death curve
%subplot(2,1,2);
figure;
hold on;
for k=1:numConditions
    semilogy(Time{k}, DC{k}/max(DC{k}), ...
        'Color',colour_{k},'Marker',Marker_{k},'LineStyle',lineStyle_{k});
end
set(gca, 'YScale', 'log')
% xlim([400 2200])
% ylim([1e-2 1e0])
legend(leg);
title('Normalized Death curves');
xlabel('Time [minutes]');
ylabel('Normalized death curve');


%% Hist Not Normalized (average per 100 ml)
figure;
% subplot(2,1,1);
hold on;
numConditions = size(TotalDistr,2);
leg={};
for k=1:numConditions
    plot(TimeAxis{k}, TotalDistr{k}/NumberOfPlates(k),...
         'Color',colour_{k},'Marker',Marker_{k},'LineStyle',lineStyle_{k});
    leg(k) = {sprintf('%s, total %4.1f',expDesc{k}, ...
             sum(TotalDistr{k})/NumberOfPlates(k))};
end
legend(leg);
xlim([400 2200])
title('Histograms (per 100ml)');
xlabel('Appearance Time [minutes]');
ylabel('Number of appearences');
hold off;

% Death curve
subplot(2,1,2);
hold on;
for k=1:numConditions
    semilogy(Time{k}, DC{k}/NumberOfPlates(k),...
             'Color',colour_{k},'Marker',Marker_{k},'LineStyle',lineStyle_{k});
end
set(gca, 'YScale', 'log')
xlim([400 2200])
ylim([1e0 3e2])
legend(leg);
title('Death curves (per 100ml)');
xlabel('Time [minutes]');
ylabel('Death curve');

%% growth Ira

lb = 20;
ub = 80;
leg = {};

TotColoniesIndices = {};
TotAppearanceTime  = {};
TotlbSizeTime      = {};
TotubSizeTime      = {};
NormTotAppearaceTime = {};
GrowthTime = 0:bin:2000;
for k=1:length(DirMat)
    DirVec = DirMat{k};
    [TotColoniesIndices{k}, TotAppearanceTime{k}, TotlbSizeTime{k}, TotubSizeTime{k}]=...
        getColoniesAppearanceSizeTimeAll(DirVec, lb, ub);
    GrowthHist{k} = hist(TotubSizeTime{k}-TotlbSizeTime{k}, GrowthTime);
    mHist{k} = hist2d([(TotubSizeTime{k}-TotlbSizeTime{k}),...
        TotAppearanceTime{k}], GrowthTime, TimeAxis{k});
    growthStat{k} = getStatistics(GrowthTime, TotubSizeTime{k}-TotlbSizeTime{k});
    NormTotAppearaceTime {k} = (TotAppearanceTime{k}-400+20);
end


%% growth Irit
lb = 20;
ub = 80;
leg = {};

ColoniesIndices    = {};
ColoniesAppearance = {};
ColoniesGrowth     = {};
AreaGap            = {};
GrowthTime = 0:bin:2000;

for k=1:length(DirMat)
    
    DirVec = DirMat{k};

    [ColoniesGrowth{k}, ColoniesAppearance{k},ColoniesIndices{k},AreaGap{k},...
               NotBigEnough,MergedBeforUpper]=...
                 getAppearanceGrowthByVec(DirVec,lb,ub);
    currColoniesGrowth = [];
    currColoniesAppearance = [];
    for i=1:size(ColoniesGrowth{k},2)
        currColoniesGrowth = [currColoniesGrowth; ColoniesGrowth{k}{i}] ;
        currColoniesAppearance = [currColoniesAppearance; ColoniesAppearance{k}{i}] ;
    end
    TotColoniesGrowth{k}= currColoniesGrowth;
    TotColoniesAppearance{k}= currColoniesAppearance;
    GrowthHist{k} = hist(TotColoniesGrowth{k}, GrowthTime);
    mHist{k} = hist2d([TotColoniesGrowth{k},...
        TotColoniesAppearance{k}], GrowthTime, TimeAxis{k});
end

%% Irit

figure;
hold on;
for k=1:length(DirMat)
    plot(TotColoniesAppearance{k}, TotColoniesGrowth{k}, ...
        '.', 'Color',colour_{k});  
    leg(k) = expDesc(k);
end



%% scatter plots
figure;
hold on;
for k=1:length(DirMat)
    plot(TotlbSizeTime{k}, TotubSizeTime{k}, ...
        '.', 'Color',colour_{k});  
    leg(k) = expDesc(k);
end
legend(leg);
xlabel(sprintf('Time to reach %2.0f pixels [minutes]', lb));
ylabel(sprintf('Time to reach %2.0f pixels [minutes]', ub));

figure;
hold on;
for k=1:length(DirMat)
    plot(TotAppearanceTime{k}, TotubSizeTime{k} - TotlbSizeTime{k}, ...
        '.', 'Color',colour_{k});  
    leg(k) = expDesc(k);
end
legend(leg);
xlabel('Appearance Time [minutes]');
ylabel(sprintf('Time to reach from %2.0f to %2.0f pixels [minutes]', lb, ub));

figure;
hold on;
for k=1:length(DirMat)
    plot(GrowthTime, GrowthHist{k}/length(ColoniesGrowth{k})/bin, ...
        'Marker',Marker_{k},'LineStyle',lineStyle_{k}, 'Color',colour_{k});  
    leg(k) = expDesc(k);
end
legend(leg);
xlabel(sprintf('Time to reach from %2.0f to %2.0f pixels [minutes]', lb, ub));
title('Normalized histogram')
xlim([0 500])

%% logarithmic scale histograms
indFirst = find(TotalDistr{1}>0,1,'first');
figure;
hold on;
for k=1:length(DirMat)
    [TA,TotalAppearenceTime] = GetAppearanceTimes(DirMat{k});
    ShiftedAppearenceTime = TotalAppearenceTime - TimeAxis{k}(indFirst);
    ShiftedLogTimeAxis = logspace(1 ,3.7 ,40);
    logHist = hist(ShiftedAppearenceTime, ShiftedLogTimeAxis);
    plot(ShiftedLogTimeAxis, logHist/length(TotubSizeTime{k}), ...
        'Marker',Marker_{k},'LineStyle',lineStyle_{k}, 'Color',colour_{k});  
end
legend(leg);
xlabel('Appearance Time [minutes]');
title('Normalized histogram')
set(gca, 'XScale', 'log')


%% "final" figure
figure;
wt =1;
mut = [2,3];
numMut = length(mut);
subplot(numMut+1,3,3)
    mHist{k} = hist2d([TotColoniesGrowth{k},...
        TotColoniesAppearance{k}], GrowthTime, TimeAxis{k});
Plot2dHist(mHist{wt}/TotalBact(wt), TimeAxis{wt}, GrowthTime, ...
    'Appearance Time [minutes]', ...
    'Growth Time [minutes]', ...
    '');
text(550,350,expDesc{wt},'Color',colour_{wt},...
    'FontSize',8,'FontWeight','bold');
% maxClim = 0.088;
% set(gca,'CLim',[0,maxClim]);
colorbar('location','East'); 
xlim([300,1500])
ylim([0,500])
for k=1:numMut
    subplot(numMut+1,3,(k+1)*3-2)
    hold on;
    bar(TimeAxis{wt}, TotalDistr{wt}/TotalBact(wt)/bin,...
        0.5,'FaceColor',colour_{wt},'EdgeColor','none');
    bar(TimeAxis{mut(k)}+bin/2, TotalDistr{mut(k)}/TotalBact(mut(k))/bin,...
        0.5,'FaceColor',colour_{mut(k)},'EdgeColor','none');
    legend(expDesc{wt},expDesc{mut(k)});
    xlim([300,1500])
    box on;

%     subplot(numMut+1,3,(k+1)*3-1)
%     hold on;
%     bar(GrowthTime, GrowthHist{wt}/length(TotubSizeTime{wt})/bin,...
%         0.5,'FaceColor',colour_{wt},'EdgeColor','none');
%     bar(GrowthTime+bin/2, GrowthHist{mut(k)}/length(TotubSizeTime{mut(k)})/bin,...
%         0.5,'FaceColor',colour_{mut(k)},'EdgeColor','none');
%     legend(expDesc{wt},expDesc{mut(k)});
%     xlim([0,500])
%     box on;
    
    
    subplot(numMut+1,3,(k+1)*3-1)
    hold on;
    bar(GrowthTime, GrowthHist{wt}/length(TotColoniesGrowth{wt})/bin,...
        0.5,'FaceColor',colour_{wt},'EdgeColor','none');
    bar(GrowthTime+bin/2, GrowthHist{mut(k)}/length(TotColoniesGrowth{mut(k)})/bin,...
        0.5,'FaceColor',colour_{mut(k)},'EdgeColor','none');
    legend(expDesc{wt},expDesc{mut(k)});
    xlim([0,400])
    box on;


    subplot(numMut+1,3,(k+1)*3)
    Plot2dHist(mHist{mut(k)}/TotalBact(mut(k)), TimeAxis{mut(k)}, GrowthTime, ...
        'Appearance Time [minutes]', ...
        'Growth Time [minutes]', ...
        '');
    text(550,350,expDesc{mut(k)},'Color',colour_{mut(k)},...
        'FontSize',8,'FontWeight','bold');
    colorbar('location','East'); 
%     set(gca,'CLim',[0,maxClim]);

    xlim([300,1500])
    ylim([0,500])
end
subplot(numMut+1,3,4)
title('Appearance time histograms','Fontsize',12)
subplot(numMut+1,3,5)
title('Growth time histograms','Fontsize',12)
subplot(numMut+1,3,(numMut+1)*3-2)
xlabel('Appearance Time [minutes]','Fontsize',12);
subplot(numMut+1,3,(numMut+1)*3-1)
xlabel(sprintf('Time to reach from %2.0f to %2.0f pixels [minutes]', lb, ub)...
    ,'Fontsize',12);

%% Export statistical data to csv
%statdatadir = [char(FullPath(1)), char(DirName(1)),'stats.csv'];
%gstatdir = [char(FullPath(1)), char(DirName(1)),'growthstats.csv'];
%fid = fopen(statdatadir,'wt');
%fid1 = fopen(gstatdir,'wt');
%for i=1:size(Stat,2)
%   fprintf(fid,'%s,%f,%f,%f,%f,%f,%f,%f,%f\n',expDesc{i},Stat{i}.total, Stat{i}.Avg, Stat{i}.std, Stat{i}.skw, Stat{i}.kurtosis, Stat{i}.max, Stat{i}.median, Stat{i}.stdMed); 
%   fprintf(fid1,'%s,%f,%f,%f,%f,%f,%f,%f,%f\n',expDesc{i},growthStat{i}.total, growthStat{i}.Avg, growthStat{i}.std, growthStat{i}.skw, growthStat{i}.kurtosis, growthStat{i}.max, growthStat{i}.median, growthStat{i}.stdMed);
%  fprintf(fid,'%s,%f,%f,%f,%f,%f,%f,%f,%f\n',expDesc{i},Stat{i}.total, Stat{i}.Avg, Stat{i}.std, Stat{i}.skw, Stat{i}.max, Stat{i}.median, Stat{i}.stdMed); 
%  fprintf(fid1,'%s,%f,%f,%f,%f,%f,%f,%f,%f\n',expDesc{i},growthStat{i}.total, growthStat{i}.Avg, growthStat{i}.std, growthStat{i}.skw, growthStat{i}.max, growthStat{i}.median, growthStat{i}.stdMed);
%    
%end
% fprintf('finished\n');
% fclose(fid);
% fclose(fid1);

