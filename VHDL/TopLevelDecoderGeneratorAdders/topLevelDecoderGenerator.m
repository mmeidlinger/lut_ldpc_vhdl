function topLevelDecoderGenerator(param)

% Open one file for each iteration
fid = fopen(sprintf('../TopLevelDecoderAdders/TopLevelDecoder.vhdl'), 'wt');

%% Write standard header
fprintf(fid,['library ieee;\n' ...
    'use ieee.std_logic_1164.all;\n' ...
    'use ieee.numeric_std.all;\n' ...
    'library work;\n' ...
    'use work.config.all;\n\n' ...
    'entity TopLevelDecoder is\n' ...
    '  port (\n' ...
    '    ChLLRxDI       : in ChLLRTypeStage;\n' ...
    '    ClkxCI         : in std_logic;\n' ...
    '    RstxRBI        : in std_logic;\n' ...
    '    DecodedBitsxDO : out std_logic_vector(N-1 downto 0)\n' ...
    '  );\n' ...
    'end TopLevelDecoder;\n\n' ...
    'architecture arch of TopLevelDecoder is\n\n']);

%% Declare components
fprintf(fid,['  component CNStage is\n' ...
  '    port (\n' ... 
  '      ClkxCI           : in std_logic;\n' ...
  '      RstxRBI          : in std_logic;\n' ...
  '      IntLLRCNStagexDI : in IntLLRTypeCNStage;\n' ...
  '      ChLLRCNStagexDI  : in ChLLRTypeStage;\n' ...
  '      IntLLRCNStagexDO : out IntLLRTypeCNStage;\n' ...
  '      ChLLRCNStagexDO  : out ChLLRTypeStage\n' ...
  '  );\n' ...  
  '  end component;\n\n']);

fprintf(fid,['  component VNStage is\n' ...
  '    port (\n' ... 
  '      ClkxCI           : in std_logic;\n' ...
  '      RstxRBI          : in std_logic;\n' ...
  '      IntLLRVNStagexDI : in IntLLRTypeVNStage;\n' ...
  '      ChLLRVNStagexDI  : in ChLLRTypeStage;\n' ...
  '      IntLLRVNStagexDO : out IntLLRTypeVNStage;\n' ...
  '      ChLLRVNStagexDO  : out ChLLRTypeStage\n' ...
  '  );\n' ...  
  '  end component;\n\n']);

fprintf(fid,['  component VNStageLastIter is\n' ...
  '    port (\n' ... 
  '      ClkxCI           : in std_logic;\n' ...
  '      RstxRBI          : in std_logic;\n' ...
  '      IntLLRVNStagexDI : in IntLLRTypeVNStage;\n' ...
  '      ChLLRVNStagexDI  : in ChLLRTypeStage;\n' ...
  '      DecodedBitsxDO   : out std_logic_vector(N-1 downto 0)\n' ...
  '  );\n' ...  
  '  end component;\n\n']);

%% Declare signals between pipeline stages
% VNStage inputs
fprintf(fid,'  -- VN Stage input signals\n');
fprintf(fid,'  signal ');
fprintf(fid,'VNStageIntLLRInputS%dxD, ', 0:param.maxIter-2);
fprintf(fid,'VNStageIntLLRInputS%dxD : IntLLRTypeVNStage;\n', param.maxIter-1);
fprintf(fid,'  signal ');
fprintf(fid,'VNStageChLLRInputS%dxD, ', 0:param.maxIter-2);
fprintf(fid,'VNStageChLLRInputS%dxD : ChLLRTypeStage;\n\n', param.maxIter-1);

% VNStage outputs
fprintf(fid,'  -- VN Stage output signals\n');
fprintf(fid,'  signal ');
fprintf(fid,'VNStageIntLLROutputS%dxD, ', 0:param.maxIter-3);
fprintf(fid,'VNStageIntLLROutputS%dxD : IntLLRTypeVNStage;\n', param.maxIter-2);
fprintf(fid,'  signal VNStageIntLLROutputS%dxD : std_logic_vector(N-1 downto 0);\n', param.maxIter-1);
fprintf(fid,'  signal ');
fprintf(fid,'VNStageChLLROutputS%dxD, ', 0:param.maxIter-3);
fprintf(fid,'VNStageChLLROutputS%dxD : ChLLRTypeStage;\n\n', param.maxIter-2);

% CNStage inputs
fprintf(fid,'  -- CN Stage input signals\n');
fprintf(fid,'  signal ');
fprintf(fid,'CNStageIntLLRInputS%dxD, ', 0:param.maxIter-2);
fprintf(fid,'CNStageIntLLRInputS%dxD : IntLLRTypeCNStage;\n', param.maxIter-1);
fprintf(fid, '  signal ');
fprintf(fid,'CNStageChLLRInputS%dxD, ', 0:param.maxIter-2);
fprintf(fid,'CNStageChLLRInputS%dxD : ChLLRTypeStage;\n\n', param.maxIter-1);

% CNStage outputs
fprintf(fid,'  -- CN Stage output signals\n');
fprintf(fid,'  signal ');
fprintf(fid,'CNStageIntLLROutputS%dxD, ', 0:param.maxIter-2);
fprintf(fid,'CNStageIntLLROutputS%dxD : IntLLRTypeCNStage;\n', param.maxIter-1);
fprintf(fid,'  signal ');
fprintf(fid,'CNStageChLLROutputS%dxD, ', 0:param.maxIter-2);
fprintf(fid,'CNStageChLLROutputS%dxD : ChLLRTypeStage;\n\n', param.maxIter-1);

%% Begin architecture
fprintf(fid, 'begin\n\n');

fprintf(fid,'  -- Instantiate CN and VN stages\n');
for iter = 1:param.maxIter
   % Instantiate check node stage 
   fprintf(fid,'  CNStage_%d: CNStage port map(\n', iter-1);
   fprintf(fid,'    ClkxCI => ClkxCI,\n');
   fprintf(fid,'    RstxRBI => RstxRBI,\n');
   fprintf(fid,'    IntLLRCNStagexDI => CNStageIntLLRInputS%dxD,\n', iter-1);
   fprintf(fid,'    ChLLRCNStagexDI => CNStageChLLRInputS%dxD,\n', iter-1);
   fprintf(fid,'    IntLLRCNStagexDO => CNStageIntLLROutputS%dxD,\n', iter-1);
   fprintf(fid,'    ChLLRCNStagexDO => CNStageChLLROutputS%dxD\n', iter-1);
   fprintf(fid,'  );\n\n');
   % Instantiate variable node stage
   if( iter < param.maxIter )
       fprintf(fid,'  VNStage_%d: VNStage port map(\n', iter-1);
       fprintf(fid,'    ClkxCI => ClkxCI,\n');
       fprintf(fid,'    RstxRBI => RstxRBI,\n');
       fprintf(fid,'    IntLLRVNStagexDI => VNStageIntLLRInputS%dxD,\n', iter-1);
       fprintf(fid,'    ChLLRVNStagexDI => VNStageChLLRInputS%dxD,\n', iter-1);
       fprintf(fid,'    IntLLRVNStagexDO => VNStageIntLLROutputS%dxD,\n', iter-1);
       fprintf(fid,'    ChLLRVNStagexDO => VNStageChLLROutputS%dxD\n', iter-1);
       fprintf(fid,'  );\n\n');
   else
       fprintf(fid,'  VNStage_%d: VNStageLastIter port map(\n', iter-1);
       fprintf(fid,'    ClkxCI => ClkxCI,\n');
       fprintf(fid,'    RstxRBI => RstxRBI,\n');
       fprintf(fid,'    IntLLRVNStagexDI => VNStageIntLLRInputS%dxD,\n', iter-1);
       fprintf(fid,'    ChLLRVNStagexDI => VNStageChLLRInputS%dxD,\n', iter-1);
       fprintf(fid,'    DecodedBitsxDO => VNStageIntLLROutputS%dxD\n', iter-1);
       fprintf(fid,'  );\n\n');
   end
end

% Connect input channel LLRS to first CN stage based on parity-check matrix
fprintf(fid,'  -- Connect input channel LLRS to first CN stage\n');
CNPortsUsed = zeros(param.M,1);
CNPorts2VN = zeros(param.M,param.CNodeDegree);     % corresponding variable node which is connected to CN(param.M), port(param.CNodeDegree)
for ii = 1:param.N
    cNodes = find(param.H(:,ii));
    CNPortsUsed(cNodes) = CNPortsUsed(cNodes) + 1;
    for jj = 1:length(cNodes)   %=param.VNodeDegree
        fprintf(fid,'  CNStageIntLLRInputS0xD(%d)(%d) <= ChLLRxDI(%d);\n', cNodes(jj)-1, CNPortsUsed(cNodes(jj))-1, ii-1);        
        CNPorts2VN(cNodes(jj),CNPortsUsed(cNodes(jj))) = ii;
    end    
end
fprintf(fid,'\n');

% Connect output channel LLRs of stages with input channel LLRs of following stages
fprintf(fid,'  -- Connect output channel LLRs of stages with input channel LLRs of following stages\n');
fprintf(fid, '  CNStageChLLRInputS0xD <= ChLLRxDI;\n');
for iter = 1:param.maxIter-1
   fprintf(fid, '  VNStageChLLRInputS%dxD <= CNStageChLLROutputS%dxD;\n',iter-1,iter-1);
   fprintf(fid, '  CNStageChLLRInputS%dxD <= VNStageChLLROutputS%dxD;\n',iter,iter-1);
end
fprintf(fid, '  VNStageChLLRInputS%dxD <= CNStageChLLROutputS%dxD;\n\n',param.maxIter-1,param.maxIter-1);

% Connect CN and VN stages based on parity-check matrix
fprintf(fid,'-- Connect CN and VN stages\n');
for iter = 1:param.maxIter
    
    % Variable Nodes
    fprintf(fid,'\n  -- Variable Nodes (Iteration %d)\n', iter-1);
    VNPortsUsed = zeros(param.N,1);
    VNPorts2CN = zeros(param.N,param.VNodeDegree);     % corresponding check node which is connected to VN(param.N), port(param.VNodeDegree)
    for ii = 1:param.M
        vNodes = find(param.H(ii,:));
        VNPortsUsed(vNodes) = VNPortsUsed(vNodes) + 1;
        for jj = 1:length(vNodes)
            fprintf(fid,'  VNStageIntLLRInputS%dxD(%d)(%d) <= CNStageIntLLROutputS%dxD(%d)(%d);\n', iter-1, CNPorts2VN(ii,jj)-1, VNPortsUsed(vNodes(jj))-1, iter-1, ii-1, jj-1);

            VNPorts2CN(vNodes(jj),VNPortsUsed(vNodes(jj))) = ii;
        end
    end

    % Check Nodes (last iteration only contains variable node stage)
    if( iter < param.maxIter )
        fprintf(fid,'\n  -- Check Nodes (Iteration %d)\n', iter);
        CNPortsUsed = zeros(param.M,1);
        CNPorts2VN = zeros(param.M,param.CNodeDegree);     % corresponding check node which is connected to VN(param.N), port(param.VNodeDegree)
        for ii = 1:param.N
            cNodes = find(param.H(:,ii));
            CNPortsUsed(cNodes) = CNPortsUsed(cNodes) + 1;
            for jj = 1:length(cNodes)
                fprintf(fid,'  CNStageIntLLRInputS%dxD(%d)(%d) <= VNStageIntLLROutputS%dxD(%d)(%d);\n', iter, VNPorts2CN(ii,jj)-1, CNPortsUsed(cNodes(jj))-1, iter-1, ii-1, jj-1);    
                CNPorts2VN(cNodes(jj),CNPortsUsed(cNodes(jj))) = ii;
            end
        end
    end
end

% % Connect output of last VN stage with top-level output
% fprintf(fid,'\n  -- Connect output of last VN stage with top-level output\n');
% fprintf(fid,'  assign_output: process(VNStageIntLLROutputS4xD)\n');
% fprintf(fid,'  begin\n');
% fprintf(fid,'    for ii in 0 to N-1 loop\n');
% fprintf(fid,'      DecodedBitsxDO(ii) <= to_std_logic(to_integer(VNStageIntLLROutputS4xD(ii)(0)));\n');
% fprintf(fid,'    end loop;\n');
% fprintf(fid,'  end process;\n');

% End architecture
fprintf(fid, 'end arch;');

% Close file
fclose(fid);