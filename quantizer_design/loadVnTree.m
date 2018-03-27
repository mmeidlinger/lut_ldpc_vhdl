function [ vnroot ] = loadVnTree()

%% Manually specify trees in this file

%% (Brute as tree)
vnroot= node('root');
addchild(vnroot, 'msg');
addchild(vnroot, 'msg');
addchild(vnroot, 'cha');

%% (Tree)
% vnroot= node('root');
% addchild(vnroot, 'im');
% addchild(vnroot.children(1), 'msg');
% addchild(vnroot.children(1), 'msg');
% addchild(vnroot, 'cha');

end

