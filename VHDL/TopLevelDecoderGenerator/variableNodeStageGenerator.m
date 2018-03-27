function variableNodeStageGenerator(param)

% Generates maxIter stages of variable nodes

% Import template file
templStr = fileread('VNStage_template.vhdl');

% Replace text in template for all iterations but last
for stage = 0:param.maxIter-2
    
    % Replace strings in template
    writeStr = strrep(templStr, 'VNODELUTCOMPONENT', sprintf('VNodeLUT_S%d', stage));
    
%     if( stage == param.maxIter-1 )
%         writeStr = strrep(writeStr, 'INTLLROUTPORT', sprintf('IntLLRVNStagexDO : out std_logic_vector(N-1 downto 0)'));
%         writeStr = strrep(writeStr, 'CHLLROUTPUTPORT', sprintf(''));
%         writeStr = strrep(writeStr, 'CHLLROUTPUTASSIGNMENT', '');
%         writeStr = strrep(writeStr, 'VNODELUTOUTPUTNAME', 'DecodedBitxDO');
%         writeStr = strrep(writeStr, 'VNODELUTOUTPUTTYPE', 'std_logic');
%         writeStr = strrep(writeStr, 'VNODEOUTPUTREGTYPE', 'std_logic_vector(N-1 downto 0)');       
%         writeStr = strrep(writeStr, 'REGRESET', '        IntLLRVNStagexDP <= (others => ''0'');\n        ChLLRVNStagexDP <= (others => 0 );\n');
%     else
%         writeStr = strrep(writeStr, 'INTLLROUTPORT', sprintf('IntLLRVNStagexDO : out IntLLRTypeVNStage;'));
%         writeStr = strrep(writeStr, 'CHLLROUTPUTPORT', sprintf('ChLLRVNStagexDO : out ChLLRTypeStage'));
%         writeStr = strrep(writeStr, 'CHLLROUTPUTASSIGNMENT', sprintf('ChLLRVNStagexDO  <= ChLLRVNStagexDP;'));          
%         writeStr = strrep(writeStr, 'VNODELUTOUTPUTNAME', 'IntLLRxDO');
%         writeStr = strrep(writeStr, 'VNODELUTOUTPUTTYPE', 'IntLLRTypeV');
%         writeStr = strrep(writeStr, 'VNODEOUTPUTREGTYPE', 'IntLLRTypeVNStage');  
%         writeStr = strrep(writeStr, 'REGRESET', 'IntLLRVNStagexDP <= (others => (others =>  0 ));\nChLLRVNStagexDP <= (others => 0 );\n');
%     end          
    writeStr = strrep(writeStr, 'VNODELUTNAME', sprintf('VNStage_S%d',stage));
    
    % Open VNStage file
    fid = fopen(sprintf('../TopLevelDecoder/VNStage_S%d.vhdl', stage), 'w');
    
    % Write string to file
    fprintf(fid, writeStr);
    
    % Close file
    fclose(fid);
    
end

% Replace text in template for last iteration
stage = param.maxIter-1;
    
% Import template file
templStr = fileread('VNStage_template_last_iteration.vhdl');

% Replace strings in template
writeStr = strrep(templStr, 'VNODELUTCOMPONENT', sprintf('VNodeLUT_S%d', stage));

% if( stage == param.maxIter-1 )
% %     writeStr = strrep(writeStr, 'INTLLROUTPORT', sprintf('IntLLRVNStagexDO : out std_logic_vector(N-1 downto 0)'));
% %     writeStr = strrep(writeStr, 'CHLLROUTPUTPORT', sprintf(''));
% %     writeStr = strrep(writeStr, 'CHLLROUTPUTASSIGNMENT', '');
%     writeStr = strrep(writeStr, 'VNODELUTOUTPUTNAME', 'DecodedBitxDO');
%     writeStr = strrep(writeStr, 'VNODELUTOUTPUTTYPE', 'std_logic');
%     writeStr = strrep(writeStr, 'VNODEOUTPUTREGTYPE', 'std_logic_vector(N-1 downto 0)');       
%     writeStr = strrep(writeStr, 'REGRESET', '        IntLLRVNStagexDP <= (others => ''0'');\n        ChLLRVNStagexDP <= (others => 0 );\n');
% else
%     writeStr = strrep(writeStr, 'INTLLROUTPORT', sprintf('IntLLRVNStagexDO : out IntLLRTypeVNStage;'));
%     writeStr = strrep(writeStr, 'CHLLROUTPUTPORT', sprintf('ChLLRVNStagexDO : out ChLLRTypeStage'));
%     writeStr = strrep(writeStr, 'CHLLROUTPUTASSIGNMENT', sprintf('ChLLRVNStagexDO  <= ChLLRVNStagexDP;'));          
%     writeStr = strrep(writeStr, 'VNODELUTOUTPUTNAME', 'IntLLRxDO');
%     writeStr = strrep(writeStr, 'VNODELUTOUTPUTTYPE', 'IntLLRTypeV');
%     writeStr = strrep(writeStr, 'VNODEOUTPUTREGTYPE', 'IntLLRTypeVNStage');  
%     writeStr = strrep(writeStr, 'REGRESET', 'IntLLRVNStagexDP <= (others => (others =>  0 ));\nChLLRVNStagexDP <= (others => 0 );\n');
% end          
writeStr = strrep(writeStr, 'VNODELUTNAME', sprintf('VNStage_S%d',stage));

% Open VNStage file
fid = fopen(sprintf('../TopLevelDecoder/VNStage_S%d.vhdl', stage), 'w');

% Write string to file
fprintf(fid, writeStr);

% Close file
fclose(fid);
    
