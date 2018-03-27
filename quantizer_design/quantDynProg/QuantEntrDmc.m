% [Q,MI] = QuantMiDmc(P,K)
%
% Finds the K-Partition of P that maximizes Entropy.
% P is a vector of length M and K is an integer, generally less
% than M. 
%
% Q is one of the optimal quantizers. Q(m,k) is a 1 if DMC output m is quantized
% to k, and otherwise is a 0.
%
% MI is the mutual information between the channel input and the quantizer
% output.
%
% QuantEntrDMC (c) 2015 Michael Meidlinger,
% based on QuantMiDMC by Brian Kurkoski
% Distributed under an MIT-like license; see the file LICENSE
%

error('Run the command MEXIFY to compile QUANTENTRDMC before using it');
