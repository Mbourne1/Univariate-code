function [dx] = GetGCDCoefficients_3Polys(ux, vx, wx, fx, gx, hx, k, alpha, theta)
% Get The Coefficients of the approximate GCD using Quotient Polynomials.
%
% % Inputs
%
% [ux, vx, wx] : Coefficients of cofactor polynomials u(x), v(x) and w(x) 
% in the Bernstein basis.
%
% [fx, gx, hx] : Coefficients of polynomial f(x), g(x) and h(x) in the 
% Bernstein basis.
%
% k : Degree of common divisor.
%
% alpha : Optimal value of \alpha
%
% theta : Optimal value of \theta
%
% % Outputs
%
% dx : Coefficients of the polynomial d(x)


% Global variables
global SETTINGS

% Get f(w) and g(w)
fw = GetWithThetas(fx,theta);
gw = GetWithThetas(gx,theta);
hw = GetWithThetas(hx,theta);

% Get u(w) and v(w)
uw = GetWithThetas(ux,theta);
vw = GetWithThetas(vx,theta);
ww = GetWithThetas(wx,theta);

switch SETTINGS.GCD_COEFFICIENT_METHOD
    case 'ux and vx'
        % Build solution vector bk = [f;g]
        bk = [fw ; alpha .* gw; hw];
        
        % Build the coefficient vector HCG
        HCG = BuildHCG_3Polys(uw,vw,ww,k);
        
        % Get the vector d(w), which is the solution of a problem of the form Ax=b
        dw = SolveAx_b(HCG,bk);
        
        % Get d(x) without thetas
        dx = GetWithoutThetas(dw,theta);
        
    case 'ux'
        bk = fw;
        
        H1C1G = BuildH1C1G(uw,k);
        
        dw = SolveAx_b(H1C1G,bk);
        
        dx = GetWithoutThetas(dw,theta);
    otherwise
        error('GCD_COEFFICIENT_METHOD is either (ux) or (ux and vx)')
end




