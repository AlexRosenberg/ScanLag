function [TimeAxis,TotalDistr]=GalHistograms
% [TimeAxis,Histogram]=AddHistograms(DirVec, board)
% -------------------------------------------------------------------------
%  This function creates a plot of a few plates averaged into a
%   histogram of appearance time.
%   bin is a default of 30 (minutes).
% -------------------------------------------------------------------------

ExpVec = {
%    ['Insert (FULL) Pathway HERE'];
'C:\ScanLag\20150107_B3_Short_preexp\3_1';
% 'C:\ScanLag\20150110_B5\5_5';
    };
[TimeAxis,Histogram]=AddHistograms(ExpVec,30);
figure;
plot(TimeAxis,Histogram);
xlabel('Appearance Time (min)');
ylabel('New colony appearance');
datamatrix = {TimeAxis; cell2mat(Histogram)};

