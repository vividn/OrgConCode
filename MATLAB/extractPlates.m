% extractPlates
% Takes all of the subjects and extracts the plate data and saves it.
% Save location is ANALYSIS_DIR\[SubjectName]plates.mat

global ANALYSIS_DIR SUBJECTS;

for iSubject = 1:length(SUBJECTS)
    sub = SUBJECTS{iSubject};
    SubjectStructure = loadsubject(sub);
    variableName = [sub 'plates'];
    fileName = [ANALYSIS_DIR variableName '.mat'];
    
    % gathers the plate data and saves it under a custom name (hence the
    % evals)
    eval([variableName ' = platesData(SubjectStructure)'])
    eval(['save(' fileName variableName])
end