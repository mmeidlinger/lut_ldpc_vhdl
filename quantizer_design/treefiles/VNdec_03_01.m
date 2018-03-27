function [root] = VNdec_03_01()

root= node('root');
%level 1
addchild(root, 'im');
addchild(root, 'im');
%level 2
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'cha');