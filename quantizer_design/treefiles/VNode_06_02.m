function [root] = VNode_06_02()

% cumulative distance from leaves to root as a metric:
% m = 12

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'im');
addchild(root, 'im');
% level 2
addchild(root.children(1), 'msg');
addchild(root.children(1), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(2), 'msg');
addchild(root.children(3), 'msg');
addchild(root.children(3), 'cha');