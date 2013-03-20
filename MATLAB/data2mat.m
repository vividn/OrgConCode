function ExperimentStructure = data2mat(experimentDir)
%DATA2MAT loads the raw data from the experiment directory and processes
%some of it. Then it saves all the generated matrices into a file.
%

trialLengths = load([experimentDir 'TrialLengths']);
timeTicks = (1:max(trialLengths))';

trials = load([experimentDir 'Trials'])';
%If a trial is repeated in the experiment, data is overwritten, but an
%extra trial is still recorded.
trials = unique(trials);

%Dimensions of the structure components (for preallocation)
dataDim = [max(timeTicks) max(trials)];
gloveDim = [max(timeTicks) 17 max(trials)];
a = nan(dataDim); %Tempoary variables for preallocation
b = nan(gloveDim);

%Initialize structures
[Rh Lh]= deal(struct('x',a,'y',a,'z',a,'az',a,'el',a,'roll',a,'v',a,'glove',b));


for iTrial = trials    
    trialStr = num2str(iTrial);
    display(['Trial ' num2str(iTrial)])
    
    %%POLHEMUS FASTRAK DATA AGGREGATION%%
    display(['  Loading fastrak data...'])
    %Data arrangement:
    % null RH(x y z az el roll) null LH(x  y  z  az el roll) null)
    % 1       2 3 4 5  6  7     8       9  10 11 12 13 14    15
    fastrakRaw = load([experimentDir 'Pol_Data' trialStr]);
    fastrakTime = load([experimentDir 'Pol_Time' trialStr]);
    
    % Trim the first 20 entries (timing issues occur when polhemus, etc.
    % first starts
    fastrakRaw(1:20,:) = [];
    fastrakTime(1:20,:) = [];
    
    % Occasionally duplicate times sneak into the data, must delete
    [fastrakTime, fastrakRaw] = deleteduplicates(fastrakTime,fastrakRaw);
    
    % Interpolate the data
    fastrakInterpolate = interp1(fastrakTime,fastrakRaw,timeTicks);
    
    %Separate into the two hands
    rhFastrakData = fastrakInterpolate(:,2:7); 
    lhFastrakData = fastrakInterpolate(:,9:14);
    
    %Extract important components
    Rh = fastrak2struct(Rh,rhFastrakData,iTrial);
    Lh = fastrak2struct(Lh,lhFastrakData,iTrial);
    
    
    %%CYBERGLOVE DATA AGGREGATION%%
    display(['  Loading cyberglove data...'])
    
    Degree.Rh = load([experimentDir 'RH_Deg' trialStr]);
    Raw.Rh = load([experimentDir 'RH_Raw' trialStr]);
    Time.Rh = load([experimentDir 'RH_Time' trialStr]);
    Degree.Lh = load([experimentDir 'LH_Deg' trialStr]);
    Raw.Lh = load([experimentDir 'LH_Raw' trialStr]);
    Time.Lh = load([experimentDir 'LH_Time' trialStr]);
    
    handNames = {'Rh';'Lh'};
    for i = 1:length(handNames);
        hand = handNames{i};
        %Trim first 20 entries
        Degree.(hand)(1:20,:) = [];
        Raw.(hand)(1:20,:) = [];
        Time.(hand)(1:20,:) = [];
        
        % Delete any duplicate times
        [Time.(hand), Degree.(hand), Raw.(hand)] = ...
            deleteduplicates(Time.(hand), Degree.(hand), Raw.(hand));

        % Interpolate the data
        DegreeInterp.(hand) = interp1q(Time.(hand),Degree.(hand),timeTicks);
        RawInterp.(hand) = interp1q(Time.(hand),Raw.(hand),timeTicks);
    end % hand
    
    Rh.glove(:,:,iTrial) = DegreeInterp.Rh;
    Rh.gloveRaw(:,:,iTrial) = RawInterp.Rh;
    
    Lh.glove(:,:,iTrial) = DegreeInterp.Lh;
    Lh.gloveRaw(:,:,iTrial) = RawInterp.Lh;
    
end; % iTrial

% calculates the velocities of the hands
Rh.v = computevelocity(timeTicks,Rh.x,Rh.y,Rh.z);
Lh.v = computevelocity(timeTicks,Lh.x,Lh.y,Lh.z);

% Computes Principal Component Scores from the glove data
display('Computing principal component scores of all glove data...')
Rh.glovePC = glove2pcscores(Rh.glove);
Lh.glovePC = glove2pcscores(Lh.glove);

display('Saving...')
save([experimentDir 'Data.mat'],'experimentDir','trials','trialLengths',...
    'timeTicks','Rh','Lh');
ExperimentStructure = load([experimentDir 'Data.mat']);
display('Experiment loaded.')


function [outTimes varargout] = deleteduplicates(inTimes,varargin)
inDataArray = varargin;
%Get indices of time duplicates and remove
[~, timeIndex, ~] = unique(inTimes,'first');
outTimes = inTimes(timeIndex);
for i = 1:length(inDataArray)
    % Remove the same indices from all the data
    varargout(i) = {inDataArray{i}(timeIndex,:,:)};
end

function StructureOut = fastrak2struct(StructureIn, fastrakData, trialNumber)
fieldName = {'x';'y';'z';'az';'el';'roll'};
for i = 1:length(fieldName)
    StructureIn.(fieldName{i})(:,trialNumber) = fastrakData(:,i);
end
StructureOut = StructureIn;
