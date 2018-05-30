H1 = zeros(nchk, nvar);
H2 = zeros(nchk, nvar);

idx = 1;
for vv=1:nvar
    for dd=1:dv_vec(vv)
        H1(cn_msg_idx(idx)+1, vv) = 1;
        idx = idx +1;
    end
end

for cc=1:nchk
    H2(cc, chk_equ_idx{cc}+1) = 1;
end

sum(sum(H1-H2))