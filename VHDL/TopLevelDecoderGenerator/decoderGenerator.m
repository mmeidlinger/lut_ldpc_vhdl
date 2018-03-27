clear 
close all
clc

%% Set parameters

% Add paths
addpath('../../quantizer_design');
addpath('../../quantizer_design/quantDynProg');

% Define code length
param.N = 2048;%10;%

% Variable node degree
param.VNodeDegree = 6;%3;%

% Check node degree
param.CNodeDegree = 32;%6;%

% Code Rate
param.R = 1 - param.VNodeDegree/param.CNodeDegree;

% Load parity-check matrix in a-list form
param.Halist = load(sprintf('../../decoder/codes/v%dc%d-reg_%d', param.VNodeDegree, param.CNodeDegree, param.N));

% Number of check nodes
param.M = size(param.Halist,1);

% Internal LLR bit-width
param.QLLR = 3;

% Channel LLR bit-width
param.QCh = 4;

% Maximum number of iterations
param.maxIter = 5;

% Decoder design SNR (in dB)
param.designSNR = 4.5;

% Convert parity-check matrix to matrix form
param.H = zeros(param.M,param.N);
for ii = 1:param.M
   param.H(ii,param.Halist(ii,:)) = 1;
end

% % Define LUT trees
% % Variable nodes
% % level 0
% param.vnroot= node('root');
% % level 1
% addchild(param.vnroot, 'im');
% addchild(param.vnroot, 'im');
% % level 2
% addchild(param.vnroot.children(2), 'msg');
% addchild(param.vnroot.children(2), 'cha');
% addchild(param.vnroot.children(1), 'im');
% addchild(param.vnroot.children(1), 'im');
% addchild(param.vnroot.children(1).children(1), 'msg');
% addchild(param.vnroot.children(1).children(1), 'msg');
% addchild(param.vnroot.children(1).children(2), 'msg');
% addchild(param.vnroot.children(1).children(2), 'msg');

% NEW TREE, matched with simulation
% level 0
param.vnroot= node('root');
% level 1
addchild(param.vnroot, 'im');
addchild(param.vnroot, 'cha');
% level 2
addchild(param.vnroot.children(1), 'im');
addchild(param.vnroot.children(1), 'msg');
% level 3
addchild(param.vnroot.children(1).children(1), 'im');
addchild(param.vnroot.children(1).children(1), 'im');
% level 4
addchild(param.vnroot.children(1).children(1).children(1), 'msg');
addchild(param.vnroot.children(1).children(1).children(1), 'msg');
addchild(param.vnroot.children(1).children(1).children(2), 'msg');
addchild(param.vnroot.children(1).children(1).children(2), 'msg');

% dv = 3
% % level 0
% param.vnroot= node('root');
% % level 1
% addchild(param.vnroot, 'im');
% addchild(param.vnroot, 'cha');
% % level 2
% addchild(param.vnroot.children(1), 'msg');
% addchild(param.vnroot.children(1), 'msg');


% Decision node
% level 0
param.decroot = node('root');
% level 1
addchild(param.decroot, 'im');
addchild(param.decroot, 'im');
addchild(param.decroot, 'cha');
% level 2
addchild(param.decroot.children(1), 'msg');
addchild(param.decroot.children(1), 'msg');
addchild(param.decroot.children(1), 'msg');
addchild(param.decroot.children(2), 'msg');
addchild(param.decroot.children(2), 'msg');
addchild(param.decroot.children(2), 'msg');

% dv = 3
% % level 0
% param.decroot = node('root');
% % level 1
% addchild(param.decroot, 'msg');
% addchild(param.decroot, 'msg');
% addchild(param.decroot, 'msg');
% addchild(param.decroot, 'cha');

% Check node (no tree as we use min-sum decoding)
param.cnroot = [];

%% Generate required VHDL files

% Get quantizers (stored in param.QVN
param = getQuantizers(param);

% Generate config file
configGenerator(param);

% Generate variable nodes
variableNodeGenerator(param);

% Generate variable node stages
variableNodeStageGenerator(param);

% Generate top-level decoder
topLevelDecoderGenerator(param);
