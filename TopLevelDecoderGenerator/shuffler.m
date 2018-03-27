function lut_shuffled = shuffler (lut)

lut_shuffled=20*ones(size(lut));
if length(lut)==2^(3+3)%64
    for indx=1:64
        indxBin=dec2bin(indx-1,6);     % -1 is translation from matlab to HDL
        indxBin1=indxBin(1:3);
        indxBin2=indxBin(4:6);
        
        indxBinNew1=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin1),3),3);
        indxBinNew2=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin2),3),3);
        indxNew=bin2dec([indxBinNew1 indxBinNew2]);
        lut_shuffled(indxNew+1)=OffsetBin_to_SignMag(lut(indx),3); % +1 is translation from HDL to matlab
    end
    
elseif length(lut)==2^(3+4)%128
    for indx=1:128
        indxBin=dec2bin(indx-1,7);
        indxBin1=indxBin(1:3);
        indxBin2=indxBin(4:7);
        
        indxBinNew1=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin1),3),3);
        indxBinNew2=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin2),4),4);
        indxNew=bin2dec([indxBinNew1 indxBinNew2]);
        lut_shuffled(indxNew+1)=OffsetBin_to_SignMag(lut(indx),3);
    end
    
elseif length(lut)==2^(3+3+3+4)%8192
    for indx=1:length(lut)
        indxBin=dec2bin(indx-1,13);
        indxBin1=indxBin(1:3);
        indxBin2=indxBin(4:6);
        indxBin3=indxBin(7:9);
        indxBin4=indxBin(10:13);
        
        indxBinNew1=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin1),3),3);
        indxBinNew2=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin2),3),3);
        indxBinNew3=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin3),3),3);
        indxBinNew4=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin4),4),4);
        indxNew=bin2dec([indxBinNew1 indxBinNew2 indxBinNew3 indxBinNew4]);
        lut_shuffled(indxNew+1)=lut(indx);
    end
    
elseif length(lut)==2^(3+3+3)%512
    for indx=1:length(lut)
        indxBin=dec2bin(indx-1,9);
        indxBin1=indxBin(1:3);
        indxBin2=indxBin(4:6);
        indxBin3=indxBin(7:9);
        
        indxBinNew1=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin1),3),3);
        indxBinNew2=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin2),3),3);
        indxBinNew3=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin3),3),3);
        indxNew=bin2dec([indxBinNew1 indxBinNew2 indxBinNew3]);
        lut_shuffled(indxNew+1)=OffsetBin_to_SignMag(lut(indx),3);
    end
    
elseif length(lut)==2^(3+3+4)%1024
    for indx=1:length(lut)
        indxBin=dec2bin(indx-1,10);
        indxBin1=indxBin(1:3);
        indxBin2=indxBin(4:6);
        indxBin3=indxBin(7:10);
        
        indxBinNew1=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin1),3),3);
        indxBinNew2=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin2),3),3);
        indxBinNew3=dec2bin(OffsetBin_to_SignMag(bin2dec(indxBin3),4),4);
        indxNew=bin2dec([indxBinNew1 indxBinNew2 indxBinNew3]);
        lut_shuffled(indxNew+1)=lut(indx);
    end
    
else
    error('LUT length is not implemented in the shuffler function!')
    
end
