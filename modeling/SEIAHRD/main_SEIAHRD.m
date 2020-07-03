% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% This is the main file for the SEIAHRD epidemic model, which
% divides a population in 7 compartments:
%
%   S = susceptibles
%   E = exposed
%   I = symptomatic infectious
%   A = asymptomatic infectious
%   H = hospitalized
%   R = recovered
%   D = deceased
%
% Infection spreads via direct contact between
% a susceptible and infectious individual.
% Delay is modeled as an exposed group: there is an
% latent period until an infected becomes able to transmit.
% Among the infectious, most individuals are asymptomatic; only
% a small fraction display symptoms after incubation.
% Disease-related deaths are considered when infectious.
% A control procedure is considered: a fraction of the infectious,
% is hospitalized, thus reducing their infectivity and fatality chance.
%
% This model has 9 parameters:
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
%
% This codes uses rhs_SEIAHRD.m to define the ODE system
% and outputs the plots, R_nought value and R_control value. 
% Calculations are made on a day time scale.
% -----------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% last update: Jun 16, 2020
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% initial population size (number of individuals)
N0 = 1000;
        
% transmission rate (days^-1)
beta = 1/2;

% hospitalization infectivity-factor (adimensional)
%
% -- Models contact diminishment. 
% -- Values:  0<epsilonH<1.
epsilonH = 0.5;

% latent period (days)
Talpha = 10;

% latent rate (days^-1)
alpha = 1/Talpha;

% symptomatic fraction (adimensional)
%
% -- Models fraction of infectious that display symptoms. 
% -- Values: 0<fE<1.
fE = 0.4;

% recovery period (days)
Tgamma = 10;

% recovery rate (days^-1)
gamma = 1/Tgamma;

% hospitalization rate (days^-1)
rho = 1/7;

% death rate (days^-1)
delta = 1/15;

% Hospitalization recovery-factor (adimensional)
%
% -- Models fatality chance diminishment.  
% -- Values: 0<kappaH<1.
kappaH = 0.5;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

D0 = 0;                 % initial deceased                  (number of individuals)
R0 = 0;                 % initial recovered               (number of individuals)
H0 = 0;                 % initial hospitalized            (number of individuals)
A0 = 0;                 % initial asymptomatic infectious (number of individuals)
I0 = 0;                 % initial symptomatic infectious  (number of individuals)
E0 = 1;                 % initial exposed                 (number of individuals)
S0 = N0-E0-I0-A0-H0-R0; % initial susceptible             (number of individuals)

% initial cumulative infectious (number of individuals)
C0 = E0;
% -----------------------------------------------------------


% display code header on screen
% -----------------------------------------------------------

% computing the basic reproduction number R_nought
R_nought = beta/(gamma+delta);

% computing the control reproduction number R_control
DI = gamma + rho + delta;       % mean duration in compartment I
DA = gamma + delta;             % mean duration in compartment A
DH = gamma + kappaH*delta;      % mean duration in compartment H
R_control = fE*beta/DI + (1-fE)*beta/DA + rho*fE*epsilonH*beta/DI/DH;

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
disp(' --------------------------------------'             )
disp(' ++++++++++ SEIAHRD model +++++++++++++'             )
disp(' --------------------------------------'             )
disp(['  * initial population       = ',num2str(N0)]       )
disp( '    (individuals)              '                    )
disp(['  * transmission rate        = ',num2str(beta)]     )
disp( '    (days^-1)                  '                    )
disp(['  * hosp. infectivity        = ',num2str(epsilonH)] )
disp( '    (adimensional)             '                    )
disp(['  * latent rate              = ',num2str(alpha)]    )
disp( '    (days^-1)                  '                    )
disp(['  * symptomatic farction     = ',num2str(fE)]       )
disp( '    (adimensional)             '                    )
disp(['  * recovery rate            = ',num2str(gamma)]    )
disp( '    (days^-1)                  '                    )
disp(['  * hospitalization rate     = ',num2str(rho)]      )
disp( '    (days^-1)                  '                    )
disp(['  * death rate               = ',num2str(delta)]    )
disp( '    (days^-1)                  '                    )
disp(['  * hospitalization recovery = ',num2str(kappaH)]   )
disp( '    (adimensional)             '                    )
disp(['  * R_nought                 = ',num2str(R_nought)] )
disp( '    (adimensional)             '                    )
disp(['  * R_control                = ',num2str(R_control)])
disp( '    (adimensional)             '                    )
disp(' --------------------------------------'             )
% -----------------------------------------------------------


% integration of the initial value problem
% -----------------------------------------------------------

% parameters vector
param = [N0 beta epsilonH alpha fE gamma rho delta kappaH];

% initial conditions vector
IC = [S0 E0 I0 A0 H0 R0 D0 C0];

% time interval of analysis
   t0 = 1;                  % initial time (days)
   t1 = 365;                % final time   (days)
   dt = 0.1;                % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SEIAHRD(t,y,param),tspan,IC);

% time series
S = y(:,1);  % susceptible             (number of individuals)
E = y(:,2);  % exposed                 (number of individuals)
I = y(:,3);  % symptomatic infectious  (number of individuals)
A = y(:,4);  % asymptomatic infectious (number of individuals)
H = y(:,5);  % hospitalized            (number of individuals)
R = y(:,6);  % recovered               (number of individuals)
D = y(:,7);  % deceased                (number of individuals)
C = y(:,8);  % cumulative infectious   (number of individuals)
% -----------------------------------------------------------


% post-rocessing
% -----------------------------------------------------------

% NewCases (per day) computation
tu = 1;                     % time unit (days)
%
% -- tu/dt must be an integer
% -- tu = 1 defines a 'per day' computation
% -- For a 'per week' computation, use tu = 7 and t0 = 7
NewCases = zeros(floor((Ndt-1)/(tu/dt)),1);
for n = 1:length(NewCases)
    NewCases(n) = C((n)*tu/dt +1) - C((n-1)*tu/dt +1);
end


% custom colors
yellow = [255 204  0]/256;
orange = [256 128  0]/256;
brown  = [101  33 33]/256;

% plot all compartments of SEIAHRD model
figure(1)
hold on
fig1(1) = plot(time,S);
fig1(2) = plot(time,E);
fig1(3) = plot(time,I);
fig1(4) = plot(time,A);
fig1(5) = plot(time,H);
fig1(6) = plot(time,R);
fig1(7) = plot(time,D);
fig1(8) = plot(time,C);
hold off

    % plot labels
     title('SEIAHRD dynamic model'  );
    xlabel('time (days)'          );
    ylabel('number of individuals');

    % set plot settings
    set(gca,'FontSize',18);
    set(fig1,{'Color'},{'b';yellow;'r';orange;brown;'g';'k';'m'});
    set(fig1,{'LineWidth'},{2;2;2;2;2;2;2;2});
    
    % legend
    leg = {'Suceptibles'; 'Exposed'; 'Symp. Infectious';...
                    'Asymp. Infectious'; 'Hospitalized';...
                     'Recovered';'Deceased'; 'Cum. Infectious'};
    legend(fig1,leg,'Location','Best','FontSize',10);

    % axis limits
    xlim([t0 t1]);
    ylim([0 N0]);


% plot NewCases (per day) of SEIAHRD model
figure(2)
fig2 = scatter([1:length(NewCases)]+1,NewCases);

    % plot labels
     title('NewCases per day (SEIAHRD)' );
    xlabel('time (days)'                );
    ylabel('number of individuals'      );

    % set plot settings
    set(gca,'FontSize',18);
    set(fig2,{'MarkerFaceColor','MarkerEdgeColor'},{'y','r'});

    % axis limits
    xlim([t0 length(NewCases)]+1);
% -----------------------------------------------------------
