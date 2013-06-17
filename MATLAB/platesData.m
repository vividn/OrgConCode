function platesDataOut = platesData(SubjectStructure)
% Extracts all the data from when the subject sets plates on the table
%
% Inputs:
% SubjectStructure: the entire subject's data structure
% save: true if data should be saved after extraction
%
% Outputs a 3D matrix. Time x PC(1-3 right, 4-6 left) x Trial 
% Matrix is padded with NaNs, since duration of plating segment varies
% trial to trial.


% The times when the plating segment begin and end can be detected in the
% left hand y-position very easily. The other position data matrices are
% sent to resolve any ambiguity.
leftHandY = SubjectStructure(1).Lh.y;
otherData = {SubjectStructure(1).Lh.x;
             SubjectStructure(1).Rh.x;
             SubjectStructure(1).Rh.y;};

% Tell user to search for first peak
clf
text(.5,.5,'Identify Start of Sequence','HorizontalAlignment','center',...
    'FontSize',38)
pause
beginTime = extremaSelector(leftHandY,'max',11000,2000,otherData);

% Tell user to search for second peak
clf
text(.5,.5,'Identify End of Sequence','HorizontalAlignment','center',...
    'FontSize',38)
pause
endTime = extremaSelector(leftHandY,'max',15000,2000,otherData);

plateRhPc = processData(SubjectStructure(1).Rh.glovePC,beginTime,endTime);
plateLhPc = processData(SubjectStructure(1).Lh.glovePC,beginTime,endTime);

platesDataOut = cat(2,plateRhPc,plateLhPc);

end %function plateData


function outputData = processData(data,beginTime,endTime)
% Chops the data at the specified begining and end points
% and then concatenates and pads the result into a new matrix
nTrials = min(size(beginTime,2),size(endTime,2));
dim = find(size(data)==nTrials);
if isempty(dim)
    error('Number of trials and timepoints not equivalent')
end

% Initialize output variable (must start empty for cat purposes)
outputData = [];

% Add all the truncated data
for iTrial = 1:nTrials
    truncationIndices = beginTime(iTrial):endTime(iTrial);
    
    %Create a structure for custom indexing
    S = struct;
    S.type= '()';
    S.subs = {truncationIndices,':',':'}; % Sets up the subs
    S.subs{dim} = iTrial; % Replaces the correct index with the trial number
    
    truncatedData = subsref(data,S);
    outputData = nancat(dim,outputData,truncatedData);
end
end %function processData

