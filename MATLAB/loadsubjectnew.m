function SubjectStructure = loadsubjectnew(subjectInitials)
% Creates a new structure for the subject, saves it.
% Saved structure is saved under ANLYSIS_DIR as subjectInitials.mat

global DATA_DIR ANALYSIS_DIR
matFileName = [ANALYSIS_DIR subjectInitials '.mat'];

%The location where all the subject's data is stored
subjectDataDir = [DATA_DIR subjectInitials '\Data\'];

%dir returns a structure of all the subfiles and folders
DataFolderInfo = dir(subjectDataDir);
nScenes = size(DataFolderInfo,1);

%Iterates through all the scenes in the subject's data folder
for iScene = 3:nScenes; %First two entries in dir are '.' and '..'
    folderName = DataFolderInfo(iScene).name;

    %Now check to make sure that the folder is an scene folder via
    %string scan. 'Scene1\'
    sceneNumber = sscanf(folderName,'Scene%d');
    if isempty(sceneNumber), return;end

    % UI update
    display([subjectInitials, ' - Scene ', num2str(sceneNumber)]); 

    sceneDir = [subjectDataDir 'Scene' num2str(sceneNumber) '\'];

    %data2mat saves the data into a file once its done. If MATLAB runs
    %out of memory and does not finish all scenes, can reload
    %individual scene data. Reloads if the scene data was created
    %after the last time the structure was.
    sceneDataFile = [sceneDir 'Data.mat'];

    sceneDataLastChange = lastmodtime(sceneDataFile);
    dataExists = any(sceneDataLastChange);
    
    matLastChange = lastmodtime(matFileName);
    matExists = any(matLastChange);
    
    dataFileIsGood = dataExists && ...
        (~matExists || sceneDataLastChange > matLastChange);

    if dataFileIsGood
        display('Viable data file found for scene, loading...')
        SubjectStructure(sceneNumber) = load(sceneDataFile);
    else
        %Extract all pertinent data into structure from raw data
        SubjectStructure(sceneNumber) = data2mat(sceneDir);    
    end
    SubjectStructure(sceneNumber).name = subjectInitials;
    display(sprintf('%s\n\n',repmat('-',1,40)));
end
display('Subject Complete. Saving structure...')
save(matFileName, 'SubjectStructure');
