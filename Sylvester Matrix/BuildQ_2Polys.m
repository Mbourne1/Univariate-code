function Q = BuildQ_2Polys(m,n,k)
% Build the diagonal matrix Q corresponding to the binomial coefficients
% of coprime polynomials u and v.
%
%
%
% Inputs
%
% m : Degree of polynomial f(x)
%
% n : Degree of polynomial g(x)
%
% k : Index of subresultant S_{k} to be formed.
%
%
% Outputs.
%
% Q : The diagonal matrix of binomial coefficients corresponding to coprime
%       polynomials u and v.
%
%

% Build first partition of Q corresponding to the binomial coefficients of
% v(y). \binom{n-k}{i}
Q1 = BuildQ1(n-k);

% Build second partition of Q corresponding to the binomial coefficients of
% u(y). \binom{m-k}{i}
Q2 = BuildQ1(m-k);

% Join the two partitions as a diagonal matrix.
Q = blkdiag(Q1,Q2);
end
