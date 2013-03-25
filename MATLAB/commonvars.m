function commonvars
% Sets up many global variables and constants used ubiquitously throughout
% the entire project

global ROOT_DIR HOME_DIR DATA_DIR ANALYSIS_DIR Joints PC_AVG PC_COEFFS
ROOT_DIR = 'C:\OrgCon\';
HOME_DIR = [ROOT_DIR 'OrgConCode\MATLAB\'];
DATA_DIR = [ROOT_DIR 'ExperimentData\'];
ANALYSIS_DIR = [ROOT_DIR 'Analysis\'];



%Joints is a structure that has information on the sensors in the
%cyberglove.
Joints.NAMES = ...
    {'Thumb Rotation';
    'Thumb MCP';
    'Thumb IP';
    'Thumb/Index Abduction';
    'Index MCP';
    'Index PIP';
    'Middle MCP';
    'Middle PIP';
    'Index/Middle Abduction';
    'Ring MCP';
    'Ring PIP';
    'Middle/Ring Abduction';
    'Pinkie MCP';
    'Pinkie PIP';
    'Ring/Pinkie Abduction';
    'Wrist Pitch';
    'Wrist Yaw'};

Joints.ALL = 1:length(Joints.NAMES);
Joints.MCP = [2 5 7 10 13];
Joints.PIP = [3 6 8 11 14];
Joints.ABD = [4 9 12 15];
Joints.THUMB = [1 2 3 4];
Joints.INDEX = [5 6 9];
Joints.MIDDLE = [7 8 9 12];
Joints.RING = [10 11 12 15];
Joints.PINKIE = [13 14 15];
Joints.WRIST = [16 17];


% Principal Components to use as a default
PC_AVG = importdata([ANALYSIS_DIR 'PC_AVG.mat']);
PC_COEFFS = importdata([ANALYSIS_DIR 'PC_COEFFS.mat']);

% Only use the first 3 PC's
PC_COEFFS = PC_COEFFS(1:3,:);