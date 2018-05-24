% deserialize a LUT Tree string (cf. https://mail.nt.tuwien.ac.at/unfold/md_trees_README.html for details) into a tree of node MATLAB objects
% Author: Michael Meidlinger (michael@meidlinger.info)
% Copyright (C) 2018 Michael Meidlinger - All Rights Reserved

function [vn_tree_array, cn_tree_array] = lut_tree_arrays_from_string(var_tree_string, chk_tree_string)
    
    %% Process VN luts
    if(isempty(var_tree_string))
        error('var_tree_string must not be empty! make sure you loaded a valid decoder')
    end
    var_tree_string_split = strsplit(var_tree_string.' ,'\n'); % cell array of lines in the string
    % number of trees
    num_trees_iter = str2num(var_tree_string_split{1});
    var_tree_string_split(1) = [];
    
    for ii=1:num_trees_iter
        num_degrees_active = str2num(var_tree_string_split{1});
        var_tree_string_split(1) = [];
        for dd=1:num_degrees_active
            [vn_tree_array{dd,ii}, var_tree_string_split] = lut_tree_from_string(var_tree_string_split);
        end
    end
    
    %% Process CN luts
    if(isempty(var_tree_string))
        error('chk_tree_string must not be empty! make sure you loaded a valid decoder')
    end
    chk_tree_string_split =  strsplit(chk_tree_string.' ,'\n');
    num_trees_iter = str2num(chk_tree_string_split{1});
    chk_tree_string_split(1) = [];
    
    if(num_trees_iter == 0)
        cn_tree_array = {};
    else
       error('CN LUTs not supported yet!')
    end
    
        
    
end


function [root, tree_string_split] = lut_tree_from_string(tree_string_split)
    % Get Tree Type and number of leaves
    [tmp] = str2num(tree_string_split{1});
    tree_type = tmp(1);
    num_leaves = tmp(2);
    tree_string_split(1) = [];
   
    [root, tree_string_split] = node.deserialize_tree(tree_string_split);
    
end