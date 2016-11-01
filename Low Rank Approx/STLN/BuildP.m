
function P = BuildP(idx_col,m,n,k)
% Build the matrix P_{t}, where h_{t} = P_{t}z
%
% Inputs.
%
% idx_col : Index of column removed from S_{k}
%
% m : Degree of polynomial f(x)
%
% n : Degree of polynomial g(x)
%
% k : Degree of polynomial d(x)

% If column is in first partition
if idx_col <= n-k+1
    % First Partition
    j = idx_col;
    
    % Get binomials corresponding to f(x)
    bi_m = GetBinomials(m);
    
    bi_denom = zeros(m+1,1);
    for k = 0:1:m
        bi_denom(k+1) = nchoosek(m+n-k,(j-1)+k);
    end
    
    
    G = bi_m .* nchoosek(n-k,j-1) ./ bi_denom;
    
    P = ...
        [
        zeros(j-1,m+1)      zeros(j-1,n+1);
        diag(G)        zeros(m+1,n+1);
        zeros(n-k-j+1,m+1)  zeros(n-k-j+1,n+1);
        ];
else % Column is in second partition.
    
    j = idx_col - (n-k+1);
    
    
    bi_n = GetBinomials(n);
    
    bi_denom = zeros(n+1,1);
    for k = 0:1:n
        bi_denom(k+1) = nchoosek(m+n-k,j+k-1);
    end
    
    G = (bi_n .* nchoosek(m-k,j-1)) ./ bi_denom;
    
    P = ...
        [
        zeros(j-1,m+1)      zeros(j-1,n+1);
        zeros(n+1,m+1)      diag(G) ;
        zeros(m-k-j+1,m+1)  zeros(m-k-j+1,n+1);
        ];
    
end

end