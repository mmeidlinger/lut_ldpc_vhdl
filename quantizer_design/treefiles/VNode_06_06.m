function [root] = VNode_06_06()

% cumulative distance from leaves to root as a metric:
% m = 10

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'im');
addchild(root, 'msg');
addchild(root, 'cha');
% level 2
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'msg');