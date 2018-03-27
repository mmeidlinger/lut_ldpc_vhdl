clear 
close all
clear all
clc

%% Set independent parameters

% Codec filename generated from the C++ program
param.lut_tree_filename = '../../lut_ldpc/results/RES_N2048_R0.841309_maxIter8_zcw0_frames100_minLUT/lut_codec.it';

% Codec filename generated from the C++ program
param.alist_filename = '../../lut_ldpc/codes/rate0.84_reg_v6c32_N2048.alist';




%% Dependent parameters

% Convert parity-check matrix to matrix form
param.H = load_alist(param.alist_filename);

% Define code length
param.N = size(param.H ,2);

% Number of check nodes
param.M = size(param.H,1);

% Load LUT Trees
[vn_tree_array, cn_tree_array, max_iters, reuse_vec, Nq_Msg, Nq_Cha, vn_degrees, cn_degrees] = load_lut_trees(param.lut_tree_filename);
% check if a regular code min-lut (i.e. no cn luts was imported) and throw
% and error if not. this should be removed and the script generation
% adopted to be capable to process those cases

if(size(vn_tree_array,1)>1)
    error('Irregular Codes not supported yet!')
end
if(~isempty(cn_tree_array))
    error('CN LUTs not supported yet!')
end
if(sum(reuse_vec)>0)
    error('Reusing LUTs not supported yet!')
end
if(length(unique(Nq_Msg)) ~= 1)
    error('Downsizing LUTs not supported yet!')
end

param.QVN = vn_tree_array;


% Variable node degree
param.VNodeDegree = vn_degrees;

% Check node degree
param.CNodeDegree = cn_degrees;

% Internal LLR bit-width
param.QLLR = log2(unique(Nq_Msg));

% Channel LLR bit-width
param.QCh = log2(Nq_Cha);

% Maximum number of iterations
param.maxIter = max_iters;







%% Generate required VHDL files

% Generate config file
configGenerator(param);

% Generate variable nodes
variableNodeGenerator(param);

% Generate variable node stages
variableNodeStageGenerator(param);

% Generate top-level decoder
topLevelDecoderGenerator(param);
