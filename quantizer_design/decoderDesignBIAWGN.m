function [ Q_Cn, Q_Vn, MI, qb_Cha, qb_Msg] = decoderDesignBIAWGN( Nq_Msg, Nq_Cha, reuseLUT, dv, dc, SNR, max_dec_it, qmode, cnmethod,  vnmethod, cnroot,vnroot, decroot, useDecNode)


    sigma_th = 10^(-SNR/20);
    
    
    %% Gennerate Channel and Message DMCs corresponding to current noise level
    
     [p_Cha, p_Msg, qb_Cha, qb_Msg, LLRs_Msg ] = initQuantizer(sigma_th, Nq_Cha, Nq_Msg(1));

    %% Decoder Design
    Q_Cn = cell(1,max_dec_it);
    Q_Vn = cell(1,max_dec_it);
    % update checknode distribution
    [p_Msg, Q_Cn{1}]= CnUpdate(p_Msg, 0 , LLRs_Msg, dc, cnmethod, cnroot);
%     MI_msg = getMI([.5; .5], p_Msg.')
%     MI_cha = getMI([.5; .5], p_Cha.')
    % update variable node distribution
    [p_Msg, LLRs_Msg, ~, Q_Vn{1}] = VnUpdate(p_Msg, p_Cha, 0, [], dv, Nq_Msg(2),qmode, vnmethod, vnroot(1), decroot, 0);
    for kk = 2:max_dec_it
%         kk
        % update checknode distribution
       [p_Msg, Q_Cn{kk}] = CnUpdate(p_Msg,reuseLUT(kk), LLRs_Msg, dc, cnmethod, cnroot);
%        MI_msg = getMI([.5; .5], p_Msg.')
%        MI_cha = getMI([.5; .5], p_Cha.')
        % update variable node distribution
       [p_Msg, LLRs_Msg, MI, Q_Vn{kk}] = VnUpdate(p_Msg, p_Cha,reuseLUT(kk), Q_Vn{kk-1}, dv, Nq_Msg(kk+1),qmode, vnmethod, vnroot(kk), decroot,(kk == max_dec_it) && useDecNode);
        
        
%        rel_dev = abs(mean(Q_Vn{kk}.Q)-(Nq_Msg(kk)-1)/2)*2/((Nq_Msg(kk)-1));
%        if ( (rel_dev > 0.15) || (MI >= (1-1e-6)) )
%          % If the conditional message distribution gets too peaky, the quantizer design
%          % will not yield meaningful results
%          for ii=kk:max_dec_it
%              Q_Vn{ii} = Q_Vn{kk-1}.deepcopy();
%          end
%          break;
%        end
    end

end


