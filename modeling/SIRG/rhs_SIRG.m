% -----------------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------------
% This function defines the system of ODEs for the SIRG
% epidemic model.
%
% The dynamic state coordinates are:
%
%  S = susceptibles  (number of individuals)
%  I = infected      (number of individuals)
%  R = recovered     (number of individuals)
%  G = guarded       (number of individuals)
%
% The epidemic model parameters are:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   gamma = recovery rate     (days^-1)
%   phi   = quantine-in rate  (days^-1)
%   theta = quantine-out rate (days^-1)
%   tq0   = quantine start (days)
%   tq1   = quantine end (days)
%
% Inputs:
%   t: time                    - double
%   y: state vector            - double array (5x1)
%   param: parameters vector   - double array (7x1)
%
% Output:
%   dydt: state rate of change - double array (5x1)
% -----------------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% number of lines: 34
% last update: Jan 27, 2021
% -----------------------------------------------------------------

% -----------------------------------------------------------------
function dydt = rhs_SIRG(t,y,param)

if length(param) < 7 
   error('Warning: To few model parameters')
elseif length(param) > 7
   error('Warning: To many model parameters')
end

if mod(param(1),1) ~= 0
   error('Warning: Use a integer population size')
end

if sum(param<0)~=0
   error('Warning: Use positive parameters values')
end

if sum([param(4) param(5)]>1) ~=0
   error('Warning: Use values < 1 for phi and theta')
end

if param(6) > param(7)
   error('Warning: Use tqo < tq1')
end

% model parameters: param = [N beta gamma phi theta tq0 tq1]
N      = param(1);  % population size  (days^-1)
beta   = param(2);  % transmission rate  (days^-1)
gamma  = param(3);  % recovery rate      (days^-1)
phi    = param(4);  % quarantine-in rate (days^-1)
theta  = param(5);  % quantine-out rate  (days^-1)
tq0    = param(6);  % quarentine start   (day)
tq1    = param(7);  % quarentine end     (day)

% SIRG dynamic model:
% 
%      y = [S I R G]             is the state vector
%   dydt = [dSdt dIdt dRdt dQdt] is the evolution law
% 
% dSdt - rate of susceptible  (number of individuals/days)
% dIdt - rate of infected     (number of individuals/days)
% dRdt - rate of recovered    (number of individuals/days)
% dGdt - rate of guarded      (number of individuals/days)

[S,I,R,G,C] = deal(y(1),y(2),y(3),y(4),y(5));

% rate of quarentine adherence
Phi = phi*(heaviside(t-tq0)-heaviside(t-tq1));

dSdt = - beta*S.*(I/N) - Phi*S + theta*G;
dIdt = beta*S.*(I/N) - gamma*I;
dRdt = gamma*I;
dGdt = Phi*S - theta*G;
dCdt = beta*S.*(I/N);
dydt = [dSdt; dIdt; dRdt; dGdt; dCdt];

end
% -----------------------------------------------------------------
