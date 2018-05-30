classdef node < handle
    %LUT Tree node class for handling LUT trees in MATLAB (cf.
    %https://mail.nt.tuwien.ac.at/unfold/md_trees_README.html for more
    %infor on LUT Trees)
    % Author: Michael Meidlinger (michael@meidlinger.info)
    % Copyright (C) 2018 Michael Meidlinger - All Rights Reserved
    
    properties
        parent   %parent node
        children
        Q 
        p
        type  % im    ... intermediate
              % root  ... root node
              % msg   ... Message leaf
              % cha   ... Channel leaf
        outres
    end
    
    properties (Constant)
        IM = 0;
        ROOT = 1;
        MSG = 2;
        CHA = 3;
        num_node_types = 4;
    end
    
    methods
        function obj = node(type)
            obj.parent= [];
            obj.children = {};
            obj.Q = [];
            obj.type = type;    % root, im, cha, msg
            obj.p = [];
            obj.outres=0;
        end
        
        function  addchild(obj, type)
            % only add children to non leave nodes
            if( strcmp(type, 'msg') == 0 && strcmp(type, 'cha'))
                new_child = node(type);
                new_child.parent = obj;
                obj.children{end+1} = new_child;    
            end
        end
        
        function root = deepcopy(obj)
            root = node(obj.type);
            root.p = obj.p;
            root.Q = obj.Q;
            root.outres = obj.outres;
            for ii = 1:length(obj.children)
                root.children{end+1}  =  obj.children{ii}.deepcopy();
            end

            return;
        end
            
        
        function  setLeaves(obj,p_Msg, p_Cha)
            % in case of checknodes, p_Cha is irrelevant
            if strcmp(obj.type,'msg') 
                obj.p = p_Msg;
                return 
            elseif strcmp(obj.type,'cha')
                obj.p = p_Cha;
                return  
            else
                for ii = 1:length(obj.children)
                    obj.children{ii}.setLeaves(p_Msg, p_Cha);
                end
            end
        end
        
        
        function  [ p_Msg_out,  MI] = VnUpdateTree(obj,Nq_Msg_in,Nq_Msg_out, quant_method)
%             Nq_Msg_in    ... Resolution of Input- and Intermediate Messages 
%             Nq_Msg_out   ... Resolution of Output Messages
%             quant_method ... How to updated the
            if strcmp(obj.type,'msg') || strcmp(obj.type,'cha')
                p_Msg_out = obj.p;
                MI = 0;
                return 
            else
                p_Msg = {};
                for ii = 1:length(obj.children)
                    [ p_Msg{ii},  MI] = obj.children{ii}.VnUpdateTree(Nq_Msg_in, Nq_Msg_out,quant_method);
                end
                % At this point we are at an im or root node an have examined and callected all
                % children distributions in p_Msg
                if strcmp(obj.type,'im')
                    if strcmp(quant_method, 'keepOld')
                        [ p_Msg_out,  MI, Q] = VnUpdateIm(p_Msg,  Nq_Msg_in, quant_method, obj.Q);
                    else
                    	[ p_Msg_out,  MI, Q] = VnUpdateIm(p_Msg,  Nq_Msg_in, quant_method);
                        obj.Q = Q;
                    end
                    obj.p = p_Msg_out;
                    obj.outres = Nq_Msg_in;
                else %root node
                    if strcmp(quant_method, 'keepOld')
                        [ p_Msg_out,  MI, Q] = VnUpdateIm(p_Msg,  Nq_Msg_out, quant_method, obj.Q);
                    else
                    	[ p_Msg_out,  MI, Q] = VnUpdateIm(p_Msg,  Nq_Msg_out, quant_method);
                        obj.Q = Q;
                    end
                    obj.p = p_Msg_out;
                    obj.outres = Nq_Msg_out;
                end
            end
        end
        

        
        
        function [ qcell] = qtree2qcell(obj,Nq_Msg, Nq_Cha )
            levels = obj.breadthFirstSearch; 
            levels.reverse;
            for jj = 1:length(levels.elements)
                for ii = 1:length(levels.elements{jj}.elements)
                    tmp_node = levels.elements{jj}.elements{ii};
                    quant.map = cast(tmp_node.Q, 'int64');
                    quant.lmap = cast(length(quant.map),'int64');
                    quant.outres = cast(tmp_node.outres, 'int64');
                    quant.inres = zeros(1,length(tmp_node.children), 'int64');
                    quant.numin = cast(length(tmp_node.children),'int64');
                    for ll = 1:length(tmp_node.children)
                        if strcmp(tmp_node.children{ll}.type, 'im') || strcmp(tmp_node.children{ll}.type, 'msg')
                            quant.inres(ll) = cast(Nq_Msg, 'int64');
                        elseif strcmp(tmp_node.children{ll}.type, 'cha')
                            quant.inres(ll) = cast(Nq_Cha, 'int64');
                        end
                        % Store type of input message
                        quant.type{ll} = tmp_node.children{ll}.type;
                    end
                    qcell{ii, jj} = quant;
                end
            end
        end
        
        function levels = breadthFirstSearch(obj)
            myq1 = queue();
            myq2 = queue();
            level = queue();
            levels = queue();
            myq1.addElement(obj);
            while ~isempty(myq1.elements)
                traverse = myq1.removeElement();
                level.addElement(traverse);
                for ii=1:length(traverse.children)
                    if ~ (strcmp(traverse.children{ii}.type,'msg') || strcmp(traverse.children{ii}.type,'cha'))
                        myq2.addElement(traverse.children{ii});
                    end
                end
                if isempty(myq1.elements) %we reached the end of a level
                    levels.addElement(level);
                    myq1=myq2;
                    myq2 = queue();
                    level = queue();
                end
            end
        end
        
        function m = getMetric(obj,l)
            %return the cumulative distance from leave nodes to the root
            %node
            m = 0;
                 
            if strcmp(obj.type,'msg') || strcmp(obj.type,'cha')
                m = l;
                return 
            else
                l = l+1;     
                for ii = 1:length(obj.children)
                    m = m + getMetric(obj.children{ii},l);
                end
            end
        end
        
        function outstring= drawTree(obj)
            % This function returns a string that can be saved to a file
            % and compiled using e.g., tikz2pdf or with pdflatex if it is
            % wrapped appropriately. Most likely, the sibling distance
            % needs to be ajusted mannually for the tree nodes not to
            % overlap.
            %=== preamble
            outstring = sprintf(['\\tikzset{\n', ...
                                '   leavenode/.style = {align=center, inner sep=2pt, text centered },\n',...
                                '   imnode/.style = {align=center, inner sep=1pt, text centered}\n',...
                                '}\n\n',...
                                '\\def\\imstring{$\\Phi$}\n',...
                                '\\def\\chastring{$L$}\n',...
                                '\\def\\msgstring{$\\mu$}\n\n',...
                                '\\begin{tikzpicture}[<-, >=stealth]' ...
                                ]);
            outstring= drawTreeRecursive(obj,outstring,0);
            %=== postamble
            outstring = sprintf('%s\n\\end{tikzpicture}',outstring);
        end
        
        function outstring= drawTreeRecursive(obj,outstring, level)
            % Recursive part of drawTree. Use root.drawTreeRecursive([],0)
            % if you want to produce only the tree without the preamble
            %=== Write a newline and indentation
            outstring=newTreeLine(outstring, level);
            %=== Write the nodes according to the type of node
            switch obj.type
                case 'root'
                    outstring = sprintf('%s\\node (root)[imnode] {\\imstring}',outstring);
                case 'msg'
                    outstring = sprintf('%schild{ node [leavenode] {\\msgstring}',outstring);
                case 'cha'
                    outstring = sprintf('%schild{ node [leavenode] {\\chastring}',outstring);
                case 'im'
                    outstring = sprintf('%schild{ node[imnode] {\\imstring}',outstring);
                otherwise
                    error('Node Type not defined!');
            end
            %=== Proceed to traverse the tree
            for ii = 1:length(obj.children)
                 outstring = drawTreeRecursive(obj.children{ii},outstring,level+1);
            end
            %=== Befor returning, the child{... statements need to be
            %closed
            outstring = newTreeLine(outstring, level);
            if strcmp(obj.type, 'root')
                outstring = [outstring, ';'];
            else
                outstring = [outstring, '}'];
            end
            
        end
        
    end
    methods(Static)
        function [new_node, tree_string_split] = deserialize_tree( tree_string_split)
            % get the number of children
            num_children =  str2num(tree_string_split{1});
            tree_string_split(1) = [];
            
            % build the node itself
            tmp =  str2num(tree_string_split{1});
            tree_string_split(1) = [];
            node_type = tmp(1);
            inres = tmp(2);
            outres = tmp(3);
            
            if(inres<= 0 && ~(node_type==node.CHA || node_type==node.MSG) )
                error('No quantizer present')
            end
            
            switch node_type
                case node.IM
                    new_node = node('im');
                case node.ROOT
                    new_node = node('root');
                case node.MSG
                    new_node = node('msg');
                case node.CHA
                    new_node = node('cha');
                otherwise
                    error('Undefined node type!')
            end
            
            new_node.outres = outres;
            if(inres>0) % for non leaf-nodes
                new_node.Q =  str2num(tree_string_split{1});
                tree_string_split(1) = [];
                if(length(new_node.Q) ~= inres)
                    error('Mismatch in quantizer resolution!')
                end
                % where as the c++ program uses symmetry, the VHDL
                % generation doesnt, wo we need to duplicate the LUTs
                new_node.Q = [new_node.Q,  outres-1-fliplr(new_node.Q)];
            end
            
            
            
            % proceed recursively with children
            for cc=1:num_children
               [new_child, tree_string_split] = node.deserialize_tree( tree_string_split);
               new_node.children{end+1} =  new_child;
               new_child.parent = new_node;
            end
        end
      
        function outstring = newTreeLine(outstring, treelevel)
            % This function is referenced by drawTreeRecursive() and attaches a
            % newline and indentation to the outstring
            outstring = sprintf('%s\n', outstring);
            for ii = 1:treelevel
                outstring = sprintf('%s   ', outstring);
            end
            return;
        end

    end

    
end


