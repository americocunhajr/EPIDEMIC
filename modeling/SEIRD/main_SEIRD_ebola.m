% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: main_SEIRD_ebola.m
%
% This is the main file for the SEIRD epidemic model, which
% divides a population in 5 compartments:
%
%   S = susceptibles
%   E = exposed
%   I = infectious
%   R = recovered
%   D = deceased
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
%
% The parameters used in this example were taken from this work:
% P. Diaz, P. Constantine, K. Kalmbach, E. Jones and S. Pankavichm.
% A modified SEIR model for the spread of Ebolain Western Africa
% and metrics for resource allocation, Applied Mathematics and
% Computation, 324(1): 141-155, 2018
%
%
% Inputs:
%   param: parameters vector      - double array (5x1)
%   IC: initial conditions vector - double array (6X1)
%   tspan: time interval          - double array (?x1)
%   rhs_SEIRD: SEIRD equations file - .m function file
%
% Outputs:
%   R_nought: basic reproduction number   - double
%   figure 1: model state in time         - inplace figure
%   figure 2: number of new cases in time - inplace figure 
% -----------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% number 0f lines: 91
% last update: Jan 26, 2021
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% initial population size (number of individuals)
N0 = 6092000;
        
% transmission rate (days^-1)
beta = 0.7124;

% latent period (days)
Talpha = 9;

% latent rate (days^-1)
alpha = 1/Talpha;

% recovery period (days)
Tgamma = 8.451656;

% recovery rate (days^-1)
gamma  = 1/Tgamma;

% death rate (days^-1)
delta = 0.37468;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

D0 = 0;            % initial deceased    (number of individuals)
R0 = 0;            % initial recovered   (number of individuals)
I0 = 1;            % initial infectious  (number of individuals)
E0 = 0;            % initial exposed     (number of individuals)
S0 = N0-E0-I0-R0;  % initial susceptible (number of individuals)

% initial cumulative infectious (number of individuals)
C0 = I0;
% -----------------------------------------------------------


% display program header on screen
% -----------------------------------------------------------

% computing the basic reproduction number R_nought
R_nought = beta/(gamma+delta);

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
disp( '    (dimensionless)       '                  )
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
   t1 = 730;                % final time   (days)
   dt = 0.1;                % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SEIRD(t,y,param),tspan,IC);

% time series
S = y(:,1);      % susceptibles          (number of individuals)
E = y(:,2);      % exposed               (number of individuals)
I = y(:,3);      % infectious            (number of individuals)
R = y(:,4);      % recovered             (number of individuals)
D = y(:,5);      % deceased              (number of individuals)
C = y(:,6);      % cumulative infectious (number of individuals)
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


% custom colors
yellow = [255 204  0]/256;

% plot all compartments of SEIRD model
figure(1)
hold on
fig1(1) = plot(time,S);
fig1(2) = plot(time,E);
fig1(3) = plot(time,I);
fig1(4) = plot(time,R);
fig1(5) = plot(time,D);
fig1(6) = plot(time,C);
hold off

    % plot labels
     title('SEIRD dynamic model'  );
    xlabel('time (days)'          );
    ylabel('number of individuals');

    % set plot settings
    set(gca,'FontSize',18);
    set(fig1,{'Color'},{'b';yellow;'r';'g';'k';'m'});
    set(fig1,{'LineWidth'},{2;2;2;2;2;2});
    
    % legend
    leg = {'Suceptibles'; 'Exposed'; 'Infectious'; 'Recovered';...
                                        'Deceased'; 'Cum. Infectious'};
    legend(fig1,leg,'FontSize',10,'location','northeast');

    % axis limits
    xlim([t0 t1]);
    ylim([0 N0]);

    saveas(figure(1),'fig_modeling_SEIRD_example2_compart.png')


% plot NewCases (per day) of SEIRD model
figure(2)
fig2 = scatter([1:length(NewCases)]+1,NewCases);

    % plot labels
     title('NewCases per day (SEIRD)'    );
    xlabel('time (days)'               );
    ylabel('number of individuals'     );

    % set plot settings
    set(gca,'FontSize',18);
    set(fig2,{'MarkerFaceColor','MarkerEdgeColor'},{'y','r'});

    % axis limits
    xlim([t0 length(NewCases)]+1);

    saveas(figure(2),'fig_modeling_SEIRD_example2_newcases.png')
% -----------------------------------------------------------
