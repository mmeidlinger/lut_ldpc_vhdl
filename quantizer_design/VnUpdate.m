function [ p_Msg_out, LLRs, MI, Q] = VnUpdate( p_Msg, p_Cha, reuseLUT, Q_old,  dv, Nq_Msg_out, quant_method, mode, vnroot, decroot, isDecNode )

if isDecNode && reuseLUT
    error('You cannot reuse a Node as a Decision Node!');
end

switch mode
    case 'brute'
        error('This mode is deprecated! Use the tree mode and a single quantizer tree!')
    case 'tree'
        if reuseLUT
            quant_method = 'keepOld';
            Q = Q_old.deepcopy();   %copy old node
        elseif isDecNode
            Q = decroot.deepcopy();  %copy empty decision node
        else
            Q = vnroot.deepcopy();  %copy empty node
        end
        Q.setLeaves(p_Msg,p_Cha);   %update leaves of newly copied node
        [ p_Msg_out, MI] = Q.VnUpdateTree( size(p_Msg,2), Nq_Msg_out, quant_method);    %update node
        LLRs = log(p_Msg_out(1,:)) - log(p_Msg_out(2,:));
        
    otherwise
        error('Mode not defined!');
end
    
end
