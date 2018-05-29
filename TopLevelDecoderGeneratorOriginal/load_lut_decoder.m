%load LUT decoder from file produce using the LUT-LDPC C++ software for
%simulation and design of LUT-based LDPC decoders
% Author: Michael Meidlinger (michael@meidlinger.info)
% Copyright (C) 2018 Michael Meidlinger - All Rights Reserved

function [vn_tree_array, cn_tree_array, max_iters, reuse_vec, Nq_Msg, Nq_Cha, vn_degrees, cn_degrees, H, Nq_Cha_2_Nq_Msg_map] =   load_lut_decoder(lut_tree_filename)
    max_iters = [];
    reuse_vec = [];
    Nq_Msg = [];
    Nq_Cha = [];
    vn_degrees = [];
    cn_degrees = []; 
    Nq_Cha_2_Nq_Msg_map = [];
    
    % Load parameters. There are some filetypes in the decoder object that
    % cannot be processed by matlab like bools or GF2 matrices. To avoid
    % warnings for these, we temporarily disable them here
    orig_state = warning;
    warning('off','all')
    itload(lut_tree_filename);
    warning(orig_state);

    
    reuse_vec = reuse_vec.';
    Nq_Msg = Nq_Msg.';
    Nq_Cha = Nq_Cha.';
    vn_degrees = sort(unique(dv_vec.'));
    cn_degrees = sort(unique(dc_vec.'));
    Nq_Cha_2_Nq_Msg_map = Nq_Cha_2_Nq_Msg_map.';
    
    [vn_tree_array, cn_tree_array] = lut_tree_arrays_from_string(var_tree_string, chk_tree_string );

    % Create sparse parity-check matrix
    H = sparse(nchk,nvar);
    for ii = 1:nchk
       H(ii,chk_equ_idx{ii}+1) = 1;
    end
    
    return;
end