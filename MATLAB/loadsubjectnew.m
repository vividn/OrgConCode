function SubjectStructure = loadsubjectnew(subjectInitials)
% Creates a new structure for the subject, saves it.
% Saved structure is saved under ANLYSIS_DIR as subjectInitials.mat

global DATA_DIR ANALYSIS_DIR
matFileName = [ANALYSIS_DIR subjectInitials '.mat'];

%The location where all the subject's data is stored
subjectDataDir = [DATA_DIR subjectInitials '\Data\'];

%dir returns a structure of all the subfiles and folders
DataFolderInfo = dir(subjectDataDir);
nExperiments = size(DataFolderInfo,1);

%Iterates through all the experiments in the subject's data folder
for iExperiment = 3:nExperiments; %First two entries in dir are '.' and '..'
    folderName = DataFolderInfo(iExperiment).name;

    %Now check to make sure that the folder is an experiment folder via
    %string scan. 'Exp1\'
    experimentNumber = sscanf(folderName,'Exp%d');
    if isempty(experimentNumber), return;end

    % UI update
    display([subjectInitials, ' - Experiment ', num2str(experimentNumber)]); 

    experimentDir = [subjectDataDir 'Exp' num2str(experimentNumber) '\'];

    %data2mat saves the data into a file once its done. If MATLAB runs
    %out of memory and does not finish all experiments, can reload
    %individual experiment data. Reloads if the experiment data was created
    %after the last time the structure was.
    experimentDataFile = [experimentDir 'Data.mat'];

    experimentDataLastChange = lastmodtime(experimentDataFile);
    dataExists = any(experimentDataLastChange);
    
    matLastChange = lastmodtime(matFileName);
    matExists = any(matLastChange);
    
    dataFileIsGood = dataExists && ...
        (~matExists || experimentDataLastChange > matLastChange);

    if dataFileIsGood
        display('Viable data file found for experiment, loading...')
        SubjectStructure(experimentNumber) = load(experimentDataFile);
    else
        %Extract all pertinent data into structure from raw data
        SubjectStructure(experimentNumber) = data2mat(experimentDir);
    end
    display(sprintf('%s\n\n',repmat('-',1,40)));
end
display('Subject Complete. Saving structure...')
save(matFileName, 'SubjectStructure');
