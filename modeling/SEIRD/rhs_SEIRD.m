% -----------------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------------
% Modeling: rhs_SEIRD.m
%
% This function defines the system of ODEs for the
% SEIRD epidemic model.
%
% The dynamic state coordinates are:
%
%   S = susceptibles          (number of individuals)
%   E = exposed               (number of individuals)
%   I = infectious            (number of individuals)
%   R = recovered             (number of individuals)
%   D = deceased              (number of individuals)
%   C = cumulative infectious (number of individuals)
%
% The epidemic model parameters are:
%
%   N0    = initial population size (number of individuals)
%   beta  = transmission rate       (days^-1)
%   alpha = latent rate             (days^-1)
%   gamma = recovery rate           (days^-1)
%   delta = death rate              (days^-1)
%
% Inputs:
%   t: time                    - double
%   y: state vector            - double array (6x1)
%   param: parameters vector   - double array (5x1)
%
% Output:
%   dydt: state rate of change - double array (6x1)
% -----------------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% number of lines: 27
% last update: Jan 17, 2021
% -----------------------------------------------------------------

% -----------------------------------------------------------------
function dydt = rhs_SEIRD(t,y,param)

if length(param) < 5 
   error('Warning: To few model parameters')
elseif length(param) > 5
   error('Warning: To many model parameters')
end

if mod(param(1),1) ~= 0
   error('Warning: Use a integer population size')
end

if sum(param<0)~=0
   error('Warning: Use positive parameters values')
end

% model parameters: param = [N0 beta alpha gamma delta]
N0    = param(1);  % initial population size   (number of individuals)
beta  = param(2);  % transmission rate         (days^-1)
alpha = param(3);  % latent rate               (days^-1)
gamma = param(4);  % recovery rate             (days^-1)
delta = param(5);  % death rate                (days^-1)

% SEIRD dynamic model:
% 
%      y = [S E I R D C]                   is the state vector
%   dydt = [dSdt dEdt dIdt dRdt dNdt dCdt] is the evolution law
%      N = current population at time t
% 
% dSdt - rate of susceptible           (number of individuals/days)
% dEdt - rate of exposed               (number of individuals/days)
% dIdt - rate of infectious            (number of individuals/days)
% dRdt - rate of recovered             (number of individuals/days)
% dDdt - rate of deceased              (number of individuals/days)
% dCdt - rate of cumulative infectious (number of individuals/days)

[S E I R D C] = deal(y(1),y(2),y(3),y(4),y(5),y(6));

   N = N0 - D;
dSdt = - beta*S*(I/N);
dEdt = beta*S*(I/N) - alpha*E;
dIdt = alpha*E - (gamma+delta)*I;
dRdt = gamma*I;
dDdt = delta*I;
dCdt = alpha*E;
dydt = [dSdt; dEdt; dIdt; dRdt; dDdt; dCdt];

end
% -----------------------------------------------------------------
