function [root] = VNdec_06_01()

root = node('root');
% level 1
addchild(root, 'im');
addchild(root, 'im');
% level 2
addchild(root.children(1), 'im');
addchild(root.children(1), 'im');
addchild(root.children(2), 'im');
addchild(root.children(2), 'cha');
% level 3
addchild(root.children(1).children(1), 'msg');
addchild(root.children(1).children(1), 'msg');
addchild(root.children(1).children(2), 'msg');
addchild(root.children(1).children(2), 'msg');
addchild(root.children(2).children(1), 'msg');
addchild(root.children(2).children(1), 'msg');