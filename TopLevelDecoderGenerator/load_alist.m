%load alist sparse GF2 matrix from file and return dense GF2 matrix
% Author: Michael Meidlinger (michael@meidlinger.info)
% Copyright (C) 2017 Michael Meidlinger - All Rights Reserved

function H = load_alist(filename)
    
Halist = dlmread(filename, ' ');

N = Halist(1,1);
M = Halist(1,2);

H = zeros(M,N);
for ii = 1:N
   H(Halist(ii+4, Halist(ii+4, :)>0),ii) = 1;
end

end