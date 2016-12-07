function [Cf] = BuildSubresultant_Partition_2Polys(fx,n_k)
% BuildSubresultant_Partition_2Polys(fx, n_k)
%
% This function builds a partition of the kth subresultant matrix S_{k}(f,g)
% where f(x) is in the Bernstein Basis.
%
%
% % Inputs
%
% fx : Coefficients of polynomial f(x) in Bernstein Basis
%
% n_k:  Degree of polynomial v(x)
%
% % Outputs
%
% Sk : The kth Sylvester subresultant matrix S_{k}(f,g)


% Global Variables.
global SETTINGS


% Get the degree of the polynomial f(x)
m = GetDegree(fx);

% Get the degree of the polynomial g.
n = GetDegree(n_k);


switch SETTINGS.SYLVESTER_BUILD_METHOD
    
    case 'T'
        
        T1 = BuildT1(fx,n_k);
        Cf = T1;
        
    case 'DT'
        
        D = BuildD(m,n_k);
        T1 = BuildT1(fx,n_k);
        Cf = D*T1;
        
    case 'DTQ'
        
        D = BuildD_2Polys(m,n_k);
        T1 = BuildT1(fx,n_k);
        Q1 = BuildQ1(n_k);
        Cf = D*T1*Q1;
        
    case 'TQ'
        
        T1 = BuildT1(fx,n_k);
        Q1 = BuildQ1(n_k);
        
        Cf = T1*Q1;
        
    case 'DTQ Rearranged Denom Removed'
        
        DT1Q1 = BuildDT1Q1_Rearranged_RemovedDenom(fx,n_k);
        
        Cf = DT1Q1;
        
        
    case 'DTQ Rearranged' % Build based on generating individual elements
        
        % Build First Partition
        DT1Q1 = BuildDT1Q1_Rearranged(fx,n_k);
        
        Cf = DT1Q1;
        
    otherwise
        error('SETTINGS.SYLVESTER_BUILD_METHOD is either standard or rearranged')
end

end




