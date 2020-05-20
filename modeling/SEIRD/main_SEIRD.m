% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% This is the main file for the SEIRD epidemic model, which
% divides a population in 5 compartments:
%
%   S = susceptibles
%   E = exposed
%   I = infectious
%   R = recovered
%   D = deaths
%
% Infection spreads via direct contact between
% a susceptible and infectious individual.
% Delay is modeled as an exposed group: there is an
% latent period until an infected becomes able to 
% transmit (infectious).
% Disease-related deaths are considered when infectious.
%
% This model has 5 parameters:
%
%   N0    = initial population size   (number of individuals)
%   beta  = transmission rate         (days^-1)
%   alpha = latent rate               (days^-1)
%   gamma = recovery rate             (days^-1)
%   delta = death rate                (days^-1)
%
% This codes uses rhs_SEIRD.m to define the ODE system
% and outputs the plots and R_nought value. Calculations
% are made on a day time scale.
% -----------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% last update: May 19, 2020
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% initial population size (number of individuals)
N0 = 1000;
        
% transmission rate (days^-1)
beta = 1/4;

% latent period (days)
Talpha = 7;

% latent rate (days^-1)
alpha = 1/Talpha;

% recovery period (days)
Tgamma = 10;

% recovery rate (days^-1)
gamma  = 1/Tgamma;

% death rate (days^-1)
delta = 1/15;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

D0 = 0;            % initial deaths      (number of individuals)
R0 = 0;            % initial recovered   (number of individuals)
I0 = 1;            % initial infected    (number of individuals)
E0 = 0;            % initial exposed     (number of individuals)
S0 = N0-E0-I0-R0;  % initial susceptible (number of individuals)

% initial cumulative infected (number of individuals)
C0 = I0;
% -----------------------------------------------------------


% display program header on screen
% -----------------------------------------------------------

% computing the basic reproduction number R_nought
R_nought = beta/gamma;

disp(' ')
disp('================================================')
disp('   EPIDEMIC - Epidemiology Educational Code     ')
disp('   by A. Cunha, E. Dantas, et al.               ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' --------------------------------------'      )
disp(' ++++++++++++ SEIRD model +++++++++++++'      )
disp(' --------------------------------------'      )
disp(['  * initial population = ',num2str(N0)]      )
disp( '    (individuals)        '                   )
disp(['  * transmission rate  = ',num2str(beta)]    )
disp( '    (days^-1)            '                   )
disp(['  * latent rate        = ',num2str(alpha)]   )
disp( '    (days^-1)            '                   )
disp(['  * recovery rate      = ',num2str(gamma)]   )
disp( '    (days^-1)            '                   )
disp(['  * death rate         = ',num2str(delta)]   )
disp( '    (days^-1)            '                   )
disp(['  * R_nought           = ',num2str(R_nought)])
disp( '    (adimensional)       '                   )
disp(' --------------------------------------'      )
% -----------------------------------------------------------


% integration of the initial value problem
% -----------------------------------------------------------

% parameters vector
param = [N0 beta alpha gamma delta];

% initial conditions vector
IC = [S0 E0 I0 R0 D0 C0];

% time interval of analysis
   t0 = 1;                  % initial time (days)
   t1 = 365;                % final time   (days)
   dt = 1;                  % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SEIRD(t,y,param),tspan,IC);

% time series
S = y(:,1);      % susceptibles        (number of individuals)
E = y(:,2);      % exposed             (number of individuals)
I = y(:,3);      % infected            (number of individuals)
R = y(:,4);      % recovered           (number of individuals)
D = y(:,5);      % deaths              (number of individuals)
C = y(:,6);      % cumulative infected (number of individuals)
% -----------------------------------------------------------


% post-processing
% -----------------------------------------------------------

% custom colors
yellow = [255 204  0]/256;

% plot all populalations of SEIRD model
figure(1)
hold on
figS = plot(time,S,'DisplayName','Suceptibles' ,'Color','b');
figE = plot(time,E,'DisplayName','Exposed'     ,'Color',yellow);
figI = plot(time,I,'DisplayName','Infected'    ,'Color','r');
figR = plot(time,R,'DisplayName','Recovered'   ,'Color','g');
figD = plot(time,D,'DisplayName','Deaths'      ,'Color','k');
figC = plot(time,C,'DisplayName','Cum. Inf.'   ,'Color','m');
hold off

% plot labels
 title('SEIRD dynamic model'  );
xlabel('time (days)'          );
ylabel('number of individuals');

% legend
leg = [figS; figE; figI; figR; figD; figC];
leg = legend(leg,'Location','Best');

% set plot settings
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultLineLineWidth',2);
set(leg,'FontSize',10);

% axis limits
xlim([t0 t1]);
ylim([0 N0]);
% -----------------------------------------------------------