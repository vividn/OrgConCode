function setupexperiment(subjectInitials, experimentNumber)


global DATA_DIR subject subjectDir experimentStr experimentNum experimentDir

if isempty(DATA_DIR)
    error('Global data directory, DATA_DIR, must be set to initialize experiment variables.')
end

subject = subjectInitials;
subjectDir = [DATA_DIR subject '\'];
if nargin >= 2
    experimentStr = num2str(experimentNumber);
    experimentNum = str2double(experimentStr);
    experimentDir = [subjectDir 'Data\Exp_' experimentStr '\'];
end