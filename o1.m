function [fx,gx,dx, ux, vx,alpha,theta] = ...
    o1(fx,gx)
% This function computes the GCD d(x) of two noisy polynomials f(x) and g(x).
%
%                             Inputs:
%
% fx : Coefficients of the polynomial f(x)
%
% gx : Coefficients of the polynomial g(x)
%
% Outputs:
%
% fx : f(x) + \delta f(x)
%
% gx : g(x) + \delta g(x
%
% dx : The GCD of f(x) + \delta f(x) and g(x) + \delta g(x)
%
% ux : Coefficients of polynomial u(x) where u(x) = f(x)/d(x)
%
% vx : Coefficeints of polynomial v(x) where v(x) = g(x)/d(x)
% 
% alpha : Optimal \alpha
% 
% theta : Optimal \theta


%
%                       GLOBAL VARIABLES

global LOW_RANK_APPROXIMATION_METHOD
global APF_METHOD
global PLOT_GRAPHS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the degree m of polynomial f
m = GetDegree(fx) ;

% Get the degree n of polynomial g
n = GetDegree(gx) ;

% Get degree of GCD by first method

% Method 1 - 'From Scratch' Build each subresultant from scratch
[t, alpha, theta, gm_fx, gm_gx] = ...
    GetGCD_Degree(fx,gx);

fprintf('GCD Degree : %i \n ',t);

if t == 0
    % If the two polynomials f(x) and g(x) are coprime, set GCD to be 1,
    fprintf('\n f(x) and g(x) are coprime \n')
    dx = 1;
    ux = fx;
    vx = gx;
    alpha = 1;
    theta = 1;
    return
end

% If finding the GCD fails, set the degree of the GCD to be 1.
if isempty(t)
    t = 1;
end

% Normalise f(x) and g(x) by Geometric mean to obtain fx_n and gx_n.
% Normalise by geometric mean obtained by entries of f(x) and g(x) in the
% subresultant S_{t}
fx_n = fx./gm_fx;
gx_n = gx./gm_gx;

% Get the Sylvester subresultant of unprocessed f(x) and g(x)
St_unproc = BuildSubresultant(fx,gx,t);

% Get Subresultant of preprocessed f(\theta,\omega) and g(\theta, \omega)
fw = fx_n.*(theta.^(0:1:m)');
gw = gx_n.*(theta.^(0:1:n)');

St_preproc = BuildSubresultant(fw,alpha.*gw,t);

%%
% Get the optimal column of the sylvester matrix to be removed. Where
% removal of the optimal column gives the minmal residual in (Ak x = ck)
[opt_col] = GetOptimalColumn(St_preproc);

%% Perform SNTLN
% Apply / Don't Apply structured perturbations.

switch LOW_RANK_APPROXIMATION_METHOD
    case 'Standard STLN' 
        
        % Performe structured Total Least Norm
        [fw,a_gw] = STLN(fw,alpha.*gw,t,opt_col);
        
        % Get f(x) and g(x) from low rank approximation.
        fx_n = GetWithoutThetas(fw,theta);
                
        gw = a_gw ./ alpha;
        gx_n = GetWithoutThetas(gw,theta);
        
        
    case 'Standard SNTLN' % Structured Non-Linear Total Least Norm

        % Perform Structured non-linear total least norm
        [fx_n,gx_n,alpha,theta,~] = SNTLN(fx_n,gx_n,alpha,theta,t,opt_col);
        
        
    case 'Root Specific SNTLN'
        
        [fx_n,gx_n,alpha,theta,~] = ...
            SNTLN_Roots(fx_n,gx_n,alpha,theta,t,opt_col,gm_fx,gm_gx);
        
    case 'None'
        
    otherwise
        error('Global variable LOW_RANK_APPROXIMATION_METHOD must be valid')
end

% Get quotient polynomials u(x) and v(x)
[ux,vx] = GetQuotients(fx_n,gx_n,t,alpha,theta);


%%
% Build Sylvester Matrix for normalised, refined coefficients, used in
% comparing singular values.

fw = GetWithThetas(fx,theta);
gw = GetWithThetas(gx,theta);

St_low_rank = BuildSubresultant(fw,alpha.*gw,t);

%% Get the coefficients of the GCD
dx = GetGCD(ux,vx,fx_n,gx_n,t,alpha,theta);


%%
% Apply/Don't Apply structured perturbations to Approximate Polynomial
% Factorisation such that approximation becomes equality.
switch APF_METHOD
    case 'Root Specific APF'
        % Use root method which has added constraints.
        
        [PostAPF_fx, PostAPF_gx, PostAPF_dx, PostAPF_uk, PostAPF_vk, PostAPF_theta] = ...
            APF_Roots(fx_n,ux,vx,theta,dx,t);
        
        % Build Post APF_gx
        PostAPF_gx = zeros(m,1);
        for i = 0:1:m-1
            PostAPF_gx(i+1) = m.*(gm_fx./ gm_gx) .* (PostAPF_fx(i+2) - PostAPF_fx(i+1));
        end
        % update ux,vx,dx values
        dx = PostAPF_dx;
        vx = PostAPF_vk;
        ux = PostAPF_uk;
        
        % Edit 20/07/2015
        fx = PostAPF_fx;
        gx = PostAPF_gx;
        
    case 'Standard APF'
        [PostAPF_fx, PostAPF_gx, PostAPF_dx, PostAPF_uk, PostAPF_vk, PostAPF_theta] = ...
            APF(fx_n,gx_n,ux,vx,alpha,theta,dx,t);
        
        % update ux,vx,dx values
        dx = PostAPF_dx;
        vx = PostAPF_vk;
        ux = PostAPF_uk;
        
        % Edit 20/07/2015
        fx = PostAPF_fx;
        gx = PostAPF_gx;
    case 'None'
        % Do Nothing
    otherwise
        error('err')
end






%%
% Assesment of the Sylvester Matrix before processing, post processing, and
% post SNTLN. Before Preprocessing


% Get singular values of Sylvester matrix of noisy input polynomials
vSingVals_St_unproc = svd(St_unproc);
vSingVals_St_unproc = vSingVals_St_unproc./norm(vSingVals_St_unproc);

% Get Singular values of Sylvester matrix of preprocessed polynomials
vSingVals_St_preproc = svd(St_preproc);
vSingVals_St_preproc = vSingVals_St_preproc./norm(vSingVals_St_preproc);

% Get Singular values of Sylvester matrix of f+ \delta f and g+\delta g
vSingVals_St_LowRank = svd(St_low_rank);
vSingVals_St_LowRank = vSingVals_St_LowRank./norm(vSingVals_St_LowRank);


% Plot the Singular Values of the Sylvester matrix
switch PLOT_GRAPHS
    case 'y'
        figure('name','Singaular values of Sylvester Matrix');
        plot(1:1:length(vSingVals_St_unproc),log10(vSingVals_St_unproc),'red-s','DisplayName','Before Preprocessing')
        hold on
        plot(1:1:length(vSingVals_St_preproc),log10(vSingVals_St_preproc),'blue-s','DisplayName','After Preprocessing')
        switch LOW_RANK_APPROXIMATION_METHOD
            case {'Standard STLN', 'Standard SNTLN','Root Specific SNTLN'}
                plot(1:1:length(vSingVals_St_LowRank),log10(vSingVals_St_LowRank),'green-s','DisplayName','Low Rank Approximation')
            case 'None'
            otherwise
                error('error : Low rank approximation method must be valid')
        end
        legend(gca,'show');
        xlabel('i')
        title('Ordered Singular Values of The Sylvester Matrix S{(f,g)}')
        ylabel('log_{10} Minimal Singular Values ')
        hold off
    case 'n'
    otherwise
        error('err')
end







end








