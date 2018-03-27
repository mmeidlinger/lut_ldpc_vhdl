cnmethod = 'minsum';
vnmethod = 'tree';   %always use tree, brute is deprecated, as it is now a special kind of tree (1 level only)
max_dec_it = 5;
designSNR = 4.5; 
dv = 6;
dc = 32;
Nq_Cha = 2^4;
Nq_Msg = 2^3 *ones(1,max_dec_it+1);
qmode = 'maxMIsym'; %maxEntr; %maxMI
reUseLUT = zeros(1,max_dec_it);
useDecNode = 1;

quantizer_folder = '../../quantizers/';


%% Define Quantizer structure
vnroot  =  VNode_06_04();
decroot =  VNdec_06_03();
cnroot = [];


%% Write output

[ ~, Q_Vn, MI] = decoderDesignBIAWGN( Nq_Msg, Nq_Cha, reUseLUT, dv, dc, designSNR, max_dec_it, qmode, cnmethod , vnmethod, cnroot, vnroot, decroot, useDecNode );

qcell = cell(1);
for bb=1:max_dec_it
    qcell = cell(1);
    b{1,bb} = fliplr(Q_Vn{bb}.qtree2qcell(Nq_Msg(bb), Nq_Cha));
end

dec_folder_name = sprintf('tree%dlevels_%s_%s_SNR%02.1fdB_dv%d_dc%d_it%d_NbMsg%d-%d_NbCha%d/',size(b{1,bb},2),  cnmethod, qmode, designSNR, dv,dc,max_dec_it, log2(max(Nq_Msg)), log2(min(Nq_Msg)), log2(Nq_Cha));
mkdir([quantizer_folder, dec_folder_name]);


% convention:  L_Msg1, L_Msg2, ..., L_Cha
for ii= 1:max_dec_it
    for treeLevel = 1:size(b{ii},2) %lowest index = root, highest index = leaves
%         for treeIndex = 1:size(b{1,bb},1) %lowest index = lefmost
        for treeIndex = 1:size(b{ii},1) %lowest index = lefmost
            if ~isempty(b{ii}{treeIndex,treeLevel})
                %filename: <iteration>_<tree_level>_<index_at_level>
                dlmwrite([ quantizer_folder, dec_folder_name sprintf('%02.0f_%02.0f_%02.0f.txt', ii-1, treeLevel-1, treeIndex-1)], b{ii}{treeIndex,treeLevel}.map, ',');
            end
        end
    end
end


