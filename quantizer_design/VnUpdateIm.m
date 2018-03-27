function [ p_Msg_out, MI, Q_out] = VnUpdateIm( p_Msg_cell , Nq_Msg, quant_method, varargin )


if ~isempty(varargin) && strcmp(quant_method, 'keepOld')
    % If we pass a quantier, we only update the p_Msg_out and MI
    Q_out = varargin{1};
end

p_Msg = p_Msg_cell{end};
p_Msg_prod1 = p_Msg(1,:);
p_Msg_prod2 = p_Msg(2,:);
for ii = length(p_Msg_cell)-1:-1:1
    p_Msg = p_Msg_cell{ii};
    p_Msg_prod1 = kron(p_Msg(1,:), p_Msg_prod1);
    p_Msg_prod2 = kron(p_Msg(2,:), p_Msg_prod2);
end


p_Msg_prod = [p_Msg_prod1/sum(p_Msg_prod1) ; p_Msg_prod2/sum(p_Msg_prod2)];
[~,idx] = sort( log(p_Msg_prod(1,:)) - log(p_Msg_prod(2,:)), 'ascend');



switch quant_method
    case 'maxMI'
        p_Msg_prod = p_Msg_prod(:,idx);
        [Q,MI] = QuantMiDmc(p_Msg_prod, Nq_Msg);
        p_Msg_out = p_Msg_prod*Q';
        [~,Q_labels]  = max(Q);
        Q_out(idx) = (Q_labels-1).';
    case 'maxMIsym'
        p_Msg_prod = p_Msg_prod(:,idx);
        [Q,MI] = QuantMiDmcSym(p_Msg_prod, Nq_Msg);
        p_Msg_out = p_Msg_prod*Q';
        [~,Q_labels]  = max(Q);
        Q_out(idx) = (Q_labels-1).';
    case 'maxEntr'
        p_Msg_prod = p_Msg_prod(:,idx);
        [Q,~] = QuantEntrDmc(sum(p_Msg_prod*0.5), Nq_Msg);
        p_Msg_out = p_Msg_prod*Q';
        tmp = p_Msg_out*0.5 .* log2(p_Msg_out./ repmat(sum(p_Msg_out*0.5,1), [size(p_Msg_out,1),1] ));
        MI = sum(tmp(~isnan(tmp)));
        [~,Q_labels]  = max(Q);
        Q_out(idx) = (Q_labels-1).';
    case 'keepOld'
        Q_mat = zeros(Nq_Msg, length(Q_out));
        for jj=1:length(Q_out)
            Q_mat(Q_out(jj)+1, jj) = 1;
        end
        p_Msg_out = p_Msg_prod*Q_mat';
        tmp = p_Msg_out*0.5 .* log2(p_Msg_out./ repmat(sum(p_Msg_out*0.5,1), [size(p_Msg_out,1),1] ));
        MI = sum(tmp(~isnan(tmp)));
    otherwise
        error('Quantizer Design method not supported!')
end





end


% 
% L_Cha = size(p_Msg_cell{end},2);
% L_Msg = size(p_Msg_cell{1},2);
% dv = length(p_Msg_cell);
% B=2;
% 
% llr_combos = zeros(L_Msg^(dv-1)*L_Cha, dv);
% llr_combos(:, 1) = repmat( (1:L_Cha).', [L_Msg^(dv-1), 1]);
% for ii=2:dv
%     tmp =  repmat((1:L_Msg), [L_Cha*L_Msg^(ii-2), 1]);
%     llr_combos(:,ii)= repmat( tmp(:), [L_Msg^(dv-ii), 1]);
% end
% llr_combos = fliplr(llr_combos);
% 
% p_Msg_prod_check = zeros(2, size(llr_combos,1));
% 
% % Build the Product DMC p(all_LLR_combinations | source bit of VN that receives the CN message)
% tmp = zeros(dv,1);
% for kk=1:size(llr_combos,1)
%     for bb=1:B
%         for ii=1:dv
%             tmp(ii) =  p_Msg_cell{ii}(bb,llr_combos(kk,ii));
%         end
%         p_Msg_prod_check(bb, kk) = exp(sum(log(tmp)));
%     end
% end
% 
% 
% % sort ascending in the value of the output LLRs
% 
% [ ~, sort_idx] = sort(log(p_Msg_prod_check(1,:)) - log(p_Msg_prod_check(2,:)), 'ascend');
% p_Msg_prod_check = p_Msg_prod_check(:,sort_idx);
% 
% % Reduce the Product DMC to p(LLR of VN that receives the CN message | source bit of VN that receives the CN message)
% % [Q_cell,MI] = QuantMiDmcMulti(pZ_X_full.',2^Nb_out);
% % Q = Q_cell{1};
% [Q,MI] = QuantMiDmc(p_Msg_prod_check,Nq_Msg);
% [~,Q_labels_check]  = max(Q);
% 
% 
%  Q_out(sort_idx) = (Q_labels_check-1).';
%  
% p_Msg_out = p_Msg_prod_check*Q';
%  MI=0;
