clear 
close all
clc

%% Set independent parameters
H_filename = '../../codes/rate0.84_reg_v6c32_N2048.alist';

% Internal LLR bit-width
param.QLLR = 5;

% Channel LLR bit-width
param.QCh = 5;

% Maximum number of iterations
param.maxIter = 5;

%% Set parameters

% Load parity-check matrix in a-list form
param.H = load_alist(H_filename);

% Define code length
param.N = size(param.H,2);

% Number of check nodes
param.M = size(param.H,1);

% Variable node degree
if( length(unique(sum(param.H,1))) == 1 )
    param.VNodeDegree = full(sum(param.H(:,1)));
else
    error('Irregular Codes not supported yet!')
end

% Check node degree
if( length(unique(sum(param.H,2))) == 1 )
    param.CNodeDegree = full(sum(param.H(1,:)));
else
    error('Irregular Codes not supported yet!')
end


%% Generate required VHDL files

% Generate config file
configGenerator(param);

% Generate top-level decoder
topLevelDecoderGenerator(param);