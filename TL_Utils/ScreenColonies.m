function [Colonies,areas]= ScreenColonies(FileDir)

 DirName = fullfile(FileDir, 'Results');
 load(fullfile(DirName,'VecArea'));
 load(fullfile(DirName,'VecCen'));
 load(fullfile(DirName,'VecBBox'));
% load(fullfile(DirName,'ExcludedBacteria.txt'));
 load(fullfile(DirName,'TimeAxis'));
%allColonies=1:size(VecArea,1);
allColonies = FindColoniesInWorkingArea(FileDir); %Screening colonies that 
%                                                   are too close to the border
NColonies=length(allColonies);
%screen out colonies that appeared before 8 hours
for k=1:NColonies
    AppearanceIndex = find(VecArea(allColonies(k),:),1);
    AppearanceMinute(k) = TimeAxis(AppearanceIndex);
end
ind=find(AppearanceMinute>240);
Colonies=allColonies(ind);


%screen colonies with final size<10

ColoniesFinalSize=VecArea(Colonies,end);
smallCol=Colonies(find(ColoniesFinalSize<10));
Colonies=setdiff(Colonies, smallCol);
%For appearance time - we take merged colonies 
%For growth rate - we exclude merged colonies



%Screen merged colonies
allMerged=getMergedColonies(fullfile(FileDir, 'Results')); %0 if not merged, time of merging if merged
merged=find(allMerged); 
Colonies=setdiff(Colonies, merged);


%Colonies now have the colonies' indices (=rows in the VecArea matrix)
%after screening

%save the data
screened_data.colonies_ind=Colonies; 
screened_data.area=VecArea(Colonies,:);
screened_data.center=VecCen(Colonies,:,:);
screened_data.bbox=VecBBox(Colonies,:,:);
save([DirName '\screened_data'],'screened_data');
areas=VecArea(Colonies,:);
save([DirName '\screened_area.txt'], 'areas', '-ascii');




