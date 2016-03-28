function hi = Deconvolve(set_g)
% Performs a series of d deconvolutions over a set of polynomials,
% where each polynomial g_{i} appears in two deconvolutions.
%
%
% Inputs
%
%
% set_g :   set of input polynomials g(y) to be deconvolved. Each g_{i} has a
%           different number of elements, so set_g is a cell array.
%
% Outputs
%
%
% h_{i} = g_{i-1}/g_{i}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Set Deconvolution Method
%   single := Use standard non batch method
%   batch  := Use batch deconvolution
global BOOL_DECONVOLVE

switch BOOL_DECONVOLVE
    case 'Single'
        % Deconvolve independent method
        hi = Deconvolve_Independent(set_g);
    case 'Batch'
        % Deconvolve Batch Method
        hi = Deconvolve_Batch(set_g);
    otherwise
        error('BOOL_DECONVOLVE must be either (Single) or (Batch)')
end




end

function hi = Deconvolve_Independent(set_g)
% Perform a series of deconvolutions independently, and output the
% solutions as an array of vectors.
%
%                          Inputs
%
%
% set_g : the array of polynomials on which deconvolution is performed.
%
%


% for each item in set g starting at
for i = 1:1:length(set_g)-1
    % Get the two polynomials which are to be deconvolved
    % f{i},f{i+1}
    hi{i} = Deconvolve_Independent_Subfunction(set_g{i},set_g{i+1});
end


end

function h1 = Deconvolve_Independent_Subfunction(f0,f1)
% Given two polynomials, f0 and f1 of degrees m0 and m1, perform
% deconvolution to obtain h1 = f0/f1, 
% f0 : first input polynomial.
% f1 : second input polynomial.


% h1 : output polynomial = f0/f1.

% Obtain degree of polynomial f0
m0 = size(f0,1)-1;

% Obtain degree of polynomial f1
m1 = size(f1,1)-1;

% Set right hand side vector
RHS_f = f0;
bk = RHS_f;

% Build Left hand side matrix.
DCQ = BuildD0C1Q1_nchoosek(f1,m0);

h1 = SolveAx_b(DCQ,bk);

end

function D0C1Q1 = BuildD0C1Q1_nchoosek(f1,m0)
% Build a partition D_{i-1}C_{i}Q_{i} of the DCQ matrix
global BOOL_DENOM_SYL

% Get the degree of polynomial f1.
m1 = size(f1,1) - 1;

% Define n1 the degree of h1 to be found.
n1 = m0 - m1;

% Preassign space for partition D_{0}C_{1}Q_{1}
D0C1Q1 = zeros(m0+1,n1+1);

% For each column k = 0:1:m_{i-1} - m_{i}
for j = 0:1:m0-m1
    % For each row j = k:1:m_{i}+k
    for i = j:1:m1+j
        D0C1Q1(i+1,j+1) = ...
            f1(i-j+1) .* ...
            nchoosek(i,j) .* nchoosek(m0-i,m1-(i-j)) ;
    end
end

% % If including the denominator
switch BOOL_DENOM_SYL
    case 'y'
        % Included denominator in sylvester matrix
        denom = nchoosek(m0,m1);
        D0C1Q1 = D0C1Q1 ./ denom ;
    case 'n'
    otherwise
        error('err')
end
end