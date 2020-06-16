% -----------------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------------
% This function defines the system of ODEs for the
% SEIR epidemic model.
%
% The dynamic state coordinates are:
%
%  S = susceptibles        (number of individuals)
%  E = exposed             (number of individuals)
%  I = infectious          (number of individuals)
%  R = recovered           (number of individuals)
%  C = cumulative infected (number of individuals)
%
% The epidemic model parameters are:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   alpha = latent rate       (days^-1)
%   gamma = recovery rate     (days^-1)
% -----------------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% last update: Jun 16, 2020
% -----------------------------------------------------------------

% -----------------------------------------------------------------
function dydt = rhs_SEIR(t,y,param)

% model parameters: param = [N beta alpha gamma]
N     = param(1);  % population size   (number of individuals)
beta  = param(2);  % transmission rate (days^-1)
alpha = param(3);  % latent rate       (days^-1)
gamma = param(4);  % recovery rate     (days^-1)

% SEIR dynamic model:
% 
%      y = [S E I R C]                is the state vector
%   dydt = [dSdt dEdt dIdt dRdt dCdt] is the evolution law
% 
% dSdt - rate of susceptible         (number of individuals/days)
% dEdt - rate of exposed             (number of individuals/days)
% dIdt - rate of infectious          (number of individuals/days)
% dRdt - rate of recovered           (number of individuals/days)
% dCdt - rate of cumulative infected (number of individuals/days)

[S E I R C] = deal(y(1),y(2),y(3),y(4),y(5));

dSdt = - beta*S.*(I/N);
dEdt = beta*S.*(I/N) - alpha*E;
dIdt = alpha*E - gamma*I;
dRdt = gamma*I;
dCdt = alpha*E;
dydt = [dSdt; dEdt; dIdt; dRdt; dCdt];

end
% -----------------------------------------------------------------
