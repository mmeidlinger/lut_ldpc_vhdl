function [root] = VNode_06_05()

% cumulative distance from leaves to root as a metric:
% m = 19

% Same as VNode_06_04, except that the channel LLR is moved away from the
% root node

% level 0
root= node('root');
% level 1
addchild(root, 'im');
addchild(root, 'msg');
% level 2
addchild(root.children(1), 'im');
addchild(root.children(1), 'msg');
% level 3
addchild(root.children(1).children(1), 'im');
addchild(root.children(1).children(1), 'im');
% level 4
addchild(root.children(1).children(1).children(1), 'msg');
addchild(root.children(1).children(1).children(1), 'msg');
addchild(root.children(1).children(1).children(2), 'msg');
addchild(root.children(1).children(1).children(2), 'cha');
