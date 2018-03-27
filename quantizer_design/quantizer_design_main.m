% We start with very simple BPSK over an AWGN channel. The quantizer design
% for is done using the analytic distributions; however  we could also work with LLR samples, but we would still 
% need an analytical model pf p(\lambda| b).

close all;
clear;
addpath('quantDynProg');


%% Generate Samples from an analytical BPSK over AWGN model. 


SNR = 2; %dB
sigma2 = 10^(-SNR/10);
Nb_Ch = 4; %warning: more than 5 bit will be too much in terms of memory and computation!!
Nq_Ch = 2^Nb_Ch;

C = .5 *log2(1+1/sigma2); % AWGN capacity
% Evaluate normalized BICM Capacity?
% Rate_loss = (C - max(MI))/C;
% SNR_loss = 10*log10(2^(2*max(MI))-1) - SNR ;

%% setup quantization algorithm
num_iter = 100;
eps_stop = 1e-12;
quantizer_boundaries_init = linspace(-2/sigma2 -3.5*sqrt(4/sigma2), 2/sigma2 +3.5*sqrt(4/sigma2), Nq_Ch-1);

[MI, R, LLRs_Ch,  quantizer_boundaries, pZ_X_Ch] = quant_alternating(2/sigma2, num_iter, eps_stop, quantizer_boundaries_init);

% We now have the DMC LLR given codebits (pZ_X_Ch) and the numerical values (LLRs_Ch). 

%% Start to design decoder nodes
dc = 6; % Check node degree
dv = 3; % Variable node degree

max_decoder_iterations = 25;


pZ_X_tot            = cell(max_decoder_iterations);
check_node_LUT_tot  = cell(max_decoder_iterations);
Nb_out = 3*ones(1,max_decoder_iterations);  %Number of output bits of variable nodes
cn_mode = 'min_sum';



%% first iteration is different
% [Q_channel,~] = QuantMiDMC(pZ_X_Ch,2^Nb_out(1))
quantizer_boundaries_init_Int = linspace(-2/sigma2 -3.5*sqrt(4/sigma2), 2/sigma2 +3.5*sqrt(4/sigma2), 2^Nb_out(1)-1);
[~, ~, LLRs_Int, ~ , pZ_X_kk] = quant_alternating(2/sigma2, num_iter, eps_stop, quantizer_boundaries_init_Int);

% update checknode distribution
pZ_X_kk = CnUpdateMinsum(pZ_X_kk, LLRs_Int, dc);
% update variable node distribution
[pZ_X_kk, LLRs_Int, MI] = VnUpdateBrute(pZ_X_kk, pZ_X_Ch, dv, 2^Nb_out(1) );

eps_break = 1e-3;
for kk = 2:max_decoder_iterations
    % update checknode distribution
    pZ_X_kk = CnUpdateMinsum(pZ_X_kk, LLRs_Int, dc);
    % update variable node distribution
   [pZ_X_kk, LLRs_Int, MI] = VnUpdateBrute(pZ_X_kk, pZ_X_Ch, dv, 2^Nb_out(kk) );
   if (1-MI)<eps_break
       disp('Converged');
       break;
   end
end



%% sanity check
sanity_check = 1; 
if sanity_check
    Gauss = @(mu,sigma2, x)  1/sqrt(2*pi*sigma2)*exp(-.5* (x-mu).^2/sigma2);
    x = linspace( -2/sigma2 -4*sqrt(4/sigma2), 2/sigma2 +4*sqrt(4/sigma2), 1e3);
    llr_0 = Gauss(-2/sigma2, 4/sigma2,x);
    llr_1 = Gauss(2/sigma2, 4/sigma2,x);
    subplot(4,1,1);
    hold on;
    plot(x,llr_0, 'r-');
    plot(x,llr_1, 'b--');
    plot(quantizer_boundaries, zeros(Nq_Ch-1), 'kx');
    plot(quantizer_boundaries_init, zeros(Nq_Ch-1), 'r+');
    plot(LLRs_Ch, zeros(Nq_Ch), 'g+');
    subplot(4,1,2);
    hold on;
    plot(x,llr_0*.5 + llr_1*.5, 'k-');
    plot(quantizer_boundaries, zeros(Nq_Ch-1), 'kx');
    plot(quantizer_boundaries_init, zeros(Nq_Ch-1), 'r+');
    plot(LLRs_Ch, zeros(Nq_Ch), 'g+');
    subplot(4,1,3);
    hold on;
    stem(LLRs_Ch, pZ_X_Ch(1,:), 'r');
    stem(LLRs_Ch, pZ_X_Ch(2,:), 'b');
    subplot(4,1,4);
    stem(LLRs_Ch, sum(pZ_X_Ch,1)/2, 'k');
    hold off;
end

