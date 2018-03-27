function [ sigma_th ] = densityEvolutionBIAWGN( Nq_Msg, Nq_Cha, dv, dc, sw, precision, BER_target, max_dec_it, max_bisec_it,quant_method, cnmethod, vnmethod, cnroot, vnroot, decroot)

ii=0;
converged = false;
while (ii <= max_bisec_it) && (converged == false)
    ii= ii+1;
    sigma_th = mean(sw);
    %% Gennerate Channel and Message DMCs corresponding to current noise level
   [p_Cha, p_Msg,  ~, ~, LLRs_Msg] = initQuantizer(sigma_th, Nq_Cha, Nq_Msg(1));
  

    %% Density Evolution
    achievable = false;
    % update checknode distribution
    [p_Msg, ~ ] = CnUpdate(p_Msg, 0, LLRs_Msg, dc,cnmethod, cnroot);
    % update variable node distribution
    [p_Msg, LLRs_Msg, ~] = VnUpdate(p_Msg, p_Cha, 0, [], dv, Nq_Msg(1), quant_method, vnmethod, vnroot, decroot, 0 );
    for kk = 2:max_dec_it
        achievable = false;
        % update checknode distribution
       [p_Msg, ~ ] = CnUpdate(p_Msg, 0, LLRs_Msg, dc, cnmethod, cnroot);
        % update variable node distribution
       [ p_Msg, LLRs_Msg, MI, ~] = VnUpdate(p_Msg, p_Cha, 0, [], dv, Nq_Msg(kk),quant_method, vnmethod, vnroot, decroot, kk==max_dec_it);

%        Check for Mutual Information
%        if  MI > 0.999
%            achievable = true;
%            break;
%        elseif MI < 0
%            achievable = false;
%            break;
%        end
       % Check for Biterror Probability
       if  sum(p_Msg(1,1:size(p_Msg,2)/2)) <= BER_target;
           achievable = true;
           break;
       elseif MI < 0
           achievable = false;
           break;
       end
    end
    
    if (sw(2)-sw(1))<precision && achievable %Found Solution within the given precision
        converged = true;
    end
    
    if achievable
        sw(1) = sigma_th;
    else
        sw(2) = sigma_th;
    end
end

if converged ==false
    sigma_th = NaN;
end


end


