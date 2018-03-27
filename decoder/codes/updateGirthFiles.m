function updateGirthFiles()
% to be called from the sourcecode/decoder directory

%% filenames
codes = {
'v3c6-reg_10',
'v3c6-reg_504',
'v3c6-reg_816',
'v3c6-reg_1002',
'v3c6-reg_1008',
'v3c6-reg_1024',
'v6c32-reg_2048',
'v3c6-reg_2640',
};

curfolder = pwd;
% parfor cc = 1:length(codes)
for cc = 1:length(codes)
    code_filename = [curfolder '/codes/' codes{cc}];
    gith_filename = [curfolder '/codes/' codes{cc} '.girth'];
    % check if the code file exists
    if exist(code_filename) == 2
    else
        error('The code %s does not exist in directory %s', codes{cc}, [curfolder '/codes/']);
    end
    % check if the corresponding loop file exists    
    if exist(gith_filename)==2
        continue;
    else
       S = sscanf(codes{cc},'%*c%f%*c%f%*c%*c%*c%*c%*c%*c%f',[1 Inf]);
       dv = S(1);
       dc = S(2);
       N =  S(3);
       
       H0 = load(code_filename);
       M = N*dv/dc;
       H = false(M,N);
       for mm = 1:M
           H(mm,H0(mm,:)) = true;
       end
       % Calculate the Girth
       % We use MATLAB coder to produce 
%        getGirth_mex from getGirth.m
       [ g ] = getGirth_mex(H);
       %write file
       csvwrite( gith_filename , g);
    end
end
end