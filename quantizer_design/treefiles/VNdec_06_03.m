function [root] = VNdec_06_03()
% used for SiPS Paper

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'im');
addchild(root, 'cha');
% level 2
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'msg');