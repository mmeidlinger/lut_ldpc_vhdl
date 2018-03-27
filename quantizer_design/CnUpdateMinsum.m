function [ p_Msg_out ] = CnUpdateMinsum( p_Msg, LLRs, dc)


A = [1 0 0 1 ; 0 1 1 0] * 0.5;  %First row, even parity, second row odd parity


p_Msg_out = p_Msg;
for ii = 1:dc-2
    p_Msg_prod = kron(p_Msg_out,p_Msg);
    p_Msg_prod = A * p_Msg_prod;
    LLR_combos = LLRs(combinator(length(LLRs),2).');
    p_Msg_out= zeros(size(p_Msg));
    for jj=1:size(LLR_combos,2)
        LLR = min(abs(LLR_combos(:,jj)))*prod(sign(LLR_combos(:,jj)));
        [~, idx] = min(abs(LLRs-LLR));
        p_Msg_out(:,idx) = p_Msg_out(:,idx) + p_Msg_prod(:,jj);
    end
end
% for numeric stability
p_Msg_out(1,:) = p_Msg_out(1,:)/sum(p_Msg_out(1,:),2);
p_Msg_out(2,:) = p_Msg_out(2,:)/sum(p_Msg_out(2,:),2);

end