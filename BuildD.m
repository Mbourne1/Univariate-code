function D = BuildD(m,n,k)
% Build Matrix D^{-1} the diagonal matrix of binomial coefficients. Used to
% construct the Sylvester Subresultant matrices D_{k}^{-1}T_{k}(f,g)
%
% Input
%
% m : Degree of polynomial f.
%
% n : Degree of polynomial g.
%
% k : Index of subresultant.
%
%

% Produce a vector of elements of D, then diagonalise it to form a matrix.

D = diag(1./GetBinomials(m+n-k));

end