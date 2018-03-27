function [root] = VNode_06_03()

% cumulative distance from leaves to root as a metric:
% m = 16

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'im');
% level 2
addchild(root.children(2), 'msg');
addchild(root.children(2), 'cha');
addchild(root.children(1), 'im');
addchild(root.children(1), 'im');
% level 3
addchild(root.children(1).children(1), 'msg');
addchild(root.children(1).children(1), 'msg');
addchild(root.children(1).children(2), 'msg');
addchild(root.children(1).children(2), 'msg');