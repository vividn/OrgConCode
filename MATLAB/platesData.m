function platesData(SubjectStructure,save)
% Extracts all the data from when the subject sets plates on the table
%
% Inputs:
% SubjectStructure: the entire subject's data structure
% save: true if data should be saved after extraction
%
% No Outputs

if nargin < 2
    save = false;
    if nargin < 1
        error('not enough inputs')
    end
end


% The times when the plating segment begin and end can be detected in the
% left hand y-position very easily.
leftHandY = SubjectStructure(1).Lh.y;
beginTime = extremaSelector(leftHandY,'max',10000);
endTime = extremaSelector(leftHandY,'max',14500);

