function [ I ] = getMI( prior, transition, varargin)
%calculate the mutual information 
prior2 = transition*prior;

temp1 = prior2.*log2(prior2);
temp2 = transition.*repmat(prior.', [size(transition,1), 1]).*log2(transition);

ind1 = prior2~=0;
ind2 = transition~=0;

I= sum(sum(temp2(ind2))) - sum(temp1(ind1));



end

