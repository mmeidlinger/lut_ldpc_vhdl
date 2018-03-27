clear 
close all
clc

%% Set parameters

% Add paths
addpath('../../quantizer_design');
addpath('../../quantizer_design/quantDynProg');

% Define code length
param.N = 2048;

% Variable node degree
param.VNodeDegree = 6;

% Check node degree
param.CNodeDegree = 32;

% Load parity-check matrix in a-list form
param.Halist = load(sprintf('../../decoder/codes/v%dc%d-reg_%d', param.VNodeDegree, param.CNodeDegree, param.N));

% Number of check nodes
param.M = size(param.Halist,1);

% Internal LLR bit-width
param.QLLR = 5;

% Channel LLR bit-width
param.QCh = 5;

% Maximum number of iterations
param.maxIter = 5;

% Convert parity-check matrix to matrix form
param.H = zeros(param.M,param.N);
for ii = 1:param.M
   param.H(ii,param.Halist(ii,:)) = 1;
end

%% Generate required VHDL files

% Generate config file
configGenerator(param);

% Generate top-level decoder
topLevelDecoderGenerator(param);