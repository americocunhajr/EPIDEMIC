% -----------------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------------
% Modeling: rhs_SIR.m
%
% This function defines the system of ODEs for the
% SIR epidemic model.
%
% The dynamic state coordinates are:
%
%   S = susceptibles        (number of individuals)
%   I = infected            (number of individuals)
%   R = recovered           (number of individuals)
%   C = cumulative infected (number of individuals)
%
% The epidemic model parameters are:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   gamma = recovery rate     (days^-1)
%
% Inputs:
%   t: time                    - double
%   y: state vector            - double array (4x1)
%   param: parameters vector   - double array (3x1)
%
% Output:
%   dydt: state rate of change - double array (4x1)
% -----------------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% number of lines: 22
% last update: Jan 19, 2021
% -----------------------------------------------------------------

% -----------------------------------------------------------------
function dydt = rhs_SIR(t,y,param)

if length(param) < 3 
   error('Warning: To few model parameters')
elseif length(param) > 3
   error('Warning: To many model parameters')
end

if mod(param(1),1) ~= 0
   error('Warning: Use a integer population size')
end

if sum(param<0)~=0
   error('Warning: Use positive parameters values')
end

% model parameters: param = [N beta gamma]
N     = param(1);  % population size   (number of individuals)
beta  = param(2);  % transmission rate (days^-1)
gamma = param(3);  % recovery rate     (days^-1)

% SIR dynamic model:
% 
%      y = [S I R C]             is the state vector
%   dydt = [dSdt dIdt dRdt dCdt] is the evolution law
% 
% dSdt - rate of susceptible         (number of individuals/days)
% dIdt - rate of infected            (number of individuals/days)
% dRdt - rate of recovered           (number of individuals/days)
% dCdt - rate of cumulative infected (number of individuals/days)

[S I R C] = deal(y(1),y(2),y(3),y(4));

dSdt = - beta*S.*(I/N);
dIdt = beta*S.*(I/N) - gamma*I;
dRdt = gamma*I;
dCdt = beta*S.*(I/N);
dydt = [dSdt; dIdt; dRdt; dCdt];

end
% -----------------------------------------------------------------
