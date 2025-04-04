% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: main_SEIR_Dantas.m
%
% This is the main file for the SEIR epidemic model, which
% divides a population in 4 compartments:
%
%   S = susceptible
%   E = exposed
%   I = infectious
%   R = recovered
%
% Infection spreads via direct contact between
% a susceptible and infectious individual.
% Delay is modeled as an exposed group: there is an
% latent period until an infected becomes able to 
% transmit (infectious).
% No deaths are considered, all infected become recovered.
%
% This model has 4 parameters:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   alpha = latent rate       (days^-1)
%   gamma = recovery rate     (days^-1)
%
% This code uses rhs_SEIR.m to define the ODE system
% and outputs the plots and R_nought value. Calculations
% are made on a day time scale.
%
% The conditions simulated by this file was estrated 
% from the Brazil's zika outbreak discrebed in 
% E. Dantas, M. Tosin and A. Cunha Jr,
% Calibration of a SEIR–SEI epidemic model 
% to describe the Zika virus outbreak in Brazil, 
% Applied Mathematics and Computation, 338, p.249-259, 
% 2020. DOI: https://doi.org/10.1016/j.amc.2018.06.024
%
% Inputs:
%   param: parameters vector      - double array (4x1)
%   IC: initial conditions vector - double array (5X1)
%   tspan: time interval          - double array (?x1)
%   rhs_SEIR: SEIR equations file - .m function file
%
% Outputs:
%   R_nought: basic reproduction number   - double
%   figure 1: model state in time         - inplace figure
%   figure 2: number of new cases in time - inplace figure
% -----------------------------------------------------------
% programmers: Michel Tosin
%
% % number of lines: 85
% last update: Jan 17, 2021
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% population size (number of individuals)
N = 206e6;
        
% transmission rate (days^-1)
beta = 1/7.7;

% latent period (days)
Talpha = 5.9;

% latent rate (days^-1)
alpha = 1/Talpha;

% recovery period (days)
Tgamma = 7.9;

% recovery rate (days^-1)
gamma  = 1/Tgamma;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

R0 = 29639;       % initial recovered   (number of individuals)
I0 = 8201;        % initial infectious  (number of individuals)
E0 = I0;          % initial exposed     (number of individuals)
S0 = N-E0-I0-R0;  % initial susceptible (number of individuals)

% initial cumulative infectious (number of individuals)
C0 = I0;
% -----------------------------------------------------------


% display program header on screen
% -----------------------------------------------------------

% computing the basic reproduction number R_nought
R_nought = beta/gamma;

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
disp(' --------------------------------------'      )
disp(' ++++++++++++ SEIR model ++++++++++++++'      )
disp(' --------------------------------------'      )
disp(['  * population        = ',num2str(N)]        )
disp( '    (individuals)       '                    )
disp(['  * transmission rate = ',num2str(beta)]     )
disp( '    (days^-1)           '                    )
disp(['  * latent rate       = ',num2str(alpha)]    )
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
param = [N beta alpha gamma];

% initial conditions vector
IC = [S0 E0 I0 R0 C0];

% time interval of analysis
   t0 = 7;                  % initial time (days)
   t1 = 364;                % final time   (days)
   dt = 0.1;                % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SEIR(t,y,param),tspan,IC);

% time series
S = y(:,1);  % susceptibles          (number of individuals)
E = y(:,2);  % exposed               (number of individuals)
I = y(:,3);  % infectious            (number of individuals)
R = y(:,4);  % recovered             (number of individuals)
C = y(:,5);  % cumulative infectious (number of individuals)
% -----------------------------------------------------------


% post-processing
% -----------------------------------------------------------

% NewCases (per day) computation
tu = 7;                     % time unit (days)
%
% -- tu/dt must be an integer
% -- tu = 1 defines a 'per day' computation
% -- For a 'per week' computation, use tu = 7 and t0 = 7
NewCases = zeros(floor((Ndt-1)/(tu/dt)),1);
for n = 1:length(NewCases)
    NewCases(n) = C((n)*tu/dt +1) - C((n-1)*tu/dt +1);
end


% custom color
yellow = [255 204  0]/256;

% plot all compartments of SEIR model
figure(1)
hold on
fig1(1) = plot(time,S);
fig1(2) = plot(time,E);
fig1(3) = plot(time,I);
fig1(4) = plot(time,R);
fig1(5) = plot(time,C);
hold off

    % plot labels
     title('SEIR dynamic model'   );
    xlabel('time (days)'          );
    ylabel('number of individuals');

    % set plot settings
    set(gca,'FontSize',18);
    set(fig1,{'Color'},{'b';yellow;'r';'g';'m'});
    set(fig1,{'LineWidth'},{2;2;2;2;2});

    % legend
    leg = {'Suceptibles'; 'Exposed'; 'Infectious'; 'Recovered'; 'Cum. Infectious'};
    legend(fig1,leg,'FontSize',10,'location','northeast');
    
    % axis limits
    xlim([t0 t1]);
    ylim([0 N]);

    saveas(figure(1),'fig_modeling_SEIR_example2_compart.png')


% plot NewCases (per day) of SEIR model
figure(2)
fig2 = scatter([1:length(NewCases)]+1,NewCases);

    % plot labels
     title('New Cases per day (SEIR)'  );
    xlabel('time (days)'               );
    ylabel('number of individuals'     );

    % set plot settings
    set(gca,'FontSize',18);
    set(fig2,{'MarkerFaceColor','MarkerEdgeColor'},{'y','r'});

    % axis limits
    xlim([t0 length(NewCases)]+1);

    saveas(figure(2),'fig_modeling_SEIR_example2_newcases.png')
% -----------------------------------------------------------
