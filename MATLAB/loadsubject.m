function SubjectStructure = loadsubject(subjectInitials)
% Loads an existing structure of a subject's data
% If no strucuture exists, runs function to generate the structure.
%
% Subject structure should be under ANALYSIS_DIR as subjectInitials.mat

global ANALYSIS_DIR

%Compare the last modified time of data2mat (a program that generates a
%.mat file from the data) and the .mat file to be generated.

% Generation process is computationally expensive, so only run data2mat if
% the .mat file doesn't exist, or the program has been changed since the
% last structure generation.

programLastChange = lastmodtime('data2mat.m');

matFileName = [ANALYSIS_DIR subjectInitials '.mat'];
matLastChange = lastmodtime(matFileName);
matExists = any(matLastChange); %True if .mat file exists, false if not


if ~matExists
    % Warn user that a new file is being generated
    display('Subject data structure not found. Generating...');
    SubjectStructure = loadsubjectnew(subjectInitials);
    return;
    
elseif matLastChange < programLastChange
   display(['Data structure may be out of date. Consider running'...
        ' loadsubjectnew.']);
end

display(['Loading "' matFileName '"'])
SubjectStructure = importdata(matFileName);
display('Done.')