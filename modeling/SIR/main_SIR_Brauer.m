% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: main_SIR_Brauer.m
%
% This is a main file for the SIR epidemic model, which
% divides a population in 3 compartments:
%
%   S = susceptible
%   I = infected
%   R = recovered
%
% Infection spreads via direct contact between
% a susceptible and infected individual, with no delay.
% No deaths are considered, all infected become recovered.
%
% This model has 3 parameters:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   gamma = recovery rate     (days^-1)
%
% This code uses rhs_SIR.m to define the ODE system
% and outputs the plots and R_nought value. Calculations
% are made on a day time scale.
%
% The conditions simulated by this file was esctrated 
% from the New York City measles discrebed in 
% F. Brauer, P. van den Driessche and J. Wu (eds.) 
% Mathematical epidemiology, Springer-Verlag, Berlin, 2008, 
% p.5-11. DOI: https://doi.org/10.1007/978-3-540-78911-6 
%
% Inputs:
%   param: parameters vector      - double array (3x1)
%   IC: initial conditions vector - double array (4X1)
%   tspan: time interval          - double array (?x1)
%   rhs_SIR: SIR equations file   - .m function file
%
% Outputs:
%   R_nought: basic reproduction number   - double
%   figure 1: model state in time         - inplace figure
%   figure 2: number of new cases in time - inplace figure
% -----------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% number of lines: 78
% last update: Jan 19, 2021
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% population size (number of individuals)
N = 7781984;
        
% transmission rate (days^-1)
beta = 3.6;

% recovery period (days)
Tgamma = 5;

% recovery rate (days^-1)
gamma  = 1/Tgamma;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

S0 = 0.065*N;  % initial susceptible (number of individuals)
I0 = 123*5/30; % initial infected    (number of individuals)
R0 = N-S0-I0;  % initial recovered   (number of individuals)

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
disp(' ++++++++++++ SIR model +++++++++++++++'      )
disp(' --------------------------------------'      )
disp(['  * population        = ',num2str(N)]        )
disp( '    (individuals)       '                    )
disp(['  * transmission rate = ',num2str(beta)]     )
disp( '    (days^-1)           '                    )
disp(['  * recovery rate     = ',num2str(gamma)]    )
disp( '    (days^-1)           '                    )
disp(['  * R_nought          = ',num2str(R_nought)] )
disp( '    (dimensionless)     '                    )
disp(' --------------------------------------'      )
% -----------------------------------------------------------


% integration of the initial value problem
% -----------------------------------------------------------

% parameters vector
param = [N beta gamma];

% initial conditions vector
IC = [S0 I0 R0 C0];

% time interval of analysis
   t0 = 1;                  % initial time (days)
   t1 = 120+365;            % final time   (days)
   dt = 0.1;                % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SIR(t,y,param),tspan,IC);

% time series
S = y(:,1);  % susceptible         (number of individuals)
I = y(:,2);  % infected            (number of individuals)
R = y(:,3);  % recovered           (number of individuals)
C = y(:,4);  % cumulative infected (number of individuals)
% -----------------------------------------------------------


% post-processing
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


% plot all compartments of SIR model
figure(1)
hold on
fig1(1) = plot(time,S);
fig1(2) = plot(time,I);
fig1(3) = plot(time,R);
fig1(4) = plot(time,C);
hold off

    % plot labels
     title('SIR dynamic model'    );
    xlabel('time (days)'          );
    ylabel('number of individuals');

    % set plot settings
    set(gca,'FontSize',18);
    set(fig1,{'Color'},{'b';'r';'g';'m'});
    set(fig1,{'LineWidth'},{2;2;2;2});
    
    % legend
    leg = {'Suceptibles'; 'Infected'; 'Recovered'; 'Cum. Infected'};
    legend(fig1,leg,'FontSize',10,'location','northeast');

    % axis limits
    xlim([t0 t1]);
    ylim([0 N]);


% plot NewCases (per day) of SIR model
figure(2)
fig2 = scatter([1:length(NewCases)]+1,NewCases);

    % plot labels
     title('New Cases per day (SIR)'   );
    xlabel('time (days)'               );
    ylabel('number of individuals'     );

    % set plot settings
    set(gca,'FontSize',18);
    set(fig2,{'MarkerFaceColor','MarkerEdgeColor'},{'y','r'});

    % axis limits
    xlim([t0 length(NewCases)]+1);
% -----------------------------------------------------------


% Clear extra variables
% -----------------------------------------------------------
clearvars -except param IC tspan S I R C NewCases
% -----------------------------------------------------------
