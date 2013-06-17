function segmentTime = extremaSelector(inputData,extremaType,guessValue,minPeakSeparation,moreData)
% extremaSelector allows the user to select from a number of extrema on
% given data.
%
% This function graphs the data supplied as well as extrema found by the
% findpeaks function. If the user suggests a guessValue, the function will
% color the closest extrema to that value red. User specifies desired
% extrema in relation to the suggested extrema: '+1', '-2', etc. User may just
% press enter to select the suggested extrema.
% User may also change the minPeakSeparation value (if the program does not
% find the desired extrema) by typing in the value(as long as value>20)
%
% Inputs:
% inputData may be a column vector of data or a 2D matrix of data, if it is
%       a matrix, program will iterate through each column.
% extremaType must be either 'max' or 'min'. Which extrema type to look for.
%       Defaults to 'max'
% guessValue is approximately the index value where the desired extrema
%       occurs. If 0, program asks user to select extrema objectively from
%       all found. Defaults to 0.
% minPeakSeparation specifies the MINPEAKDISTANCE parameter in the
%       findpeaks function. Defaults to 2000.
% moreData is a cell array of any additional things to plot, should the
%       user need more information to resolve ambiguity
%
% Output:
% segmentTime = the index at which the selected extremum occurs. If a matrix
% is supplied as input, the output will be a row vector with each index in
% its corresponding column.

% Defualts for unspecified inputs
if nargin < 4
    minPeakSeparation = 2000;
    if nargin < 3
        guessValue = 0;
        if nargin < 2
            extremaType = 'max';
            if nargin < 1
                error('extremaSelector: no data given as input.')
            end
        end
    end
end

% findpeaks only finds local maxima, so data must be flipped if searching
% for minima.
switch extremaType
    case 'max'
        isFlipped = false;
    case 'min'
        inputData = inputData .* -1;
        isFlipped = true;
    otherwise
        error('extremaSelector: extremaType myst be either ''min'' or ''max''')
end

% if guessValue = 0, extrema selection becomes objective (not in reference
% to a suggested extremum.
if guessValue <= 0
    isObjective = true;
else
    isObjective = false;
end

% Display instructions for use
if isObjective
    display('Select desired extremum (1 for leftmost, 2 for next, etc.).')
else
    display('Select desired extremum in relation to the red line (eg. ''-2'' for 2 lines to the left)')
end
display('Numbers > 20 change spacing between the extrema lines [if desired extremum is not found]')

% Number of trials to churn through
nTrials = size(inputData,2);

segmentTime = ones(1,nTrials); % Initialize output variable

%Arbitrary number to signal program to display otherData
%User can type the variable name to signal the program.
m = 6475823;

for iTrial = 1:nTrials; %iterates through the columns
    trialData = inputData(:,iTrial);
    userInput = minPeakSeparation; % Initializes user input to progress through while loop
    showMoreData = false;
    
    while userInput > 20
        clf
        if isFlipped
            plot(-trialData)
        else
            plot(trialData)
        end
        
        if showMoreData
            hold all
            for iData = 1:length(moreData)
                newData = moreData{iData};
                plot(newData(:,iTrial));
            end
        end
        
        [~,extremaIndices] = findpeaks(trialData,'MINPEAKDISTANCE',userInput);
        vline(extremaIndices,'k--');
        
        % Red line for suggested extremum if not objective
        if isObjective
            iExtremum = 0;
        else
            [closestExtrema,iExtremum] = closestval(extremaIndices,guessValue);
            vline(closestExtrema,'r-')
        end
        
        %User makes selection (if invalid will just ask again)
        try
            userInput = input('?:');
        end
        if isempty(userInput)
            userInput = isObjective + 0; % 0 for subjective selection, 1 for objective
        end
        if userInput == m;
            showMoreData = true;
            userInput = minPeakSeparation; %resets the userInput
        end
    end
    
    selectedExtrema = extremaIndices(iExtremum + userInput);
    segmentTime(1,iTrial) = selectedExtrema;
end
