function [ux, vx, wx] = GetQuotients_3Polys(fx, gx, hx, k)
% Given polynomials f(x) and g(x), get the quotient polynomials u(x) and
% v(x) such that f(x)*v(x) = g(x)*u(x).
%
% % Inputs
%
% [fx, gx, hx] : Coefficients of the polynomials f(x), g(x) and h(x) in 
% the Bernstein basis
% 
% k : Degree of common divisor
%
% % Outputs
%
% [ux, vx, wx] : Coefficients of the cofactor polynomials u(x), v(x) and
% w(x)


global SETTINGS

% Get degree of input polynomial g(x)
n = GetDegree(gx);

o = GetDegree(hx);

% Build the t^th subresultant
St = BuildSubresultant_3Polys(fx, gx, hx, k);

% Get the optimal column for removal
[~,idx_col] = GetMinDistance(St);

% Remove optimal column
At = St;
At(:,idx_col) = [];

% Get the optimal column c_{t} removed from S_{k}
ct = St(:,idx_col);

% Obtain the solution vector x = [-v;u]
x_ls = SolveAx_b(At,ct);

% Insert a zero into the position corresponding to the index of the optimal
% column so that S(f,g)*vec_x = 0.
vec_x =[
    x_ls(1:idx_col-1);
    -1;
    x_ls(idx_col:end);
    ]  ;

% Obtain values for quotient polynomials u and v. still expressed in the
% scaled bernstein basis, including theta.

nCoeffs_vx = n-k+1;
nCoeffs_wx = o-k+1;


switch SETTINGS.SYLVESTER_BUILD_METHOD
    case 'T'
        
        vx = vec_x(1:nCoeffs_vx);
        wx = vec_x(nCoeffs_vx + 1: nCoeffs_vx + nCoeffs_wx);
        ux = -vec_x(nCoeffs_vx + nCoeffs_wx + 1:end);
        
    case 'DT'
        
        
        vx_bi = vec_x(1:nCoeffs_vx);
        wx_bi = vec_x(nCoeffs_vx + 1: nCoeffs_vx + nCoeffs_wx);
        ux_bi = -vec_x(nCoeffs_vx + nCoeffs_wx + 1:end);
        
        ux = GetWithoutBinomials(ux_bi);
        vx = GetWithoutBinomials(vx_bi);
        wx = GetWithoutBinomials(wx_bi);
        
    case 'DTQ'
        vx = vec_x(1:nCoeffs_vx);
        wx = vec_x(nCoeffs_vx + 1: nCoeffs_vx + nCoeffs_wx);
        ux = -vec_x(nCoeffs_vx + nCoeffs_wx + 1:end);
        
    case 'TQ'
        vx = vec_x(1:nCoeffs_vx);
        wx = vec_x(nCoeffs_vx + 1: nCoeffs_vx + nCoeffs_wx);
        ux = -vec_x(nCoeffs_vx + nCoeffs_wx + 1:end);
        
    case 'DTQ Denominator Removed'
        
        vx = vec_x(1:nCoeffs_vx);
        wx = vec_x(nCoeffs_vx + 1: nCoeffs_vx + nCoeffs_wx);
        ux = -vec_x(nCoeffs_vx + nCoeffs_wx + 1:end);
        
    case 'DTQ Rearranged'
        
        vx = vec_x(1:nCoeffs_vx);
        wx = vec_x(nCoeffs_vx + 1: nCoeffs_vx + nCoeffs_wx);
        ux = -vec_x(nCoeffs_vx + nCoeffs_wx + 1:end);
        
    otherwise 
        error('err')
end



end