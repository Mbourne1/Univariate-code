function [ root_mult_array ] = o_roots_bisection(fx)
%   ROOTS_BISECTION obtain roots in interval by bisection method, once a
%   root is obtained with assumed multiplicity one, deconvolve and perform
%   bisection on f2 with root removed, until no more roots are found.
%
% Inputs.
%
% fx : Coefficients of polynomial f(x)
%
%
% Outputs.
%
% root_mult_array : Matrix of roots of f(x) and their corresponding
% multiplicities, where the row i contains r_{i} and multiplicity m_{i}.

% Get the upper and lower bound of the bisection method.
interval_lowerbound = 0;
interval_upperbound = 1;

b = interval_upperbound;
a = interval_lowerbound;

% Set some variables
min_interval_size = 0.001;
eps_abs = 1e-10;

% Plot f(x)
ite_num = 1;

root_mult_array = [];

figure_name = sprintf('%s : Bernstein Polynomial Curve %i',mfilename,ite_num);
Plot_fx(fx,a,b,figure_name);

while (b - a >= min_interval_size)
    %&&...
    %(abs( Bernstein_Evaluate(fx,a) ) >= eps_abs) &&...
    %(abs( Bernstein_Evaluate(fx,b) ) >= eps_abs ))
    
    % Obtain the midpoint of the interval
    c = (a + b)/2;
    
    % check to see if the evaluation of the function f at the midpoint is
    % within the margins of error of zero
    if ( abs(Bernstein_Evaluate(fx,c)) < eps_abs )
        break;
        
        % Check for change of sign in the first half of the interval
    elseif ( Bernstein_Evaluate(fx,a)*Bernstein_Evaluate(fx,c) < 0 )
        
        % if a change of sign exists, then root lies in the interval [a,c] and
        % must bisect the new interval. so set upper end of interval b = c.
        b = c;
        
        % Check for change of sign in the second half of the interval
    elseif ( Bernstein_Evaluate(fx,c)*Bernstein_Evaluate(fx,b) < 0)
        % if change of sign exists, then root lies in the interval [c,b]
        % and we must bisect the new interval. so set lower end of the
        % interval a equal to c.
        
        a = c;
        
    else
        PrintoutRoots('BISECTION' , root_mult_array)
        return
    end
end

% Get calculated roots and multiplicity
root_mult = [c 1];

% Initialise list of all roots
root_mult_array = root_mult;

% Convert to polynomial in scaled bernstein form
gx_bi = B_poly(root_mult);

% Build polynomial of the removed root
gx = GetWithoutBinomials(gx_bi);

% Perform deconvolution to obtain f2, the remainder of the polynomial now
% that the found root has been removed.
f2 = Bernstein_Deconvolve(fx,gx);

ite_num = 1;

% while the degree of f2 is greater than 1
while GetDegree(f2) >=1
    
    % Increment the iteration number
    ite_num = ite_num + 1;
    
    % Get the control points of f2
    figure_name = sprintf('%s : Bernstein Polynomial Curve - %i',mfilename,ite_num);
    Plot_fx(f2,0,1,figure_name);
    
    % Set interval lower bound
    a = interval_lowerbound;
    
    % Set interval upper bound
    b = interval_upperbound;
    
    
    while (b - a >= min_interval_size )
        %&& ...
        % (abs( Bernstein_Evaluate(f2,a) ) >= eps_abs && ...
        %(abs( Bernstein_Evaluate(f2,b) ) >= eps_abs ) ))
        
        % Get the midpoint of the interval
        c = (a + b)/2;
        
        % Evaluate the function at the midpoint
        if (  abs(Bernstein_Evaluate(f2,c)) < eps_abs )
            break;
            
            % Check for change of sign in first half of the interval
        elseif ( Bernstein_Evaluate(f2,a)*Bernstein_Evaluate(f2,c) < 0 )
            % if change of sign, then set the upper bound of the next
            % interval b = c
            b = c;
            
            % Check for change of sign in the second half of the interval
        elseif ( Bernstein_Evaluate(f2,b)*Bernstein_Evaluate(f2,c) < 0 )
            % if change of sign, then set the lower bound of the next
            % interval a = c
            a = c;
        else
            PrintoutRoots('BISECTION' , root_mult_array)
            return;
        end
    end
    
    % Get calculated roots and multiplicity
    root_mult = [c 1];
    
    % Add root to list of roots
    root_mult_array = [root_mult_array ;root_mult];
    
    % Convert to polynomial in scaled bernstein form
    gx_bi = B_poly(root_mult);
    
    % Build polynomial of removed root
    gx = GetWithoutBinomials(gx_bi);
    
    % Perform deconvolution to obtain f2
    f2 = Bernstein_Deconvolve(f2,gx);
    
    
end

% Print out roots
PrintoutRoots('BISECTION' , root_mult_array)
end









