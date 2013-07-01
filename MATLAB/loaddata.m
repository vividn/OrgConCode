function dataOutput = loaddata(category,subject,subcategory)

global ANALYSIS_DIR

if nargin < 3
    subcategory = '';
end

fileName = [ANALYSIS_DIR category '/' subject category subcategory '.mat'];
dataOutput = importdata(fileName);