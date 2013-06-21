% extractPlates
% Takes all of the subjects and extracts the plate data and saves it.
% Save location is ANALYSIS_DIR\[SubjectName]plates.mat

global ANALYSIS_DIR SUBJECTS;

nSubjects = length(SUBJECTS);
formatString = cat(2,repmat('%s  ',1,nSubjects),'\n',repmat('%02d  ',1,nSubjects));

display(sprintf(formatString,SUBJECTS{:},1:nSubjects));

userInput = input('Start at which subject(#):');
if isempty(userInput), userInput=1;end;
if or(userInput < 1, userInput > nSubjects);
    error('Bad Subject Number')
end


for iSubject = userInput:length(SUBJECTS)
    sub = SUBJECTS{iSubject};
    SubjectStructure = loadsubject(sub);
    variableName = [sub 'plates'];
    fileName = [ANALYSIS_DIR variableName '.mat'];
    
    % gathers the plate data and saves it
    [subjectPlates segmentTimes] = platesData(SubjectStructure);
    savedata(subjectPlates,'plates',sub)
    savedata(segmentTimes,'plates',sub,'Times')
end