% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: main_SEIRAHD.m
%
% This is the main file for the SEIR(+AHD) epidemic model, which
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
%   alpha    = latent rate                        (days^-1)
%   fE       = symptomatic fraction               (dimensionless)
%   gamma    = recovery rate                      (days^-1)
%   rho      = hospitalization rate               (days^-1)
%   delta    = death rate                         (days^-1)
%   kappaH   = hospitalization mortality-factor   (dimensionless)
%
% This codes uses rhs_SEIRAHD.m to define the ODE system
% and outputs the plots, R_nought value and R_control value. 
% Calculations are made on a day time scale.
%
% The parameters used in this example were taken from this work.
% W. Lyra, J. Nascimento, J. Belkhiria, L. de Almeida,
% P. P. Chrispim and I. Andrade.COVID-19 pandemics modelingwith
% SEIR(+CAQH), social distancing, and age stratification. The effect
% of vertical confinement and release in Brazil.,medRxiv, 2020.
%
% Inputs:
%   param: parameters vector      - double array (9x1)
%   IC: initial conditions vector - double array (8X1)
%   tspan: time interval          - double array (?x1)
%   rhs_SEIRAHD: SEIRAHD equations file - .m function file
%
% Outputs:
%   R_nought: basic reproduction number   - double
%   figure 1: model state in time         - inplace figure
%   figure 2: number of new cases in time - inplace figure
% -----------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% number of lines: 119
% last update: Jan 26, 2021
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% initial population size (number of individuals)
N0 = 1000;
        
% transmission rate (days^-1)
beta = 0.25;

% hospitalization infectivity-factor (dimensionless)
%
% -- Models contact diminishment. 

% latent period (days)
Talpha = 5;

% latent rate (days^-1)
alpha = 1/Talpha;

% symptomatic fraction (dimensionless)
%
% -- Models fraction of infectious that display symptoms. 
% -- Values: 0<fE<1.
fE = 0.6;

% recovery period (days)
Tgamma = 14;

% recovery rate (days^-1)
gamma = 1/Tgamma;

% hospitalization rate (days^-1)
rho = 0.1;

% death rate (days^-1)
delta = 0.07;

% Hospitalization mortality-factor (dimensionless)
%
% -- Models mortality diminishment.  
% -- Values: 0<kappaH<1.
kappaH = 0.55;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

D0 = 0;                 % initial deceased                  (number of individuals)
R0 = 0;                 % initial recovered               (number of individuals)
H0 = 0;                 % initial hospitalized            (number of individuals)
A0 = 0;                 % initial asymptomatic infectious (number of individuals)
I0 = 1;                 % initial symptomatic infectious  (number of individuals)
E0 = 0;                 % initial exposed                 (number of individuals)
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
R_control = fE*beta/DI + (1-fE)*beta/DA + rho*fE*beta/DI/DH;

disp(' ')
disp('================================================')
disp('   EPIDEMIC - Epidemiology Educational Code     ')
disp('   by Bruna Pavlack et al.                      ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' --------------------------------------'             )
disp(' ++++++++++ SEIR(+AHD) model +++++++++++++'             )
disp(' --------------------------------------'             )
disp(['  * initial population       = ',num2str(N0)]       )
disp( '    (individuals)              '                    )
disp(['  * transmission rate        = ',num2str(beta)]     )
disp( '    (days^-1)                  '                    )
disp(['  * latent rate              = ',num2str(alpha)]    )
disp( '    (days^-1)                  '                    )
disp(['  * symptomatic farction     = ',num2str(fE)]       )
disp( '    (dimensionless)            '                    )
disp(['  * recovery rate            = ',num2str(gamma)]    )
disp( '    (days^-1)                  '                    )
disp(['  * hospitalization rate     = ',num2str(rho)]      )
disp( '    (days^-1)                  '                    )
disp(['  * death rate               = ',num2str(delta)]    )
disp( '    (days^-1)                  '                    )
disp(['  * hospitalization recovery = ',num2str(kappaH)]   )
disp( '    (dimensionless)            '                    )
disp(['  * R_nought                 = ',num2str(R_nought)] )
disp( '    (dimensionless)            '                    )
disp(['  * R_control                = ',num2str(R_control)])
disp( '    (dimensionless)            '                    )
disp(' --------------------------------------'             )
% -----------------------------------------------------------


% integration of the initial value problem
% -----------------------------------------------------------

% parameters vector
param = [N0 beta alpha fE gamma rho delta kappaH];

% initial conditions vector
IC = [S0 E0 I0 A0 H0 R0 D0 C0];

% time interval of analysis
   t0 = 1;                  % initial time (days)
   t1 = 365;                % final time   (days)
   dt = 0.1;                % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SEIRAHD(t,y,param),tspan,IC);

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

% plot all compartments of SEIR(+AHD) model
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
     title('SEIR(+AHD) dynamic model'  );
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
    legend(fig1,leg,'FontSize',10,'location','northeast');

    % axis limits
    xlim([t0 t1]);
    ylim([0 N0]);

    saveas(figure(1),'fig_modeling_SEIRAHD_example2_compart.png')


% plot NewCases (per day) of SEIR(+AHD) model
figure(2)
fig2 = scatter([1:length(NewCases)]+1,NewCases);

    % plot labels
     title('NewCases per day (SEIR(+AHD))' );
    xlabel('time (days)'                );
    ylabel('number of individuals'      );

    % set plot settings
    set(gca,'FontSize',18);
    set(fig2,{'MarkerFaceColor','MarkerEdgeColor'},{'y','r'});

    % axis limits
    xlim([t0 length(NewCases)]+1);

    saveas(figure(2),'fig_modeling_SEIRAHD_example2_newcases.png')
% -----------------------------------------------------------
