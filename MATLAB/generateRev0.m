function SubjectStructure = generateRev0(subjectInitials)
% Generates the first set of data, in mostly raw form. The data is
% untruncated, not smoothed and has a lot of data that we probably won't
% end up using.
% The output is structure with several fields, the most important of which
% are the substructures, Rh and Lh. These have the data for their
% corresponding hand including x,y,z,az,el,roll,gloveRaw,glove,and glovePC

global DATA_DIR
%The location where all the subject's data is stored
subjectDataDir = [DATA_DIR subjectInitials '\Data\'];

%dir returns a structure of all the subfiles and folders
DataFolderInfo = dir(subjectDataDir);
nScenes = size(DataFolderInfo,1);

dataFileCellArray = cell(1,nScenes - 2);

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
    dataFileCellArray{sceneNumber} = sceneDataFile;

    sceneDataLastChange = lastmodtime(sceneDataFile);
    dataExists = any(sceneDataLastChange);

    if dataExists
        display('Viable data file found for scene, loading...')
        SubjectStructure(sceneNumber) = load(sceneDataFile);
    else
        %Extract all pertinent data into structure from raw data
        SubjectStructure(sceneNumber) = data2mat(sceneDir);    
    end
    SubjectStructure(sceneNumber).name = subjectInitials;
    display(sprintf('%s\n\n',repmat('-',1,40)));
end

%Once the entire structure is generated delete temporary files
delete(dataFileCellArray{:})
    