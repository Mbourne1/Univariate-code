function [Sk] = BuildSubresultant_2Polys(fx, gx, k)
% BuildSubresultant_2Polys(fx,gx,k)
%
% This function builds the k-th Sylvester subresultant matrix S_{k}(f,g), 
% in the Bernstein Basis.
%
%
% % Inputs
%
% fx : (Vector) Coefficients of polynomial f(x) in Bernstein Basis
%
% gx : (Vector) Coefficients of polynomial g(x) in Bernstein Basis
%
% k:  (Int) Index of subresultant S_{k} to be built
%
% % Outputs
%
% Sk : (Matrix) The kth Sylvester subresultant matrix S_{k}(f,g)


% Global Variables.
global SETTINGS


% Get the degree of the polynomial f(x)
m = GetDegree(fx);

% Get the degree of the polynomial g.
n = GetDegree(gx);


switch SETTINGS.SYLVESTER_BUILD_METHOD
    
    case 'T'
        
        T = BuildT_2Polys(fx, gx, k);
        Sk = T;
        
    case 'DT'
        
        D = BuildD_2Polys(m, n - k);
        T = BuildT_2Polys(fx, gx, k);
        Sk = D*T;
        
    case 'DTQ'
        
        D = BuildD_2Polys(m, n - k);
        T = BuildT_2Polys(fx, gx, k);
        Q = BuildQ_2Polys(m, n, k);
        Sk = D*T*Q;
        
    case 'TQ'
        
        T = BuildT_2Polys(fx, gx, k);
        Q = BuildQ_2Polys(m, n, k);
        
        Sk = T*Q;
        
    case 'DTQ Denominator Removed'
        
        DT1Q1 = BuildDT1Q1_Rearranged_RemovedDenom(fx, n - k);
        DT2Q2 = BuildDT1Q1_Rearranged_RemovedDenom(gx, m - k);
        
        Sk = [DT1Q1 DT2Q2];
        
        
        
    case 'DTQ Rearranged' % Build based on generating individual elements
        
        % Build First Partition
        D1T1Q = BuildDT1Q1(fx, n - k);
        
        % Build Second Partition
        D2T2Q = BuildDT1Q1(gx, m - k);
        
        % Build Sylvester Matrix by concatenation of matrices A and B.
        Sk = [D1T1Q D2T2Q];
        
    otherwise
        error('SETTINGS.SYLVESTER_BUILD_METHOD must be one of the following *T or *DT or *DTQ or *TQ or *DTQ Denominator Removed or *DTQ Rearranged')
end

end



