function [ p_Msg_out, p_Cha_out, LLRout ] = symmetrizeQuantizers( p_Msg_in, varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Nq_Msg = size(p_Msg_in,2);

%% Symmetrize Message Distributions
p_Msg_out(1,:)     = (p_Msg_in(1,:) + fliplr(p_Msg_in(2,:)))/2;
p_Msg_out(2,:)     = fliplr(p_Msg_in(1,:));

%% Symmetrize channel distribution if passed to function
if (isempty(varargin{1}))
    p_Cha_out = [];
else
    p_Cha_in = varargin{1};
    p_Cha_out(1,:)     = (p_Cha_in(1,:) + fliplr(p_Cha_in(2,:)))/2;
    p_Cha_out(2,:)     = fliplr(p_Cha_in(1,:));
end

%% Symmetrize LLRs if passed to function

if (isempty(varargin{2}))
    LLRout = [];
else
    LLRin = varargin{2};
    
    LLRout = zeros(size(LLRin));
    LLRout(1:Nq_Msg(1)/2)     = (LLRin(1:Nq_Msg(1)/2) - fliplr(LLRin(Nq_Msg(1)/2+1:end)))/2;
    LLRout(Nq_Msg(1)/2+1:end) = -fliplr(LLRout(1:Nq_Msg(1)/2));

end


end

