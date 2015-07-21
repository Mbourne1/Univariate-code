
function [f_noisy,noisevector]=VariableNoise(f,el,eu,seed)
% This function adds noise in the componentwise sense to the coefficients
% of the Bernstein basis polynomial.
% The upper threshold \epsilon is a random variable between two values
% \epsilon_{max} and \epsilon_{min}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                           Inputs:


% f :- exact coefficients of polynomial f, in the Bernstein basis.

% el:- Lower threshold of the epsilon value (Noise/Signal)

% eu:- Upper threshold of the epsilon value (Noise/Signal)

% r :- Random Variable in interval [-1,+1]

% v :- Random Variable in interval [0,1]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                          Outputs:


% f_noisy :- the noisy coefficients of perturbed polynomial f.

% noisevector:- vector of the noise added to f_exact.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get degree of input polynomial f.
m = length(f) - 1  ;

% Set Seed for random number generator.
rng(seed)

% Generate random variables r_{i}
r = (2*rand(m+1,1))-ones(m+1,1);


% Generate random variables v_{i}
v = rand(m+1,1);

% Get vector 'eps' - the vector which stores the upper Noise/Signal
% threshold \epsilon_{i} for each cofficient a_{i}
eps = el + v.*(eu-el);

% Calculate the noise vector = a_{i}r_{i}.*\epsilon_{i}
noisevector = f.* r .*eps;

% Calculate the perturbed coefficients = a_{i} + a_{i}r_{i}\epsilon_{i}
f_noisy = f + noisevector;




end