function revisionOutput = loadsubjectnew(subjectInitials,revNum)
% Creates a new structure for the subject, saves it.
% Saved structure is saved under ANLYSIS_DIR as subjectInitials.mat

global ANALYSIS_DIR SUBJECTS

LATEST_REVISION = 1;
header = [subjectInitials ' - '];

if nargin < 2
    revNum = LATEST_REVISION;
end

if strcmp(subjectInitials, 'all');
    for iSubject = 1:length(SUBJECTS)
        loadsubjectnew(SUBJECTS{iSubject},revNum)
        revisionOutput = [];
    end
else

    % Check if revision 0 exists
    rev0FileName = [ANALYSIS_DIR '0\' subjectInitials '0' '.mat'];
    rev0LastChange = lastmodtime(rev0FileName);
    rev0Exists = any(rev0LastChange);
    
    % Check if revision 1 exists
    rev1FileName = [ANALYSIS_DIR '1\' subjectInitials '1' '.mat'];
    rev1LastChange = lastmodtime(rev1FileName);
    rev1Exists = any(rev1LastChange);
    
    % Lower the revision number if files do not exist yet
    if revNum > 0 && ~rev0Exists
        display('Cannot detect revision 0.')
        revNum = 0;
    end
    
    if revNum > 1 && ~rev1Exists
        display('Cannot detect revision 1.')
        revNum = 1;
    end
    
    %%%%%%%%%%%%%%
    % Revision 0 %
    %%%%%%%%%%%%%%
    if revNum <= 0
        display([header 'Generating Revision 0'])
        SubjectStructure = generateRev0(subjectInitials);
        display([header 'Saving Revision 0'])
        rev0FileName = savedata(SubjectStructure,'rev0',subjectInitials);
        display(['Saved to: ' rev0FileName])
    else
        SubjectStructure = loaddata('rev0',subjectInitials);
    end
    
    %%%%%%%%%%%%%%
    % Revision 1 %
    %%%%%%%%%%%%%%
    if revNum <= 1
        display('Generating Revision 1')
        SubStructR1 = generateRev1(SubjectStructure);
        display('Saving Revision 1')
        rev1FileName = savedata(SubStructR1,'',subjectInitials);
        display(['Saved to: ' rev1FileName])
    else
        SubStructR1 = loaddata('',subjectInitials);
    end
    
    display('Subject complete.')
    revisionOutput = SubStructR1;
end

% Only output if specified
if nargout < 1
    clearvars revisionOutput
end