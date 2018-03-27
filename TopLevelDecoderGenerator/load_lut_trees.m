function [vn_tree_array, cn_tree_array, max_iters, reuse_vec, Nq_Msg, Nq_Cha, vn_degrees, cn_degrees] =   load_lut_trees(lut_tree_filename)
    max_iters = [];
    reuse_vec = [];
    Nq_Msg = [];
    Nq_Cha = [];
    vn_degrees = [];
    cn_degrees = []; 
    
    
    itload(lut_tree_filename);
    
    reuse_vec = reuse_vec.';
    Nq_Msg = Nq_Msg.';
    Nq_Cha = Nq_Cha.';
    vn_degrees = sort(unique(dv_vec.'));
    cn_degrees = sort(unique(dc_vec.'));
    
    [vn_tree_array, cn_tree_array] = lut_tree_arrays_from_string(var_tree_string, chk_tree_string );

    
    return;
end