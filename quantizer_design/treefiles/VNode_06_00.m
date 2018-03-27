function [root] = VNode_06_00()

% cumulative distance from leaves to root as a metric:
% m = 6

root= node('root');
addchild(root, 'msg');
addchild(root, 'msg');
addchild(root, 'msg');
addchild(root, 'msg');
addchild(root, 'msg');
addchild(root, 'cha');