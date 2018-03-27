function [ p_Msg_out, MI, Q_out] = VnUpdateBrute( p_Msg, p_Cha,  dv, Nq_Msg, quant_method )

p_Msg_prod1 = p_Cha(1,:);
p_Msg_prod2 = p_Cha(2,:);
for ii = 1:dv-1
    p_Msg_prod1 = kron(p_Msg(1,:), p_Msg_prod1);
    p_Msg_prod2 = kron(p_Msg(2,:), p_Msg_prod2);
end
p_Msg_prod = [p_Msg_prod1/sum(p_Msg_prod1) ; p_Msg_prod2/sum(p_Msg_prod2)];
[~,idx] = sort( p_Msg_prod(1,:) ./ p_Msg_prod(2,:), 'ascend');
p_Msg_prod = p_Msg_prod(:,idx);


switch quant_method
    case 'maxMI'
        [Q,MI] = QuantMiDmc(p_Msg_prod, Nq_Msg);
        p_Msg_out = p_Msg_prod*Q';
    case 'maxEntr'
        [Q,~] = QuantEntrDmc(sum(p_Msg_prod*0.5), Nq_Msg);
        p_Msg_out = p_Msg_prod*Q';
        tmp = p_Msg_out*0.5 .* log2(p_Msg_out./ repmat(sum(p_Msg_out*0.5,1), [size(p_Msg_out,1),1] ));
        MI = sum(tmp(~isnan(tmp)));
    otherwise
        error('Quantizer Design method not supported!')
end

[~,Q_labels]  = max(Q);
Q_out(idx) = (Q_labels-1).';

end

%% Explicit indexind to double check
% 
% pZ_X_old = p_Msg;
% pZ_X_channel = p_Cha;
% 
% B= 2;
% L_Int = size(p_Msg,2);
% L_Ch  = size(p_Cha,2);
% 
% 
% llr_combos = zeros(L_Int^(dv-1)*L_Ch, dv);
% llr_combos(:, 1) = repmat( (1:L_Ch).', [L_Int^(dv-1), 1]);
% for ii=2:dv
%     tmp =  repmat((1:L_Int), [L_Ch*L_Int^(ii-2), 1]);
%     llr_combos(:,ii)= repmat( tmp(:), [L_Int^(dv-ii), 1]);
% end
% llr_combos = fliplr(llr_combos);
% 
% pZ_X_full = zeros(2, size(llr_combos,1));
% 
% % Build the Product DMC p(all_LLR_combinations | source bit of VN that receives the CN message)
% tmp = zeros(dv,1);
% for kk=1:size(llr_combos,1)
%     for bb=1:B
%         for ii=1:dv-1
%             tmp(ii) =  pZ_X_old(bb,llr_combos(kk,ii));
%         end
%         tmp(end) = pZ_X_channel(bb,llr_combos(kk,end));
%         pZ_X_full(bb, kk) = exp(sum(log(tmp)));
%     end
% end
% 
% pZ_X_full(1,:) = pZ_X_full(1,:)/sum(pZ_X_full(1,:));
% pZ_X_full(2,:) = pZ_X_full(2,:)/sum(pZ_X_full(2,:));
% 
% 
% % sort ascending in the value of the output LLRs
% LLR_full = log(pZ_X_full(1,:)) - log(pZ_X_full(2,:));
% [LLR_full, sort_idx] = sort(LLR_full, 'ascend');
% pZ_X_full = pZ_X_full(:,sort_idx);
% 
% % Reduce the Product DMC to p(LLR of VN that receives the CN message | source bit of VN that receives the CN message)
% % [Q_cell,MI] = QuantMiDmcMulti(pZ_X_full.',2^Nb_out);
% % Q = Q_cell{1};
% [Q,MI] = QuantMiDmc(pZ_X_full,Nq_Msg);
% [~,Q_labels]  = max(Q);
% 
% Q_out_check = Q_labels(idx)-1;

