function lut_shuffled = shuffler(LUT)

% Get all relevant data from LUT object
lut = double(LUT.map);
inres = double(LUT.inres);
inbits = sum(inres);
outres = log2(double(LUT.outres));

% Initialize output
lut_shuffled = zeros(1,2^(inbits));

for indx = 1:2^(inbits)
    
    % Convert index to binary
    indxBin=dec2bin(indx-1,inbits);
    
    % Generate new index
    indxBinNew = '';
    startInd = 1;
    for ii = 1:length(inres)
        indxBinTemp = indxBin(startInd:startInd+inres(ii)-1);
        indxBinNew = [indxBinNew, dec2bin(OffsetBin_to_SignMag(bin2dec(indxBinTemp),inres(ii)),inres(ii)) ];        
        startInd = startInd+inres(ii);
    end
    
    % Shuffle values
    indxNew=bin2dec(indxBinNew);
    lut_shuffled(indxNew+1)=OffsetBin_to_SignMag(lut(indx),outres);
    
end
