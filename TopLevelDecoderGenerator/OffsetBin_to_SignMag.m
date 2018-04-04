function out = OffsetBin_to_SignMag (in,len)

% Do the conversion
intemp = in - 2^(len-1);
intemp(intemp<0) = abs(intemp(intemp<0)-(2^(len-1)-1));
out = intemp;

