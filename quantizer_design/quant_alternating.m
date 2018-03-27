function [MI, R, LLRs, quantizer_boundaries, pZ_X] = quant_alternating(mu, num_iter, eps_stop, quantizer_boundaries_init)
% quantize conditionally gaussian LLRs distributed according to N(+-mu,
% 2mu), where for BPSK over AWGN channel mu = 2/sigma2

    m = 1;
    eta = inf;

    quantizer_boundaries = quantizer_boundaries_init;
    MI = zeros(num_iter + 1, 1);
    R = zeros(num_iter + 1, 1);
    [MI(1), R(1), LLRs] = compute_mi(mu, quantizer_boundaries);

    while (m <= num_iter && eta >= eps_stop)
        quantizer_boundaries = log(log((1 + exp(LLRs(2:end))) ./ (1 + exp(LLRs(1:(end-1))))) ./ log((1 + exp(-LLRs(1:(end-1)))) ./ (1 + exp(-LLRs(2:end)))));
        [MI(m+1), R(m+1), LLRs, pZ_X] = compute_mi(mu, quantizer_boundaries);
        eta = (MI(m+1) - MI(m)) / MI(m+1);
        m = m + 1;
    end
    
    MI = MI(1:m);
    R = R(1:m);
end
