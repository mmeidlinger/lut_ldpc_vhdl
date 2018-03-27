function [root] = VNode_06_08()

% cumulative distance from leaves to root as a metric:
% m = 11

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'cha');
% level 2
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
