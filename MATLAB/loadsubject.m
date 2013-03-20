function SubjectStructure = loadsubject(subjectInitials)
% Loads or generates a structure of a subject's data

global DATA_DIR ANALYSIS_DIR
if isempty(DATA_DIR)
    commonvars() %Initializes all the the global variables
end

%Compare the last modified time of data2mat (a program that generates a
%.mat file from the data) and the .mat file to be generated.

% Generation process is computationally expensive, so only run data2mat if
% the .mat file doesn't exist, or the program has been changed since the
% last structure generation.

programLastChange = lastmodtime('data2mat.m');

matFileName = [ANALYSIS_DIR subjectInitials '.mat'];
matLastChange = lastmodtime(matFileName);
matExists = any(matLastChange); %True if .mat file exists, false if not

dataConversionNeeded = ~matExists || ...
    (matLastChange < programLastChange);

if dataConversionNeeded
    % Warn user that a new file is being generated
    display(['Data file out of date or nonexistant. Generating a new file.']);
    
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
        %individual experiment data by doing similar comparison as above
        experimentDataFile = [experimentDir 'Data.mat'];
        
        experimentDataLastChange = lastmodtime(experimentDataFile);
        dataExists = any(experimentDataLastChange);
        dataFileIsGood = dataExists && ...
            (programLastChange < experimentDataLastChange);
        
        if dataFileIsGood
            display('Viable data file found for experiment, loading...')
            SubjectStructure(experimentNumber) = load(experimentDataFile);
        else
            %Extract all pertinent data into structure
            SubjectStructure(experimentNumber) = data2mat(experimentDir);
        end
        display(sprintf('%s\n\n',repmat('-',1,40)));
    end
    display('Subject Complete. Saving structure...')
    save(matFileName, 'SubjectStructure');
else
    display('Viable data file found. Loading...')
    % If all the data is recent and prepared just load it.
    SubjectStructure = importdata(matFileName);
end
display('Done.')