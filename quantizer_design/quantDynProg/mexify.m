%compiles the C functions to MEX

% currentPath = pwd;
% 
% aFile = 'QuantMiDmcMulti.m';
% newPath = which(aFile);
% if length(newPath) == 0
%     error(sprintf('Could not find %s in the search path\nAdd QuantDmc to the search path',upper(aFile)));
% end
% newPath = strrep(newPath,aFile,'');
% cd(newPath)

fprintf('Compiling....\n')

try
    mex csource/QuantEntrDmc.c csource/mmatrix.c
    fprintf('Succeeded mexing QuantEntrDmc.m\n');
catch
    fprintf('Error, failed to compile  QuantEntrDmc.m \n');
end

try
    mex csource/QuantMiDmc.c csource/mmatrix.c
    fprintf('Succeeded mexing QuantMiDmc.m\n');
catch
    fprintf('Error, failed to compile QuantMiDmc.m\n');
end

try
    mex csource/QuantMiDmcSym.c csource/mmatrix.c
    fprintf('Succeeded mexing QuantMiDmcSym.m\n');
catch
    fprintf('Error, failed to compile QuantMiDmcSym.m\n');
end