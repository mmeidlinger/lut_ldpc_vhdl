function out = OffsetBin_to_SignMag (in,len)
if len==3
    switch in
        case 0
            out = 7;
        case 1
            out = 6;
        case 2
            out = 5;
        case 3
            out = 4;
        case 4
            out = 0;
        case 5
            out = 1;
        case 6
            out = 2;
        case 7
            out = 3;
    end
elseif len==4
    offsetBin =[0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15];
    SignComp = [15 14 13 12 11 10 9  8  0  1  2  3  4  5  6  7];
    indx = find(offsetBin==in,2^4);
    out = SignComp(indx);
else
    error('input length is out of range!')
end