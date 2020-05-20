% -----------------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------------
% This function defines the system of ODEs for the
% SEIAHRD epidemic model.
%
% The dynamic state coordinates are:
%
%  S = susceptibles        (number of individuals)
%  E = exposed             (number of individuals)
%  I = infected            (number of individuals)
%  A = asymptomatic        (number of individuals)
%  H = hospitalized        (number of individuals)
%  R = recovered           (number of individuals)
%  D = deaths              (number of individuals)
%  C = cumulative infected (number of individuals)
%
% The epidemic model parameters are:
%
%   N0       = initial population size            (number of individuals)
%   beta     = transmission rate                  (days^-1)
%   epsilonH = hospitalization infectivity-factor (adimensional)
%   alpha    = latent rate                        (days^-1)
%   fE       = symptomatic fraction               (adimensional)
%   gamma    = recovery rate                      (days^-1)
%   rho      = hospitalization rate               (days^-1)
%   delta    = death rate                         (days^-1)
%   kappaH   = hospitalization recovery-factor    (adimensional)
% -----------------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% last update: May 19, 2020
% -----------------------------------------------------------------

% -----------------------------------------------------------------
function dydt = rhs_SEIAHRD(t,y,param)

% model parameters: param = [N0 epsilonH alpha fE gamma rho delta kappaH zeta]
N0       = param(1);  % initial population size   (number of individuals)
beta     = param(2);  % transmission rate (days^-1)
epsilonH = param(3);  % hospitalization infectivity-factor (adimensional)
alpha    = param(4);  % latent rate (days^-1)
fE       = param(5);  % symptomatic fraction (adimensional)
gamma    = param(6);  % recovery rate (days^-1)
rho      = param(7);  % hospitalization rate (days^-1)
delta    = param(8);  % death rate (days^-1)
kappaH   = param(9);  % hospitalization recovery-factor (adimensional)

% SEIAHRD dynamic model:
% 
%      y = [S E I A H R D C]               is the state vector
%   dydt = [dSdt dEdt dIdt dRdt dDdt dCdt] is the evolution law
%      N = current population at time t
% 
% dSdt - rate of susceptible         (number of individuals/days)
% dEdt - rate of exposed             (number of individuals/days)
% dIdt - rate of infected            (number of individuals/days)
% dAdt - rate of asymptomatic        (number of individuals/days)
% dHdt - rate of hospitalized        (number of individuals/days)
% dRdt - rate of recovered           (number of individuals/days)
% dDdt - rate of deaths              (number of individuals/days)
% dCdt - rate of cumulative infected (number of individuals/days)

[S E I A H R D C] = deal(y(1),y(2),y(3),y(4),y(5),y(6),y(7),y(8));

   N = N0 - D;
dSdt = - beta*S.*(I+A+epsilonH*H)./N;   
dEdt = beta*S.*(I+A+epsilonH*H)./N - alpha*E;                                           
dIdt = fE*alpha*E - (gamma+rho+delta)*I;           
dAdt = (1-fE)*alpha*E - (gamma+delta)*A;           
dHdt = rho*I - (gamma+kappaH*delta)*H;             
dRdt = gamma*(I+A+H);
dDdt = delta*(I+A+kappaH*H);
dCdt = alpha*E;                                    

% system of ODEs
dydt = [dSdt; dEdt; dIdt; dAdt; dHdt; dRdt; dDdt; dCdt];

end
% -----------------------------------------------------------------
