function [MI, R, LLRs, pZ_X] = compute_mi(mu, quantizer_boundaries)
% Compute MI for quantized, conditionally gaussian LLRs distributed according to N(+-mu,
% 2mu), where for BPSK over AWGN channel mu = 2/sigma2


    N = 1000;
    num_levels = length(quantizer_boundaries) + 1;
    MI = 0;
    R = 0;
    
    LLRs = zeros(1, num_levels);
    
    quantizer_boundaries = [quantizer_boundaries(1) - 10*sqrt(mu) quantizer_boundaries quantizer_boundaries(end) + 10*sqrt(mu)];
    
    pZ_X = zeros(num_levels, 2);
    for i = 1:num_levels
        y = linspace(quantizer_boundaries(i), quantizer_boundaries(i+1), N);
        p0 = trapz(y, exp(-(y-mu).^2 / (4*mu)) / sqrt(4*pi*mu));
        p1 = trapz(y, exp(-(y+mu).^2 / (4*mu)) / sqrt(4*pi*mu));
        
%         LLR_(i) = trapz( y, (y.*exp(-(y-mu).^2 / (4*mu)) + y.*exp(-(y-mu).^2 / (4*mu)) ) / (sqrt(4*pi*mu)*(p0+p1)/2));
        
        pZ_X(i,1) = p0;
        pZ_X(i,2) = p1;
        p = (p0 + p1) / 2;
        MI = MI + p0 * log2(2 * p0 / (p0 + p1)) / 2 + p1 * log2(2 * p1 / (p0 + p1)) / 2;
        R = R - p * log2(p);
        LLRs(i) = log(p0 / p1);
    end
    0;
    pZ_X = pZ_X.';
end
