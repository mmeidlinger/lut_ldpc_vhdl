function [p_Cha, p_Msg,  qb_Cha, qb_Msg, LLRs_Msg] = initQuantizer(sigma_th, Nq_Cha, Nq_Msg)
% Initialize the quantizers

init_mode = 'continous';    % could be passed to the function, but there is not much of a difference

switch init_mode
    case 'continous'
        %% Design quantizers for a continous pdf
        % This is only locally optimal
        quantizer_boundaries_init = linspace(-2/sigma_th^2 -3.5*sqrt(4/sigma_th^2), 2/sigma_th^2 +3.5*sqrt(4/sigma_th^2), Nq_Cha-1);
        [~, ~, ~, qb_Cha_init, p_Cha_init] = quant_alternating(2/sigma_th^2, 100, 1e-9, quantizer_boundaries_init);

        quantizer_boundaries_init = linspace(-2/sigma_th^2 -3.5*sqrt(4/sigma_th^2), 2/sigma_th^2 +3.5*sqrt(4/sigma_th^2), Nq_Msg-1);
        [~, ~, LLRs_Msg_init, qb_Msg_init , p_Msg_init] = quant_alternating(2/sigma_th^2, 100, 1e-9, quantizer_boundaries_init);

        %% symmetrize
        % In general, the optimal quantizers from above are symmetric, however,
        % slightly off symmetry results may propagate and cause errors

        % Symmetrize Message Distributions
        p_Msg(1,:)     = (p_Msg_init(1,:) + fliplr(p_Msg_init(2,:)))/2;
        p_Msg(2,:)     = fliplr(p_Msg_init(1,:));

        % Symmetrize channel distribution
        p_Cha(1,:)     = (p_Cha_init(1,:) + fliplr(p_Cha_init(2,:)))/2;
        p_Cha(2,:)     = fliplr(p_Cha_init(1,:));

        % Symmetrize LLRs
        LLRs_Msg = zeros(size(LLRs_Msg_init));
        LLRs_Msg(1:Nq_Msg/2)     = (LLRs_Msg_init(1:Nq_Msg/2) - fliplr(LLRs_Msg_init(Nq_Msg/2+1:end)))/2;
        LLRs_Msg(Nq_Msg/2+1:end) = -fliplr(LLRs_Msg(1:Nq_Msg/2));

        % Symmetrize Quantizer boundaries
        qb_Cha = zeros(size(qb_Cha_init));
        qb_Cha(1:Nq_Cha/2-1) = (qb_Cha_init(1:Nq_Cha/2-1) - fliplr(qb_Cha_init(Nq_Cha/2+1:end)))/2 ;
        qb_Cha(Nq_Cha/2)=0;
        qb_Cha(Nq_Cha/2+1:end) = -fliplr(qb_Cha_init(1:Nq_Cha/2-1));

        qb_Msg = zeros(size(qb_Msg_init));
        qb_Msg(1:Nq_Msg/2-1) = (qb_Msg_init(1:Nq_Msg/2-1) - fliplr(qb_Msg_init(Nq_Msg/2+1:end)))/2 ;
        qb_Msg(Nq_Msg/2)=0;
        qb_Msg(Nq_Msg/2+1:end) = -fliplr(qb_Msg_init(1:Nq_Msg/2-1));
    

    case 'discrete'
        %% Quantize the continous pdf to a discrete pmf via fine, uniform quantization
        % Afterwards, apply the discrete quantization algorithm. This is
        % globally optimal
         Nq_fine = 5000;
         mu = 2/sigma_th^2;
         sig = sqrt(2*mu);

         qb_fine = linspace(-mu -4*sig, mu +4*sig, Nq_fine-1);
         q_fine = zeros(2, Nq_fine);
         inf_abs = 10*sqrt(mu);
         q_fine(2,1) =       qfunc( (-inf_abs+mu)/sig) - qfunc( (qb_fine(1)+mu)/sig);
         q_fine(2,2:end-1) = qfunc( (qb_fine(1:end-1)+mu)/sig ) - qfunc( (qb_fine(2:end)+mu)/sig);
         q_fine(2,end)    =  qfunc( (qb_fine(end)+mu)/sig) - qfunc( (inf_abs+mu)/sig);
         q_fine(2,:)= q_fine(2,:)/sum(q_fine(2,:),2);
         q_fine(1,:) = fliplr(q_fine(2,:));

         [Q_Cha,~] = QuantMiDmcSym(q_fine, Nq_Cha);
          p_Cha = q_fine*Q_Cha';
         [~,Q_Cha_labels]  = max(Q_Cha);
         qb_Cha = qb_fine(diff(Q_Cha_labels)==1);

         [Q_Msg,~] = QuantMiDmcSym(q_fine, Nq_Msg);
          p_Msg = q_fine*Q_Msg';
         [~,Q_Msg_labels]  = max(Q_Cha);
         qb_Msg = qb_fine(diff(Q_Msg_labels)==1);

         LLRs_Msg = log(p_Msg(1,:))- log(p_Msg(2,:));

     
    otherwise
        error('Init Mode not supported!');
 end

 
end
