function variableNodeGenerator(param)

% Generates variable nodes

% Convert quantization tree to cell
Qcell = cell(param.maxIter,1);
for iter = 1:param.maxIter
    Qcell{iter} = fliplr(param.QVN{iter}.qtree2qcell(param.QLLR,param.QCh));
end

for iter = 1:param.maxIter
    
    % Open one file for each iteration
    fid = fopen(sprintf('../TopLevelDecoder/VNodeLUT_S%d.vhdl',iter-1), 'wt');
    
    % Output port string
    if( iter == param.maxIter )
        outStr = '    DecodedBitxDO : out std_logic);\n';
    else
        outStr = '    IntLLRxDO : out IntLLRTypeV);\n';
    end
    
    % Write standard header
    fprintf(fid,['library ieee;\n' ...
        'use ieee.std_logic_1164.all;\n' ...
        'use ieee.numeric_std.all;\n' ...
        'library work;\n' ...
        'use work.config.all;\n\n' ...
        'entity VNodeLUT_S%d is\n' ...
        '  port (\n' ...
        '    ChLLRxDI  : in  ChLLRType;\n' ...
        '    IntLLRxDI : in  IntLLRTypeV;\n' ...
        outStr ...
        'end VNodeLUT_S%d;\n\n' ...
        'architecture arch of VNodeLUT_S%d is\n\n'], iter-1, iter-1, iter-1);
    
    % Get LUT tree for current iteration
    Q = Qcell{iter};
    
    
    % Counts the number of nodes for each level of the LUT tree (only used later)
    treeNodes = zeros(size(Q,2),1);
    
    % Declare LUT address signals
    for level = 1:size(Q,2)
        for node = 1:size(Q,1)
            if( ~isempty(Q{node,level}) )
                fprintf(fid,'  signal ');
                for ii = 1:param.VNodeDegree-1
                    fprintf(fid,'LUTAddrL%d_N%d_%dxD, ', level-1, node-1, ii-1);
                end
                fprintf(fid,'LUTAddrL%d_N%d_%dxD : LUTAddrL%d_N%d_S%d;\n', level-1, node-1, param.VNodeDegree-1, level-1, node-1, iter-1);
                % One more node found
                treeNodes(level) = treeNodes(level) + 1;
            end
        end
    end
    fprintf(fid,'\n');
    
    % Declare intermediate LUT outputs
    for level = 1:size(Q,2)
        for node = 1:treeNodes(level)
            fprintf(fid,'  signal ');
            for ii = 1:param.VNodeDegree-1
                fprintf(fid,'LUTDataL%d_N%d_%dxD, ', level-1, node-1, ii-1);
            end
            fprintf(fid,'LUTDataL%d_N%d_%dxD : integer range 0 to 2**%d-1;\n', level-1, node-1, param.VNodeDegree-1, log2(double(Q{node,level}.outres)));
        end
    end
    fprintf(fid,'\n');
    
    % Begin architecture
    fprintf(fid,'begin -- arch\n\n');
    
    % Generate LUT read addresses
    % Counts how many input messages have been already used for each output
    inputMsgCounter = zeros(param.VNodeDegree,1);
    fprintf(fid,'  -- Generate LUT read addresses\n');
    % Process levels bottom up (from leaves to root)
    for level = size(Q,2):-1:1
        % Counts how many intermediate messages have been already used for this level
        imMsgCounter = zeros(param.VNodeDegree,1);
        % Process all nodes of each level
        for node = 1:treeNodes(level)
            % One LUT address signal for each of the VNodeDegree trees
            for ii = 1:param.VNodeDegree
                concatStr = ';\n';
                fprintf(fid,'  LUTAddrL%d_N%d_%dxD <= ', level-1, node-1, ii-1);
                for jj = 1:length(Q{node,level}.inres)
                    % Message is from CNs
                    if( strcmp(Q{node,level}.type(jj),'msg') )
                        if( ii == inputMsgCounter(ii)+1 && iter ~= param.maxIter ) % For last iteration we want all input messages
                            inputMsgCounter(ii) = inputMsgCounter(ii) + 2;
                        else
                            inputMsgCounter(ii) = inputMsgCounter(ii) + 1;
                        end
                        concatStr = strcat(sprintf(' std_logic_vector(to_unsigned(IntLLRxDI(%d),%d))', inputMsgCounter(ii)-1, Q{node,level}.inres(jj)), concatStr);
                        % If this is not the last signal, concatenate. Otherwise, just end line.
                        % Message is from channel
                    elseif( strcmp(Q{node,level}.type(jj),'cha') )
                        concatStr = strcat(sprintf(' std_logic_vector(to_unsigned(ChLLRxDI,%d))', Q{node,level}.inres(jj)), concatStr);
                        % Message is intermadiate (i.e., the output of some other LUT of the previous level)
                    elseif( strcmp(Q{node,level}.type(jj),'im') )
                        imMsgCounter(ii) = imMsgCounter(ii) + 1;
                        concatStr = strcat(sprintf(' std_logic_vector(to_unsigned(LUTDataL%d_N%d_%dxD,%d))', level, imMsgCounter(ii)-1, ii-1 , Q{node,level}.inres(jj)), concatStr);
                    end
                    if( jj ~= length(Q{node,level}.inres) )
                        concatStr = strcat(' &', concatStr);
                    end
                end
                fprintf(fid, concatStr);
            end
            fprintf(fid,'\n');
        end
    end
    
    % Read from LUTs
    fprintf(fid,'  -- Read from LUTs\n');
    if( iter < param.maxIter )
        for level = 1:size(Q,2)
            for node = 1:size(Q,1)
                if( ~isempty(Q{node,level}) )
                    if( level == 1 && node == 1 )
                        for ii = 1:param.VNodeDegree
                            fprintf(fid,'  IntLLrxDO(%d) <= LUTL%d_N%d_S%d(to_integer(unsigned(LUTAddrL%d_N%d_%dxD)));\n', ii-1, level-1, node-1, iter-1, level-1, node-1, ii-1);
                        end
                    else
                        for ii = 1:param.VNodeDegree
                            fprintf(fid,'  LUTDataL%d_N%d_%dxD <= LUTL%d_N%d_S%d(to_integer(unsigned(LUTAddrL%d_N%d_%dxD)));\n', level-1, node-1, ii-1, level-1, node-1, iter-1, level-1, node-1, ii-1);
                        end
                    end
                    fprintf(fid,'\n');
                end
            end
        end
    else
        for level = 1:size(Q,2)
            for node = 1:size(Q,1)
                if( ~isempty(Q{node,level}) )
                    if( level == 1 && node == 1 )
                        fprintf(fid,'  DecodedBitxDO <= to_std_logic(LUTL%d_N%d_S%d(to_integer(unsigned(LUTAddrL%d_N%d_%dxD))));\n', level-1, node-1, iter-1, level-1, node-1, ii-1);
                    else
                        fprintf(fid,'  LUTDataL%d_N%d_%dxD <= LUTL%d_N%d_S%d(to_integer(unsigned(LUTAddrL%d_N%d_%dxD)));\n', level-1, node-1, ii-1, level-1, node-1, iter-1, level-1, node-1, ii-1);
                    end
                    fprintf(fid,'\n');
                end
            end
        end
    end
    fprintf(fid,'\n');
    
    % End architecture
    fprintf(fid, 'end arch;');
    
    % Close file
    fclose(fid);
    
end