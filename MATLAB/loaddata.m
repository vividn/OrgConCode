global experimentDir subject DATA_DIR %#ok<NUSED>

% If the experiment directory has not been set, must setup experiment
if isempty(experimentDir);
    commonvars; %Loads common directories and variables for project
    setupexperiment(input('Subject Intials:','s'),input('Experiment Number:'));
end

% For now, not going to be using scaleing, may delete later
%{
if ~exist('scl','var'); scl = input('Scale data to consistent time? (y/n):','s');end %If time should be scaled for matching purposes
if strcmp(scl,'n');scl='';end
if scl;scl='_scl';end
%}

%Compare the last modified time of data2mat (a program that generates a
%.mat file from the data. And the .mat file to be generated.

% Generation process is computationally expensive, so only run data2mat if
% the .mat file doesn't exist, or the program has been changed since the
% last .mat generation.

data2matFileInfo = dir('data2mat.m');
data2matLastChangeTime = data2matFileInfo.datenum; %Last moddified time


matrixFileName = [experimentDir 'datamat.mat'];
matrixFileInfo = dir(matrixFileName);
matrixExists = size(matrixFileInfo, 1); %Size of structure is 0x1 if no file
if matrixExists, matrixLastChangeTime = matrixFileInfo.datenum;end


%Run the data2mat program if needed, else, it can just load the .mat
if ~matrixExists || (matrixLastChangeTime < data2matLastChangeTime)
    data2mat(experimentDir);
end

%Since this is a script file, get rid of all the temp variables used in the
%program.
clearvars -except experimentDir subject DATA_DIR

%Finally, load the desired data
load([experimentDir 'datamat.mat'])