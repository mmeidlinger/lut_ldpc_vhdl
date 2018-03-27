function [ p_Msg_out, Q ] = CnUpdate( p_Msg, reuseLUT, LLRs, dc, mode, cnroot)
    Q=[];
    switch mode
        case 'minsum'
            p_Msg_out = CnUpdateMinsum( p_Msg, LLRs, dc);
        case 'tree'
            error('Not implemented!');
            if reuseLUT
                0;
            else
                p_Msg_out = CnUpdateTree( p_Msg, LLRs, dc, cnroot);
            end
        otherwise
            error('Mode not defined!');
    end
    
end
