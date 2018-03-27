function [Qout,H] = QuantEntrDmcMulti(p,K)


I = length(p);


if K >= I
    tmp = - p.*log2(p);
    H = sum(tmp(~isnan(tmp)));
    Qout = {eye(length(p))};
    return
end

%initial distance computation
dist = zeros(I,I);
for ii = 1:I
    for kk = ii:I
        t = sum(p(ii:kk));
        dist(ii,kk) = -t*log2(t);
    end
end

SM = zeros(I,K);
ps = cell(I,K);
SM(:,1) = dist(1,:);

for kk = 2:K
    for ii = kk:I
        t = zeros(size([kk-1:ii-1]) );
        for ell = kk-1:ii-1
            t(ell - (kk-2) ) =  SM(ell,kk-1) + dist(ell+1,ii) ;
        end
        [SM(ii,kk),ps{ii,kk}] =  max(t);
        ps{ii,kk} =  find(t == max(t));
        ps{ii,kk} = ps{ii,kk} + kk - 2;
    end
end

%build quantizer list
Q = [I];
for kk = K:-1:1
    Qnew = [];
    for ii = 1:size(Q,1)
        s = Q(ii,K-kk+1);
        t = ps{s,kk};
        if length(t) == 0;
            t = 0;
        end
        if length(t) == 1
            Q(ii,K-kk+2) = t;
        else
            Q(ii,K-kk+2) = t(1);
            Qt = repmat(Q(ii,1:K-kk+1),length(t)-1,1);
            tp = t(:);
            Qt = [Qt tp(2:end)];
            Qnew = [Qnew; Qt];
        end
    end
    Q = [Q; Qnew];
end

%build the quantizer from the quantizer list
Qlist = Q;
Q={};
for ii = 1:size(Qlist,1)
    Q{ii} = zeros(K,I);
    for kk = 1:K
        Q{ii}(K-kk+1, Qlist(ii,kk+1)+1:Qlist(ii,kk)) = 1;
    end
end

%compute Entropy information associated with each quantizer.
for ii = 1:length(Q)
    p_out = p*Q{ii}.';
    tmp = p_out.*log2(p_out);
    H(ii)= -sum(tmp(~isnan(tmp)));
end

Qout = Q;

return 
