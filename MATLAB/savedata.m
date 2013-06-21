function savedata(data,category,subject,subcategory)
% Saves the specified data in the following format:
% ANALYSIS_DIR\dataName\subjectcategory.mat
% for example savedata(data,'plates','AB') saves the data as:
% ANALYSIS_DIR\plates\ABplates.mat
% Later, when the data is loaded, it will be loaded under the same name as
% the file (e.g., ABplates).
%
% If a subcategory is specified it is appended onto the filename, (e.g.,
% ABplatesTimeFrame)

global ANALYSIS_DIR;

if nargin <4
    subcategory = '';
    if nargin <3
        error ('Must specify subject during saving')
    end
end

dataName = [subject category subcategory];
fileName = [ANALYSIS_DIR category '\' dataName '.mat'];

% Put the data into a variable with the correct name:
evalString1 = [dataName ' = ' 'data;'];
eval(evalString1);

% Save the new data to the proper place
evalString2 = ['save(', 'fileName', ',', 'dataName' ')'];
eval(evalString2);