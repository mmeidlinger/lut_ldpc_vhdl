function [root] = VNdec_06_04()
% same as VNdec_06_03, but the channel LLR is moved away from the root node

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'im');
addchild(root, 'msg');
% level 2
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'cha');